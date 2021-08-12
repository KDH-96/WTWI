package com.wtwi.fin.attraction.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		System.out.println("전달할 페이지네이션 객체 : " + pg.getAttractionNo());
		
		ReviewPagination selectPg = dao.getListcount(pg.getAttractionNo());
		
		System.out.println("셀렉트 pg : " + selectPg);
		
		// 2) pagination 계산 결과 생성 후 반환
		return new ReviewPagination(pg.getCurrentPage(), selectPg.getListCount(), pg.getAttractionNo());
	}

	
	// 리뷰 목록 조회
	@Override
	public List<Review> selectBoardList(ReviewPagination reviewPagination) {
		return dao.selectReviewList(reviewPagination);
	}

	
}
