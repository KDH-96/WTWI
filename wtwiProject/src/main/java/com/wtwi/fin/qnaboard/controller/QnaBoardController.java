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
//@SessionAttributes({"loginMember"})
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
	
	@RequestMapping(value="/{qnaNo}", method = RequestMethod.GET)
	private String qnaBoardView(@PathVariable("qnaNo") int qnaNo,
								@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
								Model model, RedirectAttributes ra) {
		
		QnaBoard board = service.selectqnaBoard(qnaNo);
		
		if(board!=null) {
			model.addAttribute("board", board);
			//System.out.println(board);
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
	
	@RequestMapping(value="insertForm", method=RequestMethod.POST)
	public String insertBoard(@ModelAttribute QnaBoard board,
								@ModelAttribute("loginMember") Member loginMember,
								HttpServletRequest request,
								RedirectAttributes ra) {
		// 회원 정보 얻어오기
		board.setMemberNo(loginMember.getMemberNo());
		
		int boardNo = service.insertBoard(board);
		
		String path = null;
		
		if(boardNo>0) {
			path = "redirect:" + boardNo;
			MemberController.swalSetMessage(ra, "success", "게시글 삽입 성공!", path);
		}else {
			path = "redirect:" + boardNo;
			MemberController.swalSetMessage(ra, "error", "게시글 삽입 실패", path);
		}
		return path;
	}
}
