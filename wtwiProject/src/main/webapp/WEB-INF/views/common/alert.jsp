<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>alert</title>
<style>
	#alert{
		width: 300px;
		height: 200px;
	}
</style>
</head>
<body>
	<div id="alert">
		<p>문의게시글에 게시글이 입력되었습니다.</p>
	</div>
</body>

<script>
//일정 시간마다 댓글 목록 갱신
 
 const alertInterval = setInteval(function(){

		$.ajax({
			url : "${contextPath}/qnaboard/insertForm",
			type : "POST",
			data : {"qnaNo" : qnaNo,
					
			success : function(result){
			if(result>0){

				
			}
				
			},
			
			error : function(){
				console.log("알림 실패");
			}
		});
 
 }, 1000);

</script>
</html>