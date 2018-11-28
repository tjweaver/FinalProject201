import java.io.Serializable;

public class UserInfo implements Serializable {
	public static final long serialVersionUID = 2;
	public String name;
	public String password;
	public int wins;
	public int losts;
	public String action = "";
	
	public UserInfo(String name, String password) {
		this.name = name;
		this.password = password;
	}
	
	public UserInfo(String name, String password, int wins, int losts) {
		this.name = name;
		this.password = password;
		this.wins=wins;
		this.losts=losts;
	}
}