package com.wtwi.fin.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.admin.model.service.AdminReportService;
import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Search;

@Controller
@RequestMapping({"/admin/report/*"})
public class AdminReportController {
	
	@Autowired
	private AdminReportService service;
	
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String reportList(@ModelAttribute("bo") String boardOption, 
							@RequestParam(value="cp", required=false, defaultValue="1") int cp, Model model,
							Pagination pg, Search search) {
		Pagination pagination = null;
		List<Report> reportBoardList = null;

		if (search.getSv() == null) { // 검색 X 
			pagination = service.getReportPagination(pg);
			
			reportBoardList = service.selectReportBoardList(pagination);
		} else { // 검색 O
			pagination = service.getReportPagination(search, pg); 
			reportBoardList = service.selectSearchReportBoardList(search, pagination);
		}

		model.addAttribute("reportBoardList", reportBoardList);
		model.addAttribute("pagination", pagination);

		return "/admin/boards/reportList";
	}
	
	@RequestMapping(value="changeReportStatus", method=RequestMethod.POST)
	public String changeReportStatus(Report report, RedirectAttributes ra) {
		
		String status = null;
		
		if(report.getReportStatus().equals("Y")) {
			status = "등록";
		} else status = "삭제";
		
		int result = service.changeReportStatus(report);
		
		if(result>0) {
			MemberController.swalSetMessage(ra, "success", "게시글이 " + status + "상태로 변경되었습니다.", null);
		} else {
			MemberController.swalSetMessage(ra, "error", "게시글 상태 변경 실패", null);		
		}
		return "redirect:/admin/report/list";
	}
}
