package com.wtwi.fin.attraction.model.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.wtwi.fin.attraction.model.dao.ReviewDAO;
import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;


@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	private ReviewDAO dao;

	@Override
	public ReviewPagination getPagination(ReviewPagination pg) {

		// 1) 명소별 전체 리뷰 수 조회
		ReviewPagination selectPg = dao.getListcount(pg.getAttractionNo());
		
		// 2) pagination 계산 결과 생성 후 반환
		return new ReviewPagination(pg.getCurrentPage(), selectPg.getListCount(), pg.getAttractionNo());
	}

	
	// 리뷰 목록 조회
	@Override
	public List<Review> selectReviewList(ReviewPagination reviewPagination) {
		return dao.selectReviewList(reviewPagination);
	}

	
	// 리뷰 삽입
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertReview(Review insertReview) {
		
		// XSS 방지 처리
		insertReview.setReviewContent(replaceParameter(insertReview.getReviewContent()));
		
		// 개행문자 처리
		insertReview.setReviewContent(insertReview.getReviewContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		return dao.insertReview(insertReview);
	}
	
	
	// 크로스 사이트 스크립트 방지 처리 메소드
	public static String replaceParameter(String param) {
		String result = param;
		if (param != null) {
				result = result.replaceAll("&", "&amp;");
				result = result.replaceAll("<", "&lt;");
				result = result.replaceAll(">", "&gt;");
				result = result.replaceAll("\"", "&quot;");
		}

		return result;
	}

	// 리뷰 삭제
	@Override
	public int deleteReview(int reviewNo) {
		return dao.deleteReview(reviewNo);
	}
}
