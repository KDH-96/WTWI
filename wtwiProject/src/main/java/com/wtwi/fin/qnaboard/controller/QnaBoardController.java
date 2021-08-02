package com.wtwi.fin.qnaboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.wtwi.fin.qnaboard.model.service.QnaBoardServiceImpl;

@Controller
public class QnaBoardController {

	@Autowired
	private QnaBoardServiceImpl service;
	
	@RequestMapping
	private String selectQnaBoard() {
		
		return null;
	}
}
