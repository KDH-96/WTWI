package com.wtwi.fin.freeboard.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Pagination;

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

	
}
