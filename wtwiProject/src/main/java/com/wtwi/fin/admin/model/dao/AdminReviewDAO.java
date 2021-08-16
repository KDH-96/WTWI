package com.wtwi.fin.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Search;

@Repository
public class AdminReviewDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 리뷰 목록 수 조회
	public ReviewPagination getListCount() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("reviewMapper.getListCountAdmin");
	}
	
	// 리뷰 목록 조회
	public List<Review> selectReviewBoardList(ReviewPagination pg) {
		int offset = (pg.getCurrentPage()-1)*pg.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pg.getLimit());
		return sqlSession.selectList("reviewMapper.selectBoardList", 0, rowBounds);
	}

	// 리뷰 목록 수 조회(검색)
	public ReviewPagination getListCount(Search search) {
		return sqlSession.selectOne("reviewMapper.getSearchListCount", search);
	}
	
	// 리뷰 목록 수 조회(검색)
	public List<Review> selectReviewBoardList(Search search, ReviewPagination pg) {
		int offset = (pg.getCurrentPage()-1)*pg.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pg.getLimit());
		return sqlSession.selectList("reviewMapper.selectSearchBoardList", search, rowBounds);
	}
	
	// 리뷰 상태 변경
	public int changeReviewStatus(Review review) {
		return sqlSession.update("reviewMapper.changeStatus", review);
	}

}
