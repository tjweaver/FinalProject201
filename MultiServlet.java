package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MultiServlet")
public class MultiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public static String fStr;
	
    public MultiServlet() {
        super();
        // TODO Auto-generated constructor stub
        fStr = "";
    }
    
    public static void appendFeedString(String searchStr)
    {
    	System.out.println("appending");
    	if(fStr.isEmpty() == true)
    	{
    		fStr = searchStr+"%";
    	}
    	else
    	{
    		fStr = fStr+searchStr+"%";
    	}
    	System.out.println(fStr);
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("in do get of multi");
		
		
		
		String testResponseStr = fStr;
		


		response.getWriter().append(testResponseStr);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
