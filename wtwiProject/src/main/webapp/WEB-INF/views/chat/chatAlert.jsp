<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.new-chat-area{
    position: fixed;
    right: 31px;
    bottom: 77px;
	z-index: 3;
}
.chat-icon-area{
	position: fixed;
    right: 15px;
    bottom: 15px;
    z-index: 1;
}
.chat-alert-area{
    position: fixed;
    right: 26px;
    bottom: 74px;
    z-index: 2;
}
.bi-chat-square-dots{
	font-size: 48px;
}
.bi-circle-fill{
	font-size: 18px;
	color: rgba(218, 44, 61, 1.0);
}


</style>
<c:if test="${!empty loginMember}">
<div class="chat-alert btn" onclick="location.href='${contextPath}/myPage/chat';">
    <div class="chat-icon-area p-3">
    	<i class="bi bi-chat-square-dots"></i>
    </div>
    <div class="chat-alert-area">
    	<i class="bi bi-circle-fill"></i>
    </div>
    <div class="new-chat-area">
    </div>
</div>
</c:if>
<script>
const memberNo = "${loginMember.memberNo}";
$(document).ready(function(){
	
	if(memberNo!=""){
		
		// 새로운 채팅 메세지가 있는지 조회
		$.ajax({
			url: "${contextPath}/chat/newChatExist",
			data: {"memberNo": memberNo},
			type: "POST",
			
			success: function(result){
				if(result>0){
					var i = "<i style=\"font-size:12px; font-weight: 600; color: white;\">"+result+"</i>"; 
					$(".new-chat-area").append(i);
					
				} else {
					$(".chat-alert-area").html("");
				}
			},
			error: function(e){
				console.log(e);
			}
		});
	}
	
});
</script>