<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 배포된 웹 애플리케이션의 최상위 주소를 간단히 얻어올 수 있도록
	 application 범위로 변수를 하나 생성
  -->

<c:set var="contextPath" scope="application"
		value="${pageContext.servletContext.contextPath}"/>    
    
 
    
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>INTRO</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
        integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">


    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            font-weight: 700;
        }
        

        .welcome-section {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            background: #000;
            overflow: hidden;
        }

        .content-wrap {
            position: fixed;
        	width:1000px;
        	text-shadow: 1px 1px 9px orange, 9px 9px 9px black;
            top: 20%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .fly-in-text {
            list-style: none;
        }

        .fly-in-text li {
            display: inline-block;
            margin-right: 20px;
            font-size: 4em;
            color: #fff;
            opacity: 1;
            transition: all 3s ease;
        }

        .fly-in-text li:nth-child(5) {
            margin-right: 0;
        }

        a {
            position: absolute;
            display: block;
            text-align: center;
            font-size: 3em;
            color: #F5BB4E;
            opacity: 1;
            left: 460px;
            top: 240px;
            margin-top: 30px;
            transition: all 1s ease 3s;
        }
        
        .content-wrap a{
            text-decoration: none;
        }
        a:hover{
        	color:black;
        }
 
        .content-hidden .fly-in-text li {
            opacity: 0;
        }

        .content-hidden .fly-in-text li:nth-child(1) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(2) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(3) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(4) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(5) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(6) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(7) {
            transform: translate3d(-60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(8) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(9) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(10) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(11) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(12) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(13) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(14) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .fly-in-text li:nth-child(15) {
            transform: translate3d(60px, 0, 0);
        }

        .content-hidden .enter-button {
            opacity: 0;
            transform: translate3d(0, -30px, 0);
        }



        img {
            width: 100%;
            height: 100%;
            opacity: 50%;
        }
    </style>








</head>

<body>

    <div class="welcome-section content-hidden">
        <img src="${contextPath}/resources/images/intro/main.jpg">
        <div class="content-wrap">
            <ul class="fly-in-text">
                <li>R</li>
                <li>E</li>
                <li>A</li>
                <li>D</li>
                <li>Y</li>
                &nbsp;
                &nbsp;
                &nbsp;
                &nbsp;
                <li>T</li>
                <li>O</li>
                &nbsp;
                &nbsp;
                &nbsp;
                <li>G</li>
                <li>O</li>
                &nbsp;
                &nbsp;
                &nbsp;
                <li>T</li>
                <li>R</li>
                <li>I</li>
                <li>P</li>
                <li>?</li>
            </ul>
            <a href="main" class="enter-button">Enter</a>
        </div>
    </div>


    <script type="text/javascript">
        $(function () {
            var welcomeSection = $('.welcome-section')

            setTimeout(function () {
                welcomeSection.removeClass('content-hidden');
            }, 800);
        })

        $(function () {
            $("a").click(function () {
                var url = $(this).attr("href");
                $("body div").animate({
                    "opacity": "0",
                    "top": "0px"
                }, 500, function () {
                    document.location.href = url;
                });

                return false;
            });
        });
    </script>


    <script>
    
    	$(document).ready(function(){
    		
    		var confirm = window.confirm("사용자의 위치정보 수집에 동의합니까?(동의하셈)");
				if(confirm == true){
			        // 위치정보 획득
			        
			        function getGeoloaction() {
			            if(window.navigator.geolocation) {
			                // navigator.geolocation.getCurrentPosition(successCallback, [errorCallback, [options]])
			                // : 현재 위치 정보 반환
			                navigator.geolocation.getCurrentPosition(showPosition, handleError);
			            } else {                
			                $('#comment').html('Geolocation을 지원하지 않는 브라우저입니다.');
			            }
			        }
			        
			        // successCallback
			        function showPosition(position) {
			              console.log("동의한 시간 : " + new Date(position.timestamp));
			            // coords.altitude : 고도
			            // timestamp : 위치 정보를 가져온 시각
			              
					        $.ajax({
				        		url : "${contextPath}/attraction/getLocation/",
	            			data : {"latitude":position.coords.latitude, "longitude":position.coords.longitude},
	            			type : "POST",
				        	});
			              
			        }
			        
			        // errorCallback
			        function handleError(error){
			           // ★★★★ error.code
			            // code 1 :사용자가 위치정보에 대한 접근을 막은 경우
			            if(error.code === error.PERMISSION_DENIED) {
			                alert('사용자가 위치정보에 대한 접근을 막은 경우');
			            }
			            // code 2 : 네트워크 또는 GPS에 연결할 수 없는 경우
			            else if(error.code === error.POSITION_UNAVAILABLE) {
			                alert('네트워크 또는 GPS에 연결할 수 없는 경우');
			            }
			            // code 3 : 사용자의 위치정보를 계산하는데 시간이 초과한 경우
			            else if(error.code === error.TIMEOUT) {
			                alert('사용자의 위치정보를 계산하는데 시간이 초과한 경우');
			            }
			            // code 4 : 그외 알수 없는 문제가 생긴 경우
			            else if(error.code === error.UNKNOWN_ERROR) {
			                alert('그 외 알수 없는 문제가 생긴 경우');
			            }
			        /*
			           이미 위치 정보에 대해서 허용이 되어 있는 상태애세
			           에러를 확인하기 위해 새로고침을 하면 계속 허용이 된 상태이기 때문에 에러를 확인할 수 없음
			           그럴 때는 주소창 우측에 있는 GPS모양을 클릭, 관리 버튼 클릭, 허용되어있는 로컬을 삭제 하면 다시 허용하라고 뜸
			        */
			        }
			        
			        getGeoloaction();
					  
				}else {
						console.log("동의를 안하면 곤란해");
		        $.ajax({
	        		url : "${contextPath}/attraction/getLocation/",
          			data : {"latitude": 37.568477, "longitude":126.981611},
          			type : "POST",
	        	});
				}
    		
    	})
    
    
    </script>

</body>

</html>