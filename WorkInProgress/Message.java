import java.io.Serializable;

public class Message implements Serializable {
	public static final long serialVersionUID = 1;
	
	public String name;
	public String message;
	public Message(String name, String message) {
		this.name = name;
		this.message = message;
	}
	public Message(String message) {
		this.name = "";
		this.message = message;
	}
	
	public String getName() {
		return name;
	}
//	
//	public void appendNumber(int num) {
//		this.name = this.name+num; 
//	}
	
	public String getMessage() {
		return message;
	}
	
	

}