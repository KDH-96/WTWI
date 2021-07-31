package com.wtwi.fin.freeboard.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;

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
		
		// 매개변수가 안 맞는데.. 될까
		return sqlSession.selectList("freeboardMapper.selectBoardList", 1, rowBounds);
	}

	
}
