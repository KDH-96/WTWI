<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
/* 후기작성 폼 시작 */
#write-review-wrapper {
	right: 290px;
	position: absolute;
	z-index: 2;
	margin: auto;
	border-radius: 5px;
	opacity: 90%;
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
	width: 280px;
	height: 80px;
}

#img-area1 {
	margin-left: 25px;
}

#text-area {
	height: 200px;
	width: 265px;
	margin: auto;
	resize: none;
}

#text-area-wrapper {
	margin: auto;
	width: 280px;
}

#review-write-btn {
	width: 80px;
	margin-bottom: 10px;
	float: left;
}

#cancel-btn {
	width: 80px;
	margin-bottom: 10px;
	float: right;
}


/* 후기작성 폼 끝 */
</style>
</head>
<body>
	<div id="write-review-wrapper">
        <div class="card">
            <div>
                <span style="line-height: 50px; font-size: 20px; margin-left: 15px;">리뷰 작성</span>
            </div>
            <hr>
            <!-- 별점 영역 시작 -->
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
            <!-- 별점 영역 끝 -->
            <hr>
            <!-- 이미지 영역 시작 -->
            <div id="image-wrapper">
            
            
                <input type="file" id="real-input" class="image_inputType_file" accept="img/*" required multiple>
				<button class="browse-btn">사진업로드</botton>
            </div>
            <!-- 이미지 영역 끝 -->
            <hr>
            <div id="text-area-wrapper">
                <textarea class="form-control" aria-label="With textarea" id="text-area" rows="20"></textarea>
            </div>
            <hr>
            <div>
                <button type="button" class="btn btn-primary mx-3" id="review-write-btn">작성</button>
                <button type="button" class="btn btn-secondary mx-3" id="cancel-btn">취소</button>
            </div>
        </div>
	</div>
	
	<script>
		document.getElementById("browse-btn").addEventListener("click", function(){
			document.getElementById("real-input").click();
		});
		
	
	</script>
</body>
</html>