package Chatting;

import java.io.IOException;
import java.io.PrintWriter;

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
//@WebServlet("/chatting/*")
public class ChattingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChattingServlet() {
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
		// 채팅방 입장
		if (request.getRequestURI().equals("/multichat/chatting/chatroom")) {
			System.out.println("채팅 시작");
			ChattingDAO chattingDAO = new ChattingDAO();

			String title = request.getParameter("title");
			String id = (String) request.getSession().getAttribute("uid");
			request.getSession().setAttribute("title", title);
			
			System.out.println(title + " " + id);

			chattingDAO.dupUser(title, id);

			System.out.println("채팅방 입장완료");

			RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/member/chatting.jsp");
			dispatcher.forward(request, response);

			// 좋은 방법은 아님
			// request.getSession().setAttribute("post", checkPosts);
			// response.sendRedirect("/multichat/jsp/post/noticeView.jsp");
		}
		// 채팅방 퇴장
		else if (request.getRequestURI().equals("/multichat/chatting/exitUser")) {
			System.out.println("채팅 종료");
			ChattingDAO chattingDAO = new ChattingDAO();

			String id = (String) request.getSession().getAttribute("uid");
			JSONObject jsonResult = new JSONObject();
			chattingDAO.ExitChatRoom(id);
			jsonResult.put("status", true);
			jsonResult.put("url", "/multichat/jsp/home.jsp");
			System.out.println("채팅방 퇴장완료");

			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 채팅 입력
		else if (request.getRequestURI().equals("/multichat/chatting/chat")) {
			System.out.println("chat");
			ChattingDAO chattingDAO = new ChattingDAO();

			String id = (String) request.getSession().getAttribute("uid");
			String title = (String) request.getSession().getAttribute("title");
			JSONObject jsonResult = new JSONObject();
			chattingDAO.ExitChatRoom(id);
			jsonResult.put("status", true);
			jsonResult.put("url", "/multichat/jsp/home.jsp");
			System.out.println("채팅방 퇴장완료");

			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		//채팅방 생성
		else if (request.getRequestURI().equals("/multichat/chatting/insert")) {
			System.out.println("채팅 생성");
			ChattingDAO chattingDAO = new ChattingDAO();

			String title = request.getParameter("title");
			System.out.println(title);
			JSONObject jsonResult = new JSONObject();
			chattingDAO.CreateRoom(title);
			jsonResult.put("status", true);
			jsonResult.put("url", "/multichat/jsp/home.jsp");

			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
