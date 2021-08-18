<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 배포된 웹 애플리케이션의 최상위 주소를 간단히 얻어올 수 있도록 
     application 범위로 변수를 하나 생성 --%>
<c:set var="contextPath" scope="application"
	value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>마이페이지</title>
<style>
.myPage-body {
	display: flex;
	height: 100vh;
	background-image: url("https://source.unsplash.com/featured/?korea-palace");
	background-size: 100% auto;
	margin-bottom: 100px;
}

.myPage-main {
	width: 80%;
	margin-top: 40px;
}

.myPage-main__list {
	margin-right: 20px;
}

.fa-star {
	color: yellow;
}

.recommend-container {
	display: flex;
	width: 100%;
	height: 450px;
	align-items: center;
	justify-content: space-between;
	margin: 0px 10px 30px 0px;
}

.attraction {
	display: flex;
	position: relative;
	flex-direction: column;
	align-items: center;
	margin: 0px 5px;
	width: 20%;
	height: 100%;
	background-color: #ffffff;
	border-radius: 30px;
	box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
}

.attraction_list {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 20px;
}

.attrImage {
	height: 220px;
	border-top-left-radius: 30px;
	border-top-right-radius: 30px;
}

.attrNm {
	font-size: 18px;
	font-weight: bold;
	width: inherit;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	line-height: 1.2;
	text-align: center;
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
	position: relative; 
	margin: 0px 10px;
}


.attrNm:after {
position: absolute;
 content: ''; 
 width: 100%; 
 height: 1px;
 left : -2px;
 bottom: 0px;
 background: orange; 
 }

.attrStar {
	margin-top: 10px;
}

.attrReview {
	vertical-align: middle;
	width: inherit;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	line-height: 1.2;
	text-align: center;
	word-wrap: break-word;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	margin: 20px 10px 0px 10px;
}

.fa-chevron-down {
	position: absolute;
	bottom: 20px;
	color: rgba(0, 0, 0, 0.25);
}

.fa-chevron-down:hover {
	cursor: pointer;
	color: rgba(0, 0, 0, 0.5);
	transition: 0.2s ease-in-out;
}

.info-container {
	display: flex;
	width: 100%;
	height: 400px;
	background-color: #ffffff;
	border-radius: 30px;
	box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
}

#map {
	width: 45%;
	height: 100%;
	border-top-left-radius: 30px;
	border-bottom-left-radius: 30px;
}

.my-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
	height: 200px;
	background-color: #ffffff;
	margin-bottom: 30px;
	border-radius: 30px;
	box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
	padding: 20px;
}

.climate-container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100%;
	width: 55%;
	
}
.climate-container ul{
	list-style: none;
	height: 50%;
	display: flex;
	justify-content: center;
	padding: 20px;
}

.climate-container li {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	align-items: center;
}

.climate-container li:not(:last-child){
	border-right: 1px solid rgba(0,0,0,0.3);
	padding: 0px 15px;
}

.climate-container li:last-child{
	padding-left: 15px;
}

.weather {
	width: 100px;
	height: 100px;
}

.climate {
	width: 60px;
	height: 60px;
}

.hidden {
	display: none;
}

.btn-social-login, .article {
	text-decoration: none;
}
.article-li {
	height: 30px;
}

.btn-social-login:hover {
	text-decoration: none;
	color: white;
}
.article:hover {
	text-decoration: none;
	color: inherit;
	font-weight: bold;
}
.nickName, .newline{
	display: flex;
	align-items: center;
	margin-right: 30px;
}

.newline {
	margin-right: 70px;
}

.hello {
	display: flex;
	flex-direction: column;
	width: 40%;
	align-items: center;
	justify-content: center;
	margin-top: 20px;
	border-right: 1px solid rgba(0,0,0,0.3);
}
.news {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 90%;
	margin-top: 20px;
}
.news ul {
	widht: 100%;
}
.hello__weather-area {
	display: flex;
	align-items: center;
}
.hello__text-area {
	display: flex;
	text-align: center;
	flex-direction: column;
}
.fa-newspaper {
	margin-right: 5px;
}
.climate-place__area {
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-bottom: 10px;
}
.climate-place{
	font-weight: bold
}
.days { 
position: relative; 
} 
.days:after {
 content: ''; 
 display: block; 
 width: 100%; 
 height: 3px; 
 position: absolute; 
 left : 1px;
 background: #97B0FB; 
 }



</style>
</head>


<body class="myPage-body">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>

	<main class="myPage-main">
		<div class="myPage-main__list">
			<div class="my-container">
				<div class="hello">
					<h4 class="nickName">${loginMember.memberNick }님, 좋은 하루입니다 :)</h4>
					<div class="hello__weather-area">
						<div class="hello__text-area">
							<span>현재 계신 곳의 날씨는?</span>
							<span id="feelsLike"></span>
						</div>
						<img class="weather" alt="#" src="#">
					</div>
				</div>
				<div class="news">
					<c:if test="${!empty news}">
						<h4 class="newline"><i class="far fa-newspaper"></i>오늘의 여행 뉴스</h4>
						<ul>						
							<c:forEach items="${news }" var="news" varStatus="n" begin="0" end="4" >
								<li class="article-li"><a class="article" href="${news.link }">${news.title }</a></li>	
							</c:forEach>
						</ul>
					</c:if>
				</div>
			</div>
			<c:if test="${!empty reviewList}">
				<div class="recommend-container">
					<c:forEach items="${reviewList }" var="board" varStatus="b" >
						<div class="attraction">
							<img class="attrImage" src="${board.src }" alt="" onerror="this.src='/test/noImg.gif">
							<div class="attraction_list">
								<span class="attrNm">${board.attractionNm }</span>
								<div class="attrStar">
									<i class="fas fa-star fa-lg"></i> 
									<i class="fas fa-star fa-lg"></i> 
									<i class="fas fa-star fa-lg"></i> 
									<i class="fas fa-star fa-lg"></i> 
									<i class="fas fa-star fa-lg"></i>
								</div>
								<span class="attrReview">${board.reviewContent }</span>
							</div>
							<i onclick="getInfo(${board.latitude},${board.longitude},'${board.attractionNm}');" class="fas fa-chevron-down fa-2x"></i>
						</div>
					</c:forEach>
				</div>
			</c:if>
			<div class="info-container hidden">
				<div id="map"></div>
				<div class="climate-container">
					<div class="climate-place__area">
						<h4 class="climate-place"></h4>
						<span>오늘을 포함한 향후 <span class="days">5일간</span>의 날씨예보입니다 :)</span>
					</div>
					<ul class="climate-container__ul"></ul>
				</div>

			</div>
		</div>
	</main>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8a4ed58fe9183d361bb15c5289604c5f"></script>
	<script type="text/javascript">
    
    	function onGeoSuccess(position) {
    		const latitude = position.coords.latitude, 
    			  longitude = position.coords.longitude;
    		
    		$.ajax({
       			url : "${contextPath}/myPage/info",
       			data : {"latitude":latitude, "longitude":longitude, "check": "my"},
       			type : "POST",
       			dataType : "JSON",
       			success : function(info){
       	
       				var description = info.weather[0].description;
       				var weather = info.weather[0].main;
       				var icon = "http://openweathermap.org/img/wn/"+ info.weather[0].icon +".png";
       				$(".weather").attr("src",icon);
       				$("#feelsLike").text(description);
       			},
       			error : function(){ // ajax 통신 실패 시
    				console.log("통신 실패");
       			}

		})
    	}
    	
    	function onGeoError(){
    		
    	}
    
    	navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError);
    
    	function getInfo(latitude, longitude, place){
    		
    		$(".info-container").removeClass("hidden");
    		
    		console.log(place);
    		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    		var options = { //지도를 생성할 때 필요한 기본 옵션
    			center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
    			level: 3 //지도의 레벨(확대, 축소 정도)
    		};
			console.log(latitude, longitude);
    		var map = new kakao.maps.Map(container, options);
    		
    		var marker = new kakao.maps.Marker({ 
    		    // 지도 중심좌표에 마커를 생성합니다 
    		    position: map.getCenter() 
    		}); 
    		// 지도에 마커를 표시합니다
    		marker.setMap(map);
    		
    		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
    		var mapTypeControl = new kakao.maps.MapTypeControl();

    		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
    		// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
    		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

    		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
    		var zoomControl = new kakao.maps.ZoomControl();
    		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT)
			
    		
    		$.ajax({
           			url : "${contextPath}/myPage/info",
           			data : {"latitude":latitude, "longitude":longitude, "check": "all"},
           			type : "POST",
           			dataType : "JSON",
           			success : function(info){
           				$(".climate-container__ul").html("");
           				$.each(info.list, function(index, item){
           					var time = item.dt_txt;
           					if(time.substring(11,13)=="15"){           	
           						var week = ['일', '월', '화', '수', '목', '금', '토'];
           						var dayOfWeek = week[new Date(time.substring(0,10)).getDay()];
	           					var day = $("<span>").text(time.substring(5,7)+"월 " + time.substring(8,10) + "일("+dayOfWeek+")");
	           			        var temp= $("<span>").text(item.main.temp);
	           			        var feels_like= $("<span>").text("체감온도 " + item.main.feels_like);
	           			        var humidity = $("<span>").text("습도 " + item.main.humidity);
	           			        var icon = $("<img>").attr("src", "http://openweathermap.org/img/wn/" + item.weather[0].icon + ".png").addClass("climate");
	           			        var description = $("<span>").text(item.weather[0].description);
	           			        
	           			        var li = $("<li>");
	           			        li.append(day).append(icon).append(feels_like).append(humidity).append(description);
	           			     	$(".climate-container__ul").append(li);
	           			     	$(".climate-place").text(place+"의");
	           			     	
           					}

           				})
           				
           			},
           			error : function(){ // ajax 통신 실패 시
        				console.log("통신 실패");
           			}
 
    		})
    		
    	}
    </script>
</body>
</html>