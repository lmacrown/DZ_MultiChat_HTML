<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="assets/vendors/core/core.css">
<link rel="shortcut icon" href="assets/images/favicon.png"/>
<meta charset="UTF-8">
<title>DZ_MultiChat 로그인창</title>

</head>
<body>

아이디 : <input type="text" id="uid" name="uid"> 
비밀번호 : <input type="password" id="pwd" name="pwd"><br/>
<input type="button" value="로그인" id="loginCheck">
	 
	<form>
		<a href="member/findUserId.jsp">아이디 찾기</a>
		<a href="member/findUserPw.jsp">비밀번호 찾기</a>
		<a href="member/register.jsp">회원 가입</a>
	</form>
<script type="text/javascript">
//로그인 체크
let loginButton = document.querySelector("#loginCheck");
loginButton.onclick = () => {
	loginCheck();
}
async function loginCheck() {

	let response = await fetch('/multichat/member/loginCheck?uid=' + uid.value
			+'&pwd='+pwd.value);

	let jsonResult = await response.json();

	if (jsonResult.status == false) {
		alert("아이디 또는 비밀번호가 다릅니다");
	}else{
		location.href = jsonResult.url;
		alert("성공");
	}
}
</script>
</body>
</html>