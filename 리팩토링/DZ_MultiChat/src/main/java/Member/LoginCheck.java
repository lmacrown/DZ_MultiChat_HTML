package Member;

import java.io.IOException;
import java.io.PrintWriter;


import org.json.JSONObject;

import multichat.Action;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginCheck implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("logincheck 시작");
		JSONObject jsonResult = new JSONObject();
		MemberDAO memberDAO = new MemberDAO();

		String id = request.getParameter("uid");
		String pw = request.getParameter("pwd");

		String checking = memberDAO.checkMember(id, pw);
		if (checking.equals("admin"))
			jsonResult.put("url", "/multichat/jsp/adminPage.jsp");
		if (checking.equals("valid")) {
			request.getSession().setAttribute("uid", id);
			System.out.println("로그인 성공");
			jsonResult.put("status", true);
			jsonResult.put("url", "/multichat/jsp/home.jsp");
		} else if (checking.equals("not_match")) {
			System.out.println("로그인 실패");
			jsonResult.put("status", false);
		} else if (checking.equals("invalid")) {
			System.out.println("휴면");
			jsonResult.put("status", "invalid");
		}
		PrintWriter out = response.getWriter();
		out.println(jsonResult.toString());
	}
}
