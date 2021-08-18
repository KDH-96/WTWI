<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        .chat-area{ 
            height: 600px;  
            width : 1200px;
        }
        .chat-view{
            width: 100%;
            height: 500px;
            border : 1px solid dimgray;
            overflow: auto;
            list-style : none;
            padding : 10px 20px;
        }
        .chat{
            display: inline-block;
            border-radius: 10px;
            padding : 10px;
            background-color: #eee;
            position: relative;
        }
        .managerChat>p:after{
            content: '';
            position: absolute;
            border-width: 10px 20px 10px 0;
            border-color: #eee;
            display: block;
            left: -10px;
            bottom: 5px;
            border-right: 20px solid #eee;
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
        }
        .myChat{
            text-align: right;
        }
        .myChat>p{
            background-color: rgb(232, 240, 250);
        }
        .myChat>p:after{
            content: '';
            position: absolute;
            border-width: 10px 20px 0 10px;
            border-color: rgb(232, 240, 250);
            display: block;
            right: -10px;
            bottom: 5px;
            border-left: 20px solid rgb(232, 240, 250);
            border-top: 10px solid transparent;
            border-bottom: 10px solid transparent;
        }
        .input-area{
            width: 100%;
            display: flex;
        }
        #inputChatting{
            width : 90%;
            resize : none;
        }
        #send{
            width : 10%;
        }
        .chatDate{
            font-size: 10px;
        }
        .isNew > i{
        	font-size: 8px;
        	font-weight: 1000;
        	color: #da2c3d;
        }
    </style>
<jsp:include page="../common/header.jsp" />
<div class="container">
	<c:choose>
		<c:when test="${loginMember.memberGrade=='M'}">
	    	<h3 class="my-4 font-weight-bold">${attractionName} 문의 답변하기</h3>
	    </c:when>
		<c:otherwise>
	    	<h3 class="my-4 font-weight-bold">${attractionName} 담당자에게 문의하기</h3>
		</c:otherwise>
	</c:choose>
    <div class="chat-area mt-2">
        <ul class="chat-view">
        	<c:forEach items="${cmList}" var="msg">
        		<fmt:formatDate var="chatedDate" value="${msg.chatCreateDate}" pattern="yyyy-MM-dd"/>
        		<fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
        		<fmt:formatDate var="chatedTime" value="${msg.chatCreateDate}" pattern="HH:mm"/>
        		<c:if test="${msg.memberNo == loginMember.memberNo }">
		            <li class="myChat">
		                <span class="chatDate">
		                	<c:if test="${chatedDate==today}">${chatedTime}</c:if>
		                	<c:if test="${chatedDate!=today}">${chatedDate}</c:if>
		                </span>
		                <p class="chat">${msg.chatContent}</p>
		            </li>
        		</c:if>
        		<c:if test="${msg.memberNo != loginMember.memberNo }">
		            <li class="managerChat">
		                <p class="chat">${msg.chatContent}</p>
		                <span class="chatDate">
		                	<c:if test="${chatedDate==today}">${chatedTime}</c:if>
		                	<c:if test="${chatedDate!=today}">${chatedDate}</c:if>
		                </span>
		                <span class="isNew">
		                	<c:if test="${msg.chatReadYn=='N'}"><i>N</i></c:if>
		                </span>
		            </li>
        		</c:if>
        	</c:forEach>
        </ul>	
        <div class="input-area">
            <textarea class="form-control" id="inputChatting" rows="3"></textarea>
            <button class="btn btn-outline-secondary" id="send">전송</button>
        </div>
    </div>
    <div class="mt-3">
        <button class="btn btn-outline-secondary" onclick="location.href='${contextPath}/myPage/chat';">돌아가기</button>
    </div>
</div>
<!-- footer include -->

<!-- sockjs 라이브러리 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script>

(function(){

	$(".chat-view").scrollTop($(".chat-view")[0].scrollHeight);

})();

//var audio = new Audio("/resources/audio/audio.mp3");

// 로그인했을 경우 /chat 요청 주소를 통해 통신할 수 있는 WebSocket 객체 생성
let chattingSock = new SockJS("<c:url value='/chat'/>");
// -> 이 객체는 자바스크립트에서 동작

//const memberNo = "${loginMember.memberNo}";
const memberId = "${loginMember.memberId}";
const memberEmail = "${loginMember.memberEmail}";
const memberNick = "${loginMember.memberNick}";
const chatRoomNo = "${chatRoomNo}";

// 채팅 메세지 전송 버튼 클릭 시
$("#send").on("click", function(){
	
	$(".isNew").children().remove();
	
	const chatContent = $("#inputChatting").val();
	
	if(chatContent.trim().length == 0){ // 채팅 메세지 미입력 시 
		swal("메세지를 입력해주세요.");
		
	} else {
		var obj = { "memberNo": memberNo,
					"memberId": memberId,
					"memberEmail": memberEmail,
					"memberNick": memberNick,
					"chatContent": chatContent,
					"chatRoomNo": chatRoomNo };
		
		chattingSock.send(JSON.stringify(obj));
		$("#inputChatting").val("");
	}
});

// 웹소켓 객체 chattingSock이 서버로부터 메세지를 전달받으면 자동으로 실행
chattingSock.onmessage = function(event){
	
	const obj = JSON.parse(event.data);
	//console.log(obj);
	
	const li = $("<li>");
	const p = $("<p class='chat'>");
	const span = $("<span class='chatDate'>");
	
	// 날짜
	var date1 = new Date();
	//var year = date1.getFullYear();
	//var month = date1.getMonth()+1;
	//var day = date1.getDate();
	let today = date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();
	
	var date2 = new Date(obj.chatCreateDate);
	var cYear = date2.getFullYear();
	var cMonth = date2.getMonth()+1;
	var cDate = date2.getDate();

	var chatCreateDate = cYear+"-"+cMonth+"-"+cDate;
	
	var hour = date2.getHours();
	var minute = date2.getMinutes();
	
	if(chatCreateDate == today){
		if(hour<10) hour = "0"+hour;
		if(minute<10) minute = "0"+minute;
		chatCreateDate = hour+":"+minute
		
	} else {
		if(cMonth<10) cMonth = "0"+cMonth;
		if(cDate<10) cDate = "0"+cDate;
		chatCreateDate = cYear+"-"+cMonth+"-"+cDate;
	}
	span.html(chatCreateDate);
	
	const chatContent = obj.chatContent.replace(/\n/g, "<br>");
	p.html(chatContent);
	
	if(obj.memberNo == memberNo){
		li.addClass("myChat");
		li.append(span);
		li.append(p);
		
	} else {
		li.addClass("managerChat");
		li.append(p);
		li.append(span);
	}
	
	$(".chat-view").append(li);
	
	$(".chat-view").scrollTop($(".chat-view")[0].scrollHeight);

/* 	if(!$("#chatAudio").isPlaying){
		
		$("#chatAudio").play();
	} */
}
</script>

