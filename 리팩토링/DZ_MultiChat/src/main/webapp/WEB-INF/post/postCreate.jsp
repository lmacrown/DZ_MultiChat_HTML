<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="multichat.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../assets/css/demo_1/style.css">
<link rel="shortcut icon" href="../assets/images/favicon.png" />
<title>DZ_MultiChat 게시글 작성</title>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
</head>
<body class="sidebar-dark">
	<div class="main-wrapper">
		<nav class="sidebar">
			<div class="sidebar-header">
				<a class="sidebar-brand"> DZ<span>CHAT</span>
				</a>
				<div class="sidebar-toggler active">
					<span></span> <span></span> <span></span>
				</div>
			</div>
			<div class="sidebar-body">
				<ul class="nav">

					<li class="nav-item"><a href="/multichat/jsp/home.jsp"
						class="nav-link"> <i class="link-icon" data-feather="box"></i>
							<span class="link-title">홈</span>
					</a></li>

					<li class="nav-item nav-category">게시글</li>

					<li class="nav-item"><a class="nav-link"
						href="/multichat/jsp/post/notice.jsp"> <i class="link-icon"
							data-feather="feather"></i> <span class="link-title">공지 사항</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/multichat/jsp/post/post.jsp"> <i class="link-icon"
							data-feather="anchor"></i> <span class="link-title">일반 게시판</span>
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/multichat/jsp/post/QnA.jsp"> <i class="link-icon"
							data-feather="inbox"></i> <span class="link-title">QnA</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="../login.jsp">
							<i class="link-icon" data-feather="log-out"></i> <span
							class="link-title">로그아웃</span>
					</a></li>
				</ul>
			</div>
		</nav>
		<div class="page-wrapper">
			<nav class="navbar">
				<div class="navbar-content">
					<ul class="navbar-nav">
						<li class="nav-item dropdown nav-profile"><a
							class="nav-link dropdown-toggle" href="#" id="profileDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <img
								src="https://via.placeholder.com/30x30" alt="userr">
						</a>
							<div class="dropdown-menu" aria-labelledby="profileDropdown">
								<div
									class="dropdown-header d-flex flex-column align-items-center">
									<div class="figure mb-3">
										<img src="https://via.placeholder.com/80x80" alt="">
									</div>
									<div class="info text-center">
										<p class="name font-weight-bold mb-0">${uid}</p>
									</div>
								</div>
								<div class="dropdown-body">
									<ul class="profile-nav p-0 pt-3">
										<li class="nav-item"><a href="/multichat/member/view"
											class="nav-link"> <i data-feather="user"></i> <span>Profile</span>
										</a></li>
										<li class="nav-item"><a
											href="/multichat/jsp/member/memberUpdate.jsp"
											class="nav-link"> <i data-feather="edit"></i> <span>Edit
													Profile</span>
										</a></li>
										<li class="nav-item"><a class="nav-link"
											href="../login.jsp"> <i data-feather="log-out"></i> <span>LogOut</span>
										</a></li>
									</ul>
								</div>
							</div></li>
					</ul>
				</div>
				<div class="col-md-12 grid-margin stretch-card">
					<div class="card">
						<div class="card-body">
							<div class="px-4 py-5" style="width: 100%">
								<h6 class="card-title">게시글 작성</h6>
								<form name="uploadForm4" id="uploadForm4" method="post"
									enctype="multipart/form-data"
									action="<c:url value='/post/addPost'/>"
									style="width: 90%; margin-left: 10px">
									<div class="form-group">
										<label for="title">Title</label> <input type="text"
											oninput="btn_status()" class="form-control" id="title"
											placeholder="Title" name="title">
									</div>
									<div>
										<label for="content">Content</label> <input type="text"
											oninput="btn_status()" class="form-control"
											style="height: 300px;" id="content" name="content">
									</div>
									<div class="form-group">
										<table>
											<tbody>
												<tr>
													<th><label>첨부파일</label></th>
													<td><input type="file" name="filename1" id="filename1" /></td>
													<td><input type="button" value="추가" class="insertFile"></td>
												</tr>
											</tbody>
											<tfoot>
												<tr style="display: none">
													<th><label>첨부파일</label></th>
													<td><input type="file" name="filename1" id="filename1" /></td>
													<td><input type="button" value="추가" class="insertFile"></td>
													<td><input type="button" value="삭제" class="deleteFile"></td>
												</tr>
											</tfoot>
										</table>

									</div>
									<div class="row1">
										<div style="width: 150px;">

											<button type="submit" class="btn btn-primary" id="postAdd">등록</button>
											<!-- disabled=""disabled" -->
											<a href="post.jsp"
												class="btn btn-primary text-white mr-2 mb-2 mb-md-0">취소</a>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>

				</div>
			</nav>
		</div>
	</div>
	<script type="text/javascript">
	let tbody = document.querySelector("tbody");
	let tr = document.querySelector("tfoot tr");
	let insertFile = document.querySelector(".insertFile");

	function insertFileEventHandler() {
	   let newTr = tr.cloneNode(true);
	   tbody.append(newTr);
	   newTr.style.display = "";
	   
	   newTr.querySelector(".insertFile").addEventListener("click", insertFileEventHandler);
	   newTr.querySelector(".deleteFile").addEventListener("click", e => {
	      tbody.removeChild(e.target.parentNode.parentNode)
	   });
	}  

	insertFile.addEventListener("click", insertFileEventHandler);


	let uploadForm4 = document.querySelector("#uploadForm4");
	uploadForm4.addEventListener("submit", (e) => {
		e.preventDefault();
	   fetch("<c:url value='/post/addPost'/>", 
			      {
			          method: 'POST',
			          cache: 'no-cache',
			          body: new FormData(uploadForm4)
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
	<script src="../assets/vendors/core/core.js"></script>

	<script src="../assets/vendors/chartjs/Chart.min.js"></script>
	<script src="../assets/vendors/jquery.flot/jquery.flot.js"></script>
	<script src="../assets/vendors/jquery.flot/jquery.flot.resize.js"></script>
	<script
		src="../assets/vendors/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
	<script src="../assets/vendors/apexcharts/apexcharts.min.js"></script>
	<script src="../assets/vendors/progressbar.js/progressbar.min.js"></script>
	<!-- end plugin js for this page -->
	<!-- inject:js -->
	<script src="../assets/vendors/feather-icons/feather.min.js"></script>
	<script src="../assets/js/template.js"></script>
	<!-- endinject -->
	<!-- custom js for this page -->
	<script src="../assets/js/dashboard.js"></script>
	<script src="../assets/js/datepicker.js"></script>
</body>
</html>