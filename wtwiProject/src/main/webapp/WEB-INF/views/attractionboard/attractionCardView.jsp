<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	font-size: 1.25rem;
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

#attr-info-table *{
	font-size: 14px;
}
</style>
</head>
<body>


	<!-- =================================== 명소 상세정보 영역 시작 =================================== -->

	<div id="attraction-info-area">
		<div class="card" style="width: 18rem;" id="attraction-info">
			<img src="#" class="card-img-top" alt="..." id="attr-image">
			<div class="card-body">
				<h5 class="card-title"><a id="attr-title" href=""></a></h5>
				<p class="card-text">
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
						<td id="attr-info"></td> <!-- 명소 소개 출력 부분 -->
					</tr>
					<tr>
						<td style="text-align:right; font-size: 13px;"><a id="to-attr-view" href="${contextPath}/attraction/view/">더 보기</a></td> <!-- 명소 상세조회 페이지로 이동하는 부분 -->
					</tr>
				</table>
				</p>
				<a href="#" class="badge badge-pill badge-primary" id="review-btn">리뷰작성</a>
				<a href="#" class="badge badge-pill badge-info" id="chat-btn">1:1채팅</a>
				<hr>
				<div>작성된 리뷰가 없습니다. <!-- 리뷰 있을 경우 리뷰보기 버튼으로 바뀜... --></div>
			</div>
		</div>
	</div>

	<!-- =================================== 명소 상세정보 영역 끝 =================================== -->

</body>
</html>