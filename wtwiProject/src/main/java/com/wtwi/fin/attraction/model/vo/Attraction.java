package com.wtwi.fin.attraction.model.vo;

public class Attraction {
	
	private String attractionAddr; // addr1
	private String addr2;
	private int areacode;
	private int booktour;
	private String cat1;
	private String cat2;
	private String cat3;
	private int attractionNo; // contentid
	private int attractionTypeNo; // contenttypeid
	private long createdTime; 
	private String attractionPhoto; // firstimage
	private String attractionPhoto2; // firstimage2
	private String attractionHomePage; // homepage
	private double latitude; // mapx
	private double longitude; // mapy
	private int mLevel;
	private long modifiedTime;
	private String attractionInfo; // overview
	private int readCount; 
	private int sigunguCode;
	private String attractionPhone; // tel
	private String attractionNm; // title
	private int zipCode;

	// 행사
	private int eventStartDate;
	private int eventEndDate;
	
	
	
	
	
	public Attraction() {
		// TODO Auto-generated constructor stub
	}
	
	
	
	
	
	
	public String getAttractionAddr() {
		return attractionAddr;
	}
	public void setAttractionAddr(String attractionAddr) {
		this.attractionAddr = attractionAddr;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public int getAreacode() {
		return areacode;
	}
	public void setAreacode(int areacode) {
		this.areacode = areacode;
	}
	public int getBooktour() {
		return booktour;
	}
	public void setBooktour(int booktour) {
		this.booktour = booktour;
	}
	public String getCat1() {
		return cat1;
	}
	public void setCat1(String cat1) {
		this.cat1 = cat1;
	}
	public String getCat2() {
		return cat2;
	}
	public void setCat2(String cat2) {
		this.cat2 = cat2;
	}
	public String getCat3() {
		return cat3;
	}
	public void setCat3(String cat3) {
		this.cat3 = cat3;
	}
	public int getAttractionNo() {
		return attractionNo;
	}
	public void setAttractionNo(int attractionNo) {
		this.attractionNo = attractionNo;
	}
	public int getAttractionTypeNo() {
		return attractionTypeNo;
	}
	public void setAttractionTypeNo(int attractionTypeNo) {
		this.attractionTypeNo = attractionTypeNo;
	}
	public long getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(long createdTime) {
		this.createdTime = createdTime;
	}
	public String getAttractionPhoto() {
		return attractionPhoto;
	}
	public void setAttractionPhoto(String attractionPhoto) {
		this.attractionPhoto = attractionPhoto;
	}
	public String getAttractionPhoto2() {
		return attractionPhoto2;
	}
	public void setAttractionPhoto2(String attractionPhoto2) {
		this.attractionPhoto2 = attractionPhoto2;
	}
	public String getAttractionHomePage() {
		return attractionHomePage;
	}
	public void setAttractionHomePage(String attractionHomePage) {
		this.attractionHomePage = attractionHomePage;
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
	public int getmLevel() {
		return mLevel;
	}
	public void setmLevel(int mLevel) {
		this.mLevel = mLevel;
	}
	public long getModifiedTime() {
		return modifiedTime;
	}
	public void setModifiedTime(long modifiedTime) {
		this.modifiedTime = modifiedTime;
	}
	public String getAttractionInfo() {
		return attractionInfo;
	}
	public void setAttractionInfo(String attractionInfo) {
		this.attractionInfo = attractionInfo;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getSigunguCode() {
		return sigunguCode;
	}
	public void setSigunguCode(int sigunguCode) {
		this.sigunguCode = sigunguCode;
	}
	public String getAttractionPhone() {
		return attractionPhone;
	}
	public void setAttractionPhone(String attractionPhone) {
		this.attractionPhone = attractionPhone;
	}
	public String getAttractionNm() {
		return attractionNm;
	}
	public void setAttractionNm(String attractionNm) {
		this.attractionNm = attractionNm;
	}
	public int getZipCode() {
		return zipCode;
	}
	public void setZipCode(int zipCode) {
		this.zipCode = zipCode;
	}
	public int getEventStartDate() {
		return eventStartDate;
	}
	public void setEventStartDate(int eventStartDate) {
		this.eventStartDate = eventStartDate;
	}
	public int getEventEndDate() {
		return eventEndDate;
	}
	public void setEventEndDate(int eventEndDate) {
		this.eventEndDate = eventEndDate;
	}






	@Override
	public String toString() {
		return "Attraction [attractionAddr=" + attractionAddr + ", addr2=" + addr2 + ", areacode=" + areacode
				+ ", booktour=" + booktour + ", cat1=" + cat1 + ", cat2=" + cat2 + ", cat3=" + cat3 + ", attractionNo="
				+ attractionNo + ", attractionTypeNo=" + attractionTypeNo + ", createdTime=" + createdTime
				+ ", attractionPhoto=" + attractionPhoto + ", attractionPhoto2=" + attractionPhoto2
				+ ", attractionHomePage=" + attractionHomePage + ", latitude=" + latitude + ", longitude=" + longitude
				+ ", mLevel=" + mLevel + ", modifiedTime=" + modifiedTime + ", attractionInfo=" + attractionInfo
				+ ", readCount=" + readCount + ", sigunguCode=" + sigunguCode + ", attractionPhone=" + attractionPhone
				+ ", attractionNm=" + attractionNm + ", zipCode=" + zipCode + ", eventStartDate=" + eventStartDate
				+ ", eventEndDate=" + eventEndDate + "]";
	} 
	
	
	

	


	

	

	
	
	
}
