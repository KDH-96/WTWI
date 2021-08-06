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
	top: 30px;
	left: 30px;
	position: absolute;
	z-index: 2;
}

#dropdown-type-wrap {
	left: 0;
	top: 0;
	z-index: 2;
	float: left;
}

#dropdown-type {
	background-color: whitesmoke;
	opacity: 90%;
	width: 100px;
}

#dropdown-area-wrap {
	left: 0;
	top: 0;
	z-index: 2;
	float: left;
}

#dropdown-area {
	background-color: whitesmoke;
	opacity: 90%;
	width: 100px;
}

/* 검색조건 드롭다운 끝 */


</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>

	<div id="map" style="width:100%;height:100vh;">
		<!-- =================================== 리뷰 작성 폼 시작 =================================== -->
		
		<jsp:include page="/WEB-INF/views/attractionboard/reviewInsert.jsp"></jsp:include>
		
		<!-- =================================== 리뷰 작성 폼 시작 =================================== -->
		
		<!-- =================================== 명소 구분 드롭다운 시작 =================================== -->
        <div id="dropdown-wrap">
            <div id="dropdown-type-wrap">
                <button class="btn btn-outline-secondary dropdown-toggle mx-1" id="dropdown-type" type="button"
                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">구 분</button>
                <div class="dropdown-menu" id="contentTypeS" name="contentTypeS">
                    <a class="dropdown-item" href="#" value="12">관광지</a>
                    <a class="dropdown-item" href="#" value="14">문화시설</a>
                    <a class="dropdown-item" href="#" value="15">축제/공연/행사</a>
                    <a class="dropdown-item" href="#" value="25">여행코스</a>
                    <a class="dropdown-item" href="#" value="28">레포츠</a>
                    <a class="dropdown-item" href="#" value="32">숙박</a>
                    <a class="dropdown-item" href="#" value="38">쇼핑</a>
                    <a class="dropdown-item" href="#" value="39">음식</a>
                </div>
            </div>
            <div id="dropdown-area-wrap">
                <button class="btn btn-outline-secondary dropdown-toggle mx-1" id="dropdown-area" type="button"
                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">지 역</button>
                <div class="dropdown-menu" id="areaCode" name="areaCode">
                    <a class="dropdown-item" href="#" value="1">서울</a>
                    <a class="dropdown-item" href="#" value="2">인천</a>
                    <a class="dropdown-item" href="#" value="3">대전</a>
                    <a class="dropdown-item" href="#" value="4">대구</a>
                    <a class="dropdown-item" href="#" value="5">광주</a>
                    <a class="dropdown-item" href="#" value="6">부산</a>
                    <a class="dropdown-item" href="#" value="7">울산</a>
                    <a class="dropdown-item" href="#" value="8">세종</a>
                </div>
            </div>
        </div>
        <!-- =================================== 명소 구분 드롭다운 종료 =================================== -->
		
        <!-- =================================== 명소 상세정보 영역 시작 =================================== -->

      	<jsp:include page="/WEB-INF/views/attractionboard/reviewView.jsp"></jsp:include>

        <!-- =================================== 명소 상세정보 영역 끝 =================================== -->

    </div>


    <script type="text/javascript"
        src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=eebe96b9065dd3994c199f0822ac2038"></script>
        
    <script>
        // 지도 로딩속도 향상을 위한 코드
        kakao.maps.disableHD();

        // 지도 로딩 시 명소정보 고정영역 숨기기
        $("#attraction-info").hide();

        // 지도 로딩 시 후기작성 폼 고정영역 숨기기
        $("#write-review-wrapper").hide();

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
        }

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
                if (map.getLevel() > 10) { // 11레벨 초과 시 11레벨로 확대
                    map.setLevel(10);

                } else { // 11레벨 이하일 경우 현재 레벨 유지
                    map.setLevel(map.getLevel());
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

        // ==========================================================================================================
        // 지도에 명소 마커 추가

        var position;
        var marker = {};
        var data;

        var markers = []; // 전체 마커객체를 저장할 배열

        kakao.maps.event.addListener(map, 'zoom_changed', function () {
            // 지도 레벨이 11 이하일 때에만 마커 표시
            if (map.getLevel() < 12) {

                // 테스트용 JSON 파일 불러오기
                $.getJSON("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=%2FZJ4qEbEAOUpJeYCJrNhA7M4ZTjqF%2FVJw5NuHvS54FzJsEOkNVwFPQRkupaGtXRxUekRa1JaXdRO2tOkWsf4GA%3D%3D&contentTypeId=14&areaCode=1&listYN=Y&MobileOS=ETC&MobileApp=WhereTheWeatherIs&arrange=B&_type=json", function (json) {
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

                        // 전체 마커 지도에 표시
                        markers[index].setMap(map);


                        // 커스텀 오버레이의 닫기 버튼
                        var closeBtn = document.createElement('button');
                        closeBtn.className = 'btn btn-primary';
                        closeBtn.innerHTML = '닫기';


                        // 커스텀 오버레이에 표시할 내용 시작
                        var content = document.createElement('div');
                        content.id = 'attraction-info-area';
                        content.className = 'card-body';
                        content.innerHTML = data[index].title + "<br>" + data[index].contenttypeid
                            + "<br>" + "주소: " + data[index].addr1 + "<br>";
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

                            if (map.getLevel() > 10) {
                                map.setLevel(10);

                            } else {
                                map.setLevel(map.getLevel());
                            }

                            $("#attraction-info").fadeIn(100);

                        });

                        // 마커 클릭 시 부드럽게 마커의 위치로 이동
                        kakao.maps.event.addListener(marker, 'click', function () {
                            var moveLatLng = new kakao.maps.LatLng(data[index].mapy, data[index].mapx);
                            map.panTo(moveLatLng);
                        });

                        // 커스텀 오버레이 닫기 버튼으로 닫는 메소드
                        closeBtn.onclick = function () {
                            customOverlay.setMap(null);
                        };

                        // 커스텀 오버레이 및 후기작성 폼 지도영역 클릭하여 닫는 메소드
                        kakao.maps.event.addListener(map, 'click', function () {
                            customOverlay.setMap(null);
                            $("#attraction-info").fadeOut(100);

                            $("#write-review-wrapper").fadeOut(100);
                        });


                        // 후기작성 버튼 클릭 시 후기작성 폼 등장하는 메소드
                        $("#review-btn").on("click", function () {
                            $("#write-review-wrapper").fadeIn(100);
                        });

                        // 취소버튼 클릭 시 후기작성 폼을 닫는 메소드
                        $("#cancel-btn").on("click", function () {
                            $("#write-review-wrapper").fadeOut(100);
                        });

                    }); // 마커 생성 for문 종료

                }); // 명소 정보가 담긴 JSON파일의 getJSON의 닫는 괄호


            } else {
                // 마커들 삭제 + 날씨정보 입력할 조건임...(지도 레벨이 12 이상일 때)

                // 지도 위의 마커 제거
                $.each(data, function (index, val) {
                    markers[index].setMap(null);
                });

            }

        });

    </script>
    

</body>

</html>
