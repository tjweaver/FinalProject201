package flow;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/ServletThread")
public class Servlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	DatabaseConnector db;
	FeedThread feedThread = new FeedThread(this);
	public void init(ServletConfig config) throws ServletException {
		db.connect();
		Server.feedThreads.add(feedThread);
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String field= request.getParameter("field");
		//PrintWriter out = response.getWriter();
		System.out.println("called servlet:"+field);
		System.out.println(field);
		
		
		if(field.equals("addUser")) {
			System.out.println("servlet in adduser");
			
			String username= request.getParameter("username");
			//String firstName= request.getParameter("firstName");
			//String lastName= request.getParameter("lastName");
			String passhash= request.getParameter("passhash");
			String salt= request.getParameter("salt");
			
			db.addUser(username, "", "", passhash, salt);
		}
		
		if(field.equals("authenticate")) {
			System.out.println("servlet in authenticate");
			
			String username= request.getParameter("username");
			//String firstName= request.getParameter("firstName");
			//String lastName= request.getParameter("lastName");
			String passhash= request.getParameter("passhash");
			boolean exist = db.authenticate(username, passhash);
			
			//TODO send result back to front-end
			
		}
	
		if(field.equals("getSongByName")) {
			System.out.println("servlet in getSongByName");
			String name= request.getParameter("name");
			Song song =db.getSongByName(name);
			//TODO return song data to front-end
			
		}
		
		if(field.equals("getPlaylistBySongName")) {
			System.out.println("servlet in get Playlist By Song Name");
			String name= request.getParameter("name");
			//TODO ArrayList<String> by String songname
			//ArrayList<String> playlist = db.getPlaylist(name);
			
			//TODO return playlist to front-end
		}
		
		if(field.equals("playingSong")) {
			System.out.println("servlet in Playing Song");
			String songName= request.getParameter("songName");
			String userName= request.getParameter("userName");
			feedThread.addFeed(userName, songName);
		}
		
		if(field.equals("inFeed")) {
			feedThread.onFeedPage=true;
		}
		if(field.equals("outFeed")) {
			feedThread.onFeedPage=false;
		}
	}
}
//if(field.equals("getSongsByGenre")) {
//PrintWriter out = response.getWriter();
//String genre= request.getParameter("genre");
//ArrayList<Song> songs_ = db.getSongsByGenre(genre);
//
////TODO
//
//}
//if(field.equals("getSongsByYear")) {
//PrintWriter out = response.getWriter();
//short year= (short)Integer.parseInt(request.getParameter("year"));
//ArrayList<Song> songs_ = db.getSongsByYear(year);
//
////TODO
//
//}
//if(field.equals("addsong")) {
//System.out.println("servlet in addsong");
//
//String filePath= request.getParameter("filePath");
//String imageFilePath= request.getParameter("imageFilePath");
//String artist= request.getParameter("artist");
//String album= request.getParameter("album");
//String songName= request.getParameter("songName");
//short yearofRelease= (short)Integer.parseInt(request.getParameter("yearofRelease"));
//String genre = request.getParameter("genre");
//
//System.out.println("senting addsongs");
//db.addSong(filePath, imageFilePath, artist, album, songName, yearofRelease, genre);
//}

//if(field.equals("addSongToPlaylist")) {
//
//int userID= Integer.parseInt(request.getParameter("userID"));
//int songID= Integer.parseInt(request.getParameter("songID"));
//String name= request.getParameter("name");
//
//db.addSongToPlaylist(userID, songID, name);
//
//}
//if(field.equals("getSongByID")) {
//PrintWriter out = response.getWriter();
//int id= Integer.parseInt(request.getParameter("id"));
//Song song_ =db.getSongByID(id);
////TODO
//
//System.out.println("GET: "+id);
//}