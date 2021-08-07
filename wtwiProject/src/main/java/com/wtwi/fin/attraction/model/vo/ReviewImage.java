package com.wtwi.fin.attraction.model.vo;

public class ReviewImage {
	
	private int fileNo;
	private String fileNm;
	private String filePath;
	private int reviewNo;
	
	public ReviewImage() { }

	public ReviewImage(int fileNo, String fileNm, String filePath, int reviewNo) {
		super();
		this.fileNo = fileNo;
		this.fileNm = fileNm;
		this.filePath = filePath;
		this.reviewNo = reviewNo;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	@Override
	public String toString() {
		return "ReviewImage [fileNo=" + fileNo + ", fileNm=" + fileNm + ", filePath=" + filePath + ", reviewNo="
				+ reviewNo + "]";
	}
	
}
