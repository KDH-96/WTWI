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
	padding-bottom: 0;
}

#chat-btn {
	float: right;
}

/* 별점 영역 시작 */
#star {
	margin-left: 25px;
}


#attr-info-table *{
	font-size: 12px;
}

#attr-title{
	margin-bottom: 0;
}

#attr-info{
	height: 145px;
	overflow: hidden;
  	text-overflow: ellipsis;
  	white-space: normal;
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
				</p>
				<a href="#" class="badge badge-pill badge-primary" id="write-btn">리뷰작성</a>
				<a href="#" class="badge badge-pill badge-info" id="chat-btn">1:1채팅</a>
				<hr>
				<div><a href="#" class="badge badge-pill badge-primary" id="view-btn" onclick="selectReviewList()"> 리뷰 보기</a></div>
			</div>
		</div>
	</div>
	<!-- =================================== 명소 상세정보 영역 끝 =================================== -->
	
	<script>
		
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
        	if(wirteFlag = 1) {
	        	$("#write-review-wrapper").fadeOut(100);
	        	writeFlag = 0;
        	}
        });
	</script>
	
</body>
</html>