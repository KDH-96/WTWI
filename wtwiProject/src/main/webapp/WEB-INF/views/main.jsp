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
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 20px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
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
	|
	<script>
		//행정구역 구분
		$
				.getJSON(
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
			kakao.maps.event.addListener(polygon, 'mouseout', function() {
				polygon.setOptions({
					fillColor : '#fff'
				});
				customOverlay.setMap(null);
			});

		};

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
		// 지도에 명소 마커 추가

		var position;
		var marker = {};
		var data;

		$
				.getJSON(
						"https://raw.githubusercontent.com/Jun-Seok-K/coja/master/all_attraction_list.json",
						function(json) {
							data = json.records; // json 파일 data 변수에 담기

							var markers = []; // 전체 마커 좌표 저장할 배열

							var lat = ''; // 위도를 담을 변수
							var lng = ''; // 경도를 담을 변수

							var clickedOverlay = null; // 클릭된 오버레이 전역변수로 선언

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
														});

												// 커스텀 오버레이에 표시할 내용입니다
												var content = '<div class="wrap">'
														+ '    <div class="info">'
														+ '        <div class="title">'
														+ data[index].관광지명
														+ " <span>("
														+ data[index].관광지구분
														+ ")</span>"
														+ '            <div class="close" onclick="closeOverlay" title="닫기"></div>'
														+ '        </div>'
														+ '        <div class="body">'
														+ '            <div class="desc">'
														+ data[index].소재지도로명주소
														+ "<br>"
														+ data[index].관리기관전화번호
														+ "<br>"
														+ data[index].숙박시설정보
														+ " "
														+ data[index].지원시설정보
														+ " "
														+ data[index].주차가능수
														+ "대 주차 가능 <br>"
														+ data[index].공공편익시설정보
														+ '            </div>'
														+ '        </div>'
														+ '    </div>'
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
																	if (clickedOverlay) {
																		clickedOverlay
																				.setMap(null);
																	}
																	customOverlay
																			.setMap(map);
																	clickedOverlay = customOverlay;
																});

												kakao.maps.event
														.addListener(
																marker,
																'click',
																function() {
																	// map.setCenter(new kakao.maps.LatLng(data[index].위도, data[index].경도));
																	var moveLatLng = new kakao.maps.LatLng(
																			data[index].위도,
																			data[index].경도);
																	map
																			.panTo(moveLatLng);

																	console
																			.log(
																					data[index].위도,
																					data[index].경도);
																});

												/* 닫기버튼 클릭 시 오버레이 사라짐(작동안함...)
												                $("#overlay").on("click", function () {
												                    overlay.setMap(null);
												                });
												 */

											}); // 명소들 마커표시 반복문의 닫는괄호

						});
	</script>
</body>

</html>


</script>
</body>

</html>