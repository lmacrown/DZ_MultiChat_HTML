<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DZ_MultiChat 회원정보수정</title>
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
      <h1 style="text-align: center">회원 정보 수정</h1>
      <form>
        <fieldset>  
          <ul>
            <li>
              <label for="uid">아이디</label>
              <output>고정</output>
            </li>
            <li>
              <label for="pwd" style="padding-right:59px">비밀번호</label>
              <input type="password" id="pwd" placeholder="문자와 숫자, 특수 기호 포함" autofocus required> 
            </li>   
             <li>
              <label for="nickname">닉네임</label>
              <input type="text" id="nickname" required> 
            </li>     
            <li>
              <label for="email">이메일</label>
              <input type="email" id="email" required> 
            </li>
          </ul>
          <div id="buttons">
          <input type="submit" value="수정하기" id="updateButton">
          <input type="button" value="탈퇴하기" id="deleteButton">
          <input type="reset" value="취소">
        	</div>      
        </fieldset>
      </form>
    </div>    
<script type="text/javascript">
    
    let updateButton = document.querySelector("#updateButton");
    updateButton.onclick = () => {
    	updateButton();
    } 
    let deleteButton = document.querySelector("#deleteButton");
    deleteButton.onclick = () => {
    	deleteButton();
    } 
    function updateButton(){
    	let param = {
				"uid" : uid.value,
				"pwd" : pwd.value,
				"nickname" : nickname.value,
				"email" : email.value
			};
    	fetch('/multichat/member/update', {
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
    function deleteButton(){
    	//alert("정말로 삭제하시겠습니까?");
    	let param = "uid" : uid.value,

    	fetch('/multichat/member/delete')
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
</script>
</body>
</html>