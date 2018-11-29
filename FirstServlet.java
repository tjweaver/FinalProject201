import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/FirstServlet")

public class FirstServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public FirstServlet() {
        super();
        System.out.println("in constructor");
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("in do get");
		String songNameFromFront = request.getParameter("songname");
		String artistNameFromFront = request.getParameter("artistname");
		String userFromFront = request.getParameter("username");
		String feedString = userFromFront+" searched for "+songNameFromFront+" by "+artistNameFromFront;

		System.out.println(songNameFromFront+" by "+artistNameFromFront);
		System.out.println("searched by "+userFromFront);
		System.out.println(feedString);

		
		if(songNameFromFront != null)
		{
			DatabaseConnector db = new DatabaseConnector();
			db.connect();
			Playlist p = db.getPlaylist(songNameFromFront);
			System.out.println(p);
			String finalResponse = db.playlistToString(p);

			ServletContext context = request.getSession().getServletContext();
			FeedSocket ff = (FeedSocket) context.getAttribute("listener");
			ff.broadcast(finalResponse);
		}
		else
		{
			String noResults = "%";
			response.getWriter().append(noResults);
		}

	}
 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	

}
