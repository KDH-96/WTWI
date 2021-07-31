package com.wtwi.fin.freeboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wtwi.fin.freeboard.model.dao.BoardDAO;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;

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
	
	

}
