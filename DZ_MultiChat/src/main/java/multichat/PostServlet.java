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
		// 중복확인
		else if (request.getRequestURI().equals("/multichat/member/dupUidCheck")) {
			String uid = request.getParameter("uid");

			MemberDAO memberDAO = new MemberDAO();
			MemberBean memberBean = memberDAO.viewMember(uid);
			JSONObject jsonResult = new JSONObject();

			if (memberBean == null) {
				System.out.println("중복없음");
				jsonResult.put("status", true);
				jsonResult.put("message", "해당 아이디는 사용가능합니다");
			} else {
				System.out.println("중복있음");
				jsonResult.put("status", false);
				jsonResult.put("message", "해당 아이디는 사용 불가능합니다");
			}
			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 회원가입
		else if (request.getRequestURI().equals("/multichat/member/insert")) {
			BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
			String jsonStr = in.readLine();
			System.out.println("jsonStr = " + jsonStr);

			JSONObject jsonMember = new JSONObject(jsonStr);

			SimpleDateFormat now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String nowTime = now.format(System.currentTimeMillis());

			String uid = (String) jsonMember.get("uid");
			String pwd = (String) jsonMember.get("pwd");
			String name = (String) jsonMember.get("nickname");
			String email = (String) jsonMember.get("email");

			JSONObject jsonResult = new JSONObject();
			MemberDAO memberDAO = new MemberDAO();
			System.out.println("회원가입 시도");
			try {
				memberDAO.addMember(new MemberBean(uid, pwd, name, email, nowTime));
				System.out.println("회원가입 성공");
				jsonResult.put("status", true);
				jsonResult.put("url", "/multichat/jsp/login.jsp");
				jsonResult.put("message", "해당 아이디는 사용가능합니다");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("회원가입 실패");
				jsonResult.put("status", false);
				jsonResult.put("message", "해당아이디는  현재 사용중인 아이디 입니다 ");
			}

			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 회원정보 수정
		else if (request.getRequestURI().equals("/multichat/member/update")) {
			BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream(), "UTF-8"));
			String jsonStr = in.readLine();
			System.out.println("jsonStr = " + jsonStr);

			JSONObject jsonMember = new JSONObject(jsonStr);

			String id = (String) request.getSession().getAttribute("uid");
			String pwd = (String) jsonMember.get("pwd");
			String name = (String) jsonMember.get("nickname");
			String email = (String) jsonMember.get("email");
			System.out.println(id + " " + pwd + " " + name + " " + email + " ");
			JSONObject jsonResult = new JSONObject();
			MemberDAO memberDAO = new MemberDAO();
			System.out.println("회원수정 시도");
			try {
				memberDAO.updateMember(new MemberBean(id, pwd, name, email));
				System.out.println("회원수정 성공");
				jsonResult.put("status", true);
				jsonResult.put("url", "/multichat/jsp/home.jsp");
				jsonResult.put("message", "수정되었습니다");
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("회원수정 실패");
				jsonResult.put("status", false);
				jsonResult.put("message", "수정 실패하였습니다 ");
			}

			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 아이디 찾기
		else if (request.getRequestURI().equals("/multichat/member/findId")) {
			String email = request.getParameter("email");
			System.out.println(email);

			MemberDAO memberDAO = new MemberDAO();
			String uid = memberDAO.findUserId(email);
			JSONObject jsonResult = new JSONObject();
			if (uid == null) {
				System.out.println("아이디 없음");
				jsonResult.put("status", false);
				jsonResult.put("message", "에 해당하는 이메일이 없습니다");
			} else {
				System.out.println("아이디 있음");
				jsonResult.put("status", true);
				jsonResult.put("message", "아이디 : " + uid);
			}
			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 비밀번호 찾기
		else if (request.getRequestURI().equals("/multichat/member/findPwd")) {
			String email = request.getParameter("email");
			String uid = request.getParameter("uid");

			MemberDAO memberDAO = new MemberDAO();
			String pwd = memberDAO.findUserPwd(email, uid);
			JSONObject jsonResult = new JSONObject();

			if (pwd != null) {
				System.out.println("입력성공");
				jsonResult.put("status", true);
				jsonResult.put("message", "비밀번호 : " + pwd);

			} else {
				System.out.println("입력실패");
				jsonResult.put("status", false);
				jsonResult.put("message", "아이디 또는 이메일이 일치 하지 않습니다");
			}
			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 회원 삭제
		else if (request.getRequestURI().equals("/multichat/member/delete")) {
			String uid = request.getParameter("id");
			System.out.println(uid);
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.deleteMember(uid);
			JSONObject jsonResult = new JSONObject();

			System.out.println("삭제성공");
			jsonResult.put("status", true);
			jsonResult.put("message", "삭제되었습니다");

			PrintWriter out = response.getWriter();
			out.println(jsonResult.toString());
		}
		// 회원 휴면
		else if (request.getRequestURI().equals("/multichat/member/restCheck")) {
			String uid = request.getParameter("id");
			System.out.println(uid);
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.restCheck(uid);

			System.out.println("휴면성공");

		}
		// 회원 휴면 해제
		else if (request.getRequestURI().equals("/multichat/member/restUncheck")) {
			String uid = request.getParameter("id");
			System.out.println(uid);
			MemberDAO memberDAO = new MemberDAO();
			memberDAO.restUncheck(uid);

			System.out.println("휴면해제성공");
		}
		// 멤버 확인
		else if (request.getRequestURI().equals("/multichat/member/view")) {

			String id = request.getParameter("id");
			MemberDAO memberDAO = new MemberDAO();
			MemberBean memberBean = memberDAO.viewMember(id);
			request.setAttribute("memberBean", memberBean);
			RequestDispatcher dispatch = request.getRequestDispatcher("/jsp/member/view.jsp");
			dispatch.forward(request, response);
		} else if (request.getRequestURI().equals("/multichat/member/list")) {
			MemberDAO memberDAO = new MemberDAO();
			request.setAttribute("listMembers", memberDAO.listMembers());

			RequestDispatcher dispatch = request.getRequestDispatcher("/jsp/member/list.jsp");
			dispatch.forward(request, response);
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
