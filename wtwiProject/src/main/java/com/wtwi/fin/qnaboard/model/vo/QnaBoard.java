package com.wtwi.fin.qnaboard.model.vo;

import java.sql.Timestamp;

public class QnaBoard {

	private int qnaNo;			// 답글번호
	private int qnaPno;			// 글번호
	private String qnaTitle;	// 글제목
	private String qnaContent;	// 글내용
	private int qnaReadCount;		// 조회수
	private Timestamp qnaCreateDt;	// 작성일
	private Timestamp qnaModifyDt;	// 수정일
	private String qnaStatus;		// 공개여부
	private int qnaCategoryNo;	// 카테고리 코드
	private int memberNo;		// 회원 번호
	
	private String qnaCategoryNm;	// 카테고리 이름
	private String memberNick;		// 회원명
	
	
	public QnaBoard() {}

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

	public int getQnaReadCount() {
		return qnaReadCount;
	}

	public void setQnaReadCount(int qnaReadCount) {
		this.qnaReadCount = qnaReadCount;
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

	public String getQnaStatus() {
		return qnaStatus;
	}

	public void setQnaStatus(String qnaStatus) {
		this.qnaStatus = qnaStatus;
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

	public String getQnaCategoryNm() {
		return qnaCategoryNm;
	}

	public void setQnaCategoryNm(String qnaCategoryNm) {
		this.qnaCategoryNm = qnaCategoryNm;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}

	@Override
	public String toString() {
		return "QnaBoard [qnaNo=" + qnaNo + ", qnaPno=" + qnaPno + ", qnaTitle=" + qnaTitle + ", qnaContent="
				+ qnaContent + ", qnaReadCount=" + qnaReadCount + ", qnaCreateDt=" + qnaCreateDt + ", qnaModifyDt="
				+ qnaModifyDt + ", qnaStatus=" + qnaStatus + ", qnaCategoryNo=" + qnaCategoryNo + ", memberNo="
				+ memberNo + ", qnaCategoryNm=" + qnaCategoryNm + ", memberNick=" + memberNick + "]";
	}


	
}
