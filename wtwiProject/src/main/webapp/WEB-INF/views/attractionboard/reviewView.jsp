<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
/* 리뷰 리스트 조회 시작 */
#select-review-wrapper {
	right: 290px;
	position: absolute;
	z-index: 2;
	margin: auto;
	border-radius: 5px;
	opacity: 90%;
	width: 400px;
}

/* 별점 영역 시작 */
#star {
	margin-left: 25px;
}

.star-rating {
	display: flex;
	flex-direction: row-reverse;
	font-size: 15px;
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

input[name="reting"] {
	margin: 0;
}

/* 별점 영역 끝 */

/* 리뷰 리스트 조회 끝 */
</style>


</head>
<!-- 
<body>
	<div id="select-review-wrapper">
		<div class="card">
			<div>
				<span style="line-height: 50px; font-size: 20px; margin-left: 15px;">리뷰
					리스트 조회</span>
			</div>
			<ul>
				별점 영역 시작
				<div class="star-rating space-x-4 mx-auto">
					<input type="radio" id="5-stars" name="rating" value="5"
						v-model="ratings" /> <label for="5-stars" class="star pr-4">★</label>
					<input type="radio" id="4-stars" name="rating" value="4"
						v-model="ratings" /> <label for="4-stars" class="star">★</label>
					<input type="radio" id="3-stars" name="rating" value="3"
						v-model="ratings" /> <label for="3-stars" class="star">★</label>
					<input type="radio" id="2-stars" name="rating" value="2"
						v-model="ratings" /> <label for="2-stars" class="star">★</label>
					<input type="radio" id="1-star" name="rating" value="1"
						v-model="ratings" /> <label for="1-star" class="star" id="star">★</label>
				</div>
				별점 영역 끝
				<li class="reply-row">
					<div>
						<p class="rWriter">닉네임 자리</p>
						<p class="rDate">작성일자리 :</p>
					</div>
					<div>사진 첨부 영역</div>
					<p class="rContent">댓글 내용 자리</p>
				</li>
			</ul>
		</div>
	</div>
 -->
	<script>
	/* 
	function selectReviewList(){
		
		$.ajax({
			url : "${contextPath}/review/list",
			data : selectedMarker,
			type : "POST",
			dataType : "JSON",
			success : function(rList){
				console.log(rList);
				
				
				
			},
			error : function(){
				console.log("리뷰 목록 조회 실패");	
				
			}
			
		})
		
		
		
		
	 */	
		
		
		
	}
	
	
	
	
	
	
	
	</script>

</body>


</html>