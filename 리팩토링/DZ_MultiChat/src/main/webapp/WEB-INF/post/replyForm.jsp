<%@page import="java.io.PrintWriter"%>
<%@page import="Post.Board"%>
<%@page import="Post.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변글</title>
<link rel="stylesheet" href="/pro/css/board.css">
</head>
<body>
	<h2>답변글</h2>
	<ul>
		<li>글번호:${viewBoard.number}</li>
		<li>제목:${viewBoard.title}</li>
		<li>작성자:${viewBoard.writeId}</li>
		<li>작성일:${viewBoard.writeDate}</li>
		<li>조회수:${viewBoard.viewCount}</li>
		<li>내용:${viewBoard.content}</li>
	</ul>

	<form name="boardForm" id="boardForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="parentNo" id="parantNo" value="${viewBoard.number}">
		<label>제목</label>
		<input type="text" name="title" id="title" value="[답변] ${viewBoard.title}"><br/>
		<label>내용</label>
		<input type="text" name="content" id="content"/><br/>
	
		<table>
			<tbody>
				<tr>
					<th><label>첨부파일</label></th>
					<td><input type="file" name="filename1" id="filename1"/></td>
					<td><input type="button" value="추가" class="insertFile"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr style="display:none">
					<th><label>첨부파일</label></th>
					<td><input type="file" name="filename1" id="filename1"/></td>
					<td><input type="button" value="추가" class="insertFile"></td>
					<td><input type="button" value="삭제" class="deleteFile"></td>
				</tr>
			</tfoot>
		</table>
		<br/>
		<input type="submit" id="write" name="write" value="답글등록"  > 
		<input type="button" name="cancle" value="취소" onClick="history.back()">
	</form>


	<script type="text/javascript">
	let boardForm = document.querySelector("#boardForm");
	boardForm.addEventListener("submit", (e) => {
		e.preventDefault();
		
		fetch('/DZ_MultiChat/post/reply.do', {		
			method : 'POST',
		    cache: 'no-cache',
			body: new FormData(boardForm)		
		})
		.then(response => response.json())
		.then(jsonResult => {
			alert(jsonResult.message);
			if (jsonResult.status == true) {
				location.href = jsonResult.url;
			}
		});
	});

	</script>
</body>
</html>