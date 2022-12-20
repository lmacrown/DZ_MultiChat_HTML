<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DZ_MultiChat 회원가입</title>
<style>
#container {
	width: 600px;
	margin: 10px auto;
}

label {
	padding-right: 75px;
}
</style>
</head>
<body>
	<div id="container">
		<h1 style="text-align: center">회원 가입을 환영합니다</h1>
		<form>
			<fieldset>
				<legend>사용자 정보</legend>
				<ul>
					<li><label for="uid">아이디</label> <input type="text" id="uid"
						autofocus placeholder="4자 ~ 10자 사이, 공백없이" required></li>
					<li><label for="pwd" style="padding-right: 59px">비밀번호</label>
						<input type="password" id="pwd" placeholder="문자와 숫자, 특수 기호 포함"
						required></li>
					<li><label for="nickname">닉네임</label> <input type="text"
						id="nickname" required></li>
					<li><label for="email">이메일</label> <input type="email"
						id="email" required></li>
				</ul>

				<input type="submit" value="가입하기" id="insertButton">
				<button type="button"
					onClick="history.back()">취소</button>

			</fieldset>
		</form>
	</div>
	<script type="text/javascript">
    
    let insertButton = document.querySelector("#insertButton");
    insertButton.onclick = () => {
    	jsInsert();
    } 
/*     let cancelButton = document.querySelector("#cancle");
    cancelButton.onclick = () => {
    	location.href = "/multichat/jsp/login.jsp";
    }  */
    function jsInsert () {
    	//아이디 중복 확인
    	alert("as");
    	fetch('/DZ_MultiChat/Member/dupUidCheck.do?uid=' + uid.value)
    	.then(response => response.json())
    	.then(jsonResult => {

	    		if (jsonResult.status == false) {
	    			alert("[" + uid.value + "]" + jsonResult.message);
	    		} else {
	    			let param = {
	    				"uid" : uid.value,
	    				"pwd" : pwd.value,
	    				"nickname" : nickname.value,
	    				"email" : email.value
	    			};
	    			
	    			fetch('/DZ_MultiChat/Member/register.do', {
	    				//option
	    				method : 'POST',
	    				headers: {
	    				    'Content-Type': 'application/json;charset=utf-8'
	    				},
	    				body: JSON.stringify(param)	
	    			})
	    			.then(response => response.json())
	    			.then(jsonResult => {
	    				//처리후 메시지 출력
	    				alert(jsonResult.message);
	    				if (jsonResult.status == true) {
	    					//성공시 이동할 페이지로 이동한다  
	    					location.href = jsonResult.url;
	    				}
	    			});
	    		}
	    	});
    }
</script>
</body>
</html>