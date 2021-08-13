package com.wtwi.fin.reportBoard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.reportBoard.model.service.ReportBoardService;

@Controller
@RequestMapping(value = "/reportBoard/*", method = RequestMethod.GET)
@SessionAttributes({ "loginMember" })
public class ReportBoardController {
	
	@Autowired
	private ReportBoardService service;
	
	@RequestMapping(value="report", method=RequestMethod.GET)
	public String report(@RequestParam("freeNo") int freeNo, @RequestParam("type") int type, Model model) {
		
		model.addAttribute("freeNo", freeNo);
		model.addAttribute("type", type);
		
		return "reportBoard/report";
	}
	
	@RequestMapping(value="reportAction", method=RequestMethod.POST)
	public String reportAction(@ModelAttribute("loginMember") Member loginMember,
							Report report, RedirectAttributes ra) {

		report.setMemberNo(loginMember.getMemberNo());
		
		int result = service.report(report);

		if(result > 0) {
			MemberController.swalSetMessage(ra, "success", "신고 성공", null);
		} else {
			MemberController.swalSetMessage(ra, "error", "신고 실패", "문제가 지속될 경우, 대표전화로 문의주세요");
		}
		
		return "redirect:/freeboard/" + report.getReportTypeNo();
	}
}
