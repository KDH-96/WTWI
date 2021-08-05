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
         height: 100vh;
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
      	border : 1px solid black;
      }
      #attr-photo-div{
      	display: inline-blocl;
      	float : left;
      	height: 100%;
      	width: 50%;
      }
      #attr-photo-div > img {
      }
      #attr-weatherAddr-div{
      	height: 100%;
      	width: 50%;
      	display: inline-blocl;
      	float : left;
      	background-color : green;
      }
      #attr-weather-div{
      	height: 50%;
      	background-color : pink;
      }
      #attr-addr-div{
      	height : 50%;
      }
      #attrInfo-div{
      	background-color : yellow;
      	margin-top : 30px;
      	margin-left : 30px;
      	margin-right : 30px;
      }
      #attrNavi-div{
      	margin-top : 50px;
      }
      #attrReview-div{
      	margin-top : 50px;
      }
      #attrMap-div{
      	margin-top : 50px;
      }
      #btn-div{
      	margin-top : 50px;
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
         					<div id="attr-photo-div"><img src=${attr.attractionPhoto}></div>
         					<div id="attr-weatherAddr-div">
         							<div id="attr-weather-div">날씨</div>
         							<div id="attr-addr-div">${attr.attractionAddr}</div>
         					</div>
         			</div>
         			<div id="attrInfo-div">${attr.attractionInfo}</div>
         			<div id="attrReview-div">최신 리뷰 5개 들어갈 div</div>
         			<div id="attrMap-div">지도 들어갈 div</div>
         			<div id="attrNavi-div">혹시모를 div</div>
         			<div id="btn-div">              
         					<button class="form-control btn btn-primary"
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

	
	<script>
		$("#search-btn").on("click", function(){
			const contentTypeS = $("#contentTypeS").val();
			const areaCode = $("#areaCode").val();
			$.ajax({
				url : "search/area",
				data : {"contentTypeS" : contentTypeS , 
								"areaCode" : areaCode , 
								},
				dataType : "json",
				success : function(result){
					console.log(result);
					$(".list-wrapper").empty();
					
					for(let i=0 ; i<result.response.body.items.item.length ; i++){
						
						const contentid = result.response.body.items.item[i].contentid;
						const div1 = $("<div>").attr('class','card').css('width' , '18rem').attr('name', contentid);
						const src = result.response.body.items.item[i].firstimage;
						//const a = $("<a>").attr('href','result.response.body.items.item[i].contentid');

						//console.log("src : " + src);
						
						/* if(src == "undefined"){
							src = "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg";
						} */
						// if( $(this).prev().attr("src") != undefined ){  <- 다른데서 찾은 코드인데...
						const img = $("<img>").attr('src',src).attr('class','card-img-top');
						const div2 = $("<div>").attr('class' , 'card-body' );
						const p = $("<p>").attr('class','card-text').text(result.response.body.items.item[i].title);
						div2.append(p);
						div1.append(img);
						div1.append(div2);
						
						$(".list-wrapper").append(div1);
					}
				}
			});
		});

		
		
		
/* 		$(".card-text").on("click", function(event){
			event.stopPropagation();
			console.log("콘솔에 찍었다");
			console.log($(this).attr("id"));
			
		}); */

		$(document).on("click", ".card",function(){
			//console.log($(this).attr('id'));
			
			const contentid = $(this).attr('name');
			location.href = "view?contentid=" + contentid;
			
		});
		
		
		
		</script>
	
	


</body>

</html>