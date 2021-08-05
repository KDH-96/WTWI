package com.wtwi.fin.member.model.vo;

public class Search {
	
	private String sc; 
	private String sk; 
	private String sv; 
	private int memberNo;
	
	public Search() {}

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
	
	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "Search [sc=" + sc + ", sk=" + sk + ", sv=" + sv + ", memberNo=" + memberNo + "]";
	}

	
}
