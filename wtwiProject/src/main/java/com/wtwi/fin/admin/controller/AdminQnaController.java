package com.wtwi.fin.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping({"/admin/qnaboard/*"})
public class AdminQnaController {

	@RequestMapping(value="list", method = RequestMethod.GET)
	public String qnaboardList(@ModelAttribute("bo") String boardOption) {
		
		return "/admin/boards/qnaBoardList";
	}
}
