package com.wtwi.fin.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.admin.model.service.AdminFreeService;
import com.wtwi.fin.freeboard.model.service.BoardService;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.freeboard.model.vo.Search;
import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Member;

@Controller
@RequestMapping({"/admin/freeboard/*"})
@SessionAttributes({"loginMember"})
public class AdminFreeController {

	@Autowired
	private AdminFreeService service;
	
	@Autowired
	private BoardService boardService;
	
	// 관리자 페이지 자유게시판 목록 + 검색 (27, 29)
	@RequestMapping(value="list", method = RequestMethod.GET)
	public String freeboardList(@RequestParam("bo") String boardOption,
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
			
		// 검색 목록 조회
		} else {
			
			// 검색 게시글 수 조회 + 페이지네이션 생성(29-1)
			pagination = service.getPagination(search, pg);
			
			// 검색 게시글 목록 조회 (29-2)
			boardList = service.selectSearchBoardListAll(search, pagination);
		}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "/admin/boards/freeBoardList";
	}
	
	// 관리자 페이지 게시글 상태변경(28)
	@RequestMapping(value="changeFreeStatus", method=RequestMethod.POST)
	public String changeFreeStatus(@RequestParam("bo") String boardOption,
								   Board board,
								   RedirectAttributes ra,
								   @RequestParam(value="view", required=false, defaultValue="") String view) {
		
		int result = service.changeFreeStatus(board);
		
		if(result>0) {
			String status = null;
			if(board.getFreeStatus().equals("Y")) status = "등록";
			else status = "삭제";
			MemberController.swalSetMessage(ra, "success", "게시글이 "+status+"상태로 변경되었습니다.", null);
			
		} else {
			MemberController.swalSetMessage(ra, "error", "게시글 상태 변경 실패", null);
		}
		
		if(view.equals("")) {
			return "redirect:/admin/freeboard/list?bo="+boardOption;
			
		} else {
			return "redirect:/admin/freeboard/"+board.getFreeNo()+"?bo="+boardOption;
		}
	}
	
	// 관리자 페이지 게시글 상세조회(30, 31)
	@RequestMapping(value="/{freeNo}", method = RequestMethod.GET)
	public String freeboardView(@PathVariable("freeNo") int freeNo,
								@RequestParam(value="cp", required=false, defaultValue="1") int cp,
								Model model,
								RedirectAttributes ra,
								Pagination pg) {
		pg.setCurrentPage(cp);
		
		Board board = service.selectFreeboard(freeNo);
		
		if(board!=null) {
			model.addAttribute("board", board);
			
			// 댓글 개수 조회 + 페이지네이션 생성(31-1)
			Pagination pagination = service.getReplyPagination(pg, freeNo);
			
			// 댓글 목록 조회(32-2)
			List<Reply> replyList = service.selectReplyListAll(pagination, freeNo);
			
			model.addAttribute("pagination", pagination);
			model.addAttribute("replyList", replyList);
			
			return "admin/boards/freeBoardView";
			
		} else {
			MemberController.swalSetMessage(ra, "error", "존재하지 않는 게시글입니다.", null);
			return "redirect:list";
		}
	}
	
	// 관리자 페이지 댓글 상태 변경(32)
	@RequestMapping(value="changeFreeReplyStatus", method=RequestMethod.POST)
	public String changeFreeReplyStatus(Reply reply,
										@RequestParam(value="cp", required=false, defaultValue="1") int cp,
										@RequestParam("bo") String boardOption,
										RedirectAttributes ra) {
		
		int result = service.changeFreeReplyStatus(reply);
		
		if(result>0) {
			String status = null;
			if(reply.getFreeReplyStatus().equals("Y")) status = "등록";
			else if(reply.getFreeReplyStatus().equals("N")) status = "삭제";
			else status = "수정";
			MemberController.swalSetMessage(ra, "success", "댓글이 \'"+status+"\'상태로 변경되었습니다.", null);
			
		} else {
			MemberController.swalSetMessage(ra, "error", "댓글 상태 변경 실패", null);
		}
		
		return "redirect:/admin/freeboard/"+reply.getFreeNo()+"?bo="+boardOption;
	}
	
	// 관리자 페이지 글 삽입화면 전환(33)
	@RequestMapping(value="insertForm", method=RequestMethod.GET)
	public String insertForm(Model model) {
		
		// 카테고리 목록 조회
		List<Category> category = boardService.selectCategory();
		model.addAttribute("category", category);
		
		return "admin/boards/freeBoardInsert";
	}
	
	// 관리자 페이지 글 삽입(34)
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public String insertBoard(@ModelAttribute Board board,
							  @RequestParam("editordata") String freeContent,
							  @RequestParam("imgs") List<String> imgs,
							  @ModelAttribute("loginMember") Member loginMember,
							  RedirectAttributes ra, 
							  HttpServletRequest request) {
		board.setMemberNo(loginMember.getMemberNo());
		board.setFreeContent(freeContent);
		
		String webPath = "resources/images/freeboard/";
		
		// 글 삽입
		int freeNo = boardService.insertBoard(board, imgs, webPath);
		
		String path;
		if(freeNo>0) { // 삽입 성공
			path = "redirect:"+freeNo;
			MemberController.swalSetMessage(ra, "success", "게시글이 작성되었습니다.", null);
		
		} else { // 삽입 실패
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "게시글 작성에 실패하였습니다.", null);
		}
		return path;
	}
	
	// 관리자페이지 글 수정화면 전환(35)
	@RequestMapping(value="updateForm", method=RequestMethod.POST)
	public String updateForm(@RequestParam("freeNo") int freeNo,
							 Model model) {
		
		// 카테고리 목록 조회
		List<Category> category = boardService.selectCategory();
		
		// 게시글 상세 조회
		Board board = service.selectFreeboard(freeNo);

		model.addAttribute("category", category);
		model.addAttribute("board", board);
		
		return "admin/boards/freeBoardUpdate";
	}
	
	// 관리자페이지 글 수정(36)
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateBoard(@ModelAttribute Board board,
							  @RequestParam("editordata") String freeContent,
							  @RequestParam("imgs") List<String> imgs,
							  @RequestParam("deleteImgs") List<String> deleteImgs,
							  RedirectAttributes ra, 
							  HttpServletRequest request) {
		
		board.setFreeContent(freeContent);
		
		String webPath = "resources/images/freeboard/";
		
		// 글 수정
		int result = boardService.updateBoard(board, imgs, deleteImgs, webPath, request);
		
		String path;
		if(result>0) { // 수정 성공
			path = "redirect:"+board.getFreeNo();
			MemberController.swalSetMessage(ra, "success", "게시글이 수정되었습니다.", null);
			
		} else { // 수정 실패
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "게시글 수정에 실패하였습니다.", null);
		}
		return path;
	}
	
	// 관리자페이지 댓글 수정(37)
	@RequestMapping(value="updateReply", method=RequestMethod.POST)
	public String updateReply(Reply reply,
							  RedirectAttributes ra,
							  HttpServletRequest request) {
		
		//System.out.println(reply.getFreeReplyNo());
		//System.out.println(reply.getFreeReplyContent());
		
		int result = service.updateFreeReply(reply);
		
		String path;
		if(result>0) { // 수정 성공
			path = "redirect:"+reply.getFreeNo();
			MemberController.swalSetMessage(ra, "success", "댓글이 수정되었습니다.", null);
			
		} else { // 수정 실패
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "댓글 수정에 실패하였습니다.", null);
		}
		return path;
	}
	
}
