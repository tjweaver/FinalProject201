package flow;

class Constants {
	public static final int GOOD_RES = 1;
	public static final String DRIVER_CLASS = "com.mysql.jdbc.Driver";
	public static final String DRIVER_STRING = "jdbc:mysql://localhost/songsDB?user=root&password=PyVit66^&useSSL=false&allowPublicKeyRetrieval=true";
	// Insertion statements
	public static final String ADD_USER = "INSERT INTO Users (username, firstName, lastName, passhash, salt) VALUES (?,?,?,?,?)";
	public static final String ADD_SONG = "INSERT INTO Songs (filePath, imageFilePath, artist, album, songName, yearofRelease, genre) VALUES(?,?,?,?,?,?,?)";
	public static final String ADD_TO_PLAYLIST  = "INSERT INTO NewPlaylists (playlistName, userID, songID, playlistID) VALUES (?,?,?,?)";
	// Selection statements
	public static final String GET_SONG_BY_ID = "SELECT * FROM Songs WHERE songID=?";
	public static final String GET_SONG_BY_NAME = "SELECT * FROM Songs WHERE songName=?";
	public static final String GET_SONGS_BY_ARTIST = "SELECT * FROM Songs WHERE artist=?";
	public static final String GET_SONGS_BY_GENRE = "SELECT * FROM Songs WHERE genre=?";
	public static final String GET_SONGS_BY_YEAR = "SELECT * FROM Songs WHERE yearOfRelease=?";
	public static final String GET_PLAYLIST = "SELECT Songs.SongID, Songs.filePath,Songs.imageFilePath, Songs.artist, Songs.album, Songs.songName, Songs.yearOfRelease, Songs.genre FROM Songs INNER JOIN NewPlaylists ON NewPlaylists.playlistID = ?";
	public static final String CHECK_PLAYLIST_EXISTS = "SELECT COUNT(*) FROM Playlists WHERE playlistName = ?";
	
	public static final String AUTHENTICATE = "SELECT COUNT(*) FROM Users WHERE (username=? AND passhash=?)";
	// Update Statements
	public static final String UPDATE_RATING = "UPDATE Ratings SET rating = ? WHERE (userID=? AND songID=?)";
	// Deletion Statements
	public static final String REMOVE_SONG_FROM_PLAYLIST = "DELTE FROM Playlists WHERE (songID = ? AND userID = ?";
}
