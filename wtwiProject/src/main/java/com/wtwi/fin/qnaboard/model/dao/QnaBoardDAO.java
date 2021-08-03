package com.wtwi.fin.qnaboard.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;

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

	public List<QnaBoard> selectBoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("qnaboardMapper.selectBoardList", 1, rowBounds);
	}
}
