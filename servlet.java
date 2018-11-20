import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/servlet")
public class servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String field= request.getParameter("field");
		//PrintWriter out = response.getWriter();
		System.out.println("called servlet:"+field);
		System.out.println(field);
		
		if(field.equals("createSong")) {
			PrintWriter out = response.getWriter();
			Song song_ = db.createSong();
			//TODO
			
			
		}
		
		if(field.equals("createSongs")) {
			PrintWriter out = response.getWriter();
			ArrayList<Song> songs_ = db.creatSongs();
			//TODO
			
		}
		
		if(field.equals("addUser")) {
			System.out.println("servlet in adduser");
			
			String username= request.getParameter("username");
			String firstName= request.getParameter("firstName");
			String lastName= request.getParameter("lastName");
			String passhash= request.getParameter("passhash");
			String salt= request.getParameter("salt");
			
			db.addUser(username, firstName, lastName, passhash, salt);
		}
	
		if(field.equals("addsong")) {
			System.out.println("servlet in addsong");
			
			String filePath= request.getParameter("filePath");
			String imageFilePath= request.getParameter("imageFilePath");
			String artist= request.getParameter("artist");
			String album= request.getParameter("album");
			String songName= request.getParameter("songName");
			String yearofRelease= request.getParameter("yearofRelease");
			String genre = request.getParameter("genre");
			
			System.out.println("senting addsongs");
			db.addSong(filePath, imageFilePath, artist, album, songName, yearofRelease, genre);
		}
		

		if(field.equals("addSongToPlaylist")) {
			
			String userID= request.getParameter("userID");
			String songID= request.getParameter("songID");
			String name= request.getParameter("name");
			
			db.addSongToPlaylist(userID, songID, name);
		
		}
		if(field.equals("getSongByID")) {
			PrintWriter out = response.getWriter();
			String id= request.getParameter("id");
			Song song_ =db.getSongById(id);
			//TODO
			
			System.out.println("GET: "+id);
		}
		
		if(field.equals("getSongByName")) {
			PrintWriter out = response.getWriter();
			String name= request.getParameter("name");
			Song song_ =db.getSongByName(name);
			//TODO
			
		}
		if(field.equals("getSongsByGenre")) {
			PrintWriter out = response.getWriter();
			String genre= request.getParameter("genre");
			ArrayList<Song> songs_ = db.getSongsByGenre(genre);
			
			//TODO
			
		}
		if(field.equals("getSongsByYear")) {
			PrintWriter out = response.getWriter();
			String year= request.getParameter("year");
			ArrayList<Song> songs_ = db.getSongsByYear(year);
			
			//TODO
			
		}
	}
}
