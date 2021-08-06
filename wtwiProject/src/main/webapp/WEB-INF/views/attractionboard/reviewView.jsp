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
}

#attraction-info {
	margin: auto;
	opacity: 90%;
}

#attraction-image {
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
</style>
</head>
<body>


	<!-- =================================== 명소 상세정보 영역 시작 =================================== -->

	<div id="attraction-info-area">
            <div class="card" style="width: 18rem;" id="attraction-info">
                <img src="https://github.com/Jun-Seok-K/coja/blob/master/sample_image.png?raw=true" class="card-img-top"
                    alt="..." id="attraction-image">
                <div class="card-body">
                    <h5 class="card-title">명소 이름이 올 자리</h5>
                    <p class="card-text">
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
                    <table>
                        <tr>
                            <td>유형 : </td>
                            <td>명소의 유형 입력</td>
                        </tr>
                        <tr>
                            <td>연락처 : </td>
                            <td>02-2124-8800</td>
                        </tr>
                        <tr>
                            <td>주소 : </td>
                            <td>주소 입력 영역</td>
                        </tr>
                        <tr>
                            <td>여는시간 : </td>
                            <td>10:00</td>
                        </tr>
                        <tr>
                            <td>닫는시간 : </td>
                            <td>20:00</td>
                        </tr>
                    </table>
                    </p>
                    <a href="#" class="badge badge-pill badge-primary" id="review-btn">리뷰작성</a>
                    <a href="#" class="badge badge-pill badge-info" id="chat-btn">1:1채팅</a>
                    <hr>
                    <span>작성된 리뷰가 없습니다.</span>
                </div>
            </div>
        </div>

	<!-- =================================== 명소 상세정보 영역 끝 =================================== -->
</body>
</html>