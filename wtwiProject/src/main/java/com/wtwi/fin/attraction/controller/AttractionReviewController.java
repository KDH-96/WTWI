package com.wtwi.fin.attraction.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.wtwi.fin.attraction.model.service.ReviewService;
import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;

@Controller
@RequestMapping("/review/*")
@SessionAttributes({"loginMember"})
@RestController
public class AttractionReviewController {

	@Autowired
	private ReviewService service;
	
	// 리뷰 목록 조회
	@RequestMapping("{selectedMarker}/list")
	@ResponseBody
	public List<Object> selectReview(@PathVariable("selectedMarker") int attractionNo,
			@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
			Model model, ReviewPagination pg) {
		
		pg.setAttractionNo(attractionNo);
		pg.setCurrentPage(cp);
		
		ReviewPagination reviewPagination = null;
		List<Review> reviewList =null;
		
		reviewPagination = service.getPagination(pg);
		
		System.out.println("reviewPagination : " + reviewPagination.getAttractionNo());
		
		reviewList = service.selectBoardList(reviewPagination);
		
		List<Object> pgReviewList = new ArrayList<Object>();
		
		pgReviewList.add(reviewPagination);
		pgReviewList.add(reviewList);
		
		return pgReviewList;
	}
	
	
}
