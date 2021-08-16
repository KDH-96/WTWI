package com.wtwi.fin.attraction.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;

public interface ReviewService {

	/** 전체 리뷰 수 + 명소 조회
	 * @param pg
	 * @return ReviewPagination
	 */
	ReviewPagination getPagination(ReviewPagination pg);

	/** 리뷰 목록 조회
	 * @param reviewPagination
	 * @return reviewList
	 */
	List<Review> selectReviewList(ReviewPagination reviewPagination);

	/** 리뷰 삽입
	 * @param insertReview
	 * @return result
	 */
	int insertReview(Review insertReview);

	/** 리뷰 삭제
	 * @param reviewNo
	 * @return result
	 */
	int deleteReview(int reviewNo);

}
