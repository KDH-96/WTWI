package com.wtwi.fin.attraction.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.wtwi.fin.attraction.model.service.ReviewService;

@RequestMapping("/review/*")
@SessionAttributes({"loginMember"})
@RestController
public class AttractionReviewController {

	@Autowired
	private ReviewService service;
	
	// 리뷰 목록 조회
	@RequestMapping(value="list", method=RequestMethod.POST)
	public String selectReview() {
		
		
		return null;
	}
	
	
}
