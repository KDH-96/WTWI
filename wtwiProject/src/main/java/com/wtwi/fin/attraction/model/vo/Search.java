package com.wtwi.fin.attraction.model.vo;

public class Search {
	
	private String keyword; // 검색어
	private String areaCode; // 지역코드
	private String contentType; // 명소타입
	
	public Search() {
	}

	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getAreaCode() {
		return areaCode;
	}
	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	@Override
	public String toString() {
		return "Search [keyword=" + keyword + ", areaCode=" + areaCode + ", contentType=" + contentType + "]";
	}

	
	
	
	

}
