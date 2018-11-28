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
		int year = -1;
		try {
			path = rs.getString("filePath");
			iPath = rs.getString("imageFilePath");
			artist = rs.getString("artist");
			album = rs.getString("album");
			songName = rs.getString("songName");
			genre = rs.getString("genre");
			year = rs.getShort("yearOfRelease");
			// Return POJO
			return new Song(path, iPath, artist, album, songName, year, genre);
		} catch (SQLException e) {
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
	
	public Playlist createPlaylist(String name) {
		ArrayList<Song> songs = createSongs();
		Playlist p = new Playlist(name);
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
			// prepare the statement
			ps = conn.prepareStatement(Constants.ADD_TO_PLAYLIST);
			ps.setString(1, name);
			ps.setInt(2, userID);
			ps.setInt(3, songID);
			int res = ps.executeUpdate();
			if(res != Constants.GOOD_RES) {
				// error
				System.out.println("Error adding a song to a playlist.");
			}
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
	
	public Playlist getPlaylist(String name) {
		if (!connected) return null;
		try {
			// Prepare
			ps = conn.prepareStatement(Constants.GET_PLAYLIST);
			ps.setString(1, name);
			// Execute
			rs = ps.executeQuery();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		// Format
		return createPlaylist(name);
	}
	
	public boolean authenticate(String username, String passhash) {
		System.out.println(username + ", " + passhash);
		if (!connected) return false;
		try {
			// Prepare
			System.out.println(conn.isClosed());
			ps = conn.prepareStatement(Constants.AUTHENTICATE);
			ps.setString(1, username);
			ps.setString(2, passhash);
			rs = ps.executeQuery();
			rs.next();
			return rs.getInt(1) == 1;
			
		} catch (SQLException e) {
			System.out.println("Error authenticating");
			System.out.println(e.getMessage());
		}
		return false;
	}
}









