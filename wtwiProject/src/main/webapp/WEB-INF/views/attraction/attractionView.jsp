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
      /* ------------------------------영역구분선------------------------------ */
   </style>
</head>

<body>

   <jsp:include page="../common/header.jsp" />
   <!-- 전체 div를 포함하는 영역 -->
      <!-- ===============================영역구분선=============================== -->
   <div id="contentContainer">
   
      <div id="contentArea">

         <div class="list-wrapper">
							<table class="table">
		            <tbody>
		              <tr>
		                <th></th>
		                <td><a id="memberIdA" href="#">id</a></td>
		                <td>name</td>
		                <td>nickname</td>
		                <td>warnning point</td>
		                <td>Y / S / N</td>
		                <td>
		                  <select>
		                    <option>Y</option>
		                    <option>S</option>
		                    <option>N</option>
		                  </select>
		                  <button>변경</button>
		                </td>
		              </tr>
		
		            </tbody>
		          </table>
         </div>
         <!----------------------------------------------------------------------------------------------  content end -->


         <!-- 검색창 -->
         <div class="my-2">
            <form action="#" method="GET" class="text-center" id="searchForm">
               <div class="container2">
                  <div class="row">
                     <div class="col-sm" >

                      <select name="sk" class="form-control" style="width: 200px; display: inline-block; ">
                        <option value="attrName">명소이름</option>
                        <option value="attrNo">명소번호</option>
                     </select>

                     </div>
                     <div class="col-sm">
                        <input type="text" name="sv" class="form-control" style="width: 50%; display: inline-block;">
                     </div>
                     <div class="col-sm">
                        <button class="form-control btn btn-primary"
                        style="width:100px; display: inline-block; background-color: black; border: black;">검색</button>
                     </div>
                  </div>
               </div>
            </form>
         </div>
         
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