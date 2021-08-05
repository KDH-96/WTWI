package com.wtwi.fin.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.member.model.service.MypageService;
import com.wtwi.fin.member.model.vo.Member;




@Controller
@RequestMapping(value = "/myPage/*", method = RequestMethod.GET)
@SessionAttributes({ "loginMember", "freeBoardList" })
public class MypageController {
	
	@Autowired
	private MypageService service;

	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main() {

		return "myPage/main";

	}

	@RequestMapping(value = "post", method = RequestMethod.GET)
	public String viewFreeBoard(@ModelAttribute("loginMember") Member loginMember, Member member,
								@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
								Model model, Pagination pg/*페이징 처리에 사용할 비어있는 객체*/, 
								Search search/*검색용 커맨드 객체*/ ) {
		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<Board> freeBoardList = null;
		
		if(search.getSc() == null) { // 검색 X --> 전체 목록 조회
			// 2) 전체 게시글 수를 조회하여 Pagination 관련 내용을 계산하고 값을 저장한 객체 반환 받기 
			pagination = service.getFreePagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());
			// 3) 생성된 pagination을 이용하여 현재 목록 페이지에 보여질 게시글 목록 조회
			freeBoardList = service.selectFreeBoardList(pagination);
		} else { // 검색 O -> 검색 목록 조회
			// 검색이 적용된 pagination 객체 생성
			
			pagination = service.getFreePagination(search, pg); // 메소드 오버로딩
			
			// 검색이 적용된 pagination을 이용하여 게시글 목록 조회
			freeBoardList = service.selectSearchFreeBoardList(search, pagination);
		}
		
		model.addAttribute("freeBoardList", freeBoardList);
		model.addAttribute("pagination", pagination);
		return "myPage/freeBoard";

	}
	
	@RequestMapping(value = "qnaBoard", method = RequestMethod.GET)
	public String viewQnABoard(@ModelAttribute("loginMember") Member loginMember, Member member,
							   @RequestParam(value="cp", required=false, defaultValue = "1") int cp,
							   Model model, Pagination pg, 
							   Search search) {
							
		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());
		
		Pagination pagination = null;
		List<QnaBoard> qnaBoardList = null;
		
		if(search.getSc() == null) { // 검색 X --> 전체 목록 조회
			// 2) 전체 게시글 수를 조회하여 Pagination 관련 내용을 계산하고 값을 저장한 객체 반환 받기 
			pagination = service.getQnAPagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());
			// 3) 생성된 pagination을 이용하여 현재 목록 페이지에 보여질 게시글 목록 조회
			qnaBoardList = service.selectQnABoardList(pagination);
		} else { // 검색 O -> 검색 목록 조회
			// 검색이 적용된 pagination 객체 생성
			
			pagination = service.getQnAPagination(search, pg); // 메소드 오버로딩
			
			// 검색이 적용된 pagination을 이용하여 게시글 목록 조회
			qnaBoardList = service.selectSearchQnABoardList(search, pagination);
		}
		model.addAttribute("QnABoardList", qnaBoardList);
		model.addAttribute("pagination", pagination);
		return "myPage/QnABoard";
		
	}
	@RequestMapping(value = "reviewBoard", method = RequestMethod.GET)
	public String viewReviewBoard() {
		
		return "myPage/reviewBoard";
		
	}

	@RequestMapping(value = "reply", method = RequestMethod.GET)
	public String viewReply() {

		return "myPage/reply";

	}
	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String viewReport() {
		
		return "myPage/report";
		
	}
	@RequestMapping(value = "chat", method = RequestMethod.GET)
	public String viewChat() {
		
		return "myPage/chat";
		
	}


}

