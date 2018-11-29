package flow;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class Startup implements ServletContextListener{
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("ServletContextListener destroyed");
	}

        //Run this before web application is started
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		System.out.println("ServletContextListener started");
		FeedSocket fs = new FeedSocket();
		arg0.getServletContext().setAttribute("listener", fs);
	}
}
