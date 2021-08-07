package com.wtwi.fin.attraction.model.vo;

import java.sql.Date;
import java.util.List;

public class Review {

	private int reviewNo;
	private double reviewPoint;
	private String reviewContent;
	private Date reviewCreateDt;
	private int AttractionNo;
	private int memberNo;
	private List<ReviewImage> atList;
	
	public Review() { }

	public Review(int reviewNo, double reviewPoint, String reviewContent, Date reviewCreateDt, int attractionNo,
			int memberNo, List<ReviewImage> atList) {
		super();
		this.reviewNo = reviewNo;
		this.reviewPoint = reviewPoint;
		this.reviewContent = reviewContent;
		this.reviewCreateDt = reviewCreateDt;
		AttractionNo = attractionNo;
		this.memberNo = memberNo;
		this.atList = atList;
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
		return AttractionNo;
	}

	public void setAttractionNo(int attractionNo) {
		AttractionNo = attractionNo;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	public List<ReviewImage> getAtList() {
		return atList;
	}

	public void setAtList(List<ReviewImage> atList) {
		this.atList = atList;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", reviewPoint=" + reviewPoint + ", reviewContent=" + reviewContent
				+ ", reviewCreateDt=" + reviewCreateDt + ", AttractionNo=" + AttractionNo + ", memberNo=" + memberNo
				+ ", atList=" + atList + "]";
	}
	
}
