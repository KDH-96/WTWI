package com.wtwi.fin.attraction.controller;

import org.apache.maven.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.wtwi.fin.attraction.model.service.ReviewService;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;

@RequestMapping("/review/*")
@SessionAttributes({"loginMember"})
@RestController
public class AttractionReviewController {

	@Autowired
	private ReviewService service;
	
	// 리뷰 목록 조회
	@RequestMapping(value="list", method=RequestMethod.POST)
	public String selectReview(@PathVariable("") int contentId,
			@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
			Model model, ReviewPagination pg) {
		
		
		return null;
	}
	
	
}
