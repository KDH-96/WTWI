function fnRequest(addr){
	document.requestForm.action = addr;
	document.requestForm.submit();
}

// 삭제시 알림창 띄우기
function deleteAlert(){
	swal({
		icon: "warning",
		title: "게시글을 삭제하시겠습니까?",
		buttons: ["취소", "삭제"],
		dangerMode: true,
	}).then((willDelete) => {
		if (willDelete) {
			onclick=fnRequest("delete");
		} 
	});
}