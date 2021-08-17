<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
        
        
<title>Where the weather is...</title>
<style>
/* 검색조건 드롭다운 시작 */
#dropdown-wrap {
	top: 13px;
	left: 23px;
	position: absolute;
}

#dropdown-type-wrap {
	left: 0;
	top: 0;
	float: left;
}

#dropdown-type {
	background-color: whitesmoke;
	opacity: 90%;
	width: 100px;
}

#search-wrapper {
	opacity: 90%;
	position: absolute;
	margin: auto;
	opacity: 90%;
	width: 300px;
	height: 50px;
	display: inline-block;
	top: 20px;
	z-index: 2;
}

/* 검색조건 드롭다운 끝 */

</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div id="map" style="width:100%;height:100vh;">
		<!-- =================================== 리뷰 작성 폼 시작 =================================== -->
		
		<jsp:include page="/WEB-INF/views/attractionboard/reviewInsert.jsp"></jsp:include>
		
		<!-- =================================== 리뷰 작성 폼 끝 =================================== -->
		
		
		
		<!-- =================================== 리뷰 리스트 출력 시작 =================================== -->
		
		<jsp:include page="/WEB-INF/views/attractionboard/reviewView.jsp"></jsp:include>
		
		<!-- =================================== 리뷰 리스트 출력 끝 =================================== -->
		
		
		
		<!-- =================================== 명소 구분/지역 드롭다운 시작 =================================== -->
		<div class="card" id="search-wrapper">
			<div id="dropdown-wrap">
				<select id="contentTypeS" name="contentTypeS">
					<option value="12" selected>관광지</option>
					<option value="14">문화시설</option>
					<option value="15">축제/공연/행사</option>
					<option value="25">여행코스</option>
					<option value="28">레포츠</option>
					<option value="32">숙박</option>
					<option value="38">쇼핑</option>
					<option value="39">음식</option>
				</select>
				
				<select style="display:hidden;" id="areaCode" name="areaCode">
					<option value="11" selected>서울</option>
					<option value="26">부산</option>
					<option value="27">대구</option>
					<option value="28">인천</option>
					<option value="29">광주</option>
					<option value="30">대전</option>
					<option value="31">울산</option>
					<option value="36">세종</option>
					<option value="41">경기</option>
					<option value="42">강원</option>
					<option value="43">충북</option>
					<option value="44">충남</option>
					<option value="45">전북</option>
					<option value="46">전남</option>
					<option value="47">경북</option>
					<option value="48">경남</option>
					<option value="50">제주</option>
				</select>
				
				<button id="find-attr-btn" class="btn btn-dark my-0" style="height:22px; border: 0; padding-top:0; padding-bottom:0;">조회</button>
			</div>
		</div>

		<!-- =================================== 명소 구분/지역 드롭다운 종료 =================================== -->
		
        <!-- =================================== 명소 상세정보 영역 시작 =================================== -->

      	<jsp:include page="/WEB-INF/views/attractionboard/attractionCardView.jsp"></jsp:include>

        <!-- =================================== 명소 상세정보 영역 끝 =================================== -->
        
        <!-- =================================== 날씨 영역 시작 =================================== -->

      	<jsp:include page="/WEB-INF/views/attractionboard/weatherCardView.jsp"></jsp:include>

        <!-- =================================== 날씨 영역 끝 =================================== -->
	
    </div>
    <script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=eebe96b9065dd3994c199f0822ac2038"></script>
        
    <script>
        // 지도 로딩속도 향상을 위한 코드
        kakao.maps.disableHD();
        
        // 명소 정보 조회 메소드 전역변수 선언
        var viewAttrInfo = (function(){
        	
        	// 해당 명소에 대한 상세페이지 정보 조회
    		//attraction/view/명소상세글 번호
    		//console.log(selectedMarker);
    		$.ajax({
    			url : "${contextPath}/attraction/view/" + selectedMarker,
    			data : selectedMarker,
    			type : "POST",
    			dataType : "JSON",
    			success : function(attrView){
    				
    				// ======================== 우측 고정 영역에 명소 정보 출력
						// 명소 평점을 출력하기 위한 구문
    				document.getElementById("attr-avgPoint").innerText = "";
    				
    				// 평점 소수점 둘째 자리가지 표현
    				let roundAvgPoint = Math.round(attrView.avgPoint * 100) / 100;
    				
    				// 소수점에서 반올림하여 정수로 별점 결정(ex: 4.5 = 별점 5개)
      				let avgStar = Math.round(roundAvgPoint);
    				
    				switch(avgStar){
					case 1: star = "★☆☆☆☆"; break;
					case 2: star = "★★☆☆☆"; break;
					case 3: star = "★★★☆☆"; break;
					case 4: star = "★★★★☆"; break;
					case 5: star = "★★★★★"; break;
					default: star = "☆☆☆☆☆"; break;
					}
    				
    				document.getElementById("attr-avgPoint").innerText = star;
    				document.getElementById("attr-avgPoint-num").innerText = " 평균 " + roundAvgPoint + "점 / 5점";
    				document.getElementById("total-review-count").innerText = " | 리뷰 " + attrView.totalReviewCount + "건";
    				
    				
    				// 명소 이미지 출력을 위한 구문
    				document.getElementById("attr-image").src = attrView.attractionPhoto;
    				
    				// 명소 이름 출력을 위한 구문
					document.getElementById("attr-title").innerText = attrView.attractionNm;
    				
    				// 명소 이름 클릭 시 상세조회 페이지로 이동하는 구문
    				document.getElementById("attr-title").href = "${contextPath}/attraction/view/" + attrView.attractionNo;
    				
    				// 명소 번호 안보이게 요소에 삽입(reviewInsert.jap 에서 사용하기 위해...)
    				document.getElementById("attr-no").value = attrView.attractionNo;
    				
    				// 명소 연락처 출력을 위한 구문
    				document.getElementById("attr-phone").innerText = "";
    				
	   				if(attrView.attractionPhone != null) {
	   					document.getElementById("attr-phone").innerText = "◎ " + attrView.attractionPhone;
	   					
	   				}else {
	   					document.getElementById("attr-phone").innerText = "";
	   				}                    				
    				
    				// 드롭다운 버튼의 값들을 저장할 변수 선언 및 할당
    				let attrIdArr = document.getElementsByName("attr-type");
    				
    				// 명소 구분 출력을 위한 구문
    				for(let i=0; i<attrIdArr.length; i++){
    					if(attrView.attractionTypeNo == attrIdArr[i].id){
    						
    						// 명소 id(숫자)에 따라 명소의 구분 출력(드롭다운 버튼과 연동)
    						document.getElementById("attr-type").innerText = "";
    						document.getElementById("attr-type").innerText = "◎ " + attrIdArr[i].innerText;
    						
    						//console.log("일치");
    						break;
    					}
    				}
    				
    				// 명소 주소 출력을 위한 구문
    				document.getElementById("attr-addr").innerText = "◎ " + attrView.attractionAddr;
    				
    				
    				// 명소 홈페이지 출력을 위한 가공 시작
    				let rawHomepage = attrView.attractionHomePage;
    				
						// 시작지점                    				
    				let startStr =rawHomepage.indexOf("\\");
				
						// 종료지점
    				let endStr = rawHomepage.indexOf("\\", rawHomepage.indexOf("\\")+1);
			
    				let homepage = "";
    				
    				homepage = rawHomepage.substring(startStr+1, endStr);
    				
    				// 홈페이지 이름 비정상적인 곳에 대해 홈페이지 주소만 뽑기 위한 구문
    				if(homepage.indexOf("h") == -1) { // 홈페이지 주소가 뽑아져 나오지 않았을 때
    					let secRawHomepage = rawHomepage.replace("\\" + homepage + "\\", "")
    					let secStartStr = secRawHomepage.indexOf("\\");
    					let secEndStr = secRawHomepage.indexOf("\\", secRawHomepage.indexOf("\\")+1);
    					homepage = secRawHomepage.substring(secStartStr+1, secEndStr);
    				}
    				
    				// 명소 홈페이지 주소 출력을 위한 구문
    				document.getElementById("attr-homepage").innerHTML = "◎ " + "<a href='" + homepage + "' target=_blank' > 홈페이지로 이동 </a>";
    				
    				// 명소 정보 출력을 위한 구문
    				// 명소 정보 중 개행문자 처리하여 출력
    				replacedAttrInfo = attrView.attractionInfo.replaceAll("\\n", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("<br />", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("<br>", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("<br>", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("</b>", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("\\", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("</u>", " ");
    				replacedAttrInfo = replacedAttrInfo.replaceAll("<u>", " ");
    				document.getElementById("attr-info").innerText = replacedAttrInfo;
    				
    				// 명소 상세페이지로 이동
    				document.getElementById("to-attr-view").href = "${contextPath}/attraction/view/" + attrView.attractionNo;
    				
    				// 채팅버튼 클릭 시 채팅 기능 작동
                    $("#chat-btn").on("click", function(){
                       
                       if(memberNo==""){
                          swal({
                             icon: "warning",
                             title: "회원만 이용 가능합니다."
                          })
                       } else { 
                          document.getElementById("chat-btn").href = "${contextPath}/chat/openChatRoom/"+attrView.attractionNo;
                       }
                    });
    				
    			}, // ajax 통신 성공 시 실행되는 코드 종료지점
    			
    			error : function(){ // ajax 통신 실패 시
    				console.log("통신 실패");
    			}
    			
    		}); // ajax 종료 지점
        	
        });
        
        // 지도 로딩 시 명소정보 고정영역 숨기기
        $("#attraction-info").hide();
        $("#weather-info-area").hide();

        // 지도 로딩 시 후기작성 폼 고정영역 숨기기
        $("#write-review-wrapper").hide();
        
        // 지도 로딩 시 리뷰영역 폼 고정영역 숨기기
        $("#select-review-wrapper").hide();
        
        // 선택된 마커(명소)의 contentId를 담을 변수(ajax 요청을 위해...)
        let selectedMarker = "";
        
        
        // 지도의 확대레벨이 13을 초과하지 못하도록 막는 함수(레벨 14부터는 화면 깨짐)
        $(function () {
            map.setMaxLevel(13);
        });
		
        // 폴리곤 클릭 시 지역코드를 controller로 넘겨주기 위해 전역변수로 선언
        var areaCode;
        var attrType = "12"; // 디폴트
        var jsonFileForMarker = "";
        
        
        // 마커 배열 전역변수 테스트
        var markers = []; // 전체 마커객체를 저장할 배열
        var marker = {};
        
        // 폴리곤배열 전역변수 테스트
        var polygons = [];
        
        //행정구역 구분 폴리곤 geoJSON 파일 불러오는 코드
        $.getJSON("https://raw.githubusercontent.com/Jun-Seok-K/coja/master/korea_map_polygon.json", function (geojson) {
            var data = geojson.features;
            var coordinates = []; //좌표 저장할 배열
            var name = ''; //지역 구 이름
            
            $.each(data, function (index, val) {
                name = val.properties.CTP_KOR_NM;
                areaCode = val.properties.CTPRVN_CD;

                if (val.geometry.type == "MultiPolygon") {
                    displayArea(name, areaCode, val.geometry.coordinates, true);

                } else {
                    displayArea(name, areaCode, val.geometry.coordinates, false);
                }
            });

        });

        // 폴리곤 생성
        function makePolygon(coordinates) {

            var polygonPath = [];

            $.each(coordinates[0], function (index, coordinate) {
                polygonPath.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
            });

            return new kakao.maps.Polygon({
                path: polygonPath,
                strokeWeight: 2,
                strokeColor: '#004c80',
                strokeOpacity: 0.8,
                fillColor: '#fff',
                fillOpacity: 0.7
            });
        };

        // 멀티폴리곤 생성
        function makeMultiPolygon(coordinates) {

            var polygonPath = [];

            $.each(coordinates, function (index, val2) {

                var coordinates2 = [];

                $.each(val2[0], function (index2, coordinate) {

                    coordinates2.push(new kakao.maps.LatLng(coordinate[1], coordinate[0]));
                });

                polygonPath.push(coordinates2);
            });

            return new kakao.maps.Polygon({
                path: polygonPath,
                strokeWeight: 2,
                strokeColor: '#004c80',
                strokeOpacity: 0.8,
                fillColor: '#fff',
                fillOpacity: 0.7
            });
        };
        
        
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                level: 13 // 지도의 확대 레벨
         };
        
     	
        
        $("#find-attr-btn").on('click', function(){
			attrType = document.getElementById("contentTypeS").value
			areaCode = document.getElementById("areaCode").value
			
        	$.ajax({
              	url : "${contextPath}/attraction/list",
        		data : {"areaCode" : areaCode,
        				"attrType" : attrType}, // 클릭한 폴리곤의 지역 코드
        		type : "POST",
              	success : function(jsonFile){
              		jsonFileForMarker = jsonFile;
              		console.log("통신 성공");
              		
              		$.getJSON(jsonFileForMarker, function (json) {
        	            data = json.response.body.items.item; // json 파일 data 변수에 담기
              		
		           		var lat = Number(data[0].mapy); // 위도를 담을 변수
		           		var lng = Number(data[0].mapx); // 경도를 담을 변수
		           		 
			            var moveLatLng = new kakao.maps.LatLng(lat, lng);
		           		
		           		// 명소 타입과 지역 선택 후 조회버튼 클릭 시 해당 지역으로 이동 및 확대
		                map.panTo(moveLatLng);
		                
              		})
              		
              		// 지역별로 API요청주소가 담긴 jsonFileForMarker로 지역별 조회수 top 30 명소 추출
    	          	markersOnMap(jsonFileForMarker);
		            map.setLevel(11);
                          
              	},
              	
              	error : function(){
              		console.log("통신 실패");
              	}
              	
              });
			
		});
        

        var map = new kakao.maps.Map(mapContainer, mapOption),
            customOverlay = new kakao.maps.CustomOverlay({}),
            infowindow = new kakao.maps.InfoWindow({ removable: true });
        
        function displayArea(name, areaCode, coordinates, multi) {
			
        	var polygon;
            
            if (multi) {
                polygon = makeMultiPolygon(coordinates);

            } else {
                polygon = makePolygon(coordinates);
            }

            // 시도별 폴리곤 지도에 생성 자리
			
            // 테스트(폴리곤을 배열에 담에서 출력)
            polygons.push(polygon);
            
	        $.each(polygons, function (index, val) {
	        	polygons[index].setMap(map);
	        });
	        
	        
	     	// 다각형에 마우스 클릭 이벤트 삽입 코드
            kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {
                  $.ajax({
                  	url : "${contextPath}/attraction/list",
            		data : {"areaCode" : areaCode,
            				"attrType" : attrType}, // 클릭한 폴리곤의 지역 코드
            		type : "POST",
                  	success : function(jsonFile){
                  		
                  		jsonFileForMarker = jsonFile;
                  		console.log("통신 성공");
                  		
                  		// 지역별로 API요청주소가 담긴 jsonFileForMarker로 지역별 조회수 top 30 명소 추출
        	          	markersOnMap(jsonFileForMarker);
                              
                  	},
                  	
                  	error : function(){
                  		console.log("통신 실패");
                  	}
                  	
                  });
                  
            });
            
            // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경
            kakao.maps.event.addListener(polygon, 'mouseover', function (mouseEvent) {
                polygon.setOptions({ fillColor: '#09f' });
                map.setCursor('pointer');
            });
            

            // 폴리곤에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경
            kakao.maps.event.addListener(polygon, 'mouseout', function () {
                polygon.setOptions({ fillColor: '#fff' });
                customOverlay.setMap(null);
                map.setCursor();
            });


            // 폴리곤 클릭 시 지도 확대 및 클릭한 커서 위치로 화면 이동
            kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {

                // 지도 확대
                if (map.getLevel() > 11) { // 11레벨 초과 시 11레벨로 확대
                    if(areaCode < 40) {
	                	map.setLevel(9);
                    	
                    }else {
	                	map.setLevel(11);
                    }

                } else { // 11레벨 이하일 경우 현재 레벨 유지
                	if(areaCode < 40) {
	                	map.setLevel(9);
                    	
                    }else {
	                	map.setLevel(map.getLevel());
                    }
                }

                // 클릭한 곳의 좌표료 줌 이동
                var latLng = mouseEvent.latLng;
                var moveLatLng = new kakao.maps.LatLng(latLng.getLat(), latLng.getLng());
                map.panTo(moveLatLng);
           });
            
   		}; // geoJSON파일에 의한 폴리곤 생성 반복문 종료 괄호
        
        
	    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	        center: new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
	        level: 13 // 지도의 확대 레벨 
	    });
		
   		
	    // 폴리곤 클릭 시 마커 표시하는 메소드
	    function markersOnMap(jsonFileForMarker){
	    	
	    	 var position;
	         var data;
	         
	         // 마커 배열 초기화 및 각 마커 화면에서 제거
	         markers.forEach(function (marker) { marker.setMap(null); });
	         markers.length = 0 // 마커 배열 초기화
	         
	         
	        $.getJSON(jsonFileForMarker, function (json) {
	            data = json.response.body.items.item; // json 파일 data 변수에 담기
	
	            var lat = ''; // 위도를 담을 변수
	            var lng = ''; // 경도를 담을 변수
	
	            var clickedOverlay = null; // 클릭된 오버레이 전역변수로 선언

	            $.each(data, function (index, val) {
	                lat = Number(data[index].mapy); // 각 명소의 위도정보 from json
	                lng = Number(data[index].mapx); // 각 명소의 경도정보 from json
	                
	                // 각 마커의 요소로 들어갈 좌표객체 생성
	                position = new kakao.maps.LatLng(lat, lng);
					
	                // 마커 생성(관광지 정보 가져오기 테스트)
	                marker = new kakao.maps.Marker({
	                    position: position,
	                    
	                });
	            	
	                
	                // 마커들을 담는 배열에 모든 명소의 마커 추가
	                markers.push(marker);
	                
	                markers[index].setMap(map);
	                
	                // 마커 클릭 시 클릭한 좌표로 화면 이동
	                kakao.maps.event.addListener(marker, 'click', function () {
	   					
					// 날씨 api 시작
					var tiempo = new Array();
					var days = new Array();
					var icons = new Array();
					
					// 마커 클릭 시 매번 날씨정보영역 초기화
					document.getElementById("weather-info").innerHTML = " ";
					
	                $.getJSON('https://api.openweathermap.org/data/2.5/onecall?lat=' + lat + '&lon=' 
	    					 + lng + '&exclude=current&appid=ab504b375f2e984221e8e5471b13095c&units=metric', function (data) {
	                	
				        var ctime = data.daily[0].dt; // 현재 시간을 유닉스 형태로 저장
				        var minTemp = data.daily[0].temp.min;
				        var maxTemp = data.daily[0].temp.max;
				
				        var now = new Date($.now()); // 현재 시간 얻어오기
				        var cDate = now.getFullYear() + '/' + (now.getMonth() + 1) + '/' + now.getDate() ;
				        
				        for (var i = 0; i < 4; i++) {
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
				                '<ul style="width:50px; list-style: none; display: inline-block; margin-left: 10px; margin-right: 10px; padding-inline-start: 0px;">' +
				                '<li">' +
				                '<div style="text-align: center; font-size: 12px;">' + (now.getMonth() + 1) + '/' + (now.getDate()+i) + dayLabel() + '</div>' +
				                '</li>' +
				                '<li">' +
				                '<div style="text-align: center; font-size: 12px;">' + wicon + '</div>' +
				                '</li>' +
				                '<li">' +
				                '<div style="text-align: center; font-size: 10px;">' + minTemp +'℃/' + maxTemp + '℃</div>' +
				                '</li>' +
				                '</ul>'
				            );
										
				        }
				        
				        for( let i = 0 ; i < icons.length ; i++){
				        	$("#weather-info").append(icons[i]);
				        }
				        
				    });
					// 날씨 api 종료
					
	                    if (clickedOverlay) {
	                        clickedOverlay.setMap(null);
	                    }
	
	                    customOverlay.setMap(map);
	                    clickedOverlay = customOverlay;
	
	                    if (map.getLevel() > 10) {
	                        map.setLevel(10);
	
	                    } else {
	                        map.setLevel(map.getLevel());
	                    }
	
	                    $("#attraction-info").fadeIn(100);
	                    $("#weather-info-area").fadeIn(100);
	                    
	
	                    // 마커 클릭 시 부드럽게 마커의 위치로 이동
	                    var moveLatLng = new kakao.maps.LatLng(data[index].mapy, data[index].mapx);
	                    map.panTo(moveLatLng);
	                    
	                    
	                    // 마커 클릭 시 선택된 명소의 contentId 변수에 담기(명소 상세조회 ajax 요청을 위해...)
	                    selectedMarker = data[index].contentid;
	                    
						
	                    // 마커 클릭 시 리뷰작성 폼 닫기
	                    $("#write-review-wrapper").fadeOut(100);
		    			writeFlag = false;
		    			
		    			// 마커 클릭 시 선택했던 별점 초기화
		    			$("input:radio[name='rating']").prop('checked', false);
		    			// 마커 클릭 시 입력했던 글자수 초기화
		    			$('#test_cnt').html("(0 / 150)");
		    			
		    			// 마커 클릭 시 리뷰란에 작성중인 내용 삭제
		    			document.getElementById("text-area").value = '';
		    			
		    			// 마커 클릭 시 리뷰조회 폼 닫기
		    			$("#select-review-wrapper").fadeOut(100);
		    			viewFlag = false;
	                    
	                    
	                    // 리뷰 정보 호출하는 함수 호출(ajax)
	                    viewAttrInfo();
	                    
	                  
	                }); // 마커 클릭 시 발생하는 이벤트 종료 지점
	
	
	                // 커스텀 오버레이 및 후기작성 폼 지도영역 클릭하여 닫는 메소드
	                kakao.maps.event.addListener(map, 'click', function () {
	                    $("#attraction-info").fadeOut(100);
	                    $("#weather-info-area").fadeOut(100);
	                    $("#write-review-wrapper").fadeOut(100);
	                    $("#select-review-wrapper").fadeOut(100);
	                });
	                
	            }); // 마커 생성 for문 종료
	            
	        });
	        		
		};// 명소 정보가 담긴 JSON파일의 getJSON의 닫는 괄호
		
    </script>
    
</body>

</html>
