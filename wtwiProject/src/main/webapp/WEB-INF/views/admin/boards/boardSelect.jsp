<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

   <style>

      /* ------------------------------영역구분선------------------------------ */
      #contentContainer {
         /* background-color: red; */
         margin: auto;
         width: 1200px;
      }
      /* content ) 게시글 목록 스타일 */
      #h-menu{
         clear :both;
      }
      .h-div{
         float:left;
         width : 21%;
      }
      .board-menu{
         display: inline-block;
         width : 50%;
      }
      /* 게시글 목록의 높이가 최소 540px은 유지하도록 설정 */
      .list-wrapper {
         min-height: 50%;
      }
      /* 제목 a태그 색 변경 */
      #list-table td:nth-child(3)>a {
         color: black;
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
      #linkA{
         text-decoration:none;
      }
      #linkA:hover{
         background-color: pink;
      }
      th{
         text-align: center;
      }
      td{
         text-align: center;
      }
      /* ------------------------------영역구분선------------------------------ */
   </style>
   <jsp:include page="../common/header.jsp"></jsp:include>
   <!-- 전체 div를 포함하는 영역 -->
      <!-- ===============================영역구분선=============================== -->
   <div id="contentContainer">
         <div id="h-menu">
            <div class="h-div"><h2><span id="listTitle">여따 내용</span> 리스트</h2></div>
            <div class="board-menu">
               <form method="GET" action="${contextPath}/admin/boardList" id="boardSelect">
                  <select name="bo">
                     <option value="freeboard">자유</option>
                     <option value="qnaboard">문의</option>
                     <option value="report">신고</option>
                     <option value="review">리뷰</option>
                  </select>
                  <button type="submit">조회</button>
               </form>
            </div>
         </div>
         

   <script>
   keepOption();
	
   function keepOption(){
	   var boardOption = "${param.bo}";
	   
	   $("select[name=bo] > option").each(function(index, item){
		  
		   if($(item).val()==boardOption){
			   $(item).prop("selected", true);
		   }
	   });
   }

   </script>

