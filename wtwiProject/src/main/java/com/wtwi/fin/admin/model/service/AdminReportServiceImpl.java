package com.wtwi.fin.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.admin.model.dao.AdminReportDAO;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Search;

@Service
public class AdminReportServiceImpl implements AdminReportService{

	@Autowired
	private AdminReportDAO dao;

	@Override
	public Pagination getReportPagination(Pagination pg) {
		Pagination selectPg = dao.getListCount();
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	@Override
	public List<Report> selectReportBoardList(Pagination pg) {
		// TODO Auto-generated method stub
		return dao.selectReportBoardList(pg);
	}

	@Override
	public Pagination getReportPagination(Search search, Pagination pg) {
		Pagination selectPg = dao.getListCount(search);
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	@Override
	public List<Report> selectSearchReportBoardList(Search search, Pagination pg) {
		// TODO Auto-generated method stub
		return dao.selectReportBoardList(search, pg);
	}

	@Override
	public int changeReportStatus(Report report) {
		// TODO Auto-generated method stub
		return dao.changeReportStatus(report);
	}

	
	
	
	
	
}
