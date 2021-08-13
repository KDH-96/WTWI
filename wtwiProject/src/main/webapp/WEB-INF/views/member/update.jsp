<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 배포된 웹 애플리케이션의 최상위 주소를 간단히 얻어올 수 있도록 
     application 범위로 변수를 하나 생성 --%>
<c:set var="contextPath" scope="application"
	   value="${pageContext.servletContext.contextPath}" />
	   
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>내 정보 수정</title>
    <style>
        .myPage-body {
            display: flex;
            align-items: center;
            height: 100vh;
        }
        .myPage-main {
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .myPage-main h2{
            margin-bottom: 30px;
            text-align: center;
        }
        .update-form {
            width: 70%;
            justify-content: center;
        }
        .update-form form{
            width: 50%;
        }

        .update-input {
            display: flex;
        }
        .update-input div:first-child{
            padding-left: 0;
        }
        .update-phoneArea {
            display: flex;
            flex-direction: column;
        }
        .update-phoneArea div:first-child{
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .update-phoneArea select {
            width: 33.3%;
        }
        .update-phoneArea input {
            width: 33.3%;
            margin-left: 2px;
        }
        .update-phoneArea div:last-child button{
            width: 100%;
            margin-top: 5px;
        }
        .update-btnArea {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .update-btnArea button{
            width: 45%;
            margin: 0px 3px;
        }

        .check-button  {
            width: 100%;
        }

        #id, #name, #email {
            width: 100%;
        }
        
        .update_span {
        	display: flex;
        	justify-content: center;
        }
    </style>
</head>


<body class="myPage-body">

	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/myPage/sideBar.jsp"></jsp:include>
	<c:set var="phone" value="${fn:split(loginMember.memberPhone, '-') }"/>
    <main class="myPage-main">
        <h2>내 정보 수정</h2>
        <div class="row update-form " >
        		
				<c:choose>
					<c:when test="${loginMember.memberGrade == 'B' }">
				        <form method="POST" action="updateAction" class="needs-validation" name="updateForm" onsubmit="return memberUpdateValidate();">     
					</c:when>
					<c:otherwise>
				        <form method="POST" action="updateAction" class="needs-validation" name="updateForm" onsubmit="return socialUpdateValidate();">     
					</c:otherwise>
				</c:choose>
	



                    <div class="row mb-3 form-row">
                        <div class="col-md-3">
                            <label for="id">* 닉네임</label>
                        </div>
                        <div class="col-md-9">
                            <input type="text" class="form-control" name="inputNickname" id="nickName" placeholder="닉네임을 입력하세요" autocomplete="off" required value="${loginMember.memberNick }">
                        </div>
                    </div>
    				
    				<c:if test="${loginMember.memberGrade == 'B'}">
	                    <!-- 이메일 -->
	                    <div class="row mb-3 form-row">
	                        <div class="col-md-3">
	                            <label for="email">* Email</label>
	                        </div>
	                        <div class="col-md-9">
	                            <input type="email" class="form-control" id="email" name="inputEmail" autocomplete="off" required value="${loginMember.memberEmail }">
	                        </div>
	                    </div>
	    
	                    <!-- 전화번호 -->
	                    <div class="update-input form-group">
	                        <div class="col-md-3">
								<label for="phone1">* 전화번호</label>
							</div>
	                        <div class="update-phoneArea">
	                            <div>
	                                <select class="custom-select" id="phone1" name="phone" required>
	                                    <option>010</option>
	                                    <option>011</option>
	                                    <option>016</option>
	                                    <option>017</option>
	                                    <option>019</option>
	                                </select>
	                                <input type="number" class="form-control phone" id="phone2" name="phone" value="${phone[1]}">
	                                <input type="number" class="form-control phone" id="phone3" name="phone" value="${phone[2]}">
	                            </div>
	                        </div>
	                    </div>
	                    <div class="update_span">
		                    <span> ※ 핸드폰 번호는 비밀번호 찾기에 사용되니 신중히 기입해주세요</span>
	                    </div>
    				</c:if>

	    
	    
	                    <hr class="mb-4">
	                    <div class="update-btnArea">
	                        <button class="btn btn-dark btn-md " type="submit">내 정보 수정</button>
	                    </div>
                </form>
            
        </div>
    </main>
    <script>
		
		// (function(){})();
		// 즉시 실행 함수 : 함수가 정의 되자마자 실행되는 함수.
		// 변수명 중복 해결 + 속도적 측면에서 우위를 가짐.
		
		// 전화번호 첫 번째 자리 지정하기
		(function(){
			// 전화번호 앞자리가 적힌 option 요소를 배열로 얻어옴
			// each(function(index,item){} : 배열을 반복 접근하는 jQuery 메소드
			// index : 현재 접근한 인덱스 번호
			// item : 현재 접근한 요소
			$("#phone1 > option").each(function(index, item){
				console.log($(item).text());
				//=> 010~019 까지 하나씩 쭉~ 나옴
				
				// 요소에 작성된 내용이 phone[0]의 값과 같다면 
				if($(item).text() == "${phone[0]}"){
					
					// 현재 요소에 selected 속성을 추가
					$(item).prop("selected", true);
				}
			});
			
		})();
			
			
			
		// 회원정보 수정 시 유효성 검사
		function memberUpdateValidate(){
			
			const regExp1 = /^\d{3,4}$/; 
		    const regExp2 = /^\d{4}$/;

		    const ph2 = $("#phone2").val();
		    const ph3 = $("#phone3").val();

		    if(!regExp1.test(ph2) || !regExp2.test(ph3)){
				swal({"icon" : "warning", 
					  "title" : "전화번호가 유효하지 않습니다.",
					  "text" : "중간 자리는 3~4, 마지막 자리는 4글자"});
				
				return false;
		    }
		    
		    const regExp3 = /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/;
		    const inputEmail = $("#email").val().trim();

		    if(!regExp3.test(inputEmail)){

				swal({"icon" : "warning", 
					  "title" : "이메일이 유효하지 않습니다.",
					  "text" : "아이디 4글자 이상의 이메일 형식으로 작성해주세요"});
		  		return false;
		    }
		    
		    const regExp4 = /^[a-zA-Z0-9가-힣]{3,10}$/;
		    const inputNick = $("#nickName").val().trim();
		    if(!regExp4.test(inputNick)){

				swal({"icon" : "warning", 
					  "title" : "닉네임이 유효하지 않습니다.",
					  "text" : "세 글자 이상 5글자 이하 이름을 입력해주세요."});
		  		return false;
		    }
		    
		    const phone = $("[name='phone']");
	
	
			// 입력된 전화번호, 주소 조합하여 form태그에 hidden으로 추가 하기
			// 왜? -> 파라미터를 한번에 받기 쉽게 하기 위하여
			const memberPhone = $("<input>", {
				type: "hidden", name: "inputPhone",
				value: $(phone[0]).val() + "-" + $(phone[1]).val() + "-" + $(phone[2]).val()
			});
	

	
			$("form[name='updateForm']").append(memberPhone);

		}
		
		
		
		function socialUpdateValidate(){
			 const regExp4 = /^[a-zA-Z0-9가-힣]{3,10}$/;
			    const inputNick = $("#nickName").val().trim();
			    if(!regExp4.test(inputNick)){

					swal({"icon" : "warning", 
						  "title" : "닉네임이 유효하지 않습니다.",
						  "text" : "세 글자 이상 5글자 이하 이름을 입력해주세요."});
			  		return false;
			    }
		}
	</script>
</body>
</html>