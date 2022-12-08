package multichat;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class PostDAO {
	Connection conn;
	PreparedStatement pstmt;
	DataSource dataFactory;
	
	public PostDAO() {
		try {
			Context context = new InitialContext();
			Context envContext = (Context) context.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/pro05DB");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<PostBean> listNotices() {
		List<PostBean> list = new ArrayList<>();
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from notice ";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PostBean post = new PostBean(
						rs.getString("title"),	
						rs.getString("content"),	
						rs.getString("registDate"),	
						rs.getInt("views"));	
				System.out.println(post);
				list.add(post);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<PostBean> listPosts() {
		List<PostBean> list = new ArrayList<>();
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from t_board ";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PostBean post = new PostBean(
						rs.getString("title"),	
						rs.getString("content"),	
						rs.getString("registDate"),	
						rs.getInt("views"));	
				System.out.println(post);
				list.add(post);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public String checkNotice(String title) {
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from notice where title=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, title);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) 
				return rs.getString("content");
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;	
	}
	public String checkPost(String title) {
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from t_board where title=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, title);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) 
				return rs.getString("content");
			else
				return null;
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return null;	
	}
	public void addPost(PostBean postBean) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "insert into t_board (title, content, registDate, id)";
			query += " values (?,?,?,?)";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, postBean.getTitle());
			pstmt.setString(2, postBean.getContent());
			pstmt.setString(3, postBean.getRegistDate());
			pstmt.setString(4, postBean.getId());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void updateMember(MemberBean member) {
		try {
			System.out.println("회원정보 수정");
			Connection con = dataFactory.getConnection();
			String query = "update t_member set pwd=?, name=?,email=? where id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getId());
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void deleteMember(String uid) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "delete from t_member where id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void restCheck(String uid) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "update t_member set use_yn='N' where id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void restUncheck(String uid) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "update t_member set use_yn='Y' where id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, uid);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public MemberBean viewMember(String id) {
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from t_member where id = ?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			MemberBean memberBean = null;
			System.out.println("중복체크");
			if (rs.next()) {
				memberBean = new MemberBean(
						rs.getString("id"),	
						rs.getString("pwd"),	
						rs.getString("name"),	
						rs.getString("email"),	
						rs.getString("joinDate"));
			}
			rs.close();
			System.out.println("중복체크 완료");
			System.out.println(memberBean);
			return memberBean;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {}
		}
		return null;		
	}

	/*
	 * public int insertMember(MemberBean memberBean) throws SQLException{ try { //
	 * connDB(); conn = dataFactory.getConnection(); String query =
	 * "insert into t_member (id, pwd, name, email) values (?,?,?,?)";
	 * System.out.println("prepareStatememt: " + query); pstmt =
	 * conn.prepareStatement(query); pstmt.setString(1, memberBean.getId());
	 * pstmt.setString(2, memberBean.getPwd()); pstmt.setString(3,
	 * memberBean.getName()); pstmt.setString(4, memberBean.getEmail()); return
	 * pstmt.executeUpdate(); // } catch (SQLException e) { // e.printStackTrace();
	 * // throw e; //해당 함수를 호출한 부분으로 예외를 던진다 } finally { try { pstmt.close();
	 * conn.close(); } catch (Exception e) {} } }
	 */
	
	public String findUserId(String email) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "Select id from t_member where email=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			System.out.println("아이디 찾기");
			if (rs.next()) 
				return rs.getString("id");
			
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	public String findUserPwd(String email, String uid) {
		try {
			Connection con = dataFactory.getConnection();
			String query = "Select pwd from t_member where email=? and id=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, uid);
			ResultSet rs = pstmt.executeQuery();
			System.out.println("비밀번호 찾기");
			if (rs.next()) 
				return rs.getString("pwd");
			
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}	
}
