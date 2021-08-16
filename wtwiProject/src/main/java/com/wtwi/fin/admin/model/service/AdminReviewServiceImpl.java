package com.wtwi.fin.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.admin.model.dao.AdminReviewDAO;
import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Search;

@Service
public class AdminReviewServiceImpl implements AdminReviewService{

	@Autowired
	private AdminReviewDAO dao;

	@Override
	public ReviewPagination getReviewPagination(ReviewPagination pg) {
		ReviewPagination selectPg = dao.getListCount();
		return new ReviewPagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	@Override
	public List<Review> selectReviewBoardList(ReviewPagination pg) {
		// TODO Auto-generated method stub
		return dao.selectReviewBoardList(pg);
	}

	@Override
	public ReviewPagination getReviewPagination(Search search, ReviewPagination pg) {
		ReviewPagination selectPg = dao.getListCount(search);
		return new ReviewPagination(pg.getCurrentPage(), selectPg.getListCount());
	}

	@Override
	public List<Review> selectSearchReviewBoardList(Search search, ReviewPagination pg) {
		// TODO Auto-generated method stub
		return dao.selectReviewBoardList(search, pg);
	}

	@Override
	public int changeReviewStatus(Review review) {
		// TODO Auto-generated method stub
		return dao.changeReviewStatus(review);
	}

	
	
	
	
	
}
