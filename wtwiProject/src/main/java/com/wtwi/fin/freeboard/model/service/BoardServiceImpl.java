package com.wtwi.fin.freeboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.freeboard.model.dao.BoardDAO;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Search;

/**
 * @author 세은
 */
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO dao;

	// 전체 게시글 수 조회(1)
	@Override
	public Pagination getPaganation(Pagination pg) {
		
		Pagination selectPg = dao.getListCount(); // 전체 게시글 수 조회
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount()); // 페이지네이션 객체 생성 후 반환
	}

	// 게시글 목록 조회(2)
	@Override
	public List<Board> selectBoardList(Pagination pagination) {
		return dao.selectBoardList(pagination);
	}

	// 게시글 상세 조회(3)
	@Transactional(rollbackFor=Exception.class)
	@Override
	public Board selectBoard(int freeNo) {
		
		// 3-1) 게시글 상세 조회
		Board board = dao.selectBoard(freeNo);
		
		// 3-2) 게시글 상세 조회 성공 후 조회수 1 증가
		if(board!=null) {
			dao.increaseReadCount(freeNo);
			board.setFreeReadCount(board.getFreeReadCount()+1);
		}
		return board;
	}

	// 카테고리 목록 조회(4)
	@Override
	public List<Category> selectCategory() {
		return dao.selectCategory();
	}

	// 검색 게시글 수 조회(5)
	@Override
	public Pagination getPaganation(Search search, Pagination pg) {
		
		Pagination selectPg = dao.getSearchListCount(search);
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 검색 게시글 목록 조회(6)
	@Override
	public List<Board> selectBoardList(Search search, Pagination pagination) {
		return dao.selectSearchBoardList(search, pagination);
	}
	
	

}
