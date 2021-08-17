package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.qnaboard.model.dao.QnaBoardDAO;
import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.qnaboard.model.vo.QnaCategory;
import com.wtwi.fin.qnaboard.model.vo.Search;

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

	// 전체 게시글 수 조회 (검색)
	@Override
	public Pagination getPagination(Search search, Pagination pg) {
		
		Pagination selectPg = dao.getSearchListCount(search);
		return new Pagination(pg.getCurrentPage(),selectPg.getListCount());
	}

	// 전체 게시글 수 + 게시판 이름 조회
	@Override
	public List<QnaBoard> selectBoardList(Pagination pagination) {
		return dao.selectBoardList(pagination);
	}

	// 전체 게시글 수 + 게시판 이름 조회(검색)
	@Override
	public List<QnaBoard> selectBoardList(Search search, Pagination pagination) {
		return dao.selectSearchBoardList(search,pagination);
	}

	// 게시글 상세 조회
	@Transactional(rollbackFor = Exception.class)
	@Override
	public QnaBoard selectqnaBoard(int qnaNo) {
		
		QnaBoard qnaBoard = dao.selectBoard(qnaNo);
		
		// 게시글 조회수 증가 update
		if(qnaBoard != null) {
			dao.increaseReadCount(qnaNo);
			qnaBoard.setQnaReadCount(qnaBoard.getQnaReadCount()+1);
		}
		return qnaBoard;
	}

	// 카테고리 조회
	@Override
	public List<QnaCategory> selectCategory() {
		return dao.selectCategory();
	}

	// 게시글 삽입
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoard(QnaBoard board) {
		// 크로스 사이트 방지 + 개행문자 처리
		board.setQnaTitle(replaceParameter(board.getQnaTitle()));
		board.setQnaContent(replaceParameter(board.getQnaContent()));
		board.setQnaContent(board.getQnaContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));

		int boardNo = dao.insertBoard(board);
		
		//System.out.println(board);
		
		return boardNo;
	}
	
	// 게시판 답글 삽입
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertBoardRe(QnaBoard board) {
		// 크로스 사이트 방지 + 개행문자 처리
		board.setQnaTitle(replaceParameter(board.getQnaTitle()));
		board.setQnaContent(replaceParameter(board.getQnaContent()));
		
		board.setQnaContent(board.getQnaContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		int boardNo = dao.insertBoardRe(board);
		
		//System.out.println(board);
		return boardNo;
	}
	
	// 게시글 수정 조회
	@Override
	public QnaBoard selectUpdateBoard(int qnaNo) {
		QnaBoard board = dao.selectBoard(qnaNo);
		
		board.setQnaContent(board.getQnaContent().replaceAll("<br>", "\r\n"));
		
		return board;
	}

	// 게시글 수정
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateBoard(QnaBoard board) {
		
		// 크로스 사이트 방지 + 개행문자 처리
		board.setQnaTitle(replaceParameter(board.getQnaTitle()));
		board.setQnaContent(replaceParameter(board.getQnaContent()));
		
		board.setQnaContent(board.getQnaContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		System.out.println("전 : " + board.getQnaStatus());
		
		if(board.getQnaStatus()==null) {
			board.setQnaStatus("Y");
		}else {
			board.setQnaStatus("S");
		}
		System.out.println("후 : " + board.getQnaStatus());
		
		int result = dao.updateBoard(board);
		
		return result;
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

	// 게시글 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteBoard(int qnaNo) {
		return dao.deleteBoard(qnaNo);
	}

	
	// 게시글 이전 이후 조회 (관리자)
	@Override
	public QnaBoard selectqnaPreBoard(int preNo) {
		
		QnaBoard qnaBoard = dao.selectPreBoard(preNo);
		
		// 게시글 조회수 증가 update
//		if(qnaBoard != null) {
//			dao.increaseReadCount(preNo);
//			qnaBoard.setQnaReadCount(qnaBoard.getQnaReadCount()+1);
//		}
		return qnaBoard;
		
	}

	
	// 게시글 이전 이후 조회 (회원)
	@Override
	public QnaBoard selectqnaPreBoard1(QnaBoard board1) {
		QnaBoard qnaBoard = dao.selectPreBoard1(board1);
		
		// 게시글 조회수 증가 update
//		if(qnaBoard != null) {
//			dao.increaseReadCount(preNo);
//			qnaBoard.setQnaReadCount(qnaBoard.getQnaReadCount()+1);
//		}
		return qnaBoard;
	}

	
	// 게시글 이전 이후 조회(비회원)
	@Override
	public QnaBoard selectqnaPreBoard2(int qnaNo) {
		return dao.selectPreBoard2(qnaNo);
	}

	
	
	
}
