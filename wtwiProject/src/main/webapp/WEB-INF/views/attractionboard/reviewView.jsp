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

		<div class="row d-flex justify-content-center">
			<nav aria-label="Page navigation example">
				<ul class="pagination" id="review-pagination">
				
				<!-- 스크립트로 페이지네이션 삽입 -->
				
				</ul>
			</nav>
		</div>
	</div>
	
	<script>
		// 리뷰목록 조회하는 메소드
		function selectReviewList(e) {
			e.preventDefault();
	 		
			// 페이지네이션 영역 초기화
			document.getElementById("review-pagination").innerHTML = " ";
			
			$.ajax({
				url : "${contextPath}/review/" + selectedMarker + "/list",
				data : {
					"selectedMarker" : selectedMarker,
				},
				type : "GET",
				success : function(pgReviewList){
					createReviewList(pgReviewList)
				},
				
				error : function() {
					console.log("리뷰 목록 조회 실패");
	
				}
				
			});

		}
		
		
		$(document).on("click", ".dead-atag", function(e){
			e.preventDefault();
			//console.log( $(this).attr("href") );  
			
			const requestUrl = $(this).attr("href");
			
			$.ajax({
				url : requestUrl,
				dataType : "JSON",
				success : function(pgReviewList){
					createReviewList(pgReviewList)
				},
				
				error : function() {
					console.log("리뷰 목록 조회 실패");
	
				}
			})
			
		});
		
		
		function createReviewList(pgReviewList){
			console.log("통신 성공!");
			
			reviewPagination = pgReviewList[0]; // 배열[0]에 들어있는 pagination관련 정보 변수저장
			reviewList = pgReviewList[1]; // 배열[1]에 들어있는 리뷰 정보 변수저장

			$("#reviewContent").empty(); // 리뷰 삽입될 객체 비우기$(".pagination")")
			$(".pagination").empty();

			if (reviewList.length == 0) { // 선택한 명소에 리뷰가 없을 경우
				$("#reviewContent")
						.append(
								"<td colspan=20 style='padding:30px;'> 리뷰가 없습니다. </td>");

			} else {

				for (let i = 0; i < reviewList.length; i++) {

					let star;

					$("#reviewContent").append(
							"<hr style='margin:0;'>");

					switch (reviewList[i].reviewPoint) {
					case 1:
						star = "★☆☆☆☆";
						break;
					case 2:
						star = "★★☆☆☆";
						break;
					case 3:
						star = "★★★☆☆";
						break;
					case 4:
						star = "★★★★☆";
						break;
					case 5:
						star = "★★★★★";
						break;
					}

					$("#reviewContent").append(
							"<hr style='margin:0;'><div style='height: 10px'>");
					$("#reviewContent").append(
							"<span style='padding:0px; color:orange;'>"
									+ star + " " + "</span>");
					$("#reviewContent").append(
							"<span style='padding:0px;'>"
									+ reviewList[i].memberNick
									+ " " + "</span>");
					$("#reviewContent")
							.append(
									"<span style='padding:0px;'>"
											+ reviewList[i].reviewCreateDt
											+ "</span><br>");
					$("#reviewContent")
							.append(
									"<span style='padding:0px;'>"
											+ reviewList[i].reviewContent
											+ "</span><br><div style='height: 10px'>");
				}

			}
			
			/* ajax 페이지네이션 */
			/* 현재 페이지가 5 페이지 이하일 시 */
			if(reviewPagination.currentPage <= reviewPagination.pageSize){
				let pageUnderFive = '<li class="page-item disabled"><a class="page-link dead-atag" href="" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
				$(".pagination").append(pageUnderFive);
				
			/* 현재 페이지가 5페이지 초과일 시 */
			}else{
				let pageOverFive = '<li class="page-item"><a class="page-link dead-atag" href="review/' + selectedMarker + '/list?cp=' + reviewPagination.prevPage + '" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
				$(".pagination").append(pageOverFive);
			}
			
			/* 페이지 */
			for(let i=reviewPagination.startPage; i<reviewPagination.endPage+1; i++){
				if(i== reviewPagination.currentPage) {
					let page1 = '<li class="page-item active"><a class="page-link  dead-atag">' + i + '</a></li>'
					$(".pagination").append(page1);
				}else {
					let page2 = '<li class="page-item"><a class="page-link dead-atag" href="review/' + selectedMarker + '/list?cp=' + i + '">' + i + '</a></li>'
					$(".pagination").append(page2);
				}
			}
			
			/* 현재 페이지가 마지막 페이지 목록이 아닌 경우 */
			if(reviewPagination.endPage < reviewPagination.maxPage){
				let notEndPage = '<li class="page-item"><a class="page-link dead-atag" href="review/' + selectedMarker + '/list?cp=' + reviewPagination.nextPage +  '" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
				$(".pagination").append(notEndPage);
			}
			
		}
	</script>

</body>


</html>