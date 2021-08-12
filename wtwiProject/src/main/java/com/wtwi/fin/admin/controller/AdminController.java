package com.wtwi.fin.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {
	
	@RequestMapping(value="/admin/boards")
	public String boards() {
		
		return "admin/boards/boardSelect";
	}
	
	// select 값에 따라 해당 게시판 또는 그 리스트를 요청하는 주소를 대입 -> 각자 admin 컨트롤러에서 잡기~
	@RequestMapping(value="/admin/boardList", method = RequestMethod.GET)
	public String boardSelect(@RequestParam("bo") String boardOption) {
		
		String path = "";
		
		switch(boardOption) {
		
		case "freeboard" : path = "freeBoardList"; break;
		case "qnaboard" : path = "qnaBoardList"; break;
		case "report" : path = "reportList"; break;
		case "review" : path = "reviewList"; break;
		
		}
		
		return "/admin/boards/"+path;
	}

}
