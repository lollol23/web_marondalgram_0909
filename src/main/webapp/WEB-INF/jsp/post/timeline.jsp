<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	
  	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
  	
  	<link rel="stylesheet" href="/static/css/style.css">
	<title>마론달그램</title>
</head>
<body class="bg-light">
	<div id="wrap" >
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="d-flex justify-content-center">
			<div class="col-lg-7">
				
				<!--  입력 상자  -->
				<div class="border rounded mt-3  bg-white">
					<div>
						<textarea class="form-control w-100 border-0 non-resize" rows=3 id="contentInput"></textarea>
					</div>
					<div class="d-flex justify-content-between m-2">
						<a href="#" id="imageUploadBtn"><i class="bi bi-image image-upload-icon"></i></a>
						<input type="file" id="fileInput" class="d-none">
						
						<button class="btn btn-sm btn-info" id="uploadBtn">업로드</button>
					</div>
				</div>
				
				<!-- 피드 -->
				<c:forEach var="postDetail" items="${postList }">
				<div class="card border rounded mt-3">
					<!-- 타이틀 -->
					<div class="d-flex justify-content-between p-2 border-bottom">
						<div>
							<img src="https://mblogthumb-phinf.pstatic.net/20150203_225/hkjwow_1422965971196EfkMV_JPEG/%C4%AB%C5%E5%C7%C1%BB%E7_31.jpg?type=w210" width="30">
							${postDetail.post.userName }
						</div>
						
						
						<c:if test="${postDetail.post.userId eq userId }">
						<div class="more-icon" >
							<a class="text-dark moreBtn" href="#" data-post-id="${postDetail.post.id }" data-toggle="modal" data-target="#deleteModal"> 
								<i class="bi bi-three-dots-vertical"></i> 
							</a>
						</div>
						</c:if>
						
					</div>
					<!--이미지 -->
					<div>
						<img src="${postDetail.post.imagePath }" class="w-100 imageClick">
					</div>
					<!-- 좋아요 -->
					
					<div class="m-2">
						<c:choose>
							<c:when test="${postDetail.like }">
								<a href="#" class="likeBtn" data-post-id="${postDetail.post.id }" >
									<i class="bi bi-heart-fill heart-icon text-danger"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a href="#" class="likeBtn" data-post-id="${postDetail.post.id }" >
									<i class="bi bi-heart heart-icon text-dark"></i>		
								</a>
							</c:otherwise>
						</c:choose>
								

						<span class="middle-size ml-1"> 좋아요 ${postDetail.likeCount }개 </span>
					</div>
					
					<!--  content -->
					<div class="middle-size m-2">
						<b>${postDetail.post.userName }</b> ${postDetail.post.content }
					</div>
					
					<!--  댓글 -->
					
					<div class="mt-2">
						<div class=" border-bottom m-2">
							<!-- 댓글 타이틀 -->
							<div  class="middle-size">
								댓글
							</div>
						</div>
						
						<!--  댓글  -->
						<div class="middle-size m-2">
						
							<!-- postDetail > commentList  -->
							<c:forEach var="comment" items="${postDetail.commentList }">
							<div class="mt-1">
								<b>${comment.userName }</b> ${comment.content }
							</div>
							</c:forEach>
						
						</div>
						
						
						<!-- 댓글 입력 -->
						<div class="d-flex mt-2 border-top">
							<input type="text" class="form-control border-0 " id="commentInput-${postDetail.post.id }">
							<button class="btn btn-info ml-2 commentBtn" data-post-id="${postDetail.post.id }">게시</button>
						</div>
						
					
					</div>
			
				</div>
								
				<!-- /피드 -->
				</c:forEach>
			</div>	
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	
	<!-- Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      
	      <div class="modal-body text-center">
	        <a href="#" id="deleteBtn">삭제하기</a>
	      </div>
	      
	    </div>
	  </div>
	</div>
	
	<script>
	
	
	$(document).ready(function() {
		$("#imageUploadBtn").on("click", function() {
			$("#fileInput").click();
		});
			
		
			$("#uploadBtn").on("click", function() {
				let content = $("#contentInput").val().trim();
					
				if(content == null || content == "") {
					alert("내용을 입력하세요");
					return ;
				}
				
				if($("#fileInput")[0].files.length == 0) {
					alert("파일을 추가하세요");
					return ;
				}
				
				var formData = new FormData();
				formData.append("file", $("#fileInput")[0].files[0]);
				formData.append("content", content);
				
				$.ajax({
					enctype: 'multipart/form-data', // 필수
					type:"POST",
					url:"/post/create",
					processData: false, // 필수 
		        	contentType: false, // 필수 
					data:formData,
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("글쓰기에 실패했습니다.");
						}
						
					}, error:function(e) {
						alert("error ");
					}
				});
				
			});	
			
			$(".commentBtn").on("click", function() {
				var postId = $(this).data("post-id");
				// postId, content
				
				// 대응되는 input의 value
				// ex ) postId = 5;
				// "#commentInput-5"
				var content = $("#commentInput-" + postId).val();
				
				$.ajax({
					type:"post",
					url:"/post/comment/create",
					data:{"postId":postId, "content":content},
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("댓글 작성 실패");
						}
						
					},
					error:function(e) {
						alert("error");
					}
					
				});
				
				
			});
	
			$(".likeBtn").on("click", function(e) {
				e.preventDefault();
				
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/like",
					data:{"postId":postId},
					success: function(data) {
						
						if(data.result == "success") {
							location.reload();
						} else {
							alert("좋아요 실패");
						}
					},
					error: function(e) {
						alert("error");
					}
					
				});
			});
			/*
			$(".unLikeBtn").on("click", function(e) {
				e.preventDefault();
				
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/unlike",
					data:{"postId":postId},
					success: function(data) {
						
						if(data.result == "success") {
							location.reload();
						} else {
							alert("좋아요 취소 실패");
						}
					},
					error: function(e) {
						alert("error");
					}
					
				});
				
			});
			*/
			
			$(".moreBtn").on("click", function(e) {
				e.preventDefault();
				var postId = $(this).data("post-id");
				// <a href="#" id="deleteBtn" data-post-id=""></a>
				$("#deleteBtn").data("post-id", postId);
			});
			
			$("#deleteBtn").on("click", function(e) {
				e.preventDefault();
				var postId = $(this).data("post-id");
				
				$.ajax({
					type:"get",
					url:"/post/delete",
					data:{"postId":postId},
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("삭제 실패");
						}
					}, 
					error:function(e) {
						alert("error");
					}
					
				});
			});
			
		});		
	
	
	</script>
</body>
</html>