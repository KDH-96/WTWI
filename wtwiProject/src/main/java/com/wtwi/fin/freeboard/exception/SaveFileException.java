package com.wtwi.fin.freeboard.exception;

// 사용자 정의 예외
public class SaveFileException extends RuntimeException {

	public SaveFileException() {
		super("업로드된 이미지 파일을 서버에 저장하는 과정에서 문제 발생");
	}
}
