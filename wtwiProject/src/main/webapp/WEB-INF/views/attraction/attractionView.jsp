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
      /* 게시글 목록의 높이가 최소 540px은 유지하도록 설정 */
      .list-wrapper {
         min-height: 50%;
      }
      #cute-area-div{
      	margin-bottom : 5px;
      }
      #attrNm-div{
      	height: 20%;
      	margin-bottom : 10px;
      }
      #attrVirtual-content{
      	height: 300px;
      }
      #attr-photo-div{
      	display: inline-blocl;
      	float : left;
      	height: 100%;
      	width: 35%;
      	margin-right : 10px;
      }
      #attr-photo-div > img {
      }
      #attr-weatherAddr-div{
      	height: 100%;
      	width: 63%;
      	display: inline-blocl;
      	float : left;
      }
      #attr-weather-info-div{
      	height: 40%;
      	margin-top : 5px;
      }
      #attr-date-choice-div{
      	height : 55%;
      	padding-top : 10px;
      }
      #attr-weather-div{
				height : 65%;
      }
      #attr-addr-div{
      	height : 25%;
      	margin-top : 10px;
      }
      #attr-phone-div{
      	height : 25%;
      	margin-top: 10px;
      	width : 25%;
      	float : left;
      	disply : inline-block;
      }
      #attr-homepage-div{
      	height : 25%;
      	margin-top: 10px;
      	width : 73.5%;
      	float : left;
      	disply : inline-block;
      	margin-left : 10px;
      }
      #attrInfo-div{
      	margin-top : 30px;
      }
      #attrNavi-div{
      	margin-top : 50px;
      	text-align : center;
      }
      #attrReview-div{
      	margin-top : 50px;
      }
      #attrMap-div{
      	height : 380px;
      }
      #btn-div{
      	margin-bottom : 30px;
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
			#mapwrap{position:relative;overflow:hidden;}
			.category, .category *{margin:0;padding:0;color:#000;}   
			.category {position:absolute;overflow:hidden;top:10px;left:10px;width:155px;height:50px;z-index:10;border:1px solid black;font-family:'Malgun Gothic','맑은 고딕',sans-serif;font-size:12px;text-align:center;background-color:#fff;}
			.category .menu_selected {background:#FF5F4A;color:#fff;border-left:1px solid #915B2F;border-right:1px solid #915B2F;margin:0 -1px;} 
			.category li{list-style:none;float:left;width:50px;height:45px;padding-top:5px;cursor:pointer;} 
			.category .ico_comm {display:block;margin:0 auto 2px;width:22px;height:26px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png') no-repeat;} 
			.category .ico_coffee {background-position:-10px 0;}  
			.category .ico_store {background-position:-10px -36px;}   
			.category .ico_carpark {background-position:-10px -72px;} 
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
         			<div id="attrNm-div"><h1><strong>${attr.attractionNm}</strong></h1></div>
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
         							<div id="attr-weather-info-div" style="background-color : #f7f7f7">
         									<div id="attr-date-choice-div" >

         									</div>
         							</div>
         							<div id="attr-addr-div" style="background-color : #f7f7f7" >
         									<div style="margin-left : 30px; padding : 8px"><h4 style="display : inline-block"><strong>주소</strong></h4>
         									   <br>${attr.attractionAddr} . . . . . . . . . . <a id="navi-link-a" class="link-dark" href="https://map.kakao.com/link/to/${attr.attractionNm},${attr.latitude},${attr.longitude}"><span><strong>카카오맵으로 길찾기</strong></span></a>
         									</div>
         							</div>
         							<div id="attr-phone-div" style="background-color : #f7f7f7">
         									<div style="margin-left : 30px; padding : 8px">
         											<h4><strong>전화번호</strong></h4>${attr.attractionPhone}
         									</div>
         							</div>
         							<div id="attr-homepage-div" style="background-color : #f7f7f7">
         									<div style="margin-left : 30px; padding : 8px">
         											<h4><strong>홈페이지</strong></h4>${attr.attractionHomePage}
         									</div>
         							</div>
         					</div>
         			</div>
         			
         			<div id="attrInfo-div" >${attr.attractionInfo}</div>
         			
         			<div id="attrReview-div">최신 리뷰 5개 들어갈 div</div>
         			
         			<div id="attrMap-div">
         					<div id="mapwrap"> 
									    <!-- 지도가 표시될 div -->
									    <div id="map" style="width:100%;height:350px;"></div>
									    <!-- 지도 위에 표시될 마커 카테고리 -->
									    <div class="category">
									        <ul>
									            <li id="coffeeMenu" onclick="changeMarker('coffee')">
									                <span class="ico_comm ico_coffee"></span>
									                관광지
									            </li>
									            <li id="storeMenu" onclick="changeMarker('store')">
									                <span class="ico_comm ico_store"></span>
									                문화시설
									            </li>
									            <li id="carparkMenu" onclick="changeMarker('carpark')">
									                <span class="ico_comm ico_carpark"></span>
									                맛집
									            </li>
									        </ul>
									    </div>
									</div>
         			
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
					
			
	
			var attraction = ${attraction}; 
			// 상세조회 할 attraction : controller에서 ObjectMapper().writeValueAsString(attr) 이용해서 json객체로 전달받음
			
			/***** 날씨 *********************************************************************************************/
			
			var latitude = attraction.latitude;
			var longitude = attraction.longitude;
			// 날씨를 얻어오기 위해 경도, 위도 받아오기
			
	    var tiempo = new Array();
			var days = new Array();
			var icons = new Array();
			// 날씨, 날짜, 아이콘을 담을 배열
	
			// 위에 얻어온 위/경도로 날씨 정보 얻어오기
	    $.getJSON('https://api.openweathermap.org/data/2.5/onecall?lat=' + latitude + '&lon=' 
	    					 + longitude + '&exclude=current&appid=ab504b375f2e984221e8e5471b13095c&units=metric', function (data) {
	
	        var ctime = data.daily[0].dt; // 현재 시간을 유닉스 형태로 저장
	        var minTemp = data.daily[0].temp.min;
	        var maxTemp = data.daily[0].temp.max;
	
	        var now = new Date($.now()); // 현재 시간 얻어오기
	        var cDate = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate() ;
	        // cDate의 시간은 불필요한 것 같아 지웠음. 오리지널에 있으면 후에 쓸 것
	        
	        for (var i = 0; i < 8; i++) {
	            var wtime = data.daily[i].dt;
	            var thisDate = new Date(wtime*1000);
	
	            function dayLabel(){
	                var week = new Array ('(일)','(월)','(화)','(수)','(목)','(금)','(토)');
	                var today = thisDate;
	                var todayLabel = week[today.getDay()];
	                
	                return todayLabel;
	            }
	
	            var maxTemp = Math.round(data.daily[i].temp.max);
	            var minTemp = Math.round(data.daily[i].temp.min);
	            var wicon = '<img src="http://openweathermap.org/img/wn/' +
	                data.daily[i].weather[0].icon + '.png" >';
	            
	            
	            tiempo.push(minTemp +'℃/' + maxTemp + '℃');
							days.push((now.getMonth() + 1) + '/' + (now.getDate()+i) + ' ' + dayLabel());
							icons.push(
	                '<ul style="width:90px; list-style: none; display:inline-block;" >' +
	                '<li">' +
	                '<div style="text-align: center;">' + (now.getMonth() + 1) + '/' + (now.getDate()+i) + dayLabel() + '</div>' +
	                '</li>' +
	                '<li">' +
	                '<div style="text-align: center;">' + wicon + '</div>' +
	                '</li>' +
	                '<li">' +
	                '<div style="text-align: center;">' + minTemp +'℃/' + maxTemp + '℃</div>' +
	                '</li>' +
	                '</ul>');
							
	        }
	        
	        for( let i = 0 ; i < icons.length ; i++){
	        	$("#attr-date-choice-div").append(icons[i]);
	        }
	        
	        // 배열에 잘 담겼는지 확인 완료
	        //console.log(tiempo);
	        //console.log(days);
	
	        // 오늘 날짜로 입력
			    $("#date-span").text(days[0]);
			    $("#attr-date-choice-right").html(icons[0]);	
			    
	    });

	    /** 지도에 명소 위치 표시 + 주변 명소 마커 뿌리기 **************************************************************/

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
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
			
			
			/****************************************************************************/
			
			// 주변 명소 마커 용으로 controller에서 받아옴 json형태로 toString 바꿔 만듦.
			var attrList12 = ${attrList12};
			var attrList14 = ${attrList14};
			var attrList39 = ${attrList39};
			
			
			var array12 = new Array();
			var array14 = new Array();
			var array39 = new Array();
			
			console.log(attrList39);
			console.log(attrList12[0].mapx);
			
			for (i = 0 ; i < attrList12.length ; i ++){
				array12.push(new kakao.maps.LatLng(attrList12[i].mapy, attrList12[i].mapx));
			}
			for (i = 0 ; i < attrList14.length ; i ++){
				array14.push(new kakao.maps.LatLng(attrList14[i].mapy, attrList14[i].mapx));
			}
			for (i = 0 ; i < attrList39.length ; i ++){
				array39.push(new kakao.maps.LatLng(attrList39[i].mapy, attrList39[i].mapx));
			}
			console.log(array12);
			
			// 커피숍 마커가 표시될 좌표 배열입니다 : 관광지 -> array12			
			// 편의점 마커가 표시될 좌표 배열입니다 : 문화시설 -> array14
			// 주차장 마커가 표시될 좌표 배열입니다 : 맛집 -> array39 (carparkPositions) 
			
			var markerImageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png';  
					// 마커이미지의 주소입니다. 스프라이트 이미지 입니다
			    coffeeMarkers = [], // 커피숍 마커 객체를 가지고 있을 배열입니다
			    storeMarkers = [], // 편의점 마커 객체를 가지고 있을 배열입니다
			    carparkMarkers = []; // 주차장 마커 객체를 가지고 있을 배열입니다
			    
			createCoffeeMarkers(); // 커피숍 마커를 생성하고 커피숍 마커 배열에 추가합니다
			createStoreMarkers(); // 편의점 마커를 생성하고 편의점 마커 배열에 추가합니다
			createCarparkMarkers(); // 주차장 마커를 생성하고 주차장 마커 배열에 추가합니다
			
			var src12 = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

			changeMarker('coffee'); // 지도에 커피숍 마커가 보이도록 설정합니다    
			
			// 마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
			function createMarkerImage(src, size, options) {
			    var markerImage = new kakao.maps.MarkerImage(src, size, options);
			    return markerImage;            
			}
			// 좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
			function createMarker(position, image) {
			    var marker = new kakao.maps.Marker({
			        position: position,
			        image: image
			    });
			    return marker;  
			}   
			// 커피숍 마커를 생성하고 커피숍 마커 배열에 추가하는 함수입니다
			function createCoffeeMarkers() {
			    for (var i = 0; i < array12.length; i++) {  
			        
			        var imageSize = new kakao.maps.Size(22, 26),
			            imageOptions = {  
			                spriteOrigin: new kakao.maps.Point(10, 0),    
			                spriteSize: new kakao.maps.Size(36, 98)  
			            };     
			        // 마커이미지와 마커를 생성합니다
			        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
			            marker = createMarker(array12[i], markerImage);  
			        // 생성된 마커를 커피숍 마커 배열에 추가합니다
			        coffeeMarkers.push(marker);
			    }     
			}
			// 커피숍 마커들의 지도 표시 여부를 설정하는 함수입니다
			function setCoffeeMarkers(map) {        
			    for (var i = 0; i < coffeeMarkers.length; i++) {  
			        coffeeMarkers[i].setMap(map);
			    }        
			}
			
			// 편의점 마커를 생성하고 편의점 마커 배열에 추가하는 함수입니다
			function createStoreMarkers() {
			    for (var i = 0; i < array14.length; i++) {
			        
			        var imageSize = new kakao.maps.Size(22, 26),
			            imageOptions = {   
			                spriteOrigin: new kakao.maps.Point(10, 36),    
			                spriteSize: new kakao.maps.Size(36, 98)  
			            };       
			     
			        // 마커이미지와 마커를 생성합니다
			        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
			            marker = createMarker(array14[i], markerImage);  
			
			        // 생성된 마커를 편의점 마커 배열에 추가합니다
			        storeMarkers.push(marker);    
			    }        
			}
			
			// 편의점 마커들의 지도 표시 여부를 설정하는 함수입니다
			function setStoreMarkers(map) {        
			    for (var i = 0; i < storeMarkers.length; i++) {  
			        storeMarkers[i].setMap(map);
			    }        
			}
			
			// 주차장 마커를 생성하고 주차장 마커 배열에 추가하는 함수입니다
			function createCarparkMarkers() {
			    for (var i = 0; i < array39.length; i++) {
			        
			        var imageSize = new kakao.maps.Size(22, 26),
			            imageOptions = {   
			                spriteOrigin: new kakao.maps.Point(10, 72),    
			                spriteSize: new kakao.maps.Size(36, 98)  
			            };       
			     
			        // 마커이미지와 마커를 생성합니다
			        var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
			            marker = createMarker(array39[i], markerImage);  
			
			        // 생성된 마커를 주차장 마커 배열에 추가합니다
			        carparkMarkers.push(marker);        
			    }                
			}
			
			// 주차장 마커들의 지도 표시 여부를 설정하는 함수입니다
			function setCarparkMarkers(map) {        
			    for (var i = 0; i < carparkMarkers.length; i++) {  
			        carparkMarkers[i].setMap(map);
			    }        
			}
			
			// 카테고리를 클릭했을 때 type에 따라 카테고리의 스타일과 지도에 표시되는 마커를 변경합니다
			function changeMarker(type){
			    
			    var coffeeMenu = document.getElementById('coffeeMenu');
			    var storeMenu = document.getElementById('storeMenu');
			    var carparkMenu = document.getElementById('carparkMenu');
			    
			    // 커피숍 카테고리가 클릭됐을 때
			    if (type === 'coffee') {
			    
			        // 커피숍 카테고리를 선택된 스타일로 변경하고
			        coffeeMenu.className = 'menu_selected';
			        
			        // 편의점과 주차장 카테고리는 선택되지 않은 스타일로 바꿉니다
			        storeMenu.className = '';
			        carparkMenu.className = '';
			        
			        // 커피숍 마커들만 지도에 표시하도록 설정합니다
			        setCoffeeMarkers(map);
			        setStoreMarkers(null);
			        setCarparkMarkers(null);
			        
			    } else if (type === 'store') { // 편의점 카테고리가 클릭됐을 때
			    
			        // 편의점 카테고리를 선택된 스타일로 변경하고
			        coffeeMenu.className = '';
			        storeMenu.className = 'menu_selected';
			        carparkMenu.className = '';
			        
			        // 편의점 마커들만 지도에 표시하도록 설정합니다
			        setCoffeeMarkers(null);
			        setStoreMarkers(map);
			        setCarparkMarkers(null);
			        
			    } else if (type === 'carpark') { // 주차장 카테고리가 클릭됐을 때
			     
			        // 주차장 카테고리를 선택된 스타일로 변경하고
			        coffeeMenu.className = '';
			        storeMenu.className = '';
			        carparkMenu.className = 'menu_selected';
			        
			        // 주차장 마커들만 지도에 표시하도록 설정합니다
			        setCoffeeMarkers(null);
			        setStoreMarkers(null);
			        setCarparkMarkers(map);  
			    }    
			} 
			
			
			
			
			
			
	</script>
		
		


</body>

</html>