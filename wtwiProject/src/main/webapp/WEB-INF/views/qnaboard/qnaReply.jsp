<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
/*댓글*/
  .reply-area {
            width: 100%;
            height: 100px;
            position: relative;
        }

        .more-reply-area {
            width: 9%;
            height: 100%;
            text-align: center;
            position : absolute;
            top : 0%;
            right : 0%; 
        }

        .replyWrite>table {
            margin-top: 10px;
        }

        .rWriter {
            display: inline-block;
            float: left;
            width : 100px;
            vertical-align: top;
            font-size: 1.2em;
            font-weight: bold;
        }
        .rDate {
            display: inline-block;
            background-color : orange;
            color : white;
            border-radius : 2.0rem;
        }

        .rContent{
            height: 100%;
            width: 50%;
            float: left;
        }
        
        .replyBtnArea {
            height: 100%;
            width: 100%;
        }

        .replyBtnArea {
            text-align: right;
        }

        .replyUpdateContent {
            resize: none;
            width: 100%;
        }

        .reply-row {
            border-top: 1px solid #ccc;
            padding: 15px 0;
        }
</style>

<div id="reply-area ">

	<div style="height: 100%;">
         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="20" fill="currentColor" class="bi bi-chat" viewBox="0 1 16 16">
              <path d="M2.678 11.894a1 1 0 0 1 .287.801 10.97 10.97 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8.06 8.06 0 0 0 8 14c3.996 0 7-2.807 7-6 0-3.192-3.004-6-7-6S1 4.808 1 8c0 1.468.617 2.83 1.678 3.894zm-.493 3.905a21.682 21.682 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a9.68 9.68 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105z" />
          </svg>
          <label for="">1</label>
    </div>
    
	<!-- 댓글 출력 부분 -->
	<div class="replyList mt-5 pt-2">
		<ul id="replyListArea">
			<c:forEach items="${rList}" var="reply">
				
				<li class="shadow p-3 mb-5 bg-white rounded reply-row">

                        <div class="reply-area">
                        			<div class="rDate-area">
		                           	<p class="rDate">
		                           	작성일 : <fmt:formatDate value="${reply.qnaReplyCreateDt}" pattern="yyyy년 MM월 dd일" />
									</p>
                        			</div>
	                               
	                                <p class="rWriter">${reply.memberNick}</p>
		                            <p class="rContent">${reply.qnaReplyContent}</p>
	
		                        <div class="more-reply-area">
		                                <details>
		                                    <summary>더보기</summary>
		                                    <ul class="update-delete-area">
		                                        <li class="update"><a class="showUpdate" href="#" onclick="showUpdateReply(${reply.qnaReplyNo}, this)">수정</a></li>
		                                        <li class="X"><a class="deleteReply" href="#" onclick="deleteReply(${reply.qnaReplyNo})">삭제</a></li>
		                                    </ul>
		                             	</details>
		                        </div>
						</div>

                    </li>
			
			</c:forEach>
		</ul>
	</div>


	<!-- 댓글 작성 부분 -->
	<div class="replyWrite">
		<table align="center">
			<tr>
				<td id="replyContentArea">
				<textArea rows="3" id="replyContent" style="width:700px; resize: none;"></textArea>
				</td>
				<td id="replyBtnArea">
					<button class="btn btn-primary" id="addReply" onclick="addReply();">
						댓글<br>등록
					</button>
				</td>
			</tr>
		</table>
	</div>




</div>

<script>

// 로그인한 회원의 회원 번호, 비로그인 시 "" (빈문자열)
const loginMemberNo = "${loginMember.memberNo}";

// 현재 게시글 번호
const qnaNo = ${board.qnaNo};

// 수정 전 댓글 요소를 저장할 변수 (댓글 수정 시 사용)
let beforeReplyRow;


//-----------------------------------------------------------------------------------------
// 댓글 등록
function addReply()	{
	
	// 작성된 댓글 내용 얻어오기
	const replyContent = $("#replyContent").val();
	
	// 로그인이 되어있지 않은 경우
	if(loginMemberNo == ""){
		swal("로그인 후 이용해 주세요.")
	}else{
		
		if(replyContent.trim() == ""){ // 작성된 댓글이 없을 경우
			swal("댓글 작성 후 클릭해주세요.");
		}else{
			// 로그인 O, 댓글 작성 O

			$.ajax({
				url : "${contextPath}/qnaReply/insertReply", // 필수 속성
				type : "POST", 
				data : {"memberNo" : loginMemberNo,
						"qnaNo" : qnaNo,
						"qnaReplyContent" : qnaReplyContent},
						
				success : function(result){
					if(result >0){ // 댓글 삽입 성공
						swal({"icon" : "success" , "title" : "댓글 등록 성공"});
						$("#replyContent").val(""); // 댓글 작성 내용 삭제

						selectReplyList(); // 비동기로 댓글 목록 갱신
					}
				},
				error : function(){
					console.log("댓글 삽입 실패");	
					
				}
				
			});
			
		}
	}
	
}	
	


//-----------------------------------------------------------------------------------------
//해당 게시글 댓글 목록 조회
function selectReplyList(){
 $.ajax({
	 url : "${contextPath}/qnaReply/list",
	 data : {"qnaNo" : qnaNo},
	 type : "POST",
	 dataType : "JSON", // 응답되는 데이터의 형식이 JSON임을 알려줌 -> 자바스크립트 객체로 변환됨
	 success : function(rList){
			 console.log(rList);
			 
	         $("#replyListArea").html(""); // 기존 정보 초기화
	         // 왜? 새로 읽어온 댓글 목록으로 다시 만들어서 출력하려고!!
	         
	         
	         $.each(rList, function(index, item){
	        	 // $.each() : jQuery의 반복문
	        	 // rList : ajax 결과로 받은 댓글이 담겨있는 객체 배열
	        	 // index : 순차 접근 시 현재 인덱스
	        	 // item : 순차 접근 시 현재 접근한 배열 요소(댓글 객체 하나)
	        	 
	        	 
	        	 
	            
	            var li = $("<li>").addClass("shadow p-3 mb-5 bg-white rounded reply-row");
	         
	            // 댓글 작성일
	            var rDateArea = $("<div>").addClass("rDate-area")
	            var rDate = $("<p>").addClass("rDate").text("작성일 : " + item.qnaReplyCreateDt);
				rDateArea.append(rDate);
	            // 작성자, 작성일, 수정일 영역 
	            var replyArea = $("<div>").addClass("reply-area");
				// 작성자	            
	            var rWriter = $("<p>").addClass("rWriter").text(item.memberNick);
	            // 댓글 내용
	            var rContent = $("<p>").addClass("rContent").html(item.qnaReplyContent);

				replyArea.append(rDateArea).append(rWriter).append(rContent);	            
	            
	            var moreReplyArea = $("<div>").addClass("more-reply-area");
	            var details = $("<details>");
	            var summary = $("<summary>").text("더보기");
	            var ul = $("<ul>").addClass("update-delete-area");
	            var update= $("<li>").addClass("update");
	            var X= $("<li>").addClass("X");
	            
	            // 현재 댓글의 작성자와 로그인한 멤버의 아이디가 같을 때 버튼 추가
	           // if(item.memberNo == loginMemberNo){
	               
	            	var showUpdate = $("<a>").addClass("showUpdate").text("수정").attr("onclick","showUpdateReply("+item.qnaReplyNo+", this)");
	               var deleteReply = $("<a>").addClass("deleteReply").text("삭제").attr("onclick", "deleteReply("+item.qnaReplyNo+")");
	               // ** 추가되는 댓글에 onclick 이벤트를 부여하여 버튼 클릭 시 수정, 삭제를 수행할 수 있는 함수를 이벤트 핸들러로 추가함. 

	               
	               details.append(summary).append(ul).append(update).append(showUpdate).append(X).append(deleteReply);
	               moreReplyArea.append(details);
	           // }
	            
	            
	            // 댓글 요소 하나로 합치기
	            li.append(replyArea).append(moreReplyArea);
	            
	            
	            // 합쳐진 댓글을 화면에 배치
	            $("#replyListArea").append(li);
	         });
			 
			 
			 
			 
		 },
		 error : function(){
			 console.log("댓글 목록 조회 실패");
		 }
	 
 });
}


// -----------------------------------------------------------------------------------------
// 일정 시간마다 댓글 목록 갱신
/* const replyInterval = setInteval(function(){
	selectReplyList();
}, 5000); */


// -----------------------------------------------------------------------------------------
// 댓글 수정 폼

function showUpdateReply(qnaReplyNo, el){
	// el : 수정 버튼 클릭 이벤트가 발생한 요소

	
	// 이미 열려있는 댓글 수정 창이 있을 경우 닫아주기
	   if($(".replyUpdateContent").length > 0){
	      $(".replyUpdateContent").eq(0).parent().html(beforeReplyRow);
	   }
	      
	   
	   // 댓글 수정화면 출력 전 요소를 저장해둠.
	   beforeReplyRow = $(el).parent().parent().html();
	
	   
	   
	   
	   // 작성되어있던 내용(수정 전 댓글 내용) 
	   var beforeContent = $(el).parent().parent().parent().parent().prev().html();
	   
	   
	   
	   
	   
	   
	   // 이전 댓글 내용의 크로스사이트 스크립트 처리 해제, 개행문자 변경
	   // -> 자바스크립트에는 replaceAll() 메소드가 없으므로 정규 표현식을 이용하여 변경
	   beforeContent = beforeContent.replace(/&amp;/g, "&");   
	   beforeContent = beforeContent.replace(/&lt;/g, "<");   
	   beforeContent = beforeContent.replace(/&gt;/g, ">");   
	   beforeContent = beforeContent.replace(/&quot;/g, "\"");   
	   
	   beforeContent = beforeContent.replace(/<br>/g, "\n");   
	   
	   
	   // 기존 댓글 영역을 삭제하고 textarea를 추가 
	   $(el).parent().parent().parent().parent().prev().remove();
	   var textarea = $("<textarea>").addClass("replyUpdateContent").attr("rows", "3").css("width","70%").val(beforeContent);
	   $(el).parent().parent().parent().parent().before(textarea);
	   
	   
	   // 수정 버튼
	   var updateReply = $("<a>").addClass("updateReply").text("댓글 수정").attr("onclick", "updateReply(" + qnaReplyNo + ", this)");
	   
	   // 취소 버튼
	   var cancelBtn = $("<a>").addClass("cancelBtn").text("취소").attr("onclick", "updateCancel(this)");
	   
	   var replyBtnArea1 = $(el).parent().parent().parent().parent().parent();
	   
	   $(replyBtnArea1).empty(); 
	   $(replyBtnArea1).append(updateReply); 
	   $(replyBtnArea1).append(cancelBtn); 
	   
	   
	   
}

//-----------------------------------------------------------------------------------------
//댓글 수정 취소 시 원래대로 돌아가기
function updateCancel(el){
	$(el).parent().parent().parent().parent().children().children().children().children().html(beforeReplyRow);
}


//-----------------------------------------------------------------------------------------
// 댓글 수정
function updateReply(qnaReplyNo, el){
	
	// 수정된 댓글 내용
	const replyContent = $(el).parent().prev().val();
	
	$.ajax({
		url : "${contextPath}/reply/updateReply",
		type : "POST",
		data : {"qnaReplyNo" : qnaReplyNo,
				"qnaReplyContent" : qnaReplyContent},
		success : function(result){
		if(result>0){
			swal({"icon" : "success" , "title" : "댓글 수정 성공"});
			selectReplyList();
		}
			
		},
		
		error : function(){
			console.log("댓글 수정 실패");
		}
	});
	
	
}


//-----------------------------------------------------------------------------------------
//댓글 삭제
function deleteReply(qnaNo){

	   if(confirm("정말로 삭제하시겠습니까?")){
		      var url = "${contextPath}/reply/deleteReply";
		      
		      $.ajax({
		         url : url,
		         data : {"qnaReplyNo" : qnaReplyNo},
		         success : function(result){
		            if(result > 0){
		               selectReplyList(qnaNo);
		               
		               swal({"icon" : "success" , "title" : "댓글 삭제 성공"});
		            }
		            
		         }, error : function(){
		            console.log("ajax 통신 실패");
		         }
		      });
		   }
	
	
}

</script>