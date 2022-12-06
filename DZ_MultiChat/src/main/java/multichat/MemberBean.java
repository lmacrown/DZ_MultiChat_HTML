package multichat;

import lombok.Data;

@Data
public class MemberBean {
	public MemberBean(String id, String pwd, String name, String email, String joinDate) {
	      super();
	      this.id = id;
	      this.pwd = pwd;
	      this.name = name;
	      this.email= email;
	      this.joinDate = joinDate;
	   }
	public MemberBean(String pwd, String name, String email) {
	      super();
	      this.pwd = pwd;
	      this.name = name;
	      this.email= email;
	   }
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String joinDate;
}
