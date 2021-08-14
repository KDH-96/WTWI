package com.wtwi.fin.reportBoard.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.member.model.vo.Report;


@Repository
public class ReportBoardDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int report(Report report) {
		// TODO Auto-generated method stub
		return sqlSession.insert("reportMapper.insertReport", report);
	}
	
	
}
