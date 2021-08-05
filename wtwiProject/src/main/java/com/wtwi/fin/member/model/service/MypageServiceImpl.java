package com.wtwi.fin.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.member.model.dao.MypageDAO;
import com.wtwi.fin.member.model.vo.Member;

@Service
public class MypageServiceImpl implements MypageService{
	
	@Autowired
	private MypageDAO dao;
	
	// 내가 쓴 글(자유게시판) 전체 게시글 수 + 게시판 이름 조회
	@Override
	public Pagination getFreePagination(Member member, Pagination pg) {

		Pagination selectPg = dao.getFreeListCount(member);
		
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}
	
	// 내가 쓴 글(자유게시판) 게시글 목록 조회
	@Override
	public List<Board> selectFreeBoardList(Pagination pagination) {

		return dao.selectFreeBoardList(pagination);
	}
	
	// 내가 쓴 글(자유게시판) 전체 게시글 수 + 게시판 이름 조회(검색)
	@Override
	public Pagination getFreePagination(Search search, Pagination pg) {
		
		Pagination selectPg = dao.getSearchFreeListCount(search);
		
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	// 내가 쓴 글(자유게시판) 게시글 목록 조회(검색)
	@Override
	public List<Board> selectSearchFreeBoardList(Search search, Pagination pagination) {

		return dao.selectFreeBoardList(search, pagination);
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////
	
	
	// 내가 쓴 글(문의게시판) 전체 게시글 수 + 게시판 이름 조회
	@Override
	public Pagination getQnAPagination(Member member, Pagination pg) {
		
		Pagination selectPg = dao.getQnAListCount(member);
		
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}
	
	// 내가 쓴 글(문의게시판) 게시글 목록 조회(검색)
	@Override
	public List<QnaBoard> selectQnABoardList(Pagination pagination) {
		
		return dao.selectQnABoardList(pagination);
	}
	
	// 내가 쓴 글(문의게시판) 전체 게시글 수 + 게시판 이름 조회(검색)
	@Override
	public Pagination getQnAPagination(Search search, Pagination pg) {
		
		Pagination selectPg = dao.getSearchQnAListCount(search);
		
		return new Pagination(pg.getCurrentPage(), selectPg.getListCount());
	}
	
	// 내가 쓴 글(문의게시판) 게시글 목록 조회(검색)
	@Override
	public List<QnaBoard> selectSearchQnABoardList(Search search, Pagination pagination) {

		return dao.selectQnABoardList(search, pagination);
	}
	
}
