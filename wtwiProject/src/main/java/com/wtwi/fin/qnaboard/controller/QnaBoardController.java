package com.wtwi.fin.qnaboard.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.qnaboard.model.service.QnaBoardService;
import com.wtwi.fin.qnaboard.model.service.QnaBoardServiceImpl;
import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.qnaboard.model.vo.QnaCategory;
import com.wtwi.fin.qnaboard.model.vo.Search;

@Controller
@RequestMapping("/qnaboard/*")
@SessionAttributes({"loginMember"})
public class QnaBoardController {

	@Autowired
	private QnaBoardService service;
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	private String selectQnaBoard(@RequestParam(value="cp", required = false, defaultValue = "1") int cp,
									Model model, Pagination pg,
									Search search) {
		
		pg.setCurrentPage(cp);
		
		Pagination pagination = null;
		List<QnaBoard> boardList = null;
		
		if(search.getSk()==null) {// 그냥 조회
			pagination = service.getPagination(pg);
			
			boardList = service.selectBoardList(pagination);
		}else {// 검색 조회
			pagination = service.getPagination(search,pg);
			
			boardList = service.selectBoardList(search,pagination);
		}
		
		//System.out.println(boardList);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "qnaboard/qnaBoardList";
	}
	
	// 게시글 상세 조회
	@RequestMapping(value="/{qnaNo}", method = RequestMethod.GET)
	private String qnaBoardView(@PathVariable("qnaNo") int qnaNo,
								@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
								@ModelAttribute("loginMember") Member loginMember,
								Model model, RedirectAttributes ra) {
		
		QnaBoard board = service.selectqnaBoard(qnaNo);
		System.out.println(board);
		if(board!=null) {
			model.addAttribute("board", board);
			
			
			if(board.getQnaStatus().equals("S")) { // 게시글 상태가 S == 비공개
				if(!board.getMemberGrade().equals("A") || loginMember.getMemberNo() != board.getMemberNo()) { // 회원 등급이 A 매니저이거나 로그인한 멤버의 번호와 게시글 번호의 회원 번호가 같지 않다면
					MemberController.swalSetMessage(ra, "error", "비공개 게시글입니다", "작성 본인 혹은 관리자만 조회가 가능합니다.");
					return "redirect:list";
				}
			}
			// System.out.println(board);
			return "qnaboard/qnaBoardView";
		}else {
			MemberController.swalSetMessage(ra, "error", "존재하지 않는 게시글입니다", null);
			return "redirect:list";
		}
	}
	
	// 문의게시판 게시글 작성 화면 조회
	@RequestMapping(value="insertForm", method=RequestMethod.GET)
	public String insertForm(Model model) {
		
		// 카테고리 목록 조회
		List<QnaCategory> category = service.selectCategory();
		model.addAttribute("category", category);
		
		return "qnaboard/qnaBoardInsert";
	}
	
	// 문의게시판 작성
	@RequestMapping(value="insertForm", method=RequestMethod.POST)
	public String insertBoard(@ModelAttribute QnaBoard board,
								String qnaStatus,
								@ModelAttribute("loginMember") Member loginMember,
								HttpServletRequest request,
								RedirectAttributes ra) {
		// 회원 정보 얻어오기
		board.setMemberNo(loginMember.getMemberNo());
		board.setQnaStatus(qnaStatus);

		System.out.println("전 : " + board.getQnaStatus());
		if(board.getQnaStatus()==null) {
			board.setQnaStatus("Y");
		}
		System.out.println("후 : " + board.getQnaStatus());
		
		int boardNo = service.insertBoard(board);
		
		String path = null ;
			if(boardNo>0) {
				path = "redirect:" + boardNo;
				MemberController.swalSetMessage(ra, "success", "게시글 삽입 성공!", null);
			}else {
				path = "redirect:" + request.getHeader("referer");
				MemberController.swalSetMessage(ra, "error", "게시글 삽입 실패", null);
			}
		return path;
	} // 어디
	
	
	// 문의게시판 게시글 답글작성 화면 조회
	@RequestMapping(value="insertFormRE", method=RequestMethod.GET)
	public String insertFormRE(Model model) {
		
		// 카테고리 목록 조회
		List<QnaCategory> category = service.selectCategory();
		model.addAttribute("category", category);
		
		
		return "qnaboard/qnaBoardInsertRE";
	}
	
	// 문의게시판 답글작성
	@RequestMapping(value="insertFormRE", method=RequestMethod.POST)
	public String insertBoardRE(@ModelAttribute QnaBoard board,
			String qnaStatus,
			@ModelAttribute("loginMember") Member loginMember,
			HttpServletRequest request,
			RedirectAttributes ra) {
		// 회원 정보 얻어오기
		board.setMemberNo(loginMember.getMemberNo());
		board.setQnaStatus(qnaStatus);

		System.out.println("전 : " + board.getQnaStatus());
		if(board.getQnaStatus()==null) {
			board.setQnaStatus("Y");
		}
		System.out.println("후 : " + board.getQnaStatus());
		
		//System.out.println(board);
		
		int boardNo = service.insertBoardRe(board);
		
		String path = null;
		
		if(boardNo>0) {
			if(board.getQnaStatus() == null) {
				board.setQnaStatus("S");
			}
			path = "redirect:" + boardNo;
			MemberController.swalSetMessage(ra, "success", "게시글 삽입 성공!", null);
		}else {
			path = "redirect:" + request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "게시글 삽입 실패", null);
		}
		return path;
	}
	
	@RequestMapping(value="updateForm", method=RequestMethod.POST)
	public String updateForm(int qnaNo, Model model) {
		
		// 카테고리 목록 조회
		List<QnaCategory> category = service.selectCategory();
		
		QnaBoard board = service.selectUpdateBoard(qnaNo);
		
		model.addAttribute("category", category);
		model.addAttribute("board", board);
		
		return "qnaboard/qnaBoardUpdate";
	}
}
