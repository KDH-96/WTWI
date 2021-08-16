package com.wtwi.fin.attraction.model.vo;

import java.sql.Date;

public class Review {

	private int reviewNo;
	private double reviewPoint;
	private String reviewContent;
	private Date reviewCreateDt;
	private int attractionNo;
	private int memberNo;
	private String memberNick;
	private String reviewStatus;

	public Review() { }

	public Review(int reviewNo, double reviewPoint, String reviewContent, Date reviewCreateDt, int attractionNo,
			int memberNo, String memberNick, String reviewStatus) {
		super();
		this.reviewNo = reviewNo;
		this.reviewPoint = reviewPoint;
		this.reviewContent = reviewContent;
		this.reviewCreateDt = reviewCreateDt;
		this.attractionNo = attractionNo;
		this.memberNo = memberNo;
		this.memberNick = memberNick;
		this.reviewStatus = reviewStatus;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public double getReviewPoint() {
		return reviewPoint;
	}

	public void setReviewPoint(double reviewPoint) {
		this.reviewPoint = reviewPoint;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public Date getReviewCreateDt() {
		return reviewCreateDt;
	}

	public void setReviewCreateDt(Date reviewCreateDt) {
		this.reviewCreateDt = reviewCreateDt;
	}

	public int getAttractionNo() {
		return attractionNo;
	}

	public void setAttractionNo(int attractionNo) {
		this.attractionNo = attractionNo;
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

	public String getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", reviewPoint=" + reviewPoint + ", reviewContent=" + reviewContent
				+ ", reviewCreateDt=" + reviewCreateDt + ", attractionNo=" + attractionNo + ", memberNo=" + memberNo
				+ ", memberNick=" + memberNick + ", reviewStatus=" + reviewStatus + "]";
	}

}