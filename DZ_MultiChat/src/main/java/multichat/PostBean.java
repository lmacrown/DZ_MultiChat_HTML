package multichat;

import lombok.Data;

@Data
public class PostBean {
	public PostBean(String title, String content, String registDate, int views) {
	      super();
	      this.title = title;
	      this.content = content;
	      this.registDate = registDate;
	      this.views= views;
	}
	public PostBean(String title, String content, String registDate) {
	      super();
	      this.title = title;
	      this.content = content;
	      this.registDate = registDate;
	}
	public PostBean(String title, String content, String registDate, String id) {
	      super();
	      this.title = title;
	      this.content = content;
	      this.registDate = registDate;
	      this.id=id;
	}
	public PostBean(String title, String content, String registDate, int views, String id) {
	      super();
	      this.title = title;
	      this.content = content;
	      this.registDate = registDate;
	      this.views=views;
	      this.id=id;
	}
	private String title;
	private String content;
	private String registDate;
	private int views;
	private String id;
}
