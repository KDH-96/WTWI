package com.wtwi.fin.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@RequestMapping(value = "/myPage/*", method = RequestMethod.GET)
@SessionAttributes({ "loginMember" })
public class MypageController {

	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main() {

		return "myPage/main";

	}


	@RequestMapping(value = "post", method = RequestMethod.GET)
	public String viewFreeBoard() {

		return "myPage/freeBoard";

	}
	@RequestMapping(value = "QnABoard", method = RequestMethod.GET)
	public String viewQnABoard() {
		
		return "myPage/QnABoard";
		
	}
	@RequestMapping(value = "reviewBoard", method = RequestMethod.GET)
	public String viewReviewBoard() {
		
		return "myPage/reviewBoard";
		
	}

	@RequestMapping(value = "reply", method = RequestMethod.GET)
	public String viewReply() {

		return "myPage/reply";

	}
	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String viewReport() {
		
		return "myPage/report";
		
	}
	@RequestMapping(value = "chat", method = RequestMethod.GET)
	public String viewChat() {
		
		return "myPage/chat";
		
	}


}

