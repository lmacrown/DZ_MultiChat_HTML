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
<title>QnA</title>
<style type="text/css">

/* 넓이 높이 조절 */
.ck.ck-editor {
	max-width: 1000px;
}

.ck-editor__editable {
	min-height: 300px;
}
</style>
<script
	src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/ckeditor.js"></script>
<script
	src="https://cdn.ckeditor.com/ckeditor5/35.3.2/classic/translations/ko.js"></script>
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
					<li class="nav-item"><a class="nav-link" href="login.jsp">
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
								<form style="width: 90%; margin-left: 10px">
									<div class="form-group">
										<label for="title">Title</label> <input type="text"
											oninput="btn_status()" class="form-control" id="title"
											placeholder="Title" name="title">
									</div>
									<div class="form-group">
										<label for="content">Content</label>
<!-- 										<textarea class="form-control"
											style="height: 450px;" id="contents" name="C"></textarea> -->
							 			<input type="text" style="height: 300px" oninput="btn_status()" class="form-control"
											id="contents" placeholder="contents" name="contents">
									</div>

									<div class="form-group">
										<label>Image upload</label> <input type="file"
											name="postImage" id="exampleImage1"
											class="file-upload-default">
										<div class="input-group col-xs-12">
											<input type="text" class="form-control file-upload-info"
												id="exampleInputImage1" disabled=''
												placeholder="Upload Image"> <span
												class="input-group-append">
												<button class="file-upload-browse btn btn-primary"
													type="button">Upload</button>
											</span>
										</div>
									</div>
									<div class="row1">
										<div style="width: 150px;">

											<button class="btn btn-primary" id="AddQnA">등록</button>
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
	<script>

	

    	let AddQnAButton = document.querySelector("#AddQnA");
    	AddQnAButton.onclick = () => {
    		AddQnA();
    	}
    	
        async function AddQnA() {

    		let response = await fetch('/multichat/post/addQnA?title=' + title.value
    				+ '&content=' + contents.value);

    		let jsonResult = await response.json();

    		if (jsonResult.status == false) {
    			alert(jsonResult.message);
    		}else{
    			alert(jsonResult.message);
    			location.href = jsonResult.url;
    		}
    	}
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