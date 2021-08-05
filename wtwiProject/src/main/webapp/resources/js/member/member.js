// 회원 가입 유효성 검사 

// 각 유효성 검사 결과를 저장할 객체
var checkObj = {
	"id": false,
	"pwd1": false,
	"pwd2": false,
	"name": false,
    "phone2": false,
    "smsCheck" : false,
    "phoneNumCheck" : false,
    "email": false, 
};


// 아이디가 입력될 때마다 유효성 검사
// 조건 : 영어, 숫자 6~12글자 

$("#id").on("input", function(){
    
    // 아이디가 입력되는 경우 hidden 타입 태그의 값을 false로 변경
    // $("#idDup").val(false); -> 모달창 띄울 때 필요한 코드 근데 이제 안 띄우고 바로 중복검사 할
    
    // 정규 표현식 객체 생성
    const regExp = /^[a-zA-Z0-9]{6,12}$/;

    // 입력된 아이디(양쪽 공백 제거)를 얻어와 inputId 변수에 저장
    const inputId = $("#id").val().trim();

    // input 태그에 입력된 값이 정규식을 만족한f다면
    // == 정규식 조건에 맞게 문자열이 작성 되었다면
    if(   regExp.test(inputId)   ){

        // Ajax를 이용하여 비동기적으로 아이디 중복 검사를 진행

        // jQuery를 이용한 Ajax
        $.ajax({
            url : "idDupCheck",  // 요청 주소(필수로 작성!)
            data : {"id" : inputId,}, // 전달하려는 값(파라미터)
            type : "post", // 데이터 전달 방식
            success : function(result){
                // 매개변수 result : 뭔가 일을 하고 난 후 서버에서 비동기로 전달 받은 응답 데이터
                console.log(result);

                if(result > 0) { // 아이디가 중복되는 경우

                    $("#checkId").text("이미 사용중인 아이디 입니다.").css("color", "orange");
                    checkObj.id = false;
                } else { // 아이디가 중복되지 않는 경우
                    $("#checkId").text("사용가능한 아이디 입니다.").css("color", "green");
                    checkObj.id = true;

                }
            },// 비동기 통신 성공 시 동작 
            error: function(e){
                // 매개변수 e : 예외 발생 시 Exception 객체를 전달 받을 변수
                console.log("ajax 통신 실패");
                console.log(e);
            } // 비동기 통신 실패 시 동작
        })
    }else{
        
        $("#checkId").text("영어, 숫자 6~12글자로 작성해주세요.").css("color", "red");
        checkObj.id = false;
    }

});

// 닉네임 유효성 검사
// 조건 : 한글 두 글자 이상 5글자 이하 ->  /^[가-힣]{2,5}$/;
$("#nickName").on("input", function(){

    const regExp = /^[a-zA-Z0-9가-힣]{3,10}$/;

    const inputName = $(this).val().trim();

    if(   regExp.test(inputName)   ){

        $("#checkNickName").text("가입 가능한 닉네임입니다.").css("color", "green");
        checkObj.name = true;
    }else{
        
        $("#checkNickName").text("세 글자 이상 5글자 이하 이름을 입력해주세요.").css("color", "red");
        checkObj.name = false;
    }

});

// 이메일 유효성 검사
// 조건 : 아이디 4글자 이상, 이메일 형식  ->   /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/;
$("#email").on("input", function() {

    const regExp = /^[\w]{4,}@[\w]+(\.[\w]+){1,3}$/;

    const inputEmail = $(this).val().trim();

    if(regExp.test(inputEmail)){

        $("#checkEmail").text("가입 가능한 이메일입니다.").css("color", "green");
        checkObj.email = true;
    } else {

        $("#checkEmail").text("아이디 4글자 이상의 이메일 형식으로 입력해주세요.").css("color", "red");
        checkObj.email = false;
    }
});

// 비밀번호 유효성 검사
$("#pwd1").on("input", function() {
    const regExp = /^[a-zA-Z\d\_\#\-]{8,20}$/;
    const inputPwd1 = $(this).val().trim();
    if(regExp.test(inputPwd1)){
        $("#checkPwd1").text("유효한 비밀번호 형식입니다.").css("color", "green");
        checkObj.pwd1 = true;
    } else {
        $("#checkPwd1").text("유효한 비밀번호 형식에 맞게 작성해주세요.").css("color", "red");
        checkObj.pwd1 = false;
    }
})

// 비밀번호, 비밀번호 확인 일치 여부 판단 
$("#pwd1, #pwd2").on("input", function() {
    const pwd1 = $("#pwd1").val();
    const pwd2 = $("#pwd2").val();
    
    if(pwd1.trim() == "" && pwd2.trim() == "") {
        $("#checkPwd1").html("&nbsp;");
        $("#checkPwd2").html("&nbsp;");
        checkObj.pwd2 = false;
    } else if(pwd1 == pwd2){
    
         $("#checkPwd2").text("비밀번호 일치").css("color", "green");
        checkObj.pwd2 = true;
    } else{
         $("#checkPwd2").text("비밀번호 불일치").css("color", "red");
         checkObj.pwd2 = false;
    }


})


// 전화번호 유효성 검사
// 이건 제이쿼리라 .phone 클래스 있는 애들을 다 적용시키지만 
// 자바스크립트라면 배열 형태로 넘어와버림
$(".phone").on("input", function() {

    // 전화번호 input 태그에 4글자 초과 입력하지 못하게 하는 이벤트
    // type="number"는 maxlength 가 적용이 안되기 때문에!!!
	if ($(this).val().length > 4) {
		$(this).val( $(this).val().slice(0, 4));
	}

    const regExp1 = /^\d{3,4}$/; 
    const regExp2 = /^\d{4}$/;

    const ph2 = $("#phone2").val();
    const ph3 = $("#phone3").val();

    if(regExp1.test(ph2) && regExp2.test(ph3)){
        $("#checkPhone").text("유효한 전화번호 형식입니다.").css("color", "green");
        checkObj.phone2 = true;

    }else {
        $("#checkPhone").text("유효하지 않은 전화번호 형식입니다.").css("color", "red");
        checkObj.phone2 = false;
    }
})

// 회원가입 버튼 클릭 시 전체 유효성 검사 여부 확인
function validate() {
    var memberPhone1 = $("[name='memberPhone1']").val();
     // 나눠져 있는 phone과 address를 합치기
    // form 태그 내부 제일 마지막에 type="hidden"으로 추가하기
    var phone = $("[name='phone']"); // name 속성값이 phone인 요소를 모두 얻어와 배열로 저장
    // 요소에 저장된 value만 얻어와 합치기
    var memberPhone = $(phone[0]).val() + "-" + $(phone[1]).val() + "-" + $(phone[2]).val();
    
    // form 태그에 type="hidden"으로 추가
    if(memberPhone1 == memberPhone){
        checkObj.phoneNumCheck = true;
       
    } else {
        checkObj.phoneNumCheck = false;
    }

    // 객체 내 속성을 순차접근하는 반복문 : for in 구문
    for(const key in checkObj){
        if(!checkObj[key]){
            let msg;
			switch (key) {
			case "id":
				msg = "아이디가 유효하지 않습니다.";
				break;
			case "pwd1":
				msg = "비밀번호가 유효하지 않습니다.";
				break;
			case "pwd2":
				msg = "비밀번호가 일치하지 않습니다. ";
				break;
			case "name":
				msg = "닉네임이 유효하지 않습니다.";
				break;
			case "phone2":
				msg = "전화번호가 유효하지 않습니다. ";
                break;
            case "smsCheck":
                msg = "핸드폰 번호 인증을 진행해주세요. ";
                break;
             case "phoneNumCheck":
                msg = "핸드폰 번호 인증에 사용한 번호를 입력해주세요. ";
                break;
			case "email":
				msg = "이메일이 유효하지 않습니다.";
				break;
            }
            
            // msg에 담긴 내용 출력 
            swal(msg).then(function() {
                const selector = "#" + key; 

                $(selector).focus();
                //유효하지 않은 값을 입력한 부분으로 포커스 이동


            });

            return false; // submit 이벤트 제거(회원가입 실행 x)

        }


    } // for문 끝

    var inputPhone = $("<input>", {type:"hidden", name:"memberPhone", value:memberPhone1})
        
    // append() : 선택된 요소의 마지막 자식으로 추가
    $("form[name='signUpForm']").append(inputPhone);
   
    
}