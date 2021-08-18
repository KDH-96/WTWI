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

.review-row{
	list-style: none;
}

.reviewPoint{
	color: orange;
}

.rContent{
	color: black;
}

#rWriter{
	color: black;
}


</style>

</head>
<body>
	<div id="select-review-wrapper">
		<div id="reviewContent"></div>	
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
								"<td colspan=20 style='padding:30px; font-size: 20px;'> 작성된 리뷰가 없습니다. </td>");
			} else {
				// 리뷰 요소 새로 만들어서 합치기
				$.each(reviewList, function(index, item){
					
					var li = $("<li>").addClass("review-row");
			      
			        // 작성자, 작성일, 수정일 영역 
			        var div = $("<div>").addClass("review-div");
			        switch(item.reviewPoint){
			        case 0 : var point = "☆☆☆☆☆"; break;
			        case 1 : var point = "★☆☆☆☆"; break;
			        case 2 : var point = "★★☆☆☆"; break;
			        case 3 : var point = "★★★☆☆"; break;
			        case 4 : var point = "★★★★☆"; break;
			        case 5 : var point = "★★★★★"; break;
			        }
			        
			        var hr = $("<hr>");
			        var reviewPoint = $("<p>").addClass("reviewPoint").text(point + " " + item.reviewPoint + " ");
			        var rContent = $("<p>").addClass("rContent").html(item.reviewContent);
			        var rWriter = $("<span>").attr('id', "rWriter").text(" | " + item.memberNick + " | " + longToDate(item.reviewCreateDt) + "  ");
			        reviewPoint.append(rWriter);
			        div.append(hr).append(reviewPoint).append(rContent);
			         
			         // 리뷰 내용
			         // 수정, 삭제 버튼 영역
			        var reviewBtnArea = $("<div>").addClass("reviewBtnArea");
			         
			         // 현재 댓글의 작성자와 로그인한 멤버의 아이디가 같을 때 버튼 추가
			        if(item.memberNo == loginMemberNo){
			            
			            // ** 추가되는 댓글에 onclick 이벤트를 부여하여 버튼 클릭 시 수정, 삭제를 수행할 수 있는 함수를 이벤트 핸들러로 추가함. 
			            var showUpdate = $("<button>").addClass("btn btn-sm btn-primary mx-2").text("수정").attr("onclick", "showUpdateReview("+item.reviewNo+", this)");
			            var deleteReview = $("<button>").addClass("btn btn-sm btn-danger mx-2").text("삭제").attr("onclick", "deleteReview("+item.reviewNo+")");
			            
			            reviewPoint.append(showUpdate).append(deleteReview);
			        }
			         // 리뷰 요소 하나로 합치기
			        li.append(div).append(reviewBtnArea).append(hr);
			         // 합쳐진 리뷰를 화면에 배치
			        $("#reviewContent").append(li);
				});
			}
			
			/* ajax 페이지네이션 */
			/* 현재 페이지가 5 페이지 이하일 시 */
			if(reviewPagination.currentPage <= reviewPagination.pageSize){
				//let pageUnderFive = '<li class="page-item disabled"><a class="page-link dead-atag" href="" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
				//$(".pagination").append(pageUnderFive);
				
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
		
		// unix 날짜 변경
		function longToDate(val){  // val 은 long 타입의 시간값입니다 (ex : 15224115)
			  var date = new Date(val);  //입력 파라메터로 Date 객체를 생성합니다
			  var yyyy=date.getFullYear().toString(); // '연도'를 뽑아내고
			  var mm = (date.getMonth()+1).toString(); // '월'을 뽑아내고
			  var dd = date.getDate().toString(); // '일'을 뽑아냅니다

			  var Str = '';

			  //스트링 배열의 앞자리가 두자리 수가 아닌 한자리 수일 경우 
			  // 두자리로 표시하기 위해 0을 채웁니다(lpad 와 동일한 역할)
			  // (ex : '1' -> '01' )  
			  Str += yyyy + '-' + (mm[1] ? mm : '0' + mm[0]) + '-' +(dd[1] ? dd : '0' + dd[0]);
			  return Str;
		}
	</script>
	
</body>


</html>