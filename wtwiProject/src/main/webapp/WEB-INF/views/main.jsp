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




</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	
	<div id="map" style="width:100%;height:100vh;"></div>

    <p>
        <button onclick="zoomIn()">지도레벨 - 1</button>
        <button onclick="zoomOut()">지도레벨 + 1</button>
        <span id="maplevel"></span>
    </p>

    <p id="result"></p>

    <script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=eebe96b9065dd3994c199f0822ac2038"></script>|
    <script>
        // 지도 로딩속도 향상을 위한 코드
        kakao.maps.disableHD();

        // 지도의 확대레벨이 13을 초과하지 못하도록 막는 함수(레벨 14부터는 화면 깨짐)
        $(function () {
            map.setMaxLevel(13);
        });

        //행정구역 구분 폴리곤 geoJSON 파일 불러오는 코드
        $.getJSON("https://raw.githubusercontent.com/Jun-Seok-K/coja/master/korea_map_polygon.json", function (geojson) {
            var data = geojson.features;
            var coordinates = []; //좌표 저장할 배열
            var name = ''; //지역 구 이름

            $.each(data, function (index, val) {
                name = val.properties.CTP_KOR_NM;
                code = val.properties.CTPRVN_CD;

                if (val.geometry.type == "MultiPolygon") {
                    displayArea(name, code, val.geometry.coordinates, true);

                } else {
                    displayArea(name, code, val.geometry.coordinates, false);
                }
            });

            // console.log(coordinates.length); 전국 명소의 수
        })

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
        }

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
        }

        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
                level: 13 // 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption),
            customOverlay = new kakao.maps.CustomOverlay({}),
            infowindow = new kakao.maps.InfoWindow({ removable: true });

        function displayArea(name, code, coordinates, multi) {

            var polygon;
            if (multi) {
                polygon = makeMultiPolygon(coordinates);

            } else {
                polygon = makePolygon(coordinates);
            }

            // 시도별 폴리곤 지도에 생성
            polygon.setMap(map);

            // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경
            // 지역명을 표시하는 커스텀오버레이를 지도위에 표시
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
                    map.setLevel(11);

                } else { // 11레벨 이하일 경우 현재 레벨 유지
                    map.setLevel(map.getLevel());
                }

                // 클릭한 곳의 좌표료 줌 이동
                var latLng = mouseEvent.latLng;
                var moveLatLng = new kakao.maps.LatLng(latLng.getLat(), latLng.getLng());
                map.panTo(moveLatLng);

            });
            /*
                        // 중심좌표 구하기
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
            */

            /*
                        // 지도 위 표시되고 있는 폴리곤 제거
                        function deletePolygon(polygons) {
                            for (var i = 0; i < polygons.lenght; i++) {
                                polygons[i].setMap(null);
                            }
                            polygons = [];
                        }
            */

        }; // geoJSON파일에 의한 폴리곤 생성 반복문 종료 괄호


        var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
            center: new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
            level: 13 // 지도의 확대 레벨 
        });

        // ==========================================================================================================
        // 지도에 명소 마커 추가

        var position;
        var marker = {};
        var data;

        var markers = []; // 전체 마커객체를 저장할 배열

        kakao.maps.event.addListener(map, 'zoom_changed', function () {

            // 지도 레벨이 11 이하일 때에만 마커 표시
            if (map.getLevel() < 12) {

                $.getJSON("https://raw.githubusercontent.com/Jun-Seok-K/coja/master/all_attraction_list.json", function (json) {
                    data = json.records; // json 파일 data 변수에 담기

                    var lat = ''; // 위도를 담을 변수
                    var lng = ''; // 경도를 담을 변수

                    var clickedOverlay = null; // 클릭된 오버레이 전역변수로 선언

                    $.each(data, function (index, val) {
                        lat = val.위도; // 각 명소의 위도정보 from json
                        lng = val.경도; // 각 명소의 경도정보 from json

                        // 각 마커의 요소로 들어갈 좌표객체 생성
                        position = new kakao.maps.LatLng(lat, lng);

                        // 마커 생성(관광지 정보 가져오기 테스트)
                        marker = new kakao.maps.Marker({
                            position: position,
                        });

                        // 마커들을 담는 배열에 모든 명소의 마커 추가
                        markers.push(marker);

                        // 전체 마커 지도에 표시
                        markers[index].setMap(map);


                        // 커스텀 오버레이의 닫기 버튼
                        var closeBtn = document.createElement('button');
                        closeBtn.innerHTML = '닫기';

                        // 커스텀 오버레이에 표시할 내용
                        var content = document.createElement('div');
                        content.innerHTML = data[index].관광지명 + "<br>" + data[index].관광지구분
                            + "<br>" + data[index].소재지도로명주소 + "<br>" + data[index].관리기관전화번호;
                        content.style.cssText = 'background-color: white; border: 1px solid black;';
                        content.append(closeBtn);

                        // 커스텀 오버레이 생성
                        var customOverlay = new kakao.maps.CustomOverlay({
                            position: position,
                            content: content,
                            xAnchor: 0.32,
                            yAnchor: 1.065
                        });


                        // 마커 클릭 시 커스텀 오버레이 표시
                        kakao.maps.event.addListener(marker, 'click', function () {
                            if (clickedOverlay) {
                                clickedOverlay.setMap(null);
                            }
                            customOverlay.setMap(map);
                            clickedOverlay = customOverlay;

                            if (map.getLevel() > 11) {
                                map.setLevel(11);

                            } else {
                                map.setLevel(map.getLevel());
                            }

                        });

                        
                        // 마커 클릭 시 부드럽게 마커의 위치로 이동
                        kakao.maps.event.addListener(marker, 'click', function () {
                            var moveLatLng = new kakao.maps.LatLng(data[index].위도, data[index].경도);
                            map.panTo(moveLatLng);
                        });

                        // 커스텀 오버레이 닫기 버튼으로 닫는 메소드
                        closeBtn.onclick = function () {
                            customOverlay.setMap(null);
                        };

                        // 커스텀 오버레이 지도영역 클릭하여 닫는 메소드
                        kakao.maps.event.addListener(map, 'click', function () {
                            customOverlay.setMap(null);
                        });

                    });

                }); // 명소 정보가 담긴 JSON파일의 getJSON의 닫는 괄호


            } else {
                // 마커들 삭제 + 날씨정보 입력할 조건임...(지도 레벨이 12 이상일 때)

                // 지도 위의 마커 제거
                $.each(data, function (index, val) {
            
                    // 전체 마커 지도에서 제거
                    markers[index].setMap(null);

                });

            }

        });

    </script>
	
</body>

</html>

