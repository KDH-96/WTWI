package com.wtwi.fin.qnaboard.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

@RestController
@RequestMapping("/qnaReply/*")
@SessionAttributes({"loginMember"})
public class QnaReplyController {
	
	@RequestMapping(value="list",method = RequestMethod.POST)
	public String selectList() {
		
		return null;
	}

}
