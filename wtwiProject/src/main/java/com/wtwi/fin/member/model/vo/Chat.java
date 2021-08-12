package com.wtwi.fin.member.model.vo;

import java.sql.Timestamp;

public class Chat {
	private int chatNo;
	private String chatContent;
	private Timestamp chatCreateDt; 
	private String chatReadYn;
	private int chatRoomNo;
	private int memberNo;
	private String memberNick;
	private String attractionNm;
	
	
	
	public String getMemberNick() {
		return memberNick;
	}
	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public Timestamp getChatCreateDt() {
		return chatCreateDt;
	}
	public void setChatCreateDt(Timestamp chatCreateDt) {
		this.chatCreateDt = chatCreateDt;
	}
	public String getChatReadYn() {
		return chatReadYn;
	}
	public void setChatReadYn(String chatReadYn) {
		this.chatReadYn = chatReadYn;
	}
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public String getAttractionNm() {
		return attractionNm;
	}
	public void setAttractionNm(String attractionNm) {
		this.attractionNm = attractionNm;
	}
	@Override
	public String toString() {
		return "Chat [chatNo=" + chatNo + ", chatContent=" + chatContent + ", chatCreateDt=" + chatCreateDt
				+ ", chatReadYn=" + chatReadYn + ", chatRoomNo=" + chatRoomNo + ", memberNo=" + memberNo
				+ ", memberNick=" + memberNick + ", attractionNm=" + attractionNm + "]";
	}
	
	
	
}
