package com.wtwi.fin.chat.model.vo;

import java.sql.Timestamp;

public class ChatMessage {
	
	private int chatNo;
	private String chatContent;
	private Timestamp chatCreateDate;
	private String chatReadYn;
	private int chatRoomNo;
	private int memberNo;
	
	public ChatMessage() {
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

	public Timestamp getChatCreateDate() {
		return chatCreateDate;
	}

	public void setChatCreateDate(Timestamp chatCreateDate) {
		this.chatCreateDate = chatCreateDate;
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

	@Override
	public String toString() {
		return "ChatMessage [chatNo=" + chatNo + ", chatContent=" + chatContent + ", chatCreateDate=" + chatCreateDate
				+ ", chatReadYn=" + chatReadYn + ", chatRoomNo=" + chatRoomNo + ", memberNo=" + memberNo + "]";
	}
	
}
