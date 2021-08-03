package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wtwi.fin.qnaboard.model.dao.QnaBoardDAO;
import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;

@Service
public class QnaBoardServiceImpl implements QnaBoardService{

	@Autowired
	private QnaBoardDAO dao;

	// 전체 게시글 수 + 게시판 이름 조회
	@Override
	public Pagination getPagination(Pagination pg) {
		
		// 1) 전체 게시글 수 조회
		Pagination selectPg = dao.getListCount();
		return new Pagination(pg.getCurrentPage(),selectPg.getListCount());
	}

	// 전체 게시글 수 + 게시판 이름 조회
	@Override
	public List<QnaBoard> selectBoardList(Pagination pagination) {
		return dao.selectBoardList(pagination);
	}
}
