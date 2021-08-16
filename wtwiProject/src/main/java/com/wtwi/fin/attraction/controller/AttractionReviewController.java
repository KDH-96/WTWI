package com.wtwi.fin.attraction.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thoughtworks.qdox.model.Member;
import com.wtwi.fin.attraction.model.service.ReviewService;
import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;
import com.wtwi.fin.member.controller.MemberController;

@Controller
@RequestMapping("/review/*")
@SessionAttributes({ "loginMember" })
@RestController
public class AttractionReviewController {

	@Autowired
	private ReviewService service;

	// 리뷰 목록 조회
	@RequestMapping("{selectedMarker}/list")
	@ResponseBody
	public List<Object> selectReview(@PathVariable("selectedMarker") int attractionNo,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
			ReviewPagination pg) {

		pg.setAttractionNo(attractionNo);
		pg.setCurrentPage(cp);

		ReviewPagination reviewPagination = null;
		List<Review> reviewList = null;

		reviewPagination = service.getPagination(pg);

		System.out.println("reviewPagination : " + reviewPagination.getAttractionNo());

		reviewList = service.selectReviewList(reviewPagination);

		List<Object> pgReviewList = new ArrayList<Object>();

		pgReviewList.add(reviewPagination);
		pgReviewList.add(reviewList);

		return pgReviewList;
	}
	
	
	// 설화꺼
	@RequestMapping(value = "{attractionNo}/reviewList" , method = RequestMethod.POST)
	@ResponseBody
	public List<Object>  selectReviewList(@PathVariable("attractionNo") int attractionNo, 
	                     @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	                     ReviewPagination pg) {
	   
	   //int attractionNo = Integer.parseInt(selectedNo);
	   //System.out.println("ajax로 넘어온 attractionNo : " + attractionNo);
	   
	   pg.setLimit(5);
	   pg.setAttractionNo(attractionNo);
	   pg.setCurrentPage(cp);

	   ReviewPagination reviewPagination = null;
	   List<Review> reviewList = null;

	   reviewPagination = service.getPagination(pg);
	   reviewPagination.setLimit(5);
	   

	   //System.out.println("reviewPagination : " + reviewPagination.getAttractionNo());

	   reviewList = service.selectReviewList(reviewPagination);

	   List<Object> pgReviewList = new ArrayList<Object>();

	   pgReviewList.add(reviewPagination);
	   pgReviewList.add(reviewList);
	   
	   //System.out.println("pgReviewList : " + pgReviewList.toString() );
	   
	   return pgReviewList;

	}
	

	/**
	 * 리뷰 작성
	 * 
	 * @param insertReview
	 * @return result
	 */
	@ResponseBody
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public int insertReview(@ModelAttribute Review insertReview) {
		System.out.println("리뷰 성공 : " + insertReview);
		int result = service.insertReview(insertReview);
		return result;
	}
}
