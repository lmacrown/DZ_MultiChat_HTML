package multichat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import org.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MemberServlet
 */
@WebServlet("/post/*")
public class PostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("MemberSevlet============ : " + request.getRequestURI());
		// 공지 확인
		if (request.getRequestURI().equals("/multichat/post/noticeCheck")) {
			System.out.println("공지확인 시작");
			PostDAO PostDAO = new PostDAO();

			String title = request.getParameter("title");
			System.out.println(title);

			PostBean checkPosts = PostDAO.checkNotice(title);

			System.out.println("공지 확인 완료");

			request.setAttribute("notice", checkPosts);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/post/noticeView.jsp");
			dispatcher.forward(request, response);

			// 좋은 방법은 아님
			// request.getSession().setAttribute("post", checkPosts);
			// response.sendRedirect("/multichat/jsp/post/noticeView.jsp");
		}
		// 게시글 확인
		else if (request.getRequestURI().equals("/multichat/post/postCheck")) {
			System.out.println("게시글목록 시작");
			PostDAO PostDAO = new PostDAO();

			String title = request.getParameter("title");
			System.out.println(title);
			PostBean checkPosts = PostDAO.checkPost(title);

			System.out.println("포스트 확인 성공");
			
			request.setAttribute("post", checkPosts);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/post/postView.jsp");
			dispatcher.forward(request, response);
		}

		// 게시글 작성
		else if (request.getRequestURI().equals("/multichat/post/addPost")) {
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String id = (String) request.getSession().getAttribute("uid");
			System.out.println(title + " " + content + " " + id);

			SimpleDateFormat now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime = now.format(System.currentTimeMillis());

			PostDAO postDAO = new PostDAO();
			JSONObject jsonResult = new JSONObject();
			try {
				postDAO.addPost(new PostBean(title, content, nowTime, id));

				jsonResult.put("status", true);
				jsonResult.put("url", "/multichat/jsp/post/post.jsp");
				jsonResult.put("message", "게시글 작성 완료");
				System.out.println("게시글작성 성공");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("게시글작성 실패");
				jsonResult.put("status", false);
				jsonResult.put("message", "게시글 작성 실패 ");
			}
			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());

		}
		//게시글 검색
		else if(request.getRequestURI().equals("/multichat/post/searchPost")) {
			System.out.println("공지검색 시작");
			PostDAO PostDAO = new PostDAO();

			String title = request.getParameter("title");
			System.out.println(title);

			PostDAO.searchPost(title);

			System.out.println("포스트검색 완료");
			JSONObject jsonResult = new JSONObject();
			request.setAttribute("title", title);
			jsonResult.put("url", "/multichat/jsp/post/postSearch.jsp");
			jsonResult.put("title", title);
			
			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());

//			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/post/post.jsp");
//			dispatcher.forward(request, response);
//			response.sendRedirect("/jsp/post/post.jsp");
			
		}
		
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
