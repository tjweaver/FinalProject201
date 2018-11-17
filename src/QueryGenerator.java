/*
 * This class will be used by the DatabaseConnector class to query/update the database
 * All the functions will be named as the name of the string
 * The parameters to each function will follow the statement ordering
 * i.e.: addUser will be the function for adding a user and will accept args as such:
 * (username, firstName, lastName, passhash, salt)
 */


public class QueryGenerator {
	// Insertion statements
	public static final String ADD_USER = "INSERT INTO Users (username, firstName, lastName, passhash, salt) VALUES (?,?,?,?,?)";
	public static final String ADD_SONG = "INSERT INTO Songs (filePath, imageFilePath, artist, album, songName, yearofRelease, genre) VALUES(?,?,?,?,?,?,?)";
	public static final String ADD_TO_PLAYLIST  = "INSERT INTO Ratings (userID, songID) VALUES (?,?)";
	public static final String ADD_PLAYLIST = "INSERT INTO Playlists (userID, songID, playlistName) VALUES (?,?,?)";
	// Selection statements
	public static final String GET_SONG_BY_NAME = "SELECT * FROM Songs WHERE songName=?";
	public static final String GET_SONG_BY_ARTIST = "SELECT * FROM Songs WHERE artist=?";
	public static final String GET_SONG_BY_GENRE = "SELECT * FROM Songs WHERE genre=?";
	public static final String GET_SONG_BY_YEAR = "SELECT * FROM Songs WHERE yearOfRelease=?";
	public static final String GET_PLAYLIST = "SELECT * FROM Playlists WHERE playlistName=?";
	public static final String GET_GENRE = "SELECT * FROM Songs WHERE genre=?";
	public static final String GET_METADATA = "SELECT * FROM Metadata";
	// Update Statements
	public static final String UPDATE_RATING = "UPDATE Ratings SET rating = ? WHERE (userID=? AND songID=?)";
	// Deletion Statements
	public static final String REMOVE_SONG_FROM_PLAYLIST = "DELTE FROM Playlists WHERE (songID = ? AND userID = ?";
}
