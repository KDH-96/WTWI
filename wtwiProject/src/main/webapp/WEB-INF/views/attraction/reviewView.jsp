<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .free-review{
        width: 1200px;
    }
    .free-review-date{
        font-size: 12px;
    }
    .free-review-area{
    	display: inline-block;
    }
    .reviewPoint{
    	color : orange;
    }
    #rWriter{
    	color : black;
    }
    .review-div{
    	background-color : #f7f7f7;
    }
    #reviewListArea{
    	margin-block-start: 0;
    	    padding-inline-start: 0;
    }
    .review-row{
    	list-style: none;
    }
    
    .reviewWrite{
    	margin-top : 50px;
    }
    . btn-dark{
    	
    }
    
    
    /*insert 영역 css*/
		
		/* 별점 영역 시작 */
		#star {
			margin-left: 25px;
		}
		
		.star-rating {
			display: flex;
			flex-direction: row-reverse;
			font-size: 1.5rem;
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
		.text-div{
			width : 100%;
			float : clear;
			display : inline-block;		
		}
		.review-input-text{
			width : 95%;
		}
		.star-file-div{
			float : left;
			display : inline-block;	
			margin-top : 5px;	
		}
		.star-rating{
			float : left;
		}
		.file-input-div{
			float : right;
			margin-left : 30px;
			margin-top : 4px;
		}
		#review-insert-btn{
			float : right;
		}
		
		/* 별점 영역 끝 */

</style>
<div id="review-area ">

	<!-- 댓글 출력 부분 -->
	<div class="reviewList mt-5 pt-2">
		<ul id="reviewListArea">
			<c:forEach items="${rList}" var="review">
				<li class="review-row">
					<div>
						<p class="rWriter">${review.memberName}</p>
						<p class="rDate">작성일 : <fmt:formatDate value="${review.createDate }" pattern="yyyy년 MM월 dd일 HH:mm"/></p>
					</div>
	
					<p class="rContent">${review.reviewContent }</p>
					
					
					<c:if test="${review.memberNo == loginMember.memberNo}">
					<div class="reviewBtnArea">
						<button class="btn btn-primary btn-sm ml-1" id="updatereview" onclick="showUpdateReview(${review.reviewNo}, this)">수정</button>
						<button class="btn btn-primary btn-sm ml-1" id="deletereview" onclick="deleteReview(${review.reviewNo})">삭제</button>
					</div>
					</c:if>
				</li>
			</c:forEach>
		</ul>
		<ul class="pagination" id="review-pagination">
		
		<!-- 스크립트로 페이지네이션 삽입 -->
		
		</ul>
	</div>
		
	<!-- 댓글 작성 부분 -->
	<div class="reviewWrite">
	
		<div class="star-file-div">
				<div class="star-rating space-x-4 mx-auto">
                <input type="radio" id="5-stars" name="rating" value="5" v-model="ratings" />
                <label for="5-stars" class="star pr-4">★</label>
                <input type="radio" id="4-stars" name="rating" value="4" v-model="ratings" />
                <label for="4-stars" class="star">★</label>
                <input type="radio" id="3-stars" name="rating" value="3" v-model="ratings" />
                <label for="3-stars" class="star">★</label>
                <input type="radio" id="2-stars" name="rating" value="2" v-model="ratings" />
                <label for="2-stars" class="star">★</label>
                <input type="radio" id="1-star" name="rating" value="1" v-model="ratings" />
                <label for="1-star" class="star" id="star">★</label>
    		</div>
    		<div class="file-input-div" id="image-wrapper">
						<input type="file">
        </div>
		</div>
		<div class="text-div">
				<input type="text" class="review-input-text" id="reviewContent" placeholder ="리뷰를 작성해 주세요(150자)">
        <button type="button" id = "review-insert-btn" onclick="addreview();">등록</button>
		</div>

	</div>
	
</div>


<script>
  
	var attraction = ${attraction}; 
	var attractionNo = attraction.attractionNo;
	const loginMemberNo = "${loginMember.memberNo}";
	//const freeNo = ${board.freeNo};
	let beforereviewRow;
	
	reviewList();
	
	// 리뷰 등록
	function addreview(){
		
		let reviewPoint = 0; // 별점 저장 변수

		let ratingList = document.getElementsByName("rating").length
		for(let i=0; i<ratingList; i++){
			if(document.getElementsByName("rating")[i].checked == true) {
				reviewPoint = document.getElementsByName("rating")[i].value;
			}
		}
		reviewContent = $("#reviewContent").val();
		//console.log(reviewContent);
		//console.log(reviewPoint);
		//console.log(attractionNo);
		if(memberNo==""){
			swal({
				icon: "warning",
				title: "회원만 이용 가능합니다."
			});
		} else {
			if(reviewContent.trim()==""){
				swal({
					icon: "warning",
					title: "글을 작성해 주세요."
				});
			} else{
				$.ajax({
					url : "${contextPath}/review/insert",
					type : "POST",
					data : {"reviewPoint" : reviewPoint,
							"reviewContent" : reviewContent,
							"attractionNo" : attractionNo,
							"memberNo" : loginMemberNo},
							
					success : function(result){
						swal({
							icon: "success",
							title: "댓글이 작성되었습니다."
						});
						$("#reviewContent").val("");
						reviewList();
						reviewCount();
						/*console.log("통신 성공"); // 리뷰 삽입 성공
						if(result == 1) {
							$(".reviewWrite").fadeOut(100);
				        	writeFlag = false;
				        	
							// 리뷰 작성 성공 시 별점 모두 투명한 별로 변경			        	
				        for(let i=0; i<ratingList; i++){
								if(document.getElementsByName("rating")[i].checked == true) {
									document.getElementsByName("rating")[i].checked = false;
									
								}
							}
							// 리뷰 작성 성공 시 리뷰 내용란 공백으로 변경
				        	document.getElementById("reviewContent").value = "";
							// 스왈 알림(리뷰작성 성공)
				        	swal({"icon" : "success",
				        		  "title" : "리뷰를 작성하였습니다."});
						} else {
							swal({"icon" : "error",
				        		  "title" : "리뷰작성 중 문제가 발생하였습니다.",
				        		  "text" : "문제가 지속될 경우 관리자에게 문의바랍니다."});
						}*/
						
					},
					
					error : function(){
						console.log("통신 실패");
					}
					
				});
			}
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
	
	// 리뷰 목록 조회
	function reviewList(){
		
		document.getElementById("review-pagination").innerHTML = " ";
		var attraction = ${attraction}; 
		var selectedNo = attraction.attractionNo;
		
		$.ajax({
			
			url: "${contextPath}/review/" + attractionNo + "/reviewList",
			data: {"selectedNo": selectedNo},
			type: "POST",
			success : function(pgReviewList){
				createReviewList(pgReviewList)
			},
			error: function(e){
				console.log(e);	
			}
		});
	}
	
	
	$(document).on("click", ".dead-atag", function(e){
		e.preventDefault();
		console.log( $(this).attr("href") );  
		
		const requestUrl = $(this).attr("href");
		
		$.ajax({
			url : requestUrl,
			type : "POST",
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
			$("#reviewListArea").empty();
			$("#review-pagination").empty();
			
		
		
		
			// pgReviewList 0번 인덱스에는 페이지네이션 / 1번 인덱스에는 리뷰리스트 들어있음
			var reviewPagination = pgReviewList[0];
			var reviewList = pgReviewList[1];
			console.log(reviewList);
			
			// 가지고 온 리뷰가 없을 때
			if(reviewList.length == 0){
				var li = $("<li>").addClass("review-row");
				var div = $("<div>").addClass("review-div");
				var span = $("<span>").addClass("no-review-span").text("아직 작성된 리뷰가 없습니다. 첫 번째 리뷰를 작성해주세요..★★★★★ ");
		    li.append(div).append(span);
		    $(".reviewList").append(li);
				
			}else{
				
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
	        var reviewPoint = $("<p>").addClass("reviewPoint").text(point + " " + item.reviewPoint + " ");
	        var rContent = $("<p>").addClass("rContent").html(item.reviewContent);
	        var rWriter = $("<span>").attr('id', "rWriter").text(" " + item.memberNick + " | " + longToDate(item.reviewCreateDt) + "  ");
	        reviewPoint.append(rWriter);
	        div.append(reviewPoint).append(rContent);
	         
	         // 리뷰 내용
	         
	         // 수정, 삭제 버튼 영역
	        var reviewBtnArea = $("<div>").addClass("reviewBtnArea");
	         
	         // 현재 댓글의 작성자와 로그인한 멤버의 아이디가 같을 때 버튼 추가
	        if(item.memberNo == loginMemberNo){
	            
	            // ** 추가되는 댓글에 onclick 이벤트를 부여하여 버튼 클릭 시 수정, 삭제를 수행할 수 있는 함수를 이벤트 핸들러로 추가함. 
	            var showUpdate = $("<button>").addClass("btn btn-sm btn-dark").text("수정").attr("onclick", "showUpdatereview("+item.reviewNo+", this)");
	            var deleteReview = $("<button>").addClass("btn btn-sm btn-dark").text("삭제").attr("onclick", "deleteReview("+item.reviewNo+")");
	            
	            reviewPoint.append(showUpdate).append(deleteReview);
	        }
	         // 리뷰 요소 하나로 합치기
	        li.append(div).append(reviewBtnArea);
	         // 합쳐진 리뷰를 화면에 배치
	        $("#reviewListArea").append(li);
			});
			
			}
		
			
			
			/* ajax 페이지네이션 */
			/* 현재 페이지가 5 페이지 이하일 시 */
			if(reviewPagination.currentPage <= reviewPagination.pageSize){
				let pageUnderFive = '<li class="page-item disabled"><a class="page-link dead-atag" href="${contextPath}/review/' + attractionNo + '/reviewList?cp=1" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
				$(".pagination").append(pageUnderFive);
				
			/* 현재 페이지가 5페이지 초과일 시 */
			}else{
				let pageOverFive = '<li class="page-item"><a class="page-link dead-atag" href="${contextPath}/review/' + attractionNo + '/reviewList?cp=' + reviewPagination.prevPage + '" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>';
				$(".pagination").append(pageOverFive);
			}
			
			/* 페이지 */
			for(let i=reviewPagination.startPage; i<reviewPagination.endPage+1; i++){
				if(i== reviewPagination.currentPage) {
					let page1 = '<li class="page-item active"><a class="page-link  dead-atag">' + i + '</a></li>'
					$(".pagination").append(page1);
				}else {
					let page2 = '<li class="page-item"><a class="page-link dead-atag" href="${contextPath}/review/' + attractionNo + '/reviewList?cp=' + i + '">' + i + '</a></li>'
					$(".pagination").append(page2);
				}
			}
			
			/* 현재 페이지가 마지막 페이지 목록이 아닌 경우 */
			if(reviewPagination.endPage < reviewPagination.maxPage){
				let notEndPage = '<li class="page-item"><a class="page-link dead-atag" href="${contextPath}/review/' + attractionNo + '/reviewList?cp=' + reviewPagination.nextPage +  '" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>';
				$(".pagination").append(notEndPage);
			}
			
			
	}
	
	
	
	
	
	
	// 댓글 수정 폼
	function showUpdatereview(reviewNo, el){
		
		// 이미 열려있는 수정 폼 닫기
		if($(".updateReviewContent").length>0){
			$(".updateReviewContent").eq(0).parent().html(beforereviewRow);
		}
		
		// 수정폼 출력 전 요소 저장
		beforereviewRow = $(el).parent().parent().parent().parent().html();
		
		// 수정 전 내용
		var beforeContent = $(el).parent().parent().prev().children().html();
		beforeContent = beforeContent.replace(/&amp;/g, "&");   
		beforeContent = beforeContent.replace(/&lt;/g, "<");   
		beforeContent = beforeContent.replace(/&gt;/g, ">");   
		beforeContent = beforeContent.replace(/&quot;/g, "\"");   
		beforeContent = beforeContent.replace(/<br>/g, "\n");   
		
		// 기존 댓글 내용 삭제 후 textarea추가
		$(el).parent().parent().prev().remove();
		var textarea = $("<textarea>").addClass("updatereviewContent").attr("rows", "3").attr("style", "width:75%").val(beforeContent);
		$(el).parent().parent().before(textarea);
		
		// 수정버튼
		var updatereview = $("<button>").addClass("btn btn-outline-secondary ml-1").text("수정").attr("onclick", "updatereview("+freereviewNo+", this)");
		
		// 취소 버튼
		var updatereviewCancel = $("<button>").addClass("btn btn-outline-secondary ml-1 mt-4").text("취소").attr("onclick", "updatereviewCancel(this)");
		
		var reviewBtnArea = $(el).parent().parent();
		
		$(reviewBtnArea).empty();
		$(reviewBtnArea).append(updatereview); 
		$(reviewBtnArea).append(updatereviewCancel); 
	}
	
	// 댓글 수정 취소 버튼 클릭 시
	function updatereviewCancel(el){
		$(el).parent().parent().parent().html(beforereviewRow);
	}
	
	// 댓글 수정
	function updatereview(freereviewNo, el){
		
		const freereviewContent = $(el).parent().prev().val();
	
		$.ajax({
			url: "${contextPath}/freereview/updatereview",
			type: "POST",
			data: {"freereviewNo": freereviewNo,
				   "freereviewContent": freereviewContent},
				   
			success: function(result){
				
				if(result>0){
					selectreviewList();
					swal({
						icon: "success",
						title: "댓글이 수정되었습니다."
					});
				}
			},
			error: function(e){
				console.log(e);
			}
		});
	}
	
	// 댓글 삭제 알림창
	function deletereviewAlert(freereviewNo){
		
		swal({
			icon: "warning",
			title: "댓글을 삭제하시겠습니까?",
			buttons: ["취소", "삭제"],
			dangerMode: true,
		}).then((willDelete) => {
			if (willDelete) {
				deletereview(freereviewNo);
			} 
		});
	}
	
	// 댓글 삭제
	function deleteReview(attractionNo){
		
		$.ajax({
			url: "${contextPath}/review/deleteRpview",
			data: {"attractionNo": attractionNo},
			type: "POST",
			
			success: function(result){
				
				if(result>0){
					selectreviewList();
					reviewCount();
					swal({
						icon: "success",
						title: "댓글이 삭제되었습니다."
					});
				}
			},
			error: function(e){
				console.log(e);
			}
		});
	}
	
	// 댓글 수 갱신
	function reviewCount(){
		
		$.ajax({
			url: "reviewCount",
			data: {"attractionNo": attractionNo},
			type: "POST",
			
			success: function(reviewCount){
				$("#reviewCount").text(reviewCount);
			},
			error: function(e){
				console.log(e);
			}
		});
	}
	

	

</script>
