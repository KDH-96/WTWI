package com.wtwi.fin;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes({"loginMember"})
public class HomeController {
	
	@RequestMapping(value = "/intro", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		model.addAttribute("loginMember", null);
		return "intro";
	}
	
	@RequestMapping(value="main", method=RequestMethod.GET)
	public String main() {
		return "main";
	}
	
	@RequestMapping(value="info", method=RequestMethod.GET)
	public String info() {
		return "info";
	}
}
 