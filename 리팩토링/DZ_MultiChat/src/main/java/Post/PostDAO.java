package Post;

import java.sql.Connection;
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
			conn = dataFactory.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int totalPageNo(String text) {
		int totalPageSize = 0; 
		final int rowSize = 10; 
		try {
			String query = "select ceil(COUNT(*) / ? ) from board where title like "
					+ "concat('%', ?, '%') or content like concat('%', ?, '%')or "
					+ "writeId like concat('%', ?, '%') ";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, rowSize);
			pstmt.setString(2, text);
			pstmt.setString(3, text);
			pstmt.setString(4, text);
			ResultSet rs = pstmt.executeQuery();
			
			if (rs.next()) {
				totalPageSize = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalPageSize; 

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

	public List<Board> list(String text, int pageNo) {
		List<Board> list = new ArrayList<>();
		final int rowSize = 10;
		try {
			text = text == null ? "" : text;
			
			// connDB();
			String query = "select * from board where title like concat('%', ?, '%') "
					+ "or content like concat('%', ?, '%')or writeId like concat('%', ?, '%') "
					+ "ORDER BY parentNo, `NUMBER` limit ?, ?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, text);
			pstmt.setString(2, text);
			pstmt.setString(3, text);
			pstmt.setInt(4, (pageNo-1) * rowSize);
			pstmt.setInt(5, rowSize);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board(
						rs.getString("number"),	
						rs.getString("parentNo"),	
						rs.getString("title"),	
						rs.getString("content"),
						rs.getString("writeId"),
						rs.getDate("writeDate"),
						rs.getInt("viewCount"),
						rs.getInt("like_count"),
						rs.getInt("dis_like_count")
						);
				System.out.println(board);
				list.add(board);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/*
	 * public List<Board> searchPost(String title) { List<Board> list = new
	 * ArrayList<>(); try { // connDB(); System.out.println("검색 시작");
	 * System.out.println(title); conn = dataFactory.getConnection(); String query =
	 * "select * from board where title like  concat('%', ?, '%') ORDER BY parentNo, `NUMBER` "
	 * ; System.out.println("prepareStatememt: " + query); pstmt =
	 * conn.prepareStatement(query); pstmt.setString(1, title); ResultSet rs =
	 * pstmt.executeQuery();
	 * 
	 * System.out.println("게시글 확인"); while (rs.next()) { Board board = new
	 * Board(rs.getString("number"), rs.getString("parentNo"),
	 * rs.getString("title"), rs.getString("content"), rs.getString("writeId"),
	 * rs.getDate("writeDate"), rs.getInt("viewCount"), rs.getInt("like_count"),
	 * rs.getInt("dis_like_count")); list.add(board); } rs.close(); pstmt.close();
	 * conn.close(); } catch (Exception e) { e.printStackTrace(); } return list; }
	 */
	// 게시물 등록
	public int addBoard(String title, String content, String writeId) throws SQLException {
		String query = "insert into board (title, content, writeId) VALUES(?,?,?)";
		System.out.println("prepareStatememt: " + query);
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, writeId);
		pstmt.executeUpdate();

		pstmt.close();

		query = "SELECT LAST_INSERT_ID()";
		pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		int number = 0;
		if (rs.next()) {
			number = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.commit();

		return number;
	}

	public int addBoard(Board board) throws SQLException {
		String query = "insert into board (parentNo, title, content, writeId) VALUES(?,?,?,?)";
		System.out.println("prepareStatememt: " + query);
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, board.getParentNo());
		pstmt.setString(2, board.getTitle());
		pstmt.setString(3, board.getContent());
		pstmt.setString(4, board.getWriteId());
		pstmt.executeUpdate();

		pstmt.close();

		query = "SELECT LAST_INSERT_ID()";
		pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		int number = 0;
		if (rs.next()) {
			number = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.commit();

		return number;
	}

	public void fixPost(PostBean postBean) {
		try {
			String query = "update board set content=?, registDate=?, id=? where title=?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
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

	public void addQnA(PostBean postBean) {
		try {
			String query = "insert into qna (title, content, registDate, id)";
			query += " values (?,?,?,?)";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
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

	public PostBean checkNotice(String title) {
		try {
			// connDB();
			conn = dataFactory.getConnection();
			String query = "select * from notice where title = ?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, title);
			ResultSet rs = pstmt.executeQuery();
			PostBean postBean = null;
			System.out.println("공지 확인");
			if (rs.next()) {
				postBean = new PostBean(
						rs.getString("title"), 
						rs.getString("content"),
						rs.getString("registDate"),
						rs.getInt("views"));
			}
			rs.close();
			return postBean;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
			} catch (Exception e) {
			}
		}
		return null;
	}

	public List<Board> checkPost(String number) {
		List<Board> list = new ArrayList<>();
		try {
			String query = "select * from board where number = ?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, number);
			ResultSet rs = pstmt.executeQuery();
			
			String parentNo=null;
			if(rs.next())
				parentNo=rs.getString("parentNo");
			query = "select * from board where parentNo = ?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, parentNo);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Board board = new Board(
						rs.getString("number"), 
						rs.getString("parentNo"), 
						rs.getString("title"),
						rs.getString("content"), 
						rs.getString("writeId"), 
						rs.getDate("writeDate"),
						rs.getInt("viewCount"), 
						rs.getInt("like_count"), 
						rs.getInt("dis_like_count"));
				list.add(board);
			}
				rs.close();
				pstmt.close();
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return list;
	}
	public Board replyPost(String number) {
		try {
			String query = "select * from board where number = ?";
			System.out.println("prepareStatememt: " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, number);
			ResultSet rs = pstmt.executeQuery();
			Board board = null;

			if (rs.next()) {
				board = new Board(
						rs.getString("number"), 
						rs.getString("parentNo"), 
						rs.getString("title"),
						rs.getString("content"), 
						rs.getString("writeId"), 
						rs.getDate("writeDate"),
						rs.getInt("viewCount"), 
						rs.getInt("like_count"), 
						rs.getInt("dis_like_count"));
			}
			rs.close();

			return board;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}
		return null;
	}
	/*
	 * public int insertMember(MemberBean memberBean) throws SQLException{ try { //
	 * connDB(); conn = dataFactory.getConnection(); String query =
	 * "insert into member (id, pwd, name, email) values (?,?,?,?)";
	 * System.out.println("prepareStatememt: " + query); pstmt =
	 * conn.prepareStatement(query); pstmt.setString(1, memberBean.getId());
	 * pstmt.setString(2, memberBean.getPwd()); pstmt.setString(3,
	 * memberBean.getName()); pstmt.setString(4, memberBean.getEmail()); return
	 * pstmt.executeUpdate(); // } catch (SQLException e) { // e.printStackTrace();
	 * // throw e; //해당 함수를 호출한 부분으로 예외를 던진다 } finally { try { pstmt.close();
	 * conn.close(); } catch (Exception e) {} } }
	 */

	public void close() throws Exception {
		if (conn != null) {
			conn.close();
		}
	}
}
