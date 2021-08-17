<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Attraction View</title>

<style>
#attraction-info-area {
	right: 0;
	position: absolute;
	z-index: 2;
	padding: 0;
	height: 100vh;
	overflow: auto;
}

#attraction-info {
	margin: auto;
	opacity: 90%;
}

#attr-image {
	padding: 20px;
	padding-bottom: 0;
}

#chat-btn {
	float: right;
}

/* 별점 영역 시작 */
#star {
	margin-left: 25px;
}

.star-rating {
	display: flex;
	flex-direction: row-reverse;
	font-size: 2.25rem;
	line-height: 2.5rem;
	justify-content: space-around;
	padding: 0 0.2em;
	text-align: center;
	width: 5em;
}

.star-rating input {
	display: none;
}

.star-rating label {
	-webkit-text-fill-color: transparent;
	/* Will override color (regardless of order) */
	-webkit-text-stroke-width: 2.3px;
	-webkit-text-stroke-color: darkg;
	cursor: pointer;
}

.star-rating :checked ~label {
	-webkit-text-fill-color: gold;
}

.star-rating label:hover, .star-rating label:hover ~label {
	-webkit-text-fill-color: #fff58c;
}

/* 별점 영역 끝 */
#image-wrapper {
	margin: auto;
	width: 380px;
	height: 150px;
}

#attr-info-table * {
	font-size: 12px;
}

#attr-title {
	margin-bottom: 0;
}

#attr-info {
	height: 145px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
}

#btn-wrap {
	position: relative;
}

#chat-div {
	float: right;
	margin-right: 50px;
	margin-bottom: 5px;
}

#btn-wrap>div>a {
	position: absolute;
	top: 0;
}

#view-review-btn>a {
	text-decoration: none;
	color: gray;
	margin-left: 20px;
}

.reviewUpdateContent {
	resize: none;
	width: 345px;
}

.spaceDiv{
	width: 200px;
	height: 10px;
	display: inline-block;
}
</style>
</head>
<body>

	<!-- =================================== 명소 상세정보 영역 시작 =================================== -->
	<div id="attraction-info-area">
		<div class="card" style="width: 18rem;" id="attraction-info">
			<img src="#" class="card-img-top" alt="..." id="attr-image">
			<div class="card-body">
				<h5><a id="attr-title" href=""></a></h5>
				<span id="attr-no" style="display:none;"></span>
					<div style="margin:auto; text-align:center;">
						<span id="attr-avgPoint" style="color:orange; font-size:22px;"></span><br> <!-- 명소 별점 -->
						<span id="attr-avgPoint-num"  style="font-size: 13px;"></span> <!-- 명소 평점 -->
						<span id="total-review-count" style="font-size: 13px;"></span> <!-- 총 리뷰 수 -->
					</div>
					<hr>
				<table id="attr-info-table">
					<tr>
						<td id="attr-type"></td> <!-- 명소 타입 출력 부분  -->
					</tr>
					<tr>
						<td id="attr-phone"></td> <!-- 명소 전화번호 출력 부분 -->
					</tr>
					<tr>
						<td id="attr-addr"></td> <!-- 명소 주소 출력 부분 -->
					</tr>
					<tr>
						<td id="attr-homepage"></td> <!-- 명소 홈페이지 출력 부분 -->
					</tr>
					<tr>
						<td><br></td>
					</tr>
					<tr>
						<td>
						<div id="attr-info">
						</div>
						</td> <!-- 명소 소개 출력 부분 -->
					</tr>
					<tr>
						<td style="text-align:right; font-size: 13px;"><a id="to-attr-view" href="${contextPath}/attraction/view/" style="color:gray;">더 보기</a></td> <!-- 명소 상세조회 페이지로 이동하는 부분 -->
					</tr>
				</table>
				<div id="btn-wrap">
				<div style="float:left;">
					<a href="#" class="badge badge-pill badge-primary" id="write-btn">리뷰작성</a>
				</div>
				<div id="chat-div">
					<a href="#" class="badge badge-pill badge-info" id="chat-btn">1:1채팅</a>
				</div>
				</div>
			</div>
				<div id="view-review-btn" style="height: 50px;"><a href="#" id="view-btn" style="line-height: 50px;" onclick="selectReviewList(event)"> 리뷰 보기</a></div>
		</div>
	</div>
	<!-- =================================== 명소 상세정보 영역 끝 =================================== -->
	
	<script>
		const loginMemberNo = "${loginMember.memberNo}"; // 로그인 맴버 번호 전역변수 선언
		
		var viewFlag = false; // 리뷰보기 버튼 화면동작 플래그
	
		var writeFlag = false; // 리뷰보기 버튼 화면동작 플래그
		
		// 리뷰보기 버튼 클릭 시 리뷰목록 등장하는 메소드
		$("#view-btn").on('click', function(){
			
			if(viewFlag == false) {
				$("#select-review-wrapper").fadeIn(100);
				viewFlag = true;
				
				if(writeFlag==true) {
					$("#write-review-wrapper").fadeToggle(100);
					writeFlag = false;
				}
				
			}else {
				$("#select-review-wrapper").fadeOut(100);
				viewFlag = false;
			}
		});
		
		
     	// 후기작성 버튼 클릭 시 후기작성 폼 등장하는 메소드
		$("#write-btn").on("click", function () {

			if(loginMemberNo == "") {
				swal({
					"icon" : "error",
					"title" : "로그인 후 이용해주세요"
				});
				
				return;
			}
			
			
		    $("#write-review-wrapper").fadeToggle(100);
		    
			if(writeFlag==false){
				writeFlag = true; // 켜졌을 때
				
				if(viewFlag == true) {
					$("#select-review-wrapper").fadeOut(100);
					viewFlag = false;
				}
				
			} else {
				writeFlag = false; // 꺼졌을 때
			}
		});
		
		// 취소버튼 클릭 시 후기작성 폼을 닫는 메소드
		$("#cancel-btn").on("click", function () {
			if(wirteFlag = true) {
			    $("#write-review-wrapper").fadeOut(100);
			    writeFlag = false;
			}
		});
		
		// 리뷰 작성
		document.getElementById("review-write-btn").addEventListener("click", function(){
			
			console.log( $("input[name=rating]:checked") );
			
			let attractionNo = document.getElementById("attr-no").value; // 클릭한 명소 번호 저장 변수
			let reviewPoint = 0; // 별점 저장 변수
			let reviewContent = ''; // 리뷰 내용 저장 변수
			
			let ratingList = document.getElementsByName("rating").length
			
			for(let i=0; i<ratingList; i++){
				
				if(document.getElementsByName("rating")[i].checked == true) {
					
					reviewPoint = document.getElementsByName("rating")[i].value;
				}
			}
			
			reviewContent = document.getElementById("text-area").value;
			
			// 별점과 리뷰내용 작성 안했을 경우 swal 띄우기
			let count = 0;
			let textArea = $("#text-area").val();
			
			for(let i=0; i<document.getElementsByName("rating").length; i++){
				if(document.getElementsByName("rating")[i].checked == false) {
					count += count;
				}else {
					count++;
				}
			}
			
			if(count == 0) {
				swal({
					"icon" : "error",
					"title" : "별점을 입력해주세요."
				})
				
			} else if(textArea.trim() == ""){
				swal({
					"icon" : "error",
					"title" : "내용을 입력해주세요."
				});

			} else{
				// 별점과 리뷰내용이 모두 작성되었을 경우
				$.ajax({
					url : "${contextPath}/review/insert",
					type : "POST",
					data : {"reviewPoint" : reviewPoint,
							"reviewContent" : reviewContent,
							"attractionNo" : attractionNo,
							"memberNo" : loginMemberNo},
					success : function(result){
						console.log("통신 성공"); // 리뷰 삽입 성공
						if(result == 1) {
							$("#write-review-wrapper").fadeOut(100);
				        	writeFlag = false;
				        	
							// 리뷰 작성 성공 시 별점 모두 투명한 별로 변경			        	
				        	for(let i=0; i<ratingList; i++){
								if(document.getElementsByName("rating")[i].checked == true) {
									document.getElementsByName("rating")[i].checked = false;
								}
							}
							
							// 리뷰 작성 성공 시 리뷰 내용란 공백으로 변경
				        	document.getElementById("text-area").value = "";
							
							// 명소정보 새로고침
							viewAttrInfo();
							
							// 스왈 알림(리뷰작성 성공)
				        	swal({"icon" : "success",
				        		  "title" : "리뷰를 작성하였습니다."});
							
						} else {
							swal({"icon" : "error",
				        		  "title" : "리뷰작성 중 문제가 발생하였습니다.",
				        		  "text" : "문제가 지속될 경우 관리자에게 문의바랍니다."});
						}
						
					},
					
					error : function(){
						console.log("통신 실패");
					}
					
				});
			}
			
		});
		
		
		// 리뷰 삭제
		function deleteReview(reviewNo){
			if(confirm("정말로 삭제하시겠습니까?")){
				
				$.ajax({
					url : "${contextPath}/review/delete",
					data : {"reviewNo" : reviewNo},
					success : function(result){
						if(result > 0) {
							$("#select-review-wrapper").fadeOut(100);
				        	viewFlag = false;
				        	
				        	// 명소 정보 새로고침
				        	viewAttrInfo();
				        	
							swal({"icon" : "success", "title" : "리뷰 삭제 성공"});
						}
					},
					
					error : function(){
						swal({"icon" : "error", "title" : "리뷰 삭제 실패", "text" : "문제가 지속될 경우 관리자에게 문의해주세요."});
					}
				});
			}			
		}
		

		let beforeReviewRow; // 수정 전 리뷰 요소를 저장할 변수 선언
		
		// 리뷰 수정
		function showUpdateReview(reviewNo, el){
			
			if( $(".reviewUpdateContent").length > 0) {
				$(".reviewUpdateContent").eq(0).parent().html(beforeReviewRow);
			}
			
			// 리뷰 수정화면 출력 전 요소를 저장
			beforeReviewRow = $(el).parent().parent().html();
			
			var beforeContent = $(el).parent().next().html();
			
			// 이전 댓글 내용의 크로스사이트 스크립트 처리 해제, 개행문자 변경
			beforeContent = beforeContent.replace(/&amp;/g, "&");   
			beforeContent = beforeContent.replace(/&lt;/g, "<");   
			beforeContent = beforeContent.replace(/&gt;/g, ">");   
			beforeContent = beforeContent.replace(/&quot;/g, "\"");   
			beforeContent = beforeContent.replace(/<br>/g, "\n");
			
			
			// 기존 댓글영역 삭제 및 textarea 추가
			$(el).parent().next().remove();
			var textarea = $("<textarea>").addClass("reviewUpdateContent").attr("rows", "2").val(beforeContent);
			var numberLimit = $('<div id="update_cnt" style="float: right; margin-right:30px;">').text("(" + beforeContent.length + " / 150)");
			$(el).parent().after(numberLimit).after(textarea);
			
			// 수정 버튼
			var updateReview = $("<button>").addClass("btn btn-sm btn-primary mx-2").text("완료").attr("onclick", "updateReview(" + reviewNo + ", this)");
			
			// 취소 버튼
			var cancelBtn = $("<button>").addClass("btn btn-sm btn-danger mx-2").text("취소").attr("onclick", "updateCancel(this)");
			var spaceDiv = $("<div>").addClass("spaceDiv");
			
			var reviewBtnArea = $(el).parent();
			
			$(reviewBtnArea).empty();
			$(reviewBtnArea).append(spaceDiv); 
			$(reviewBtnArea).append(updateReview); 
			$(reviewBtnArea).append(cancelBtn); 
			
		}
		
		// 수정 시에도 글자수 세기 적용
		$(document).on("keyup", ".reviewUpdateContent", function() {
	        $('#update_cnt').html("(" + $(this).val().length + " / 150)");
	 	
	        if($(this).val().length < 100){
	            $("#update_cnt").css("color", "green");
	        
	    	} else if($(this).val().length < 130) {
	            $("#update_cnt").css("color", "orange");
	            
	        } else {
	            $("#update_cnt").css("color", "red");
	        }
	        
	        if($(this).val().length > 150) {
	            $(this).val($(this).val().substring(0, 150));
	            $("#update_cnt").html("(150 / 150)");
	        }
	        
    	});
		
		
		// 리뷰 수정 취소 시 원래대로 돌아가기
		function updateCancel(el){
			$(el).parent().parent().html(beforeReviewRow);
		}
		
		
		// 리뷰 수정
		function updateReview(reviewNo, el) {
			
			const reviewContent = $(el).parent().next().val();
			
			$.ajax({
				url : "${contextPath}/review/update",
				type : "POST",
				data : {"reviewNo" : reviewNo,
						"reviewContent" : reviewContent},
				success : function(result){
					
					
					if(result > 0) {
						// 명소정보 새로고침
						viewAttrInfo();
						
						$("#select-review-wrapper").fadeOut(100);
						viewFlag = false;
						
						// 스왈 알림(리뷰작성 성공)
			        	swal({"icon" : "success",
			        		  "title" : "리뷰를 수정하였습니다."});
						
					}
				},
				error : function(){
					swal({"icon" : "error", "title" : "리뷰 수정 실패"});
				}
			});
		}
		
	</script>
		
</body>
</html>