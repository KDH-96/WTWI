<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" scope="application" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">


<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>명소 상세조회</title>
   
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
      integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

   <style>

      /* ------------------------------영역구분선------------------------------ */
      #contentContainer {
         /* background-color: red;*/
         margin: auto;
         width: 1200px;
      }
      /* content ) 게시글 목록 스타일 */
      #h-menu{
         clear :both;
      }
      .h-div{
         float:left;
         width : 21%;
      }
      .attraction-menu{
         display: inline-block;
         width : 50%;
      }
      /* 게시글 목록의 높이가 최소 540px은 유지하도록 설정 */
      .list-wrapper {
         min-height: 50%;
      }
      /* pagination 가운데 정렬 */
      .pagination {
         justify-content: center;
      }
      #searchForm {
         position: relative;
      }
      #searchForm>* {
         top: 0;
      }
      .card{
      	display: inline-block;
      	float : left;
      }
      .my-2{
      	display: inline-block;
      }
      .list-class{
      	display: inline-block;
      }
      #cute-area-div{
      	height: 15%;
      }
      #attrNm-div{
      	height: 20%;
      }
      #attrVirtual-content{
      	height: 300px;
      }
      #attr-photo-div{
      	display: inline-blocl;
      	float : left;
      	height: 100%;
      	width: 40%;
      	margin-right : 10px;
      }
      #attr-photo-div > img {
      }
      #attr-weatherAddr-div{
      	height: 100%;
      	width: 50%;
      	display: inline-blocl;
      	float : left;
      }
      #attr-weather-info-div{
      	height: 60%;
      }
      #attr-date-choice-div{
      	height : 35%;
      }
      #attr-weather-div{
				height : 65%;
      }
      #attr-addr-div{
      	height : 50%;
      }
      #attrInfo-div{
      	margin-top : 30px;
      	margin-left : 30px;
      	margin-right : 30px;
      }
      #attrNavi-div{
      	margin-top : 50px;
      	text-align : center;
      }
      #attrReview-div{
      	margin-top : 50px;
      }
      #attrMap-div{
      	height : 500px;
      }
      #btn-div{
      	margin-top : 50px;
      }
      #navi-link-a{
      	text : 15px;
      }
      #attr-date-choice-left{
      	width : 50%;
      	float : left;
      }
      #attr-date-choice-right{
      	width : 50%;
      	float : left;
      }
      /* ------------------------------영역구분선------------------------------ */
   </style>
</head>

<body>
   <jsp:include page="../common/header.jsp" />
   <!-- ===============================영역구분선=============================== -->
   <!-- 전체 div를 포함하는 영역 -->
   <div id="contentContainer">
      <div id="contentArea">
         <div class="list-wrapper">
         
         			<div id="cute-area-div"><br><br>★여행정보★</div>
         			<div id="attrNm-div"><h2>${attr.attractionNm}</h2></div>
         			<div id="attrVirtual-content">
         					<div id="attr-photo-div">
                       <c:choose>
                             <c:when test = "${attr.attractionPhoto != ''}">
                                   <img src= "${attr.attractionPhoto}">
                             </c:when>
                             <c:otherwise>
                                   <img src="https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg">
                             </c:otherwise>
                       </c:choose>

         					</div>
         					<div id="attr-weatherAddr-div">
         							<div id="attr-weather-info-div">
         									<div id="attr-date-choice-div">
         											<div id="attr-date-choice-left">
		         											<button onclick="getBeforeDay()" class="btn btn-outline-dark">&laquo;</button>
		         											<span id="date-span" style="font-size:18px"></span>
		         											<button onclick="getNextDay()" class="btn btn-outline-dark">&raquo;</button>
         											</div>
         											<div id="attr-date-choice-right">
         													
         											</div>
         									</div>
         									<div id="attr-weather-div"></div>
         							</div>
         							<div id="attr-addr-div">${attr.attractionAddr}</div>
         					</div>
         			</div>
         			
         			<div id="attrInfo-div">${attr.attractionInfo}</div>
         			
         			<div id="attrReview-div">최신 리뷰 5개 들어갈 div</div>
         			
         			<div id="attrMap-div"></div>         			
         			
         			<div id="attrNavi-div">
         					<a id="navi-link-a" class="link-dark" href="https://map.kakao.com/link/to/${attr.attractionNm},${attr.latitude},${attr.longitude}">길찾기</a>
         			</div>
         			
         			<div id="btn-div">     
         					<a href="list?cp=${param.cp}${keyword}" class="btn btn-primary float-right mr-2">목록으로</a>         
         					<button class="form-control btn btn-primary" id="back-btn"
              		style="width:100px; display: inline-block; background-color: black; border: black;">뒤로가기</button>
              </div>
         		
         </div>
         <!----------------------------------------------------------------------------------------------  content end -->


         <!-- 검색창 -->
         
      </div><!-- contentarea 끝 -->
   </div>



   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>
   
   

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
      crossorigin="anonymous"></script>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e9f2b3228a237afc810c6514cece7e38"></script>
	

	<%-- 날씨 script --%>	
	<script>
						
			var attrList = ${attrList};
			console.log(attrList);
			var radius = ${radius};
			console.log(radius);
			
			var attraction = ${attraction};
			// controller에서 ObjectMapper().writeValueAsString(attr) 이용해서 json객체로 전달받음
			
			var latitude = attraction.latitude;
			var longitude = attraction.longitude;
			
	    var tiempo = new Array();
			var days = new Array();
			var icons = new Array();
	
	    $.getJSON('https://api.openweathermap.org/data/2.5/onecall?lat=' + latitude + '&lon=' 
	    					 + longitude + '&exclude=current&appid=ab504b375f2e984221e8e5471b13095c&units=metric', function (data) {
	
	        //console.log(data);
	
	        var ctime = data.daily[0].dt;
	        var minTemp = data.daily[0].temp.min;
	        var maxTemp = data.daily[0].temp.max;
	
	        var now = new Date($.now());
	        var cDate = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate() ;
	        // cDate의 시간은 불필요한 것 같아 지웠음. 오리지널에 있으면 후에 쓸 것
	        
	        for (var i = 0; i < 8; i++) {
	            var wtime = data.daily[i].dt;
	            var thisDate = new Date(wtime*1000);
	
	            function dayLabel(){
	                var week = new Array ('일요일','월요일','화요일','수요일','목요일','금요일','토요일');
	                var today = thisDate;
	                var todayLabel = week[today.getDay()];
	                
	                return todayLabel;
	            }
	
	            var maxTemp = Math.round(data.daily[i].temp.max);
	            var minTemp = Math.round(data.daily[i].temp.min);
	            var wicon = '<img src="http://openweathermap.org/img/wn/' +
	                data.daily[i].weather[0].icon + '.png" >';
	            
	            
	            tiempo.push(minTemp +'℃/' + maxTemp + '℃');
							days.push(now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + (now.getDate()+i) + ' ' + dayLabel());
							icons.push(
	                '<ul style="width:100px; list-style: none;" >' +
	                '<li">' +
	                '<div style="text-align: center;">' + wicon + '</div>' +
	                '</li>' +
	                '<li">' +
	                '<div style="text-align: center;">' + minTemp +'℃/' + maxTemp + '℃</div>' +
	                '</li>' +
	                '</ul>');
	            //$('#attr-weather-div').append(tableHtml);
	        }
	        
	        console.log(tiempo);
	        console.log(days);
	
			    $("#date-span").text(days[0]);
			    $("#attr-date-choice-right").html(icons[0]);	
			    
	    });

	    function getNextDay(){
	    	$("#date-span").text(days[1]);
				$("#attr-date-choice-right").html(icons[1]);    	
	    }
	    
	    function getBeforeDay(){
	    	$("#date-span").text(days[0]);
	    	$("#attr-date-choice-right").html(icons[0]);
	    }
	    
	    

			var mapContainer = document.getElementById('attrMap-div'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			// 마커가 표시될 위치입니다 
			var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    position: markerPosition
			});
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
			// marker.setMap(null);    
	</script>
		
		


</body>

</html>