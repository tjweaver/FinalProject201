import java.sql.*;

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
}
