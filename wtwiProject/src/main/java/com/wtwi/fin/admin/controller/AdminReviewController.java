package com.wtwi.fin.admin.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.wtwi.fin.admin.model.service.AdminReportService;
import com.wtwi.fin.admin.model.service.AdminReviewService;
import com.wtwi.fin.attraction.model.vo.Attraction;
import com.wtwi.fin.attraction.model.vo.Review;
import com.wtwi.fin.attraction.model.vo.ReviewPagination;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Search;

@Controller
@RequestMapping({"/admin/review/*"})
public class AdminReviewController {
	
	@Autowired
	private AdminReviewService service;
	
	// 관리자 리뷰 조회
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String reviewList(@ModelAttribute("bo") String boardOption, 
							@RequestParam(value="cp", required=false, defaultValue="1") int cp, Model model,
							ReviewPagination pg, Search search) {
		pg.setCurrentPage(cp);
		ReviewPagination pagination = null;
		List<Review> reviewBoardList = null;

		if (search.getSv() == null) { // 검색 X 
			pagination = service.getReviewPagination(pg);
			pagination.setPageSize(10);
			reviewBoardList = service.selectReviewBoardList(pagination);
		} else { // 검색 O
			pagination = service.getReviewPagination(search, pg); 
			reviewBoardList = service.selectSearchReviewBoardList(search, pagination);
		}

		model.addAttribute("reviewBoardList", reviewBoardList);
		model.addAttribute("pagination", pagination);
		
		System.out.println(reviewBoardList);
		
		return "/admin/boards/reviewList";
	}
	
	// 관리자 리뷰 상태 변경
	@RequestMapping(value="changeReviewStatus", method=RequestMethod.POST)
	public String changeReviewStatus(Review review, RedirectAttributes ra) {
		
		String status = null;
		
		if(review.getReviewStatus().equals("Y")) {
			status = "등록";
		} else status = "삭제";
		
		int result = service.changeReviewStatus(review);
		
		if(result>0) {
			MemberController.swalSetMessage(ra, "success", "게시글이 " + status + "상태로 변경되었습니다.", null);
		} else {
			MemberController.swalSetMessage(ra, "error", "게시글 상태 변경 실패", null);		
		}
		return "redirect:/admin/review/list";
	}

	
}
