package com.wtwi.fin.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.admin.model.service.AdminFreeService;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Search;
import com.wtwi.fin.member.controller.MemberController;

@Controller
@RequestMapping({"/admin/freeboard/*"})
public class AdminFreeController {

	@Autowired
	private AdminFreeService service;
	
	// 관리자 페이지 자유게시판 목록 (27, )
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String freeboardList(@ModelAttribute("bo") String boardOption,
								@RequestParam(value="cp", required=false, defaultValue="1") int cp,
								Model model,
								Pagination pg,
								Search search) {
		pg.setCurrentPage(cp);
		Pagination pagination = null;
		List<Board> boardList = null;
		
		// 전체 목록 조회(글 상태가 N(삭제)인 것도 모두 조회해야 함)
		if(search.getSk()==null) {
			
			// 게시글 수 조회 + 페이지네이션 생성(27-1)
			pagination = service.getPagination(pg);
			
			// 게시글 목록 조회(27-2)
			boardList = service.selectBoardListAll(pagination);
		}
		
	
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "/admin/boards/freeBoardList";
	}
	
	// 관리자 페이지 게시글 상태변경(28)
	@RequestMapping(value="changeFreeStatus", method=RequestMethod.POST)
	public String changeFreeStatus(Board board,
								   RedirectAttributes ra) {
		
		int result = service.changeFreeStatus(board);
		if(result>0) {
			String status = null;
			if(board.getFreeStatus().equals("Y")) status = "등록";
			else status = "삭제";
			MemberController.swalSetMessage(ra, "success", "게시글이 "+status+"상태로 변경되었습니다.", null);
			
		} else {
			MemberController.swalSetMessage(ra, "error", "게시글 상태 변경 실패", null);
		}
		return "redirect:/admin/freeboard/list";
	}
}
