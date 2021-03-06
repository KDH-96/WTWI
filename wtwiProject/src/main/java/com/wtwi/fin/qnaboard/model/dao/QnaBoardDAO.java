package com.wtwi.fin.qnaboard.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.qnaboard.model.vo.QnaCategory;
import com.wtwi.fin.qnaboard.model.vo.Search;

@Repository
public class QnaBoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 특정 게시판 전체 게시글 수 조회
	 * @return pagination
	 */
	public Pagination getListCount() {
		return sqlSession.selectOne("qnaboardMapper.getListCount");
	}

	/** 특정 게시판 전체 게시글 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchListCount(Search search) {
		return sqlSession.selectOne("qnaboardMapper.getSearchListCount", search);
	}
	
	
	/** 문의 게시글 목록 조회
	 * @param pagination
	 * @return boardList
	 */
	public List<QnaBoard> selectBoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("qnaboardMapper.selectBoardList", 1, rowBounds);
	}

	/** 문의 게시글 목록 조회 (검색)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	public List<QnaBoard> selectSearchBoardList(Search search, Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("qnaboardMapper.selectSearchBoardList", search, rowBounds);
	}

	/** 게시글 상세 조회
	 * @param qnaNo
	 * @return qnaBoard
	 */
	public QnaBoard selectBoard(int qnaNo) {
		return sqlSession.selectOne("qnaboardMapper.selectBoard", qnaNo);
	}

	/** 게시글 조회수 증가
	 * @param qnaNo
	 * @return
	 */
	public int increaseReadCount(int qnaNo) {
		return sqlSession.update("qnaboardMapper.increaseReadCount", qnaNo);
	}

	/** 카테고리 조회
	 * @return category
	 */
	public List<QnaCategory> selectCategory() {
		return sqlSession.selectList("qnaboardMapper.selectCategory");
	}

	/** 게시글 작성
	 * @param board
	 * @return
	 */
	public int insertBoard(QnaBoard board) {
		int result = sqlSession.insert("qnaboardMapper.insertBoard", board);
		if(result>0)return board.getQnaNo();
		else		return 0;
	}

	
	/** 게시글 답글 작성
	 * @param board
	 * @return
	 */
	public int insertBoardRe(QnaBoard board) {
		int result = sqlSession.insert("qnaboardMapper.insertBoardRe", board);
		if(result>0) return board.getQnaNo();
		else		return 0;
	}

	/** 게시글 수정
	 * @param board
	 * @return
	 */
	public int updateBoard(QnaBoard board) {
		return sqlSession.update("qnaboardMapper.updateBoard",board);
	}

	/** 게시글 삭제
	 * @param qnaNo
	 * @return
	 */
	public int deleteBoard(int qnaNo) {
		return sqlSession.update("qnaboardMapper.deleteBoard", qnaNo);
	}
	
	
	/** 게시글 이전 이후(관리자)
	 * @param preNo
	 * @return
	 */
	public QnaBoard selectPreBoard(int preNo) {
	   return sqlSession.selectOne("qnaboardMapper.selectPreBoard", preNo);
	}

	
	
	/** 게시글 이전 이후(회원)
	 * @param board1
	 * @return
	 */
	public QnaBoard selectPreBoard1(QnaBoard board1) {
	   return sqlSession.selectOne("qnaboardMapper.selectPreBoard1", board1);
	}

	
	
	/** 게시글 이전 이후(비회원)
	 * @param qnaNo
	 * @return
	 */
	public QnaBoard selectPreBoard2(int qnaNo) {
	   return sqlSession.selectOne("qnaboardMapper.selectPreBoard2", qnaNo);
	}




}
