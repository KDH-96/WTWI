package com.wtwi.fin.freeboard.model.vo;

public class Image {
	
	private int fileNo; // 파일번호
	private String fileName; // 파일명
	private String filePath; // 파일경로
	private int freeNo; // 글번호
	
	public Image() {
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getFreeNo() {
		return freeNo;
	}

	public void setFreeNo(int freeNo) {
		this.freeNo = freeNo;
	}

	@Override
	public String toString() {
		return "Image [fileNo=" + fileNo + ", fileName=" + fileName + ", filePath=" + filePath + ", freeNo=" + freeNo
				+ "]";
	}
	
}
