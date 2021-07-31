package com.wtwi.fin.freeboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.wtwi.fin.freeboard.model.service.BoardService;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;

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
}
