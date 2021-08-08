package com.wtwi.fin.member.model.vo;

import java.sql.Timestamp;

public class Report {
	private int reportNo;
	private String reportTitle;
	private String reportContent;
	private Timestamp reportCreateDt;
	private String reportStatus;
	private int reportType;
	private int reportTypeNo;
	private int memberNo;
	private int reportCategoryNo;
	private String reportCategoryNm;
	
	
	public String getReportCategoryNm() {
		return reportCategoryNm;
	}
	public void setReportCategoryNm(String reportCategoryNm) {
		this.reportCategoryNm = reportCategoryNm;
	}
	public int getReportNo() {
		return reportNo;
	}
	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}
	public String getReportTitle() {
		return reportTitle;
	}
	public void setReportTitle(String reportTitle) {
		this.reportTitle = reportTitle;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public Timestamp getReportCreateDt() {
		return reportCreateDt;
	}
	public void setReportCreateDt(Timestamp reportCreateDt) {
		this.reportCreateDt = reportCreateDt;
	}
	public String getReportStatus() {
		return reportStatus;
	}
	public void setReportStatus(String reportStatus) {
		this.reportStatus = reportStatus;
	}
	public int getReportType() {
		return reportType;
	}
	public void setReportType(int reportType) {
		this.reportType = reportType;
	}
	public int getReportTypeNo() {
		return reportTypeNo;
	}
	public void setReportTypeNo(int reportTypeNo) {
		this.reportTypeNo = reportTypeNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getReportCategoryNo() {
		return reportCategoryNo;
	}
	public void setReportCategoryNo(int reportCategoryNo) {
		this.reportCategoryNo = reportCategoryNo;
	}
	@Override
	public String toString() {
		return "Report [reportNo=" + reportNo + ", reportTitle=" + reportTitle + ", reportContent=" + reportContent
				+ ", reportCreateDt=" + reportCreateDt + ", reportStatus=" + reportStatus + ", reportType=" + reportType
				+ ", reportTypeNo=" + reportTypeNo + ", memberNo=" + memberNo + ", reportCategoryNo=" + reportCategoryNo
				+ ", reportCategoryNm=" + reportCategoryNm + "]";
	}
	
	
	
}
