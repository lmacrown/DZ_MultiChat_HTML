<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%-- <%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javax.sql.DataSource"%>
<%@ page import="javax.naming.Context"%>
<%@ page import="javax.naming.InitialContext"%>

<%!// 변수 선언
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

DataSource dataFactory;%> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" href="assets/css/demo_1/style.css"> -->
<link rel="shortcut icon" href="assets/images/favicon.png"/>
<title>adminPage</title>
<style>
	  #container {
        margin:10px auto;
      }
      fieldset{
      margin-left: auto;
      margin-right: auto;
      }
      table, th, td {
  border:1px solid #222;  /* 표 테두리 */
  border-collapse: collapse;  /* 테두리 1줄만 표시 */
}
table{
  margin-left: auto;
  margin-right: auto;
}
tr{
text-align: center;
}
</style>
</head>
<body>
<%
/* try {
Context context = new InitialContext();
Context envContext = (Context) context.lookup("java:/comp/env");
dataFactory = (DataSource) envContext.lookup("jdbc/pro05DB");
// 데이터베이스에 연결하는 작업 수행
Connection conn = dataFactory.getConnection();
// 쿼리를 생성할 객체 생성
Statement stmt = conn.createStatement();
// 쿼리 생성
ResultSet rs = stmt.executeQuery("select * from t_member"); */

MemberDAO memberDAO = new MemberDAO();
List<MemberBean> list = memberDAO.listMembers();
request.setAttribute("list",list);
%> 
<div id="container">
		<h1 style="text-align: center; margin-top: 30px;">회원 목록</h1>
		<form>
			<fieldset>
				<ul>
					<li style="c">
						<label id="inputId">회원 아이디 입력</label> 
						<input type="text" style="width: 50%" id="searchId" autofocus required>
						<input type="button" style="margin-left: 30px"value="확인" id="findId"> 
					</li>
				</ul>
			</fieldset>
		</form>
		<form>
			<fieldset>
				<table style="gravity:">
					<thead>
						<tr>
							<th class="pt-0" style="width: 10%">아이디</th>
							<th class="pt-0" style="width: 10%">비밀번호</th>
							<th class="pt-0" style="width: 10%">닉네임</th>
							<th class="pt-0" style="width: 20%">이메일</th>
							<th class="pt-0" style="width: 30%">가입일</th>
							<th class="pt-0" style="width: 20%">관리</th>
						</tr>
					</thead>
						<tbody>
		
							<c:forEach var="memberDAO" items="${list}">
								<c:if test="${memberDAO.id != 'admin' }">
										<tr>
											<td>${memberDAO.id} </td>
											<td>${memberDAO.pwd} </td>
											<td>${memberDAO.name} </td>
											<td>${memberDAO.email} </td>
											<td>${memberDAO.joinDate} </td>
											<%-- <td><%=rs.getString("pwd")%></td>
											<td><%=rs.getString("name")%></td>
											<td><%=rs.getString("email")%></td>
											<td><%=rs.getString("joinDate") %></td> --%>
											<td><input type="button" value="삭제" 
											onclick="location.href='/multichat/member/admindelete?id=${memberDAO.id}'">
											<input type="button" value="휴면" 
											onclick="location.href='/multichat/member/restCheck?id=${memberDAO.id}'">
											<input type="button" value="해제" 
											onclick="location.href='/multichat/member/restUncheck?id=${memberDAO.id}'"></td></br>
			
										</tr>
									</c:if>
							</c:forEach>
						</tbody>
					</table>
				</fieldset>
			</form>
		</div>
	
<%-- <%
	
	}
 catch (Exception e) {
e.printStackTrace();
} finally {
try {
if (rs != null) {
rs.close();
}
if (stmt != null) {
stmt.close();
}
if (conn != null) {
conn.close();
}
} catch (Exception e) {
e.printStackTrace();
}
}

%> --%>
<!-- <script type="text/javascript">
let deleteButton = document.querySelector("#deleteId");
deleteButton.onclick = () => {
	deleteId();
}
function deleteId() {
	alert("삭제실행");
		let param = {
			"uid" : uid.value
		};
		
		fetch('/multichat/member/delete', {
			//option
			method : 'POST',
			headers: {
			    'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify(param)	
		})
		.then(response => response.json())
		.then(jsonResult => {
			if (jsonResult.status == true) {
				//성공시 이동할 페이지로 이동한다  
				alert("삭제되었습니다");
			}
		});
	
}
</script> -->
</body>
</html>