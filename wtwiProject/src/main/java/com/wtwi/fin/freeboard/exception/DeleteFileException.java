package com.wtwi.fin.freeboard.exception;

// 사용자 정의 예외
public class DeleteFileException extends RuntimeException {

	public DeleteFileException() {
		super("삭제된 이미지 파일을 서버에서 삭제하는 과정에서 문제 발생");
	}
}
