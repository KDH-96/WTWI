package com.wtwi.fin.qnaboard.model.vo;

import java.sql.Timestamp;

public class Board {

	private int qnaNo;			// 답글번호
	private int qnaPno;			// 글번호
	private String qnaTitle;	// 글제목
	private String qnaContent;	// 글내용
	private int readCount;		// 조회수
	private Timestamp qnaCreateDt;	// 작성일
	private Timestamp qnaModifyDt;	// 수정일
	private int qnaCategoryNo;	// 카테고리 코드
	private int memberNo;		// 회원 번호
	
	public Board() {}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public int getQnaPno() {
		return qnaPno;
	}

	public void setQnaPno(int qnaPno) {
		this.qnaPno = qnaPno;
	}

	public String getQnaTitle() {
		return qnaTitle;
	}

	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public Timestamp getQnaCreateDt() {
		return qnaCreateDt;
	}

	public void setQnaCreateDt(Timestamp qnaCreateDt) {
		this.qnaCreateDt = qnaCreateDt;
	}

	public Timestamp getQnaModifyDt() {
		return qnaModifyDt;
	}

	public void setQnaModifyDt(Timestamp qnaModifyDt) {
		this.qnaModifyDt = qnaModifyDt;
	}

	public int getQnaCategoryNo() {
		return qnaCategoryNo;
	}

	public void setQnaCategoryNo(int qnaCategoryNo) {
		this.qnaCategoryNo = qnaCategoryNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "Board [qnaNo=" + qnaNo + ", qnaPno=" + qnaPno + ", qnaTitle=" + qnaTitle + ", qnaContent=" + qnaContent
				+ ", readCount=" + readCount + ", qnaCreateDt=" + qnaCreateDt + ", qnaModifyDt=" + qnaModifyDt
				+ ", qnaCategoryNo=" + qnaCategoryNo + ", memberNo=" + memberNo + "]";
	}
	
	
	
}
