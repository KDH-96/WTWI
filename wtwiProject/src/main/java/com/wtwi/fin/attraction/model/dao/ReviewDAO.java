package com.wtwi.fin.attraction.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;

@Repository
public class ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 페이지네이션을 위한 특정 명소의 전체 리뷰 수 조회
	 * @param attractionNo
	 * @return reviewPagination
	 */
	public ReviewPagination getListcount(int attractionNo) {
		
		System.out.println("dao에서 받은 attractionNo : " + attractionNo);
		
		return sqlSession.selectOne("reviewMapper.getListCount", attractionNo);
	}

	
	/** 특정 명소의 리뷰 조회
	 * @param reviewPagination
	 * @return reviewList
	 */
	public List<Review> selectReviewList(ReviewPagination reviewPagination) {
		
		int offset = (reviewPagination.getCurrentPage() - 1) * reviewPagination.getLimit();
		
		RowBounds rowBounds = new RowBounds(offset, reviewPagination.getLimit());
		
		return sqlSession.selectList("reviewMapper.selectReviewList", reviewPagination.getAttractionNo(), rowBounds);
	}


	/** 리뷰 삽입
	 * @param insertReview
	 * @return result
	 */
	public int insertReview(Review insertReview) {
		return sqlSession.insert("reviewMapper.insertReview", insertReview);
	}


	/** 리뷰 삭제
	 * @param reviewNo
	 * @return result
	 */
	public int deleteReview(int reviewNo) {
		return sqlSession.update("reviewMapper.deleteReview", reviewNo);
	}
	
}
