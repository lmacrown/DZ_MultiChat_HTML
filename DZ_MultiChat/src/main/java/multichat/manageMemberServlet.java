package multichat;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/manageMember")
public class manageMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDAO memberDAO = new MemberDAO();
		List<MemberBean> list = memberDAO.listMembers();
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String html = """
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 창</title>
</head>
<body>
<form name="profile" action="/project/adminShow">
<input type="text" id="uid" name="uid">
<input type="submit" value="회원검색"><br>
</form>
<table border='1'>
	<thead>
		<tr>
			<th>아이디</th>
			<th>비번</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>삭제</th>
			<th>정지</th>
			<th>활성화</th>
		</tr>
	</thead>
	<tbody>
				""";
		for (MemberBean member : list) {
			html += "<tr>";
			html += "<td>" + member.getId() + "</td>";
			html += "<td>" + member.getPwd() + "</td>";
			html += "<td>" + member.getName() + "</td>";
			html += "<td>" + member.getEmail() + "</td>";
			html += "<td>" + member.getEmail() + "</td>";
			html += "<td><a href='deleteAdmin?userid=" + member.getId() + "'>삭제</a></td>";
			html += "<td><a href='stop?userid=" + member.getId() + "'>정지</a></td>";
			html += "<td><a href='act?userid=" + member.getId() + "'>활성화</a></td>";
			html += "</tr>";
		}
		
	html += """
	</tbody>
</table>				
				"""; 
		out.println(html);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
