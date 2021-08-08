<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .free-reply{
        width: 1200px;
    }
    .free-reply-date{
        font-size: 12px;
    }
    .free-reply-area{
    	display: inline-block;
    }
</style>
<div class="free-reply mt-4">
	<div class="row col-12 free-reply-area">
    	<c:forEach var="r" items="${replyList}">
    		<div class="row free-reply-row mb-2 p-3">
    			<c:if test="${r.parentReplyNo != 0}">
    				<div class="col-1">
		        		<i class="bi bi-arrow-return-right"></i>
    				</div>
			        <div class="col-1 free-reply-info p-0">
			            <div class="row-6">
			            	${r.memberNick}
			            </div>
			            <fmt:formatDate var="replyCreateDate" value="${r.freeReplyCreateDate}" pattern="yyyy-MM-dd"/>
			            <fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
			            <c:choose>
			            	<c:when test="${replyCreateDate==today}">
			            		<div class="row-6 mt-1 free-reply-date"><fmt:formatDate value="${r.freeReplyCreateDate}" pattern="HH:mm"/></div>
			            	</c:when>
			            	<c:otherwise>
			            		<div class="row-6 mt-1 free-reply-date">${r.freeReplyCreateDate}</div>
			            	</c:otherwise>
			            </c:choose>
			    	</div>
	   			</c:if>
	   			<c:if test="${r.parentReplyNo == 0}">
			        <div class="col-2 free-reply-info">
			            <div class="row-6">
			            	${r.memberNick}
			            </div>
			            <fmt:formatDate var="replyCreateDate" value="${r.freeReplyCreateDate}" pattern="yyyy-MM-dd"/>
			            <fmt:formatDate var="today" value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd"/>
			            <c:choose>
			            	<c:when test="${replyCreateDate==today}">
			            		<div class="row-6 mt-1 free-reply-date"><fmt:formatDate value="${r.freeReplyCreateDate}" pattern="HH:mm"/></div>
			            	</c:when>
			            	<c:otherwise>
			            		<div class="row-6 mt-1 free-reply-date">${r.freeReplyCreateDate}</div>
			            	</c:otherwise>
			            </c:choose>
			        </div>
		        </c:if>
		        <div class="col-9 p-0">
		            <p>${r.freeReplyContent}</p>
		        </div>
		        <div class="free-menu col-1">
	               	<c:if test="${!empty loginMember }">
	                    <a href="#" class="btn dropdown" type="button" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                    	<i class="bi bi-three-dots"></i>
	                    </a>
	                </c:if>
					<div class="dropdown-menu" aria-labelledby="dropdownMenu">
						<c:choose>
							<c:when test="${r.memberNo == loginMember.memberNo}">
								<button class="dropdown-item" type="button" id="updateReplyBtn" onclick="updateReplyForm(${r.freeReplyNo}, this)" >수정</button>
								<button class="dropdown-item" type="button" id="deleteReplyBtn" onclick="deleteReplyAlert(${r.freeReplyNo})" >삭제</button>
							</c:when>
							<c:otherwise>
								<button class="dropdown-item" type="button">신고</button>
							</c:otherwise>
						</c:choose>
					</div>
		        </div>
			</div>
		</c:forEach>
	</div>
	<div class="input-group mt-4 mb-2 col-12 free-new-reply">
		<textarea class="form-control" rows="3" id="freeReplyContent"></textarea>
		<button class="btn btn-outline-secondary" onclick="addReply();">등록</button>
	</div>
</div>

<script>

//const memberNo = "${loginMember.memberNo}";
//const freeNo = ${board.freeNo};
let beforeReplyRow;

// 댓글 등록
function addReply(){
	
	const freeReplyContent = $("#freeReplyContent").val();
	
	if(memberNo==""){
		swal({
			icon: "warning",
			title: "회원만 이용 가능합니다."
		});
	} else {
		if(freeReplyContent.trim()==""){
			swal({
				icon: "warning",
				title: "작성된 댓글이 없습니다."
			});
		} else{
			
			$.ajax({
				
				url: "${contextPath}/freereply/insertReply",
				type: "POST",
				data: {"memberNo": memberNo,
					   "freeNo": freeNo,
					   "freeReplyContent": freeReplyContent},
				
				success: function(result){
					$("#freeReplyContent").val("");
					selectReplyList();
					replyCount();
				},
				error: function(e){
					console.log(e);
				}
			});
		}
	}
}

// 댓글 목록 조회
function selectReplyList(){
	
	$.ajax({
		
		url: "${contextPath}/freereply/selectReplyList",
		data: {"freeNo": freeNo},
		type: "POST",
		dataType: "JSON",
		
		success: function(replyList){
			$(".free-reply-area").html("");
			
			// 댓글 요소 새로 만들어서 합치기..................;;
			$.each(replyList, function(index, item){
				
				var str="";
				var strRep;
				var strDate;
				var strLogin;
				var strSelf;
				
				var date1 = new Date();
				var year = date1.getFullYear();
				var month = date1.getMonth()+1;
				var day = date1.getDate();
				let today = year+"-"+month+"-"+day;
				
				var date2 = new Date(item.freeReplyCreateDate);
				var rYear = date2.getFullYear();
				var rMonth = date2.getMonth()+1;
				var rDate = date2.getDate();
				let freeReplyCreateDate = rYear+"-"+rMonth+"-"+rDate;
				
				var hour = date2.getHours();
				var minute = date2.getMinutes();
				
				// 1) 상위댓글 여부
				if(item.parentReplyNo==0){ // 상위댓글
					strRep = "<div class=\"col-2 free-reply-info\">";
					
				} else { // 대댓글
					strRep = "<div class=\"col-1\"><i class=\"bi bi-arrow-return-right\"></i></div><div class=\"col-1 free-reply-info p-0\">";
				}
			
				// 2) 오늘 작성한 댓글 여부
				if(freeReplyCreateDate==today){ // 오늘 작성
					strDate = "<div class=\"row-6 mt-1 free-reply-date\">"+hour+":"+minute+"</div>";
					
				} else {
					strDate = "<div class=\"row-6 mt-1 free-reply-date\">"+freeReplyCreateDate+"</div>";
				}
	
				// 3) 로그인 여부
				if(memberNo!=""){
					strLogin = "<a href=\"#\" class=\"btn dropdown\" type=\"button\" id=\"dropdownMenu\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\"><i class=\"bi bi-three-dots\"></i></a>"
					
				} else {
					strLogin = "";
				}
				
				// 4) 로그인한 회원이 작성한 댓글 여부
				if(item.memberNo==memberNo){ // 로그인한 회원이 작성
					strSelf = "<button class=\"dropdown-item\" type=\"button\" id=\"updateReply\" onclick=\"updateReplyForm("+item.freeReplyNo+", this)\" >수정</button>"
							+ "<button class=\"dropdown-item\" type=\"button\" id=\"deleteReply\" onclick=\"deleteReplyAlert("+item.freeReplyNo+")\" >삭제</button>";
					
				} else { // 다른 회원이 작성
					strSelf = "<button class=\"dropdown-item\" type=\"button\">신고</button>"
				}
	
				// merge..
				str += "<div class=\"row free-reply-row mb-2 p-3\">"+strRep+"<div class=\"row-6\">"+item.memberNick+"</div>"+strDate
					 + "</div><div class=\"col-9 p-0\"><p>"+item.freeReplyContent+"</p></div><div class=\"free-menu col-1\">"+strLogin
					 + "<div class=\"dropdown-menu\" aria-labelledby=\"dropdownMenu\">"+strSelf+"</div></div></div>";
			
				// 합친 요소들을 배치
				$(".free-reply-area").append(str);
			});
		},
		error: function(e){
			console.log(e);	
		}
	});
}

// 댓글 수정 폼
function updateReplyForm(freeReplyNo, el){
	
	// 이미 열려있는 수정 폼 닫기
	if($(".updateReplyContent").length>0){
		$(".updateReplyContent").eq(0).parent().html(beforeReplyRow);
	}
	
	// 수정폼 출력 전 요소 저장
	beforeReplyRow = $(el).parent().parent().parent().parent().html();
	
	// 수정 전 내용
	var beforeContent = $(el).parent().parent().prev().children().html();
	beforeContent = beforeContent.replace(/&amp;/g, "&");   
	beforeContent = beforeContent.replace(/&lt;/g, "<");   
	beforeContent = beforeContent.replace(/&gt;/g, ">");   
	beforeContent = beforeContent.replace(/&quot;/g, "\"");   
	beforeContent = beforeContent.replace(/<br>/g, "\n");   
	
	// 기존 댓글 내용 삭제 후 textarea추가
	$(el).parent().parent().prev().remove();
	var textarea = $("<textarea>").addClass("updateReplyContent").attr("rows", "3").attr("style", "width:75%").val(beforeContent);
	$(el).parent().parent().before(textarea);
	
	// 수정버튼
	var updateReply = $("<button>").addClass("btn btn-outline-secondary ml-1").text("수정").attr("onclick", "updateReply("+freeReplyNo+", this)");
	
	// 취소 버튼
	var updateReplyCancel = $("<button>").addClass("btn btn-outline-secondary ml-1 mt-4").text("취소").attr("onclick", "updateReplyCancel(this)");
	
	var replyBtnArea = $(el).parent().parent();
	
	$(replyBtnArea).empty();
	$(replyBtnArea).append(updateReply); 
	$(replyBtnArea).append(updateReplyCancel); 
}

// 댓글 수정 취소 버튼 클릭 시
function updateReplyCancel(el){
	$(el).parent().parent().parent().html(beforeReplyRow);
}

// 댓글 수정
function updateReply(freeReplyNo, el){
	
	const freeReplyContent = $(el).parent().prev().val();

	$.ajax({
		url: "${contextPath}/freereply/updateReply",
		type: "POST",
		data: {"freeReplyNo": freeReplyNo,
			   "freeReplyContent": freeReplyContent},
			   
		success: function(result){
			
			if(result>0){
				swal({
					icon: "success",
					title: "댓글이 수정되었습니다."
				});
				selectReplyList();
			}
		},
		error: function(e){
			console.log(e);
		}
	});
}

// 댓글 삭제 알림창
function deleteReplyAlert(freeReplyNo){
	
	swal({
		icon: "warning",
		title: "댓글을 삭제하시겠습니까?",
		buttons: ["취소", "삭제"],
		dangerMode: true,
	}).then((willDelete) => {
		if (willDelete) {
			deleteReply(freeReplyNo);
		} 
	});
}

// 댓글 삭제
function deleteReply(freeReplyNo){
	
	$.ajax({
		url: "${contextPath}/freereply/deleteRpely",
		data: {"freeReplyNo": freeReplyNo},
		type: "POST",
		
		success: function(result){
			
			if(result>0){
				selectReplyList();
				replyCount();
				swal({
					icon: "success",
					title: "댓글이 삭제되었습니다."
				});
			}
		},
		error: function(e){
			console.log(e);
		}
	});
}

// 댓글 수 갱신
function replyCount(){
	
	$.ajax({
		url: "replyCount",
		data: {"freeNo": freeNo},
		type: "POST",
		
		success: function(replyCount){
			$("#replyCount").text(replyCount);
		},
		error: function(e){
			console.log(e);
		}
	});
}
</script>
