package com.wtwi.fin.qnaboard.controller;

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

import com.wtwi.fin.qnaboard.model.service.QnaBoardService;
import com.wtwi.fin.qnaboard.model.service.QnaBoardServiceImpl;
import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;

@Controller
@RequestMapping("/qnaboard/*")
//@SessionAttributes({"loginMember"})
public class QnaBoardController {

	@Autowired
	private QnaBoardService service;
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	private String selectQnaBoard(@RequestParam(value="cp", required = false, defaultValue = "1") int cp,
									Model model, Pagination pg) {
		
		pg.setCurrentPage(cp);
		Pagination pagination = service.getPagination(pg);
		
		List<QnaBoard> boardList = service.selectBoardList(pagination);
		System.out.println(boardList);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "qnaboard/qnaBoardList";
	}
	
	@RequestMapping(value="/{qnaNo}", method = RequestMethod.GET)
	private String qnaBoardView(@PathVariable("freeNo") int freeNo,
								@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
								Model model, RedirectAttributes ra) {
		
		//QnaBoard board = service.selectqnaBoard(freeNo);
		return null;
	}
}
