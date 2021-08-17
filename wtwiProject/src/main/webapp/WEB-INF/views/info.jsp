<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" scope="application" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
    integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
    integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
    crossorigin="anonymous">
    </script>
    <style>
        
        #wtwi{
            height: 100px;
            font-size: 50px;
            font-weight: bold;
        }
        #wtwi p{
            color: orange;
            text-shadow: 1px 1px 9px rgb(73,189,220), 5px 5px 2px black;
            animation: view1 1s linear forwards;
        }
        
        @keyframes view1 {
            0% {
                opacity: 0;
            }
            
            100% {
                opacity: 1;
            }
        }
        
        
        #wtwi-info{
            height: 300px;
            font-size: 24px;
            line-height: 50px;
            font-weight: bold;
        }
        #wtwi-info p{
            opacity: 0;
            text-shadow: 1px 4px 2px grey;
            animation: view2 1s linear forwards;
            animation-delay: 1s;
        }
        @keyframes view2 {
            0% {
                opacity: 0;
            }
            
            100% {
                opacity: 1;
            }
        }
        
        
        
        #about-logo-title{
            height: 100px;
            font-size: 50px;
            font-weight: bold;
        }
        #about-logo-title p{
            color: orange;
            opacity: 0;
            text-shadow: 1px 1px 9px rgb(73,189,220), 5px 5px 2px black;
            animation: view3 1s linear forwards;
            animation-delay: 2s;
        }
        
        @keyframes view3 {
            0% {
                opacity: 0;
            }
            
            100% {
                opacity: 1;
            }
        }
        
        
        #about-logo-area{
            width: 100%;
            height: 230px;
        }
        
        #about-logo{
            width: 35%;
            height: 100%;
            text-align: center;
            opacity: 0;
            float: left;
        }
        
        #about-logo-info{
            margin-left: 100px;
            width: 50%;
            height: 100%;
            float: left;
            
        }
        #logo-detail{
            width: 100%;
            height: 100%;
            opacity: 0;
        }
        
      
      
      
      
      
        #interface-area{
            width: 100%;
            height: 530px;
        }
        
        #about-interface{
            width: 100%;
            height: 90%;
            opacity: 0;
        }
        
        #interface{
            width: 100%;
            height: 100%;
        }
        
        #about-interface-info{
            width: 100%;
            height: 10%;
            line-height: 40px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            text-shadow: 1px 4px 2px grey;
            opacity: 0;
        }
        
        
        
        
        
        
        #area1{
            width: 100%;
            height: 230px;
        }
        #first-img{
            width: 40%;
            height: 100%;
            float: left;
            box-sizing: border-box;
        }
        #first-img img{
            width: 100%;
            height: 100%;
        }
        
        #img1{
            opacity:0;
            margin-left:-300px;    
            max-width:100%;
        }
        #first-img-info{
            margin-left: 5px;
            opacity: 0;
            box-sizing: border-box;
            width: 59%;
            height: 100%;
            text-align: center;
            line-height: 200px;
            font-size: 25px;
            font-weight: bold;
            text-shadow: 1px 4px 2px grey;
            float: left;
        }



        #area2{
            height: 260px;
        }
        #second-img{
            width: 40%;
            height: 100%;
            float: right;
            box-sizing: border-box;
        }
        #second-img img{
            width: 100%;
            height: 100%;
        }
        
        #img2{
            opacity:0;
            margin-left:300px;
            max-width:100%;
        }
        
        #second-img-info{
            margin-top: 100px;
            box-sizing: border-box;
            opacity: 0;
            width: 59%;
            height: 40%;
            text-align: center;
            font-size: 25px;
            font-weight: bold;
            float: left;
            text-shadow: 1px 4px 2px grey;
        }


       
        
        #area3{
            height: 260px;
        }
        #third-img{
            width: 40%;
            height: 100%;
            float: left;
            box-sizing: border-box;
        }
        #third-img img{
            width: 100%;
            height: 100%;
        }
        
        #img3{
            opacity:0;
            margin-left:-300px;    
            max-width:100%;
        }
        #third-img-info{
            margin-top: 100px;
            margin-left: 5px;
            opacity: 0;
            box-sizing: border-box;
            width: 59%;
            height: 40%;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            text-shadow: 1px 4px 2px grey;
            float: left;
        }

        </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    <div class="container">

        <div id="wtwi">
            <p>
                where the weather is...?
            </p>
        </div>
        
        <div id="wtwi-info">
            <p>
                where the weather is는 직역을 해보시면 말 그대로 "그곳의 날씨는?"이라는 의미를 가지고 있습니다.
                <br>
                어딘가로 여행을 떠날 때, 장소 따로 날씨 따로 찾아보고 가보신적 다들 있으시죠?
                <br>
                여행에 있어서 장소와 그곳의 날씨는 매우 중요한 요소입니다.
                <br>
                어딘가로 떠날 때 날씨앱 따로, 지도앱 따로 켜서 여행일정과 장소에 따라
                <br>
                날씨를 찾아보기가 조금은 귀찮아했던 경험이 있으셨을거라 생각합니다.
                <br>
                이러한 사소한 불편함을 조금이라도 해소하기 위해 날씨와 장소에 대한 정보를 함께 제공해 드립니다
            </p>
        </div>
        


        <br>
        <br>

        <div id="about-logo-title">
            <p>About the logo?</p>
        </div>


        <div id="about-logo-area">
            <div id="about-logo">
                <img src="${contextPath}/resources/images/로고 renewal2.jpg">
            </div>
            <div id="about-logo-info">
                <img id="logo-detail" src="${contextPath}/resources/images/info/로고설명최종.jpg">
            </div>
        </div>
    
        
        
        <br>
        <br>
        
        <div id="interface-area">
            <div id="about-interface">
                <img id="interface" src="${contextPath}/resources/images/info/인터페이스및명소날씨.JPG">
            </div>
            <div id="about-interface-info">
                <p>
                    직관적인 인터페이스와 대한민국의 모든곳이 들어있는 사이트(25000만건 이상)
                    날씨와 여행정보를 한번에!
                </p>
            </div>
        </div>
        

        <br>
        <br>
        
        
        <div id="area1">
            <div id="first-img">
                <img id="img1" src="${contextPath}/resources/images/info/리뷰.JPG">
            </div>
            <div id="first-img-info">
                <p>
                    다양한 명소 후기를 통한 새로운 명소 추천 기능!
                </p>
            </div>
            
        </div>
        


        <br>
        <br>
        
        
        
        <div id="area2">
            
            <div id="second-img-info">
                <p>
                    명소를 찾는 사람들과 주고받는 커뮤니티 기능! 
                    <br>    
                    명소 담당자와의 실시간 1:1 채팅으로 정보를 얻으세요!
                </p>
            </div>
            <div id="second-img">
                <img id="img2" src="${contextPath}/resources/images/info/채팅.jpg">
            </div>
            
        </div>
        
        
        <br>
        <br>
        
        
        <div id="area3">
            
            <div id="third-img">
                <img id="img3" src="${contextPath}/resources/images/info/소셜로그인.JPG">
            </div>
            <div id="third-img-info">
                <p>
                    간편한 소셜 로그인!
                    <br>
                    다양한 소셜로그인으로도 저희 사이트를 이용할 수 있습니다!
                </p>
            </div>
            
        </div>
        
        <br>
        
        
        <div id="creater">
        <p style="font-weight: bold; font-size: 20px; text-align: center;">
            created . by Junseok / Sulhwa / Jiwon / Seeun / Dohun
        </p>
        </div>
        
 
        
        
    </div>
    
    <script>

        
        $(document).ready(function() {
            /* 1 */
            $(window).scroll( function(){
                /* 2 */
                $('#about-logo').each( function(i){
                    var bottom_of_object = $(this).offset().top + $(this).outerHeight();
                    var bottom_of_window = $(window).scrollTop() + $(window).height();
                    /* 3 */
                    if( bottom_of_window > bottom_of_object/2 ){
                        $(this).animate({'opacity':'1'},500);
                    }
                }); 
            });
        });
      
        $(document).ready(function() {
            /* 1 */
            $(window).scroll( function(){
                /* 2 */
                $('#logo-detail').each( function(i){
                    var bottom_of_object = $(this).offset().top + $(this).outerHeight();
                    var bottom_of_window = $(window).scrollTop() + $(window).height();
                    /* 3 */
                    if( bottom_of_window > bottom_of_object/2 ){
                        $(this).animate({'opacity':'1'},500);
                    }
                }); 
            });
        });
        

        $(document).ready(function() {
        $(window).scroll( function(){
        $('#about-interface').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1'},1000);
            }
            
                }); 
            });
        });

        $(document).ready(function() {
        $(window).scroll( function(){
        $('#about-interface-info').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1'},1000);
            }
            
                }); 
            });
        });


        $(document).ready(function() {
        $(window).scroll( function(){
            $('#img1').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1','margin-left':'0px'},1000);
            }
            
                }); 
            });
        });

        $(document).ready(function() {
        $(window).scroll( function(){
        $('#first-img-info').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1'},2000);
            }
            
                }); 
            });
        });
        
        $(document).ready(function() {
        $(window).scroll( function(){
        $('#img2').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1','margin-left':'0px'},1000);
            }
            
                }); 
            });
        });

        $(document).ready(function() {
        $(window).scroll( function(){
            $('#second-img-info').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1'},2000);
            }
            
                }); 
            });
        });

        $(document).ready(function() {
        $(window).scroll( function(){
            $('#img3').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1','margin-left':'0px'},1000);
            }
            
                }); 
            });
        });
        
        $(document).ready(function() {
        $(window).scroll( function(){
        $('#third-img-info').each( function(i){
            
            var bottom_of_element = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            if( bottom_of_window > bottom_of_element ){
                $(this).animate({'opacity':'1'},2000);
            }
            
                }); 
            });
        });
        
        
        
        </script>
</body>
</html>