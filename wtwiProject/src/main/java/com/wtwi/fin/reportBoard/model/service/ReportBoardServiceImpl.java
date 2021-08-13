package com.wtwi.fin.reportBoard.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.reportBoard.model.dao.ReportBoardDAO;


@Service
public class ReportBoardServiceImpl implements ReportBoardService{
	@Autowired
	private ReportBoardDAO dao;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int report(Report report) {
		report.setReportTitle(replaceParameter(report.getReportTitle()));
		report.setReportContent(replaceParameter(report.getReportContent()));
		return dao.report(report);
	}
	
	// 크로스 사이트 스크립트 방지 처리 메소드
	public static String replaceParameter(String param) {
		String result = param;
		if (param != null) {
			result = result.replaceAll("&", "&amp;");
			result = result.replaceAll("<", "&lt;");
			result = result.replaceAll(">", "&gt;");
			result = result.replaceAll("\"", "&quot;");
		}

		return result;
	}
	
}
