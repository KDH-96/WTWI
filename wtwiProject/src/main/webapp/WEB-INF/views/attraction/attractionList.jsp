<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" scope="application" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="ko">


<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>명소 리스트</title>
   
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
      #contentArea{
      	float : left;
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
         margin-top : 20px;
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
      	width: 286px;
      	height : 190px;   
      }
      
      .my-2{
      	display: inline-block;
      }
      .list-class{
      	display: inline-block;
      }
      .card-img-top{
      	width: 286px;
      	height : 190px;   
      }
      #area-abajo{
      	margin-top : 100px;
      }
      /* ------------------------------영역구분선------------------------------ */
   </style>
</head>

<body>

   <jsp:include page="../common/header.jsp" />
   <!-- 전체 div를 포함하는 영역 -->
      <!-- ===============================영역구분선=============================== -->
   <div id="contentContainer">
   
      <div id="contentArea">
	         <div id="h-menu">
         
         		구분
						 <select id="contentTypeS" name="contentTypeS">
							 	<option value="12">관광지</option>
							 	<option value="14">문화시설</option>
							 	<option value="15">축제/공연/행사</option>
							 	<option value="25">여행코스</option>
							 	<option value="28">레포츠</option>
							 	<option value="32">숙박</option>
							 	<option value="38">쇼핑</option>
							 	<option value="39">음식</option>
						 </select>
						  지역
						 <select id="areaCode" name="areaCode">
							 	<option value="1">서울</option>
							 	<option value="2">인천</option>
							 	<option value="3">대전</option>
							 	<option value="4">대구</option>
							 	<option value="5">광주</option>
							 	<option value="6">부산</option>
							 	<option value="7">울산</option>
							 	<option value="8">세종</option>
						 </select>
						 <button id="find-btn" class="btn btn-dark">조회</button>
						 
         
         </div>
         <div class="list-wrapper">
         
         		<c:choose>
         			<%-- 조회된 근처 관광지 목록이 없는 경우 --%>
							<c:when test="${empty attrList}">
								<tr>
									<td colspan="6">게시글이 존재하지 않습니다.</td>
								</tr>								
							</c:when>
							
							<%-- 조회된 게시글 목록이 있을 경우 --%>
							<c:otherwise>
							
								<c:forEach items="${attrList}" var="attraction">
         					<div class="card" id="${attraction.attractionNo}">
         						<img class="card-img-top" src ="${attraction.attractionPhoto}">
		         				<div class="card-body">
		         						<p class="card-text">${attraction.attractionNm}</p>
		         				</div>	
         					</div>
         				</c:forEach>
							
							</c:otherwise>
							
						</c:choose>
         </div>
         
         
         
      </div>
         <!----------------------------------------------------------------------------------------------  content end -->

         <!----------------------------------------------------------------------------------------------  Pagination start -->
         <!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->
			<div id="area-abajo">
        <%-- 페이지네이션 --%>
	 			<c:set var="pageURL" value="list"  />
				
				<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${keyword}" />
				<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${keyword}" />
				
				
				<div class="my-5">
					<ul class="pagination">
					
						<%-- 현재 페이지가 10페이지 초과인 경우 --%>
						<c:if test="${pagination.currentPage > pagination.pageSize }">
							<li><a class="page-link" href="${prev}">&lt;&lt;</a></li>
						</c:if>
						
						<%-- 현재 페이지가 2페이지 초과인 경우 --%>
						<c:if test="${pagination.currentPage > 2 }">
							<li><a class="page-link" href="${pageURL}?cp=${pagination.currentPage - 1}${searchStr}">&lt;</a></li>
						</c:if>
						
						
					
						<%-- 페이지 목록 --%>
						<c:forEach var="p" begin="${pagination.startPage}" end="${pagination.endPage}">
							
								<c:choose>
									<c:when test="${p == pagination.currentPage }">
										<li class="page-item active"><a class="page-link">${p}</a></li>
									</c:when>
									
									<c:otherwise>
										<li><a class="page-link" href="${pageURL}?cp=${p}${searchStr}">${p}</a></li>
									</c:otherwise>
								</c:choose>						
						</c:forEach>
						
						<%-- 현재 페이지가 마지막 페이지 미만인 경우 --%>
						<c:if test="${pagination.currentPage < pagination.maxPage }">
							<li><a class="page-link" href="${pageURL}?cp=${pagination.currentPage + 1}${searchStr}">&gt;</a></li>
						</c:if>
						
						<%-- 현재 페이지가 마지막 페이지가 아닌 경우 --%>
						<c:if test="${pagination.currentPage - pagination.maxPage + pagination.pageSize < 0}">
							<li><a class="page-link" href="${next}">&gt;&gt;</a></li>
						</c:if>
	
					</ul>
				</div>
         <!----------------------------------------------------------------------------------------------  Pagination end -->

         <!-- 검색창 -->
         <div class="my-2">
            <form action="list" method="GET" class="text-center" id="searchForm">
               <div class="container2">
                  <div class="row">
                     <div class="col-sm">
                        <input type="text" id="keyword" name="keyword" class="form-control" style="width: 100%; display: inline-block;" 
                        placeholder="검색어를 입력해주세요">
                     </div>
                     <div class="col-sm">
                        <button type="submit" class="form-control btn btn-primary" id="search-btn"
                        style="width:100px; display: inline-block; background-color: black; border: black;">검색</button>
                     </div>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>



   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>
   
   

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
      crossorigin="anonymous"></script>

	
	<script>
		$("#find-btn").on("click", function(){
			const contentTypeS = $("#contentTypeS").val();
			const areaCode = $("#areaCode").val();
			$.ajax({
				url : "find/area",
				data : {"contentTypeS" : contentTypeS , 
								"areaCode" : areaCode , 
								},
				dataType : "json",
				success : function(result){
					console.log(result);
					$(".list-wrapper").empty();
					
					for(let i=0 ; i<result.response.body.items.item.length ; i++){
						
						const contentid = result.response.body.items.item[i].contentid;
						const div1 = $("<div>").attr('class','card').css('width' , '18rem').attr('id', contentid);
						let src = result.response.body.items.item[i].firstimage;
						//const a = $("<a>").attr('href','result.response.body.items.item[i].contentid');

						//console.log("src : " + src);
						
						if(src == undefined){
							src = "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg";
						}
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
		
		
		$(".page-item active").on("click",function(){
				console.log(${p});	
		
		
		
		});
		

		
		
		
/* 		$(".card-text").on("click", function(event){
			event.stopPropagation();
			console.log("콘솔에 찍었다");
			console.log($(this).attr("id"));
			
		}); */

		$(document).on("click", ".card",function(){
			console.log($(this).attr('id'));
			
			const contentid = $(this).attr('id');
			location.href = "view/" + contentid;
			
		});
		
		/*
		
		http://localhost:8080/fin/attraction/search/area?keyword=seoul
		http://localhost:8080/fin/attraction/view/125452
		
		
		*/

		
		</script>
	
	


</body>

</html>