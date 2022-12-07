<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets/css/demo_1/style.css">
<link rel="shortcut icon" href="assets/images/favicon.png"/>
<title>DZ_MultiChat</title>
<style>
	  #container {
        width:600px;
        margin:10px auto;
      }
      label{
      	padding-right: 75px;
      }
</style>
</head>
<body>
	<div id="container">
      <h1 style="text-align: center">비밀번호 찾기</h1>
      <form>
        <fieldset>   
          <ul>
            <li>
              <label for="inputEmail">이메일 입력</label>
              <input type="text" id="email" autofocus required> 
            </li>
            <li>
              <label for="inputUserId">아이디 입력</label>
              <input type="text" id="uid" required> 
            </li>
          </ul>
          <div id="buttons">
	          <input type="submit" value="확인"  id="findPwd">
	          <button type="button" onClick="location.href='/multichat/jsp/login.jsp'">취소</button>
        	</div>      
        </fieldset>
      </form>
    </div>  
<script type="text/javascript">
	let findPwdButton = document.querySelector("#findPwd");
	findPwdButton.onclick = () => {
		findPwd();
	} 
	async function findPwd() {
		let response = await fetch('/multichat/member/findPwd?email=' + 
				email.value+'&uid='+uid.value);
		let jsonResult = await response.json();
		if (jsonResult.status == true) {
			alert(jsonResult.message);
		}else{
			alert(jsonResult.message);
		}
	}
</script>      
</body>
</html>