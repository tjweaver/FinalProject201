package flow;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Vector;

class FeedSocket extends Thread{

	private Vector<ServerThread> serverThreads;
	private ServerSocket ss;
	
	public FeedSocket() {
		int port = 9002;
		try {
			System.out.println("Binding to port " + port);
			ss = new ServerSocket(port);
			System.out.println("Bound to port " + port);
			serverThreads = new Vector<ServerThread>();
			this.start();
		} catch (IOException ioe) {
			System.out.println("ioe in ChatRoom constructor: " + ioe.getMessage());
		}
	}
	
	public void broadcast(String message) {
		if (message != null) {
			System.out.println(message);
			for(ServerThread threads : serverThreads) {
				threads.sendMessage(message);
			}
		}
	}
	
	public void run() {
		while(true) {
			Socket s;
			try {
				s = ss.accept();
				System.out.println("Connection from: " + s.getInetAddress());
				ServerThread st = new ServerThread(s, this);
				serverThreads.add(st);
			} catch (IOException e) {
				System.out.println("Error adding client thread");
				System.out.println(e.getMessage());
			} // blocking
		}
	}
}