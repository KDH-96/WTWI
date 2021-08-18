package com.wtwi.fin;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.member.controller.MemberController;

@Controller
@SessionAttributes({"loginMember"})
public class HomeController {
	
	@RequestMapping(value = "/intro", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		model.addAttribute("loginMember", null);
		return "intro";
	}
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String main(RedirectAttributes ra, HttpSession session) {
		
		String dest = (String)session.getAttribute("dest");
		MemberController.swalSetMessage(ra, "error", "로그인 기간 만료", dest);
		
		return "main";
	}
	
	@RequestMapping(value="info", method=RequestMethod.GET)
	public String info() {
		return "info";
	}
}
 