package com.wtwi.fin.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.admin.model.dao.AdminFreeDAO;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.freeboard.model.vo.Search;

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

	// 검색 게시글 수 조회 + 페이지네이션 생성(29-1)
	@Override
	public Pagination getPagination(Search search, Pagination pg) {
		Pagination selectPg = dao.getSearchListCountAll(search);
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 검색 게시글 목록 조회 (29-2)
	@Override
	public List<Board> selectSearchBoardListAll(Search search, Pagination pagination) {
		return dao.selectSearchBoardListAll(search, pagination);
	}

	// 관리자 페이지 게시글 상세조회(30)
	@Override
	public Board selectFreeboard(int freeNo) {
		return dao.selectFreeboard(freeNo);
	}
	
	// 댓글 개수 조회 + 페이지네이션 생성(31-1)
	@Override
	public Pagination getReplyPagination(Pagination pg, int freeNo) {
		Pagination selectPg = dao.getReplyCount(freeNo);
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 댓글 목록 조회(31-2)
	@Override
	public List<Reply> selectReplyListAll(Pagination pagination, int freeNo) {
		return dao.selectReplyListAll(pagination, freeNo);
	}

	// 관리자 페이지 댓글 상태 변경(32)
	@Override
	public int changeFreeReplyStatus(Reply reply) {
		return dao.changeFreeReplyStatus(reply);
	}
	
	
	
}
