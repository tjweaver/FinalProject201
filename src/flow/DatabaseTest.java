package flow;

public class DatabaseTest {
	
	public static void main(String args[]) {
		DatabaseConnector dbc = new DatabaseConnector();
		dbc.connect();
//		dbc.addUser("test", "test", "test", "test", "test");
//		dbc.addSong("2", "2", "2", "2", "2", (short) 1990, "metal");
//		dbc.addSong("1", "1", "1", "1", "1", (short) 1991, "country");
//		dbc.addSong("3", "3", "3", "3", "3", (short) 1993, "rock");
//		dbc.addSong("4", "4", "1", "1", "4", (short) 1991, "country");
//		System.out.println("Authentication test: " + dbc.authenticate("test", "test"));
//		dbc.addSongToPlaylist(1, 1, "nice");
//		dbc.addSongToPlaylist(1, 2, "nice");
//		dbc.addSongToPlaylist(1, 3, "nice");
//		Playlist p = dbc.getPlaylist("nice");
//		for(Song s : p.getSongs()) {
//			System.out.println("HERE: " + s.getId());
//		}
//		dbc.convertPlaylists();
//		dbc.convertLUT();
		Playlist p = dbc.getPlaylist("Jolene");
		String s = dbc.playlistToString(p);
		System.out.print(s);
	}
	
}
