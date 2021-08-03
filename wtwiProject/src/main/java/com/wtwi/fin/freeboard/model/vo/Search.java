package com.wtwi.fin.freeboard.model.vo;

public class Search {
	
	private String sk; // 검색 조건
	private String sc; // 검색 카테고리
	private String sv; // 검색 값
	
	public Search() {
	}

	public String getSk() {
		return sk;
	}

	public void setSk(String sk) {
		this.sk = sk;
	}

	public String getSc() {
		return sc;
	}

	public void setSc(String sc) {
		this.sc = sc;
	}

	public String getSv() {
		return sv;
	}

	public void setSv(String sv) {
		this.sv = sv;
	}

	@Override
	public String toString() {
		return "Search [sk=" + sk + ", sc=" + sc + ", sv=" + sv + "]";
	}
	
}
