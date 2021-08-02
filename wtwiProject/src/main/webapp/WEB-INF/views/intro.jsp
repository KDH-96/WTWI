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
            position: absolute;
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

        .enter-button {
            position: absolute;
            display: block;
            text-align: center;
            font-size: 2em;
            text-decoration: none;
            color: #F5BB4E;
            opacity: 1;
            left: 460px;
            top: 250px;
            margin-top: 30px;
            transition: all 1s ease 3s;
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


</body>

</html>