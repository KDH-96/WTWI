package com.wtwi.fin.freeboard.model.vo;

import java.sql.Timestamp;

public class Reply {
	
	private int freeReplyNo;
	private String freeReplyContent;
	private Timestamp freeReplyCreateDate;
	private String freeReplyStatus;
	private int freeNo;
	private int memberNo;
	private int parentReplyNo;
	
	private String memberNick;
	private String parentReplyNick;

	public Reply() {
	}

	public int getFreeReplyNo() {
		return freeReplyNo;
	}

	public void setFreeReplyNo(int freeReplyNo) {
		this.freeReplyNo = freeReplyNo;
	}

	public String getFreeReplyContent() {
		return freeReplyContent;
	}

	public void setFreeReplyContent(String freeReplyContent) {
		this.freeReplyContent = freeReplyContent;
	}

	public Timestamp getFreeReplyCreateDate() {
		return freeReplyCreateDate;
	}

	public void setFreeReplyCreateDate(Timestamp freeReplyCreateDate) {
		this.freeReplyCreateDate = freeReplyCreateDate;
	}

	public String getFreeReplyStatus() {
		return freeReplyStatus;
	}

	public void setFreeReplyStatus(String freeReplyStatus) {
		this.freeReplyStatus = freeReplyStatus;
	}

	public int getFreeNo() {
		return freeNo;
	}

	public void setFreeNo(int freeNo) {
		this.freeNo = freeNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getParentReplyNo() {
		return parentReplyNo;
	}

	public void setParentReplyNo(int parentReplyNo) {
		this.parentReplyNo = parentReplyNo;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}

	public String getParentReplyNick() {
		return parentReplyNick;
	}

	public void setParentReplyNick(String parentReplyNick) {
		this.parentReplyNick = parentReplyNick;
	}

	@Override
	public String toString() {
		return "Reply [freeReplyNo=" + freeReplyNo + ", freeReplyContent=" + freeReplyContent + ", freeReplyCreateDate="
				+ freeReplyCreateDate + ", freeReplyStatus=" + freeReplyStatus + ", freeNo=" + freeNo + ", memberNo="
				+ memberNo + ", parentReplyNo=" + parentReplyNo + ", memberNick=" + memberNick + ", parentReplyNick="
				+ parentReplyNick + "]";
	}
	
}
