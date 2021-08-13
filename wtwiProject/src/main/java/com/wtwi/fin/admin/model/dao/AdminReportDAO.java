package com.wtwi.fin.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Search;

@Repository
public class AdminReportDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 신고 목록 수 조회
	public Pagination getListCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("reportMapper.getListCount");
	}
	
	// 신고 목록 조회
	public List<Report> selectReportBoardList(Pagination pg) {
		int offset = (pg.getCurrentPage()-1)*pg.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pg.getLimit());
		return sqlSession.selectList("reportMapper.selectBoardList", 0, rowBounds);
	}

	// 신고 목록 수 조회(검색)
	public Pagination getListCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("reportMapper.getSearchListCount", search);
	}
	
	// 신고 목록 수 조회(검색)
	public List<Report> selectReportBoardList(Search search, Pagination pg) {
		int offset = (pg.getCurrentPage()-1)*pg.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pg.getLimit());
		return sqlSession.selectList("reportMapper.selectSearchBoardList", search, rowBounds);
	}
	
	// 신고 상태 변경
	public int changeReportStatus(Report report) {
		// TODO Auto-generated method stub
		return sqlSession.update("reportMapper.changeStatus", report);
	}

}
