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
         margin: auto;
         width: 1200px;
         height: 100vh;
      }
      #searchArea{
      	width : 20%;
      	float : left;
      }
      #contentArea{
      	width : 80%;
      	float : right;
      }
      .col-sm{
      	text-align : left;
      }
      #dropdown-div{
      	margin-top : 100px;
      }
			select{
				width: 150px;
			}
			option{
				text-align : center;
			}
			.list-wrapper{
				margin-top : 30px;
			}
			
			
			/* 미리보기 관련 */
			#cardArea-div{
				margin-top : 30px;
				margin-buttom : 30px;
			}
			.card{
      	display: inline-block;
      	float : left;
      	width: 240px;
      	height : 215px;   
      }
      .my-2{
      	display: inline-block;
      }
      .list-class{
      	display: inline-block;
      }
      .card-img-top{
      	width: 240px;
      	height : 170px;   
      }
      .card-img-top:hover{
      	cursor : pointer;
      }
      .card-body{
      	width : 240px;
      	height : 50px;
      }

      .card-text{
      	
      	display: -webkit-box;
      	display: -ms-flexbox;
      	display: box;
      	margin-top:1px;
      	max-height:20px;
      	width: 220px;
      	overflow:hidden;
      	vertical-align:top;
      	text-overflow:ellipsis;
      	word-break:break-all;
      	-webkit-box-orient:vertical;
      	-webkit-line-clamp:3;
      	display:block;
      	white-space:nowrap;
      	text-align:center;
      	
      
      	
      }			
      /* 페이지네이션 */
      #pagination-div{
      	width:100%;
      	display : inline-block;
      	margin-top : 20px;
      }
      #page-link{
      	background-color : black;
      	border-color : black;
      }
      #page-link-1{
      	color : black;
      }
      #page-link-2{
      	color : black;
      }
      #page-link-3{
      	color : black;
      }
      #page-link-4{
      	color : black;
      }
      /* ------------------------------영역구분선------------------------------ */
   </style>
</head>

<body>

   <jsp:include page="../common/header.jsp" />
   <!-- 전체 div를 포함하는 영역 -->
      <!-- ===============================영역구분선=============================== -->
   <div id="contentContainer">
   
   		<!-- 검색 / 드롭다운 div -->
			<div id="searchArea">
							<form action="list" method="GET">
								  <div class="input-group mb-3" id="dropdown-div">
										  <label class="input-group-text" for="inputGroupSelect01">지역</label>
										  <select id="areaCode" name="areaCode" class="form-select" id="inputGroupSelect01">
												 	<option value="1">서울</option>
												 	<option value="2">인천</option>
												 	<option value="3">대전</option>
												 	<option value="4">대구</option>
												 	<option value="5">광주</option>
												 	<option value="6">부산</option>
												 	<option value="7">울산</option>
												 	<option value="8">세종</option>
												 	<option value="31">경기</option>
												 	<option value="32">강원</option>
												 	<option value="33">충북</option>
												 	<option value="34">충남</option>
												 	<option value="35">전북</option>
												 	<option value="36">전남</option>
												 	<option value="37">경북</option>
												 	<option value="38">경남</option>
												 	<option value="39">제주</option>
										  </select>
									</div>
									
									<div class="input-group mb-3">
										  <label class="input-group-text" for="inputGroupSelect01">종류</label>
										  <select id="contentType" name="contentType" class="form-select" id="inputGroupSelect01">
												 	<option value="12">관광지</option>
												 	<option value="14">문화시설</option>
												 	<option value="15">축제/공연/행사</option>
												 	<option value="25">여행코스</option>
												 	<option value="28">레포츠</option>
												 	<option value="32">숙박</option>
												 	<option value="38">쇼핑</option>
												 	<option value="39">음식</option>
										  </select>
									</div>
								 <button id="find-btn" class="btn btn-dark" style="width:100px; display: inline-block; background-color: black; border: black;">조회</button>
						 </form>
						 <br>
						 
						 <hr>
						 
						 <div class="my-2">
             <form action="list" method="GET" class="text-center" id="searchForm">
               <div class="container2">
                  <div class="row">
                     <div class="col-sm">
                        <input type="text" id="keyword" name="keyword" class="form-control" style="width: 208px; display: inline-block;" 
                        placeholder="검색어를 입력해주세요">
                     </div>
                     <div class="col-sm">
                     
                        <button type="submit" class="form-control btn btn-primary" id="search-btn"
                        style="width:100px; margin-top:10px; display: inline-block; background-color: black; border: black;">검색</button>
                        
                        
                     </div>
                  </div>
               </div>
             </form>
             </div>
             
             <%-- DB삽입용 버튼 
             <form action="insertToDB" method="POST">
             		<input type="text" name="number">
             		<button>입력</button>
             </form>
             --%>
			</div>
			
			<!-- 오른쪽 지도 또는 명소가 보여질 div -->
			<div id="contentArea">
					<div class="list-wrapper">
         
						<%-- 지도 넣으려던 자리 --%>
						<div id="map-div">
								<div id="mapwrap" class="mapwrap-div"> 
						    		<!-- 지도가 표시될 div -->
						    		<c:if test= "${!empty userLongitude}">
											<div id="map" style="width:100%;height:350px;"></div>
						    		</c:if>
								</div>
						</div>
						<%-- 지도 넣으려던 자리 끝 --%>
						
						<div id="cardArea-div">
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
		         						<c:choose>
                             <c:when test = "${!empty attraction.attractionPhoto}">
                                   <img class="card-img-top" src= "${attraction.attractionPhoto}">
                             </c:when>
                             <c:otherwise>
                                   <img class="card-img-top" src="https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg">
                             </c:otherwise>
                       </c:choose>
				         				<div class="card-body" style="padding : 8px;">
				         						<p class="card-text" >${attraction.attractionNm}</p>
				         				</div>	
		         					</div>
		         				</c:forEach>
									
									</c:otherwise>
							
							</c:choose>
						</div>
						
						<%-- 검색/조회 상태 유지를 위한 쿼리스트링용 변수 --%>
						<%-- 검색했을 경우 --%>
            <c:if test="${!empty param.keyword}">
            	<c:set var="searchKeyword" value="&keyword=${param.keyword}"/>
            </c:if>
            <%-- 드롭다운으로 조회 했을 경우 --%>
            <c:if test="${!empty param.areaCode}">
            		<c:set var="searchArea" value="&areaCode=${param.areaCode}" />
            		<c:set var="searchContentType" value="&contentType=${param.contentType}" />
            </c:if>
						
						
        		<%-- 페이지네이션 --%>
						<div id="pagination-div">
		        <%-- 페이지네이션 --%>
		        <c:set var="pageURL" value="list"/>
						<c:set var="prev" value="${pageURL}?cp=${pagination.prevPage}${searchArea}${searchContentType}${searchKeyword}"/>
						<c:set var="next" value="${pageURL}?cp=${pagination.nextPage}${searchArea}${searchContentType}${searchKeyword}"/>
		        <div class="row d-flex justify-content-center">
		            <nav aria-label="Page navigation example">
		                <ul class="pagination">
		                	<%-- 현재 페이지가 5 페이지 이하일 시 --%>
		                	<c:if test="${pagination.currentPage <= pagination.pageSize}">
		                		<li class="page-item disabled">
		                			<a class="page-link" id="page-link-1" href="#" aria-label="Previous"><span aria-hidden="">&laquo;</span></a>
		                		</li>
		                	</c:if>
		                	<c:if test="${pagination.currentPage <= pagination.pageSize}">
		                		<li class="page-item disabled">
		                			<a class="page-link" id="page-link-1" href="#" aria-label="Previous"><span aria-hidden="">&laquo;</span></a>
		                		</li>
		                	</c:if>
		                	<%-- 현재 페이지가 5 페이지 초과일 시 --%>
		                	<c:if test="${pagination.currentPage > pagination.pageSize}">
		                		<li class="page-item">
		                			<a class="page-link" id="page-link-2" href="${prev}" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
		                		</li>
		                	</c:if>
		                	<%-- 페이지 --%>
							<c:forEach var="p" begin="${pagination.startPage}" end="${pagination.endPage}">
								<c:choose>
									<c:when test="${p==pagination.currentPage}">
										<li class="page-item active"><a id="page-link" class="page-link">${p}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" id="page-link-3" href="${pageURL}?cp=${p}${searchArea}${searchContentType}${searchKeyword}">${p}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<%-- 현재 페이지가 마지막 페이지 목록이 아닌 경우 --%>
							<c:if test="${pagination.endPage < pagination.maxPage}">
								<li class="page-item">
									<a class="page-link" id="page-link-4" href="${next}" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
								</li> 
							</c:if>
		                </ul>
		            </nav>
		        </div>
		        
        
			</div>
         </div>
			</div>
			
			         <!---------------------------------------------------------------------Pagination start -->
         <!-- 페이징 처리 시 주소를 쉽게 작성할 수 있도록 필요한 변수를 미리 선언 -->


   </div>



   <!-- ===============================영역구분선=============================== -->
   <%-- <jsp:include page="../common/footer.jsp" /> --%>
   
   

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
      crossorigin="anonymous"></script>
      
   		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e9f2b3228a237afc810c6514cece7e38"></script>
			<script>
			
			var attrList = ${attrList}; 
			var userLatitude = ${userLatitude};
			var userLongitude = ${userLongitude};
			
			console.log(userLatitude);
			console.log(attrList);
		
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(userLatitude, userLongitude), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 
			// 마커를 표시할 위치와 title 객체 배열입니다 

      var attrArray = new Array();
      
      for (i = 0 ; i < attrList.length ; i ++){
    	  attrArray.push(
    			  {content : '<div style="padding:5px;">' + attrList[i].attractionNm + '</div>' ,
    				 latlng : new kakao.maps.LatLng(attrList[i].latitude, attrList[i].longitude)
    			  }
    		)
      }
      
   		// 마커 이미지의 이미지 주소입니다
      var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
          
      for (var i = 0; i < attrArray.length; i ++) {
          
          // 마커 이미지의 이미지 크기 입니다
          var imageSize = new kakao.maps.Size(24, 35); 
          
          // 마커 이미지를 생성합니다    
          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
          
          // 마커를 생성합니다
          var marker = new kakao.maps.Marker({
              map: map, // 마커를 표시할 지도
              position: attrArray[i].latlng, // 마커를 표시할 위치
              title : attrArray[i].attractionNm, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
              image : markerImage // 마커 이미지 
          });
          var infowindow = new kakao.maps.InfoWindow({
        	  content : attrArray[i].content 
          });
          kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
          kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
          
      }
   		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다
      function makeOverListener(map, marker, infowindow) {
    	    return function() {
    	        infowindow.open(map, marker);
    	    };
    	}
   		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
      function makeOutListener(infowindow) {
          return function() {
              infowindow.close();
          };
      }
   
   </script>
 
 
   <script>
   
   

      
      $(".page-item active").on("click",function(){
            console.log(${p});   
      });


      $(document).on("click", ".card",function(){
         console.log($(this).attr('id'));
         
         const contentid = $(this).attr('id');
         location.href = "view/" + contentid;
         
      });
      
      
      
      
   // 검색 내용 유지
      function keepSearch(){
	   
    		var searchAreaCode = "${param.areaCode}";
    		var searchContentType = "${param.contentType}";
    		var searchKeyword = "${param.keyword}";
    		
      	var searchKey = "${param.sk}";
      	var searchVal = "${param.sv}";
      	var searchCat = "${param.sc}";
      	
      	// 검색 조건(key)
      	$("select[name=areaCode] > option").each(function(index, item){
      		if($(item).val()==searchKey){
      		   $(item).prop("selected", true)
      		   
      			if($(item).val()=="category"){
      				$("#formCategory").attr("style", "");
      				$("#formCategory > option").each(function(intex, item){
      					if($(item).val()==searchCat){
      					   $(item).prop("selected", true);
      					}
      				});
      			}
      		}
      	});
      	
      	// 검색 내용(value)
      	$("input[name=sv]").val(searchVal);
      }

      $(document).ready(function(){
      	
      	// sk 카테고리 선택 시 카테고리 선택 메뉴 생성
      	$("#formKey").on("change", function(){
      		var element = $("#formKey option:selected").val();
      		if(element == "category"){
      			$("#formCategory").attr("style", "");
      		} else {
      			$("#formCategory").attr("style", "display:none;");
      		}
      	});
      	
      	$("#searchForm").on("submit", function(){
      		if($("#formValue").val().trim().length==0){
      			if($("#formKey").val()!="category"){
      				swal({
      					icon: "warning",
      					title: "검색어를 입력해주세요."
      				});
      				return false;
      			} else{
      				$("#formValue").attr("name", "");
      			}
      		}
      	})
      });
      

      
      </script>
   
   


</body>

</html>