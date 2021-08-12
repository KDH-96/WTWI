package com.wtwi.fin.freeboard.model.vo;

import java.sql.Timestamp;
import java.util.List;

public class Board {
	
	private int freeNo;				  // 글번호
	private String freeTitle;		  // 글제목
	private String freeContent;		  // 글내용
	private int freeReadCount;		  // 조회수
	private Timestamp freeCreateDate; // 작성일
	private Timestamp freeModifyDate; // 수정일
	private int memberNo;			  // 작성자(회원번호)
	private int freeCategoryNo;		  // 카테고리 번호
	
	private String freeCategoryName;  // 카테고리 이름
	private String memberNick;		  // 회원닉네임
	private int replyCount; 		  // 댓글수
	private int likeCount; 			  // 좋아요수
	
	private List<Image> images; 	  // 첨부 이미지 목록
	
	private String freeStatus;
	
	public Board() {
	}

	public int getFreeNo() {
		return freeNo;
	}

	public void setFreeNo(int freeNo) {
		this.freeNo = freeNo;
	}

	public String getFreeTitle() {
		return freeTitle;
	}

	public void setFreeTitle(String freeTitle) {
		this.freeTitle = freeTitle;
	}

	public String getFreeContent() {
		return freeContent;
	}

	public void setFreeContent(String freeContent) {
		this.freeContent = freeContent;
	}

	public int getFreeReadCount() {
		return freeReadCount;
	}

	public void setFreeReadCount(int freeReadCount) {
		this.freeReadCount = freeReadCount;
	}

	public Timestamp getFreeCreateDate() {
		return freeCreateDate;
	}

	public void setFreeCreateDate(Timestamp freeCreateDate) {
		this.freeCreateDate = freeCreateDate;
	}

	public Timestamp getFreeModifyDate() {
		return freeModifyDate;
	}

	public void setFreeModifyDate(Timestamp freeModifyDate) {
		this.freeModifyDate = freeModifyDate;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public int getFreeCategoryNo() {
		return freeCategoryNo;
	}

	public void setFreeCategoryNo(int freeCategoryNo) {
		this.freeCategoryNo = freeCategoryNo;
	}

	public String getFreeCategoryName() {
		return freeCategoryName;
	}

	public void setFreeCategoryName(String freeCategoryName) {
		this.freeCategoryName = freeCategoryName;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public List<Image> getImages() {
		return images;
	}

	public void setImages(List<Image> images) {
		this.images = images;
	}

	public String getFreeStatus() {
		return freeStatus;
	}

	public void setFreeStatus(String freeStatus) {
		this.freeStatus = freeStatus;
	}

	@Override
	public String toString() {
		return "Board [freeNo=" + freeNo + ", freeTitle=" + freeTitle + ", freeContent=" + freeContent
				+ ", freeReadCount=" + freeReadCount + ", freeCreateDate=" + freeCreateDate + ", freeModifyDate="
				+ freeModifyDate + ", memberNo=" + memberNo + ", freeCategoryNo=" + freeCategoryNo
				+ ", freeCategoryName=" + freeCategoryName + ", memberNick=" + memberNick + ", replyCount=" + replyCount
				+ ", likeCount=" + likeCount + ", images=" + images + ", freeStatus=" + freeStatus + "]";
	}

}
