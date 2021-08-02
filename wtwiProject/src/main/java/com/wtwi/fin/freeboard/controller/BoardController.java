package com.wtwi.fin.freeboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.freeboard.model.service.BoardService;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.member.controller.MemberController;

/**
 * @author 세은
 */
@Controller
@RequestMapping("/freeboard/*")
public class BoardController {

	@Autowired
	private BoardService service;
	
	// 자유게시판 목록 조회(1, 2)
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String boardList(@RequestParam(value="cp", required=false, defaultValue="1") int cp,
							Model model, 
							Pagination pg) {
		
		// 전체 게시글 수 조회 및 페이지네이션 객체 생성(1)
		pg.setCurrentPage(cp);
		Pagination pagination = service.getPaganation(pg);
		
		// 게시글 목록 조회(2)
		List<Board> boardList = service.selectBoardList(pagination);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "freeboard/boardList";
	}
	
	// 자유게시판 게시글 상세 조회(3)
	@RequestMapping(value="/{freeNo}", method=RequestMethod.GET)
	public String boardView(@PathVariable("freeNo") int freeNo,
							@RequestParam(value="cp", required=false, defaultValue="1") int cp,
							Model model,
							RedirectAttributes ra) {
		
		Board board = service.selectBoard(freeNo);
		
		if(board!=null) {
			// 댓글 조회 추가하기
			
			model.addAttribute("board", board);
			
			return "freeboard/boardView";
			
		} else {
			MemberController.swalSetMessage(ra, "error", "존재하지 않는 게시글입니다.", null);
			return "redirect:list";
		}
	}
	
	// 자유게시판 게시글 작성 화면 전환(4)
	@RequestMapping(value="insertForm", method=RequestMethod.GET)
	public String insertForm(Model model) {
		
		// 자유게시판 카테고리 목록 조회(4)
		List<Category> category = service.selectCategory();
		model.addAttribute("category", category);
		
		return "freeboard/boardInsert";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
