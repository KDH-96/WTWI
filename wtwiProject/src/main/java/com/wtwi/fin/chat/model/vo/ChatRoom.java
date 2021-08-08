package com.wtwi.fin.chat.model.vo;

public class ChatRoom {
	
	private int chatRoomNo;
	private int memberNo;
	
	public ChatRoom() {
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
		return "ChatRoom [chatRoomNo=" + chatRoomNo + ", memberNo=" + memberNo + "]";
	}
	
}
