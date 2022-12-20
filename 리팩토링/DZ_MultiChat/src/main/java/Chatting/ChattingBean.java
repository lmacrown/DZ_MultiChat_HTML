package Chatting;

import java.io.Serializable;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class ChattingBean implements Serializable {
	Map<String, List> ChatRecord = Collections.synchronizedMap(new HashMap<>());
	public ChattingBean(String title, String createDate, int users) {
	      super();
	      this.title = title;
	      this.createDate = createDate;
	      this.users=users;
	}
	public ChattingBean(String id) {
	      super();
	      	this.id=id;
	}
	private String title;
	private String createDate;
	private int users;
	private String id;
}
