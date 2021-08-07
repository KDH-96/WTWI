package com.wtwi.fin.qnaboard.model.vo;

import java.sql.Timestamp;

public class QnaReply {
	private int qnaReplyNo; 		 		// 문의 댓글 번호
	private String qnaReplyContent; 		// 문의 댓글 내용
	private Timestamp qnaReplyCreateDt;		// 문의 댓글 작성일
	private String qnaReplyStatus;			// 댓글 상태
	private int qnaNo;						// 댓글이 작성된 게시글 번호
	private int memberNo;					// 문의 댓글 작성 회원 번호
	private String memberNick;				// 문의 댓글 작성 회원 이름
	
	public QnaReply() {
	}

	public int getQnaReplyNo() {
		return qnaReplyNo;
	}

	public void setQnaReplyNo(int qnaReplyNo) {
		this.qnaReplyNo = qnaReplyNo;
	}

	public String getQnaReplyContent() {
		return qnaReplyContent;
	}

	public void setQnaReplyContent(String qnaReplyContent) {
		this.qnaReplyContent = qnaReplyContent;
	}

	public Timestamp getQnaReplyCreateDt() {
		return qnaReplyCreateDt;
	}

	public void setQnaReplyCreateDt(Timestamp qnaReplyCreateDt) {
		this.qnaReplyCreateDt = qnaReplyCreateDt;
	}

	public String getQnaReplyStatus() {
		return qnaReplyStatus;
	}

	public void setQnaReplyStatus(String qnaReplyStatus) {
		this.qnaReplyStatus = qnaReplyStatus;
	}

	public int getQnaNo() {
		return qnaNo;
	}

	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}

	@Override
	public String toString() {
		return "QnaReply [qnaReplyNo=" + qnaReplyNo + ", qnaReplyContent=" + qnaReplyContent + ", qnaReplyCreateDt="
				+ qnaReplyCreateDt + ", qnaReplyStatus=" + qnaReplyStatus + ", qnaNo=" + qnaNo + ", memberNo="
				+ memberNo + ", memberNick=" + memberNick + "]";
	}


	
	
}
