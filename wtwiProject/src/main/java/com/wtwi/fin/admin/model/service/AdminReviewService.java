package com.wtwi.fin.admin.model.service;

import java.util.List;

import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;
import com.wtwi.fin.member.model.vo.Search;

public interface AdminReviewService {

	/** 리뷰 조회 페이지네이션
	 * @param pg
	 * @return
	 */
	ReviewPagination getReviewPagination(ReviewPagination pg);

	/** 리뷰 전체 목록
	 * @param pagination
	 * @return
	 */
	List<Review> selectReviewBoardList(ReviewPagination pg);

	/** 리뷰 조회 페이지네이션(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	ReviewPagination getReviewPagination(Search search, ReviewPagination pg);

	/** 리뷰 전체 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Review> selectSearchReviewBoardList(Search search, ReviewPagination pg);

	/** 리뷰 상태 변경
	 * @param reportNo
	 * @return
	 */
	int changeReviewStatus(Review review);

	

}
