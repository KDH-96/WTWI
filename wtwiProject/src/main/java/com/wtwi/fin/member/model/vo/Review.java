package com.wtwi.fin.member.model.vo;

import java.sql.Date;
import java.util.List;

import com.wtwi.fin.attraction.model.vo.ReviewImage;

public class Review {
	private int reviewNo;
	private double reviewPoint;
	private String reviewContent;
	private Date reviewCreateDt;
	private String reviewStatus;
	private int attractionNo;
	private String attractionNm;
	private double latitude;
	private double longitude;
	private int memberNo;
	private List<ReviewImage> atList;
	
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
	public String getReviewStatus() {
		return reviewStatus;
	}
	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
	public int getAttractionNo() {
		return attractionNo;
	}
	public void setAttractionNo(int attractionNo) {
		this.attractionNo = attractionNo;
	}
	public String getAttractionNm() {
		return attractionNm;
	}
	public void setAttractionNm(String attractionNm) {
		this.attractionNm = attractionNm;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
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
				+ ", reviewCreateDt=" + reviewCreateDt + ", reviewStatus=" + reviewStatus + ", attractionNo="
				+ attractionNo + ", attractionNm=" + attractionNm + ", latitude=" + latitude + ", longitude="
				+ longitude + ", memberNo=" + memberNo + ", atList=" + atList + "]";
	}
	
	
}
