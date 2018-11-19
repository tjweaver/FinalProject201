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
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/Lab10?user=root&password=PyVit66^&useSSL=false");
			connected = true;
		} catch (ClassNotFoundException e) {
			connected = false;
			e.printStackTrace();
		} catch (SQLException e) {
			connected = false;
			e.printStackTrace();
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
		}catch(SQLException sqle){
			System.out.println("connection close error");
			sqle.printStackTrace();
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
			ps = conn.prepareStatement(StringConstants.ADD_USER);
			ps.setString(1,username);
			ps.setString(2,firstName);
			ps.setString(3,lastName);
			ps.setString(4, passhash);
			ps.setString(5, salt);
			int res = ps.executeUpdate();
			if(res != 2) {
				// error
				System.out.println("Error adding a user.");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void addSong(String filePath, String imageFilePath, String artist, String album, String songName, short yearofRelease, String genre) {
		if (!connected) return;
	}
	
	public void addSongToPlaylist(int userID, int songID) {
		if (!connected) return;
	}
	
	public void addPlaylist(int userID, int songID, String playlistName){
		if (!connected) return;
	}
	
}
