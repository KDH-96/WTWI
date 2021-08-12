package com.wtwi.fin.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.admin.model.dao.AdminFreeDAO;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;

@Service
public class AdminFreeServiceImpl implements AdminFreeService{

	@Autowired
	private AdminFreeDAO dao;

	// 게시글 수 조회 + 페이지네이션 생성(27-1)
	@Override
	public Pagination getPagination(Pagination pg) {
		Pagination selectPg = dao.getListCountAll();
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 게시글 목록 조회(27-2)
	@Override
	public List<Board> selectBoardListAll(Pagination pagination) {
		return dao.selectBoardListAll(pagination);
	}

	// 게시글 상태 변경(28)
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changeFreeStatus(Board board) {
		return dao.changeFreeStatus(board);
	}
	
	
	
}
