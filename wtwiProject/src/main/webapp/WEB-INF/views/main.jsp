<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>

<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">

<!-- Bootstrap core JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
	crossorigin="anonymous"></script>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>

<title>Where the weather is...</title>
<style>
.area {
	position: absolute;
	background: #fff;
	border: 1px solid #888;
	border-radius: 3px;
	font-size: 12px;
	top: -5px;
	left: 15px;
	padding: 2px;
}

.info {
	font-size: 12px;
	padding: 5px;
}

.info .title {
	font-weight: bold;
}

/* =============================================================================================================== */
/* 커스텀 오버레이 테스트 */
.overlaybox {
	position: relative;
	width: 360px;
	height: 350px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png')
		no-repeat;
	padding: 15px 10px;
}

.overlaybox div, ul {
	overflow: hidden;
	margin: 0;
	padding: 0;
}

.overlaybox li {
	list-style: none;
}

.overlaybox .boxtitle {
	color: #fff;
	font-size: 16px;
	font-weight: bold;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png')
		no-repeat right 120px center;
	margin-bottom: 8px;
}

.overlaybox .first {
	position: relative;
	width: 247px;
	height: 136px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png')
		no-repeat;
	margin-bottom: 8px;
}

.first .text {
	color: #fff;
	font-weight: bold;
}

.first .triangle {
	position: absolute;
	width: 48px;
	height: 48px;
	top: 0;
	left: 0;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png')
		no-repeat;
	padding: 6px;
	font-size: 18px;
}

.first .movietitle {
	position: absolute;
	width: 100%;
	bottom: 0;
	background: rgba(0, 0, 0, 0.4);
	padding: 7px 15px;
	font-size: 14px;
}

.overlaybox ul {
	width: 247px;
}

.overlaybox li {
	position: relative;
	margin-bottom: 2px;
	background: #2b2d36;
	padding: 5px 10px;
	color: #aaabaf;
	line-height: 1;
}

.overlaybox li span {
	display: inline-block;
}

.overlaybox li .number {
	font-size: 16px;
	font-weight: bold;
}

.overlaybox li .title {
	font-size: 13px;
}

.overlaybox ul .arrow {
	position: absolute;
	margin-top: 8px;
	right: 25px;
	width: 5px;
	height: 3px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png')
		no-repeat;
}

.overlaybox li .up {
	background-position: 0 -40px;
}

.overlaybox li .down {
	background-position: 0 -60px;
}

.overlaybox li .count {
	position: absolute;
	margin-top: 5px;
	right: 15px;
	font-size: 10px;
}

.overlaybox li:hover {
	color: #fff;
	background: #d24545;
}

.overlaybox li:hover .up {
	background-position: 0 0px;
}

.overlaybox li:hover .down {
	background-position: 0 -20px;
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div id="map" style="width: 100%; height: 80vh;"></div>

	<p>
		<button onclick="zoomIn()">지도레벨 - 1</button>
		<button onclick="zoomOut()">지도레벨 + 1</button>
		<span id="maplevel"></span>
	</p>

	<p id="result"></p>

	<script type="text/javascript"
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=eebe96b9065dd3994c199f0822ac2038"></script>
	<script>
		//행정구역 구분
		
				$.getJSON(
						"https://raw.githubusercontent.com/Jun-Seok-K/coja/master/korea_map_polygon.json",
						function(geojson) {
							var data = geojson.features;
							var coordinates = []; //좌표 저장할 배열
							var name = ''; //지역 구 이름

							$.each(data, function(index, val) {
								name = val.properties.CTP_KOR_NM;
								code = val.properties.CTPRVN_CD;

								if (val.geometry.type == "MultiPolygon") {
									displayArea(name, code,
											val.geometry.coordinates, true);

								} else {
									displayArea(name, code,
											val.geometry.coordinates, false);
								}
							});

							// console.log(coordinates.length); 전국 명소의 수
						})

		function makePolygon(coordinates) {

			var polygonPath = [];

			$.each(coordinates[0], function(index, coordinate) {
				polygonPath.push(new kakao.maps.LatLng(coordinate[1],
						coordinate[0]));
			});

			return new kakao.maps.Polygon({
				path : polygonPath,
				strokeWeight : 2,
				strokeColor : '#004c80',
				strokeOpacity : 0.8,
				fillColor : '#fff',
				fillOpacity : 0.7
			});
		}

		function makeMultiPolygon(coordinates) {

			var polygonPath = [];

			$.each(coordinates, function(index, val2) {

				var coordinates2 = [];

				$.each(val2[0], function(index2, coordinate) {

					coordinates2.push(new kakao.maps.LatLng(coordinate[1],
							coordinate[0]));

				});

				polygonPath.push(coordinates2);
			});

			return new kakao.maps.Polygon({
				path : polygonPath,
				strokeWeight : 2,
				strokeColor : '#004c80',
				strokeOpacity : 0.8,
				fillColor : '#fff',
				fillOpacity : 0.7
			});
		}

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 13
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption), customOverlay = new kakao.maps.CustomOverlay(
				{}), infowindow = new kakao.maps.InfoWindow({
			removable : true
		});

		function displayArea(name, code, coordinates, multi) {

			var polygon;
			if (multi) {
				polygon = makeMultiPolygon(coordinates);

			} else {
				polygon = makePolygon(coordinates);

			}

			polygon.setMap(map);

			// 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
			// 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
			kakao.maps.event.addListener(polygon, 'mouseover', function(
					mouseEvent) {
				polygon.setOptions({
					fillColor : '#09f'
				});

				customOverlay
						.setContent('<div class="area">' + name + '</div>'); // 시도별 이름 표시(변수명 : name)

				customOverlay.setPosition(mouseEvent.latLng);
				customOverlay.setMap(map);
			});

			// 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
			// 커스텀 오버레이를 지도에서 제거합니다 
			kakao.maps.event.addListener(polygon, 'mouseout', function() {
				polygon.setOptions({
					fillColor : '#fff'
				});
				customOverlay.setMap(null);
			});
			/* 
			            // 다각형에 click 이벤트를 등록하고 이벤트가 발생하면 다각형의 이름과 면적을 인포윈도우에 표시합니다 
			            kakao.maps.event.addListener(polygon, 'click', function (mouseEvent) {
			
			                // 현재 지도 레벨에서 확대할 레벨
			                var level = map.getLevel() - 2;
			
			                // 지도를 클릭된 폴리곤의 중앙 위치를 기준으로 지도 확대
			                map.setLevel(level, {
			                    anchor: centroid(polygonPath), animate: {
			                        duration: 350
			                    }
			                });
			
			                deletePolygon(polygons);
			            }); */
		};

		/*   // 중심좌표 구하기
		  function centroid(points) {
		      var i, j, len, p1, p2, f, are, x, y;
		
		      area = x = y = 0;
		
		      for (i = 0, len = points.lenght, j = len - 1; i < len; j = i++) {
		          p1 = points[i];
		          p2 = points[j];
		
		          f = p1.y * p2.x - p2.y * p1.x;
		          x += (p1.x + p2.x) * f;
		          y += (p1.y + p2.y) * f;
		          area += f * 3;
		      }
		      return new kakao.maps.LatLng(x / area, y / area);
		  }
		
		  // 지도 위 표시되고 있는 폴리곤 제거
		  function deletePolygon(polygons) {
		      for (var i = 0; i < polygons.lenght; i++) {
		          polygons[i].setMap(null);
		      }
		      polygons = [];
		  } */

		// 지도 레벨은 지도의 확대 수준을 의미합니다
		// 지도 레벨은 1부터 14레벨이 있으며 숫자가 작을수록 지도 확대 수준이 높습니다
		function zoomIn() {
			// 현재 지도의 레벨을 얻어옵니다
			var level = map.getLevel();

			// 지도를 1레벨 내립니다 (지도가 확대됩니다)
			map.setLevel(level - 1);

			// 지도 레벨을 표시합니다
			displayLevel();
		}

		function zoomOut() {
			// 현재 지도의 레벨을 얻어옵니다
			var level = map.getLevel();

			// 지도를 1레벨 올립니다 (지도가 축소됩니다)
			map.setLevel(level + 1);

			// 지도 레벨을 표시합니다
			displayLevel();
		}

		function displayLevel() {
			var levelEl = document.getElementById('maplevel');
			levelEl.innerHTML = '현재 지도 레벨은 ' + map.getLevel() + ' 레벨 입니다.';
		}

		var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
			level : 14
		// 지도의 확대 레벨 
		});

		// ==========================================================================================================
		// 지도에 명소 마커 및 마커 클러스터 추가

		/*
		// 마커 클러스터러를 생성합니다 
		var clusterer = new kakao.maps.MarkerClusterer({
		    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		    minLevel: 10 // 클러스터 할 최소 지도 레벨 
		});
		 */
		var position;
		var marker = {};
		var data;

		$.getJSON(
						"https://raw.githubusercontent.com/Jun-Seok-K/coja/master/all_attraction_list.json",
						function(json) {
							data = json.records; // json 파일 data 변수에 담기

							var markers = []; // 전체 마커 좌표 저장할 배열

							var lat = ''; // 위도를 담을 변수
							var lng = ''; // 경도를 담을 변수

							$.each(data, function(index, val) {
								lat = val.위도;
								lng = val.경도;
								var latLng = [ lat, lng ]; // 마커 하나 생성

								markers.push(latLng);
							});

							// console.log(markers); // 모든 여행지의 좌표 배열

							$
									.each(
											markers,
											function(index, val) {
												position = new kakao.maps.LatLng(
														val[0], val[1]);

												// 마커를 생성합니다(관광지 정보 가져오기 테스트)
												marker = new kakao.maps.Marker(
														{
															position : position,
															name : data.관광지명,
															type : data.관광지구분,
															address : data.소재지도로명주소,
															phone : data.관리기관전화번호
														//clickable: true
														});

												// 커스텀 오버레이에 표시할 내용입니다
												// HTML 문자열 또는 Dom Element 입니다 
												var content = '<div class="overlaybox">'
														+ '    <span style="cursor:pointer" onclick="closeCustomOverlay()">xxxx</span>'
														+ '    <div class="boxtitle">'
														+ marker
														+ '</div>'
														+ '    <div class="first">'
														+ '        <div class="triangle text">1</div>'
														+ '        <div class="movietitle text">드래곤 길들이기2</div>'
														+ '    </div>'
														+ '    <ul>'
														+ '        <li class="up">'
														+ '            <span class="number">2</span>'
														+ '            <span class="title">명량</span>'
														+ '            <span class="arrow up"></span>'
														+ '            <span class="count">2</span>'
														+ '        </li>'
														+ '        <li>'
														+ '            <span class="number">3</span>'
														+ '            <span class="title">해적(바다로 간 산적)</span>'
														+ '            <span class="arrow up"></span>'
														+ '            <span class="count">6</span>'
														+ '        </li>'
														+ '        <li>'
														+ '            <span class="number">4</span>'
														+ '            <span class="title">해무</span>'
														+ '            <span class="arrow up"></span>'
														+ '            <span class="count">3</span>'
														+ '        </li>'
														+ '        <li>'
														+ '            <span class="number">5</span>'
														+ '            <span class="title">안녕, 헤이즐</span>'
														+ '            <span class="arrow down"></span>'
														+ '            <span class="count">1</span>'
														+ '        </li>'
														+ '    </ul>'
														+ '</div>';

												// 커스텀 오버레이를 생성합니다
												var customOverlay = new kakao.maps.CustomOverlay(
														{
															position : position,
															content : content,
															xAnchor : 0.32,
															yAnchor : 1.065
														});

												// 모든 마커 지도에 표시
												marker.setMap(map);

												// 마커 클릭 시 커스텀 오버레이를 지도에 표시
												kakao.maps.event
														.addListener(
																marker,
																'click',
																function() {
																	customOverlay
																			.setMap(map);

																});

											});

						});

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);

		/* ============================================================================================= */
		// 커스텀 오버레이 테스트
		// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 (작동 안함....)
		function closeCustomOverlay() {
			customOverlay.setMap(null);
		}

		// 커스텀 오버레이가 표시될 위치입니다 
		// var position = new kakao.maps.LatLng(37.49887, 127.026581); 위에 반복문으로 position 정의해 놓음...
	</script>
</body>

</html>


</script>
</body>

</html>