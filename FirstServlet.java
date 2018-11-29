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
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("in do get");
		String songNameFromFront = request.getParameter("songname");
		String artistNameFromFront = request.getParameter("artistname");
		String userFromFront = request.getParameter("username");
		String feedString = userFromFront+" searched for "+songNameFromFront+" by "+artistNameFromFront;
		
		ServletContext context = request.getSession().getServletContext();
		FeedSocket ff = (FeedSocket) context.getAttribute("listener");
		ff.broadcast(feedString);

//		String testResponseStr = "Superposition by Young the Giant%Take Me Home, Country Roads by John Denvers%God's Plan by Drake%";
//		response.getWriter().append(testResponseStr);
		
	}
 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	

}
