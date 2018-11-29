package flow;
import java.util.Vector;

public class FeedThread extends Thread{
	//private Vector<Feed> pastFeeds;
	public boolean onFeedPage=false;
	int currentFeedNum=0;
	Servlet myServlet;
	
	public FeedThread(Servlet s) {
		myServlet = s;
	}
	
	public synchronized void addFeed(String username, String songName) {
		Feed adding = new Feed(username, songName);
		Server.pastFeeds.add(adding);
	}
	
	private void updateFeed() {
		//send the pastFeeds date to front-end
	}
	
	public void run() {
		while(true) {
			if(onFeedPage) {
				if(currentFeedNum!=Server.pastFeeds.size()) {
					updateFeed();
					currentFeedNum = Server.pastFeeds.size();
				}
			}
		}
	}
}
