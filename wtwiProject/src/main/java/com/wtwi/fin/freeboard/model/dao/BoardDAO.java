package com.wtwi.fin.freeboard.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Image;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Search;

/**
 * @author 세은
 */
@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 전체 게시글 수 조회(1)
	 * @return pagination
	 */
	public Pagination getListCount() {
		return sqlSession.selectOne("freeboardMapper.getListCount");
	}

	/** 게시글 목록 조회(2)
	 * @param pagination
	 * @return boardList
	 */
	public List<Board> selectBoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		// 매개변수가 안 맞는데.. 될까 -> 의미 없는 숫자 1 넘기기
		return sqlSession.selectList("freeboardMapper.selectBoardList", 1, rowBounds);
	}

	/** 게시글 상세 조회(3-1)
	 * @param boardNo
	 * @return board
	 */
	public Board selectBoard(int freeNo) {
		return sqlSession.selectOne("freeboardMapper.selectBoard", freeNo);
	}

	/** 게시글 조회수 증가(3-2)
	 * @param freeNo
	 */
	public int increaseReadCount(int freeNo) {
		return sqlSession.update("freeboardMapper.increaseReadCount", freeNo);
	}

	/** 카테고리 목록 조회(4)
	 * @return category
	 */
	public List<Category> selectCategory() {
		return sqlSession.selectList("freeboardMapper.selectCategory");
	}

	/** 검색 게시글 수 조회(5)
	 * @param search 
	 * @return
	 */
	public Pagination getSearchListCount(Search search) {
		return sqlSession.selectOne("freeboardMapper.selectSearchListCount", search);
	}

	/** 검색 게시글 목록 조회(6)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	public List<Board> selectSearchBoardList(Search search, Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("freeboardMapper.selectSearchBoardList", search, rowBounds);
	}

	/** 게시글 삽입(8-1)
	 * @param board
	 * @return freeNo
	 */
	public int insertBoard(Board board) {
		int result = sqlSession.insert("freeboardMapper.insertBoard", board);
		if(result>0) return board.getFreeNo();
		else 		 return 0;
	}

	/** 이미지 파일 정보 삽입(8-2)
	 * @param images
	 * @return result
	 */
	public int insertImages(List<Image> images) {
		return sqlSession.insert("freeboardMapper.insertImages", images);
	}

	/** DB에서 24시간보다 이전에 추가된 파일명 조회(9)
	 * @param standard
	 * @return dbList
	 */
	public List<String> selectDbList(String standard) {
		return sqlSession.selectList("freeboardMapper.selectDbList", standard);
	}

	/** 게시글 삭제(10)
	 * @param freeNo
	 * @return result
	 */
	public int deleteBoard(int freeNo) {
		return sqlSession.update("freeboardMapper.deleteBoard", freeNo);
	}

	/** 게시글 수정(13-1)
	 * @param board
	 * @return result
	 */
	public int updateBoard(Board board) {
		return sqlSession.update("freeboardMapper.updateBoard", board);
	}

	/** 삭제된 이미지 정보 DB에서 제거(13-3)
	 * @param deleteImages
	 * @return result
	 */
	public int deleteImages(List<Image> deleteImages) {
		return sqlSession.delete("freeboardMapper.deleteImages", deleteImages);
	}

	/** 좋아요 체크(14)
	 * @param map
	 * @return flag
	 */
	public boolean likeCheck(Map<String, Integer> map) {
		return sqlSession.selectOne("freeboardMapper.likeCheck", map);
	}

	/** 좋아요 취소(15-1)
	 * @param map
	 */
	public void likeCancel(Map<String, Integer> map) {
		sqlSession.delete("freeboardMapper.likeCancel", map);
	}

	/** 좋아요 반영(15-2)
	 * @param map
	 */
	public void likeMark(Map<String, Integer> map) {
		sqlSession.insert("freeboardMapper.likeMark", map);
	}

	/** 정렬 게시글 목록 조회(16)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	public List<Board> selectSortList(Search search, Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit()); 
		
		return sqlSession.selectList("freeboardMapper.selectSortList", search, rowBounds);
	}
	
}
