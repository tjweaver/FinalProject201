package flow;

import java.sql.*;
import java.util.ArrayList;

/* Functions to implement
 * addUser(username, firstName, lastName, passhash, salt)
 * addSong(filePath, imageFilePath, artist, album, songName, yearofRelease, genre)
 * addSongToPlaylist(userID, songID)
 * addPlaylist(userID, songID, playlistName)
 */

class DatabaseConnector{
	private boolean connected = false;
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	public void connect(){
		try {
			Class.forName(Constants.DRIVER_CLASS);
			conn = DriverManager.getConnection(Constants.DRIVER_STRING);
			connected = true;
		} catch (ClassNotFoundException e) {
			connected = false;
			System.out.println(e.getMessage());
		} catch (SQLException e) {
			connected = false;
			System.out.println(e.getMessage());
		}
	}
	
	public void close() {
		try{
			if (rs!=null){
				rs.close();
				rs = null;
			}
			if(conn != null){
				conn.close();
				conn = null;
			}
			if(ps != null ){
				ps = null;
			}
		}catch(SQLException e){
			System.out.println("connection close error");
			System.out.println(e.getMessage());
		}
		connected = false;
	}
	
	// Custom object instantiation
	public Song createSong() {
		// Convert result into POJO
		String path = null, iPath = null, artist = null, album = null, songName = null, genre = null;
		int id = -1, year = -1;
		try {
			id = rs.getInt("songID");
			path = rs.getString("filePath");
			iPath = rs.getString("imageFilePath");
			artist = rs.getString("artist");
			album = rs.getString("album");
			songName = rs.getString("songName");
			genre = rs.getString("genre");
			year = rs.getShort("yearOfRelease");
			// Return POJO
			return new Song(id, path, iPath, artist, album, songName, year, genre);
		} catch (SQLException e) {
			System.out.println("Error creating song");
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public ArrayList<Song> createSongs(){
		ArrayList<Song> songs = new ArrayList<Song>();
		try {
			while(rs.next()) {
				songs.add(createSong());
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return songs;
	}
	
	public Playlist createPlaylist(String name, int id) {
		ArrayList<Song> songs = createSongs();
		Playlist p = new Playlist(name, id);
		p.addSongs(songs);
		return p;
	}
	
	// Insertion functions
	public void addUser(String username, String firstName, String lastName, String passhash, String salt) {
		if (!connected) return;
		try {
			// Generate some salt
			salt = "rand";
			// prepare the statement
			ps = conn.prepareStatement(Constants.ADD_USER);
			ps.setString(1, username);
			ps.setString(2, firstName);
			ps.setString(3, lastName);
			ps.setString(4, passhash);
			ps.setString(5, salt);
			int res = ps.executeUpdate();
			if(res != Constants.GOOD_RES) {
				// error
				System.out.println("Error adding a user.");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void addSong(String filePath, String imageFilePath, String artist, String album, String songName, short yearofRelease, String genre) {
		if (!connected) return;
		try {
			// prepare the statement
			ps = conn.prepareStatement(Constants.ADD_SONG);
			ps.setString(1, filePath);
			ps.setString(2, imageFilePath);
			ps.setString(3, artist);
			ps.setString(4, album);
			ps.setString(5, songName);
			ps.setInt(6, yearofRelease);
			ps.setString(7, genre);
			int res = ps.executeUpdate();
			if(res != Constants.GOOD_RES) {
				// error
				System.out.println("Error adding a song.");
			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void addSongToPlaylist(int userID, int songID, String name) {
		if (!connected) return;
		try {
			// Check if the playlist name already exists
			ps = conn.prepareStatement("SELECT COUNT(*) AS total FROM Playlists WHERE playlistName = '" + name + "'");
			rs = ps.executeQuery();
			rs.next();
			int plid = -1;
			int count = rs.getInt(1);
			if(count < 1) {
				// Create a new playlist
				// Get the playlist id
				plid = getPlaylistId(name) + 1;
			} else {
				// Add it to existing playlist
				// Get playlist id
				plid = getPlaylistId(name);
				// add to lookup table
			}
			// prepare the statement
			ps = conn.prepareStatement(Constants.ADD_TO_PLAYLIST);
			ps.setString(1, name);
			ps.setInt(2, userID);
			ps.setInt(3, songID);
			ps.setInt(4, plid);
//			int res = ps.executeUpdate();
//			if(res != Constants.GOOD_RES) {
//				// error
//				System.out.println("Error adding a song to a playlist.");
//			}
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	// Selection statements
	public Song getSongByID(int id) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.GET_SONG_BY_ID);
			ps.setInt(1, id);
			// Execute
			rs = ps.executeQuery();
			rs.next();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		// Format
		return createSong();
	}
	
	public Song getSongByName(String name) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.GET_SONG_BY_NAME);
			ps.setString(1, name);
			// Execute
			rs = ps.executeQuery();
			rs.next();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		// Format
		return createSong();
		
	}
	
	public ArrayList<Song> getSongsByArtist(String artist) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.GET_SONGS_BY_ARTIST);
			ps.setString(1, artist);
			// Execute
			rs = ps.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		// Format
		return createSongs();
	}
	
	public ArrayList<Song> getSongsByGenre(String genre) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.GET_SONGS_BY_GENRE);
			ps.setString(1, genre);
			// Execute
			rs = ps.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		// Format
		return createSongs();
	}
	
	public ArrayList<Song> getSongsByYear(short year) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.GET_SONGS_BY_YEAR);
			ps.setShort(1, year);
			// Execute
			rs = ps.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		// Format
		return createSongs();
	}
	
	public int getPlaylistID(int songID) {
		try {
			// Prepare
			ps = conn.prepareStatement("SELECT playlistID FROM NewPlaylists WHERE songID = ?");
			ps.setInt(1, songID);
			// Execute
			rs = ps.executeQuery();
			rs.next();
			int id = rs.getInt(1);
			return id;
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return -1;
	}
	
	public String getPlaylistName(int plid) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement("SELECT DISTINCT playlistName FROM NewPlaylists WHERE playlistID = ?");
			ps.setInt(1, plid);
			// Execute
			rs = ps.executeQuery();
			rs.next();
			return rs.getString(1);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	public Playlist getPlaylist(String song) {
		if (!connected) return null;
		// Get the song id
		// Check to be sure that our db has the song
		Song target = getSongByName(song);
		int sid = -1;
		if(target == null) {
			return null;
		}else {
			sid = target.getId();
		}
		// Get the playlistid
		int plid = getPlaylistID(sid);
		String name = getPlaylistName(plid);
		try {
			// Prepare
			PreparedStatement pos = conn.prepareStatement("SELECT songID FROM NewPlaylists WHERE playlistID = ?");
			pos.setInt(1, plid);
			// Execute
			ResultSet ros = pos.executeQuery();
			ArrayList<Song> songs = new ArrayList<Song>();
			while(ros.next()) {
				int id = ros.getInt(1);
				Song s = getSongByID(id);
				songs.add(s);
			}
			Playlist p = new Playlist(name, plid);
			p.addSongs(songs);
			return p;
		} catch (SQLException e) {
			System.out.println("Error getting playlist from song name");
			System.out.println(e.getMessage());
		}
		// Format
		return null;
	}
	
	public String playlistToString(Playlist p) {
		String out = "";
		for (Song s : p.getSongs()) {
			String newS = s.getName() + " by " + s.getArtist() + "%";
			out = out + newS;
		}
		return out;
	}
	
	public int getPlaylistId(String name) {
		int id = -1;
		try {
			// Search for the id if it exists
			ps = conn.prepareStatement("SELECT DISTINCT playlistID FROM NewPlaylists WHERE playlistname = ?");
			ps.setString(1, name);
			rs = ps.executeQuery();
			if(!rs.next()) {
				// A playlist doesn't exist yet
				ps = conn.prepareStatement("SELECT MAX(playlistID) FROM NewPlaylists");
				rs = ps.executeQuery();
				if(!rs.next()) {
					// It's the first playlist
					id = 1;
				} else {
					// Set it to the next highest id
					id = rs.getInt(1) + 1;
				}
			}else {
				// There exists a playlist already
				id = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("here");
			System.out.println(e.getMessage());
			System.out.println("there");
		}
		return id;
	}
	
	public boolean authenticate(String username, String passhash) {
		if (!connected) return false;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.AUTHENTICATE);
			ps.setString(1, username);
			ps.setString(2, passhash);
			rs = ps.executeQuery();
			// Check
			rs.next();
			return rs.getInt(1) == 1;
		} catch (SQLException e) {
			System.out.println("Error authenticating");
			System.out.println(e.getMessage());
		}
		return false;
	}
	
	public void convertLUT() {
		String songName, playlistName;
		int plid, sid;
		try {
			PreparedStatement lutq = conn.prepareStatement("SELECT * FROM LUT");
			ResultSet lutrs = lutq.executeQuery();
			while(lutrs.next()) {
				songName = lutrs.getString(3);
				playlistName = lutrs.getString(2);
				plid = getPlaylistId(playlistName);
				sid = getSongByName(songName).getId();
				// Execute the update
				ps = conn.prepareStatement("INSERT INTO Lookup (songID, playlistID) VALUES (?,?)");
				ps.setInt(1, sid);
				ps.setInt(2, plid);
				int res = ps.executeUpdate();
				if(res != Constants.GOOD_RES) {
					System.out.println("Error inserting into Lookup");
				}
				
			}
		} catch (SQLException e) {
			System.out.println("Error while converting LUT");
			System.out.println(e.getMessage());
		}
	}
	
	public void convertPlaylists() {
		// Read in the playlists Table
		try {
			PreparedStatement newps = conn.prepareStatement("SELECT * FROM Playlists");
			ResultSet holder = newps.executeQuery();
			String playlistName;
			int songID, plid, userID, rows = 0;
			while(holder.next()) {
				// Get the songID, and playlistName
				userID = holder.getInt(2);
				songID = holder.getInt(3);
				playlistName = holder.getString(4);
				// Get the playlistID
				plid = getPlaylistId(playlistName);
				// add it to the newPlaylist Table
				ps = conn.prepareStatement("INSERT INTO NewPlaylists (playlistID, userID, songID, playlistName) VALUES (?,?,?,?)");
				ps.setInt(1, plid);
				ps.setInt(2, userID);
				ps.setInt(3, songID);
				ps.setString(4, playlistName);
				System.out.println(plid + " " + userID + " " + songID + " " + playlistName);
				int res = ps.executeUpdate();
				if (res != Constants.GOOD_RES) {
					System.out.println("Error converting playlists");
				}
				rows++;	
			}
			System.out.println("rows: " + rows);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
	}
	
	
}









