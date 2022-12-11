package multichat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ChattingDAO {
	Connection conn;
	PreparedStatement pstmt;
	DataSource dataFactory;
	Map<String, List> ChatMap = Collections.synchronizedMap(new HashMap<>());
	public ChattingDAO() {
		try {
			Context context = new InitialContext();
			Context envContext = (Context) context.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/pro05DB");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<ChattingBean> listChatting() {
		List<ChattingBean> list = new ArrayList<>();
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from chattingroom ";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ChattingBean Chatting = new ChattingBean(
						rs.getString("title"),	
						rs.getString("createDate"),
						rs.getInt("users"));
				System.out.println(Chatting);
				list.add(Chatting);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public void dupUser(String title, String id) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "select * from ? where id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, title);
			pstmt.setString(2, id);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next())
				EnterChatRoom(title, id);
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	public void EnterChatRoom(String title, String id) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "insert into chat values (?,?)";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, title);
			pstmt.setString(2, id);
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	public void ExitChatRoom(String id) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "delete from chat where id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, id);
			pstmt.executeQuery();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public List<ChattingBean> searchChat(String title) {
		List<ChattingBean> list = new ArrayList<>();
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select id from chat where title=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, title);
			ResultSet rs = pstmt.executeQuery();
			
			System.out.println("유저 확인");
			while (rs.next()) {
				ChattingBean chat = new ChattingBean(
						rs.getString("id"));
				list.add(chat);
				
			}
			ChatMap.put(title,list);
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {}
		}
		return list;		
	}

}