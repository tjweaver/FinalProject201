package flow;
import java.util.ArrayList;

class Song {
	private String name, artist, genre, album, path, imagePath;
	private int id, year;
	
	public Song(int id, String path, String imagePath, String artist, String album, String name, int year, String genre) {
		this.id = id;
		this.name = name;
		this.artist = artist;
		this.genre = genre;
		this.album = album;
		this.path = path;
		this.imagePath = imagePath;
	}
	
	public int getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getArtist() {
		return artist;
	}

	public String getGenre() {
		return genre;
	}

	public String getAlbum() {
		return album;
	}

	public String getPath() {
		return path;
	}

	public String getImagePath() {
		return imagePath;
	}

	public int getYear() {
		return year;
	}
	
}

class Feed{
	private String username, songName;
	public Feed(String username, String songName) {
		this.username=username;
		this.songName=songName;
	}
	public String getUsername() {
		return username;
	}
	public String getSongName() {
		return songName;
	}
}

class User {
	private String username, firstName, lastName, passhash, salt;
	private int id;
	
	public User(int id, String username, String firstName, String lastName, String passhash, String salt) {
		this.id = id;
		this.username = username;
		this.firstName = firstName;
		this.lastName = lastName;
		this.passhash = passhash;
		this.salt = salt;
	}
	
	public int getId () {
		return id;
	}

	public String getUsername() {
		return username;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getPasshash() {
		return passhash;
	}

	public String getSalt() {
		return salt;
	}
}

class Rating {
	private int userID, songID, ratingID, rating;
	
	public Rating(int userID, int songID, int ratingID, int rating) {
		this.userID = userID;
		this.songID = songID;
		this.ratingID = ratingID;
		this.rating = rating;
	}

	public int getUserID() {
		return userID;
	}

	public int getSongID() {
		return songID;
	}

	public int getRatingID() {
		return ratingID;
	}

	public int getRating() {
		return rating;
	}
}

class Playlist {
	private int id;
	private ArrayList<Song> songs;
	private String name;
	
	public Playlist(String name, int id) {
		this.id = id;
		this.name = name;
	}
	
	public int getId() {
		return id;
	}
	
	public void addSongs(ArrayList<Song> songs) {
		this.songs = songs;
	}
	
	public void add(Song song) {
		songs.add(song);
	}

	public ArrayList<Song> getSongs() {
		return songs;
	}

	public String getName() {
		return name;
	}
}
