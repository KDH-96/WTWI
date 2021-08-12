package com.wtwi.fin.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping({"/admin/report/*"})
public class AdminReportController {
	
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String reportList(@ModelAttribute("bo") String boardOption) {
		
		return "/admin/boards/reportList";
	}
}
