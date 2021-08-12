<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review</title>

<style>
#select-review-wrapper {
	background-color: whitesmoke;
	right: 290px;
	position: absolute;
	z-index: 2;
	margin: auto;
	border-radius: 5px;
	opacity: 90%;
	width: 400px;
	height: 70vh;
	overflow:scroll;
	padding: 20px;
}

#reviewContent *{
	font-size: 12px;
}
</style>

</head>
<body>
	<div id="select-review-wrapper">
		<div id="reviewContent"></div>	
	
		<hr>
		
		<nav aria-label="Page navigation example">
			<ul class="pagination">
	
				<li class="disabled"><a><<</a></li>
				
				<li class="disabled"><a><</a></li>
				
				<li class="disabled active"><a>1</a></li>
				
				<li class="goPage" data-page="2"><a>2</a></li>
				
				<li class="goPage" data-page="3"><a>3</a></li>
				
				<li class="disabled"><a>></a></li>
				
				<li class="goLastPage"><a>>></a></li>
				
			</ul> 
		</nav>
	</div>
	<script>
	// 리뷰목록 조회하는 메소드
	function selectReviewList() {
		
		$.ajax({
			url : "${contextPath}/review/" + selectedMarker + "/list",
			data : {
				"selectedMarker" : selectedMarker
			},
			type : "GET" ,
			success : function(pgReviewList) {
				console.log("통신 성공!");
								
				reviewPagination = pgReviewList[0]; // 배열[0]에 들어있는 pagination관련 정보 변수저장
				reviewList = pgReviewList[1]; // 배열[1]에 들어있는 리뷰 정보 변수저장
				
				$("#reviewContent").empty(); // 리뷰 삽입될 객체 비우기
				
				if(reviewList.length == 0) { // 선택한 명소에 리뷰가 없을 경우
					$("#reviewContent").append("<td colspan=20 style='padding:30px;'> 리뷰가 없습니다. </td>");
					
				}else{
						
					for(let i=0; i<reviewList.length; i++) {
						
						let star;
						
						$("#reviewContent").append("<hr style='margin:0;'>");
						
						switch(reviewList[i].reviewPoint){
						case 1: star = "★☆☆☆☆"; break;
						case 2: star = "★★☆☆☆"; break;
						case 3: star = "★★★☆☆"; break;
						case 4: star = "★★★★☆"; break;
						case 5: star = "★★★★★"; break;
						}
						
						$("#reviewContent").append("<hr style='margin:0;'>");
						$("#reviewContent").append("<span style='padding:0px; color:orange;'>" + star + " " + "</span>");
						$("#reviewContent").append("<span style='padding:0px;'>" + reviewList[i].memberNick + " " + "</span>");
						$("#reviewContent").append("<span style='padding:0px;'>" + reviewList[i].reviewCreateDt + "</span>");
						$("#reviewContent").append("<div style='width:50px; height:50px; background-color:gray;'></div>");
						$("#reviewContent").append("<span style='padding:0px;'>" + reviewList[i].reviewContent + "</span>");
					}
					
				}
				
			},
			error : function() {
				console.log("리뷰 목록 조회 실패");

			}

		})

	}
	</script>

</body>


</html>