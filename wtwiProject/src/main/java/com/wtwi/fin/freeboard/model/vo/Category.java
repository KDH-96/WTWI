package com.wtwi.fin.freeboard.model.vo;

public class Category {
	
	private int freeCategoryNo;
	private String freeCategoryName;
	
	public Category() {
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

	@Override
	public String toString() {
		return "Category [freeCategoryNo=" + freeCategoryNo + ", freeCategoryName=" + freeCategoryName + "]";
	}
	
}
