package Post;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Member;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BoardAction  {
       
	public String list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("list 실행");
		request.setCharacterEncoding("UTF-8");
		String text = request.getParameter("title");
		String pageNoStr = request.getParameter("pageNo");
		PostDAO boardDAO = new PostDAO();
		if ("".equals(pageNoStr) || null == pageNoStr) pageNoStr = "1";
		int pageNo = Integer.parseInt(pageNoStr);
		int pageSize = 10;
		int totalPageNo = boardDAO.totalPageNo(text);
		int startPageNo = ((pageNo - 1) / pageSize) * pageSize + 1;
		int endPageNo = startPageNo + pageSize - 1;
		
		if (endPageNo > totalPageNo) endPageNo = totalPageNo;
		List<Board> list = boardDAO.list(text, pageNo);
		request.setAttribute("list", list);
		request.setAttribute("totalPageNo", totalPageNo);
		request.setAttribute("startPageNo", startPageNo);
		request.setAttribute("endPageNo", endPageNo) ;
		request.setAttribute("currentPageNo", pageNo) ;
		boardDAO.close();
		return "/post/post.jsp";
	}

	public String view(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String number = request.getParameter("number");
		System.out.println("view 실행");
		PostDAO boardDAO = new PostDAO();
		List<Board> viewBoard= boardDAO.checkPost(number);
		request.setAttribute("viewBoard", viewBoard);
		boardDAO.close();
		
		return "/post/postView.jsp";
	}

	
	public String replyForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String number = request.getParameter("number");
	
		PostDAO boardDAO = new PostDAO();
		request.setAttribute("viewBoard", boardDAO.replyPost(number));
		boardDAO.close();
		
		return "/post/replyForm.jsp";
	}
	
	public JSONObject reply(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("write in");
		HttpSession session = request.getSession();
		
		// 저장소 객체 생성  
		DiskFileItemFactory factory = new DiskFileItemFactory();

		//업로드 파일 임시로 저장할 경로 설정 
		factory.setRepository(new File("c:\\upload"));

		// 파일 업로드 객체에 저장소 설정 
		ServletFileUpload upload = new ServletFileUpload(factory);

		System.out.println(request.getRemoteAddr());
		// 요청 객체를 파싱한다 
		try {
			Map<String, List<FileItem>> mapItems = upload.parseParameterMap(request);

			PostDAO boardDAO = new PostDAO();
			BoardFileDAO boardFileDAO = new BoardFileDAO();
			JSONObject jsonResult = new JSONObject();
			
			Board board = Board.builder()
					.parentNo(mapItems.get("parentNo").get(0).getString())
					.title(new String(mapItems.get("title").get(0).getString().getBytes("ISO-8859-1"), "UTF-8"))
					.content(new String(mapItems.get("content").get(0).getString().getBytes("ISO-8859-1"), "UTF-8"))
					.writeId("member")
					.build();
			
			try {
				int number = boardDAO.addBoard(board);
				
				//첨부파일 정보 얻어 저장 
				for(FileItem fileItem : mapItems.get("filename1")) {
					if (fileItem.getSize() == 0) continue;
					
					String real_name = "c:\\upload\\" + System.nanoTime();
					fileItem.write(new File(real_name));
	
					BoardFile boardFile = new BoardFile(0, number, fileItem.getName(), 
							real_name, fileItem.getContentType(), fileItem.getSize());
					boardFileDAO.insertBoardFile(boardFile);
				}
				boardFileDAO.close();
				boardDAO.close();
				
				jsonResult.put("status", true);
				jsonResult.put("message", "답변글쓰기를 성공했습니다.");
				jsonResult.put("url", "/DZ_MultiChat/post/postView.do?number=" + number);
				
			} catch (SQLException e) {
				jsonResult.put("status", false);
				jsonResult.put("message", "작성 중에 오류가 발생했습니다.");
				e.printStackTrace();
			}
			boardDAO.close();

			return jsonResult;
			
		} catch (Exception e) {
			e.printStackTrace();
		}		

		return null;
	}
	
	/*
	 * public String search(HttpServletRequest request, HttpServletResponse
	 * response) throws Exception { String title = request.getParameter("title");
	 * 
	 * PostDAO boardDAO = new PostDAO(); List<Board> searchBoard=
	 * boardDAO.searchPost(title); request.setAttribute("searchBoard", searchBoard);
	 * boardDAO.close();
	 * 
	 * return "/post/post.jsp"; }
	 */

	public String writeForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return "/jsp/board/writeForm.jsp";
	}
	
	public JSONObject write(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("write in");
		HttpSession session = request.getSession();
		String titles = (String)request.getParameter("title");
		// 저장소 객체 생성  
		DiskFileItemFactory factory = new DiskFileItemFactory();

		//업로드 파일 임시로 저장할 경로 설정 
		factory.setRepository(new File("c:\\upload"));

		// 파일 업로드 객체에 저장소 설정 
		ServletFileUpload upload = new ServletFileUpload(factory);

		System.out.println(request.getRemoteAddr());
		// 요청 객체를 파싱한다 
		try {
			Map<String, List<FileItem>> mapItems = upload.parseParameterMap(request);
			
			String title = new String(mapItems.get("title").get(0).getString().getBytes("ISO-8859-1"), "UTF-8"); 
			String content = new String(mapItems.get("content").get(0).getString().getBytes("ISO-8859-1"), "UTF-8");
			Member member = (Member)session.getAttribute("session_member");
			PostDAO boardDAO = new PostDAO();
			BoardFileDAO boardFileDAO = new BoardFileDAO();
			JSONObject jsonResult = new JSONObject();
			
			try {
				int number = boardDAO.addBoard(title, content, "member");
				
				//첨부파일 정보 얻어 저장 
				for(FileItem fileItem : mapItems.get("filename1")) {
					if (fileItem.getSize() == 0) continue;
					
					String real_name = "c:\\upload\\" + System.nanoTime();
					fileItem.write(new File(real_name));
	
					BoardFile boardFile = new BoardFile(0, number, fileItem.getName(), 
							real_name, fileItem.getContentType(), fileItem.getSize());
					boardFileDAO.insertBoardFile(boardFile);
				}
				boardFileDAO.close();
				boardDAO.close();
				
				jsonResult.put("status", true);
				jsonResult.put("message", "글쓰기를 성공했습니다.");
				jsonResult.put("url", "/pro/jsp/board/boardList.jsp");
				
			} catch (SQLException e) {
				jsonResult.put("status", false);
				jsonResult.put("message", "작성 중에 오류가 발생했습니다.");
				e.printStackTrace();
			}
			boardDAO.close();

			return jsonResult;
			
		} catch (Exception e) {
			e.printStackTrace();
		}		

		return null;
	}
}
