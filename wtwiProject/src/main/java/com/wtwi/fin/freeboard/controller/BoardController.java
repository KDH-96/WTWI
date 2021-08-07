package com.wtwi.fin.freeboard.controller;

import java.io.File;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.freeboard.model.service.BoardService;
import com.wtwi.fin.freeboard.model.service.ReplyService;
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Image;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.freeboard.model.vo.Search;
import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Member;

/**
 * @author 세은
 */
@Controller
@RequestMapping("/freeboard/*")
@SessionAttributes({"loginMember"})
public class BoardController {

	@Autowired
	private BoardService service;
	
	@Autowired
	private ReplyService replyService;
	
	// 자유게시판 목록 조회(1, 2) + 검색(5, 6) + 정렬(16)
	@RequestMapping(value="list", method=RequestMethod.GET)
	public String boardList(@RequestParam(value="cp", required=false, defaultValue="1") int cp,
							Model model, 
							Pagination pg,
							Search search) {
		
		pg.setCurrentPage(cp);
		
		Pagination pagination = null;
		List<Board> boardList = null;
		
		// 전체 목록 조회
		if(search.getSk()==null) {
			// 전체 게시글 수 조회 및 페이지네이션 객체 생성(1)
			pagination = service.getPaganation(pg);
			
			// 게시글 목록 조회(2)
			boardList = service.selectBoardList(pagination);
		
		// 정렬 시 목록 조회
		} else if(search.getSk().equals("date")||search.getSk().equals("like")||search.getSk().equals("read")) {
			
			pagination = service.getPaganation(pg);
			
			// 정렬 게시글 목록 조회(16)
			boardList = service.selectSortList(search, pagination);
			
		// 검색 시 목록 조회
		} else {
			// 검색 게시글 수 조회(5)
			pagination = service.getPaganation(search, pg);
			
			// 검색 게시글 목록 조회(6)
			boardList = service.selectBoardList(search, pagination);
		}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "freeboard/boardList";
	}
	
	// 자유게시판 게시글 상세 조회(3)
	@RequestMapping(value="/{freeNo}", method=RequestMethod.GET)
	public String boardView(@PathVariable("freeNo") int freeNo,
							@RequestParam(value="cp", required=false, defaultValue="1") int cp,
							Model model,
							RedirectAttributes ra) {
		
		Board board = service.selectBoard(freeNo);
		
		if(board!=null) {
			
			// 댓글 목록 조회(17)
			List<Reply> replyList = replyService.selectReplyList(freeNo);
			
			model.addAttribute("board", board);
			model.addAttribute("replyList", replyList);
			
			return "freeboard/boardView";
			
		} else {
			MemberController.swalSetMessage(ra, "error", "존재하지 않는 게시글입니다.", null);
			return "redirect:list";
		}
	}
	
	// 자유게시판 게시글 작성 화면 전환(4)
	@RequestMapping(value="insertForm", method=RequestMethod.GET)
	public String insertForm(Model model) {
		
		// 자유게시판 카테고리 목록 조회(4)
		List<Category> category = service.selectCategory();
		model.addAttribute("category", category);
		
		return "freeboard/boardInsert";
	}
	
	// 자유게시판 게시글 작성 화면 이미지 업로드 시(7)
	@ResponseBody
	@RequestMapping(value="image", method=RequestMethod.POST)
	public String uploadFile(@RequestParam("file") MultipartFile file,
							 HttpServletRequest request) {
		
		String webPath = "resources/images/freeboard/";
		String savePath = request.getSession().getServletContext().getRealPath(webPath);
		
		// 이미지 파일을 서버에 저장(7)
		String fileName = service.uploadFile(file, webPath, savePath);
		
		fileName = webPath+fileName;
		
		return fileName;
	}
	
	// 자유게시판 게시글 삽입(8)
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
		
		// 자유게시판 게시글 삽입(8)
		int freeNo = service.insertBoard(board, imgs, webPath);
		
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

	// 자유게시판 게시글 삭제(10)
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String deleteBoard(@RequestParam(value="cp", required=false, defaultValue="1") int cp,
							  @RequestParam("freeNo") int freeNo,
							  RedirectAttributes ra,
							  HttpServletRequest request) {
		
		int result = service.deleteBoard(freeNo);
		
		String path;
		if(result>0) { // 삭제 성공
			path = "redirect:list";
			MemberController.swalSetMessage(ra, "success", "게시글이 삭제되었습니다.", null);
		
		} else { // 삭제 실패
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "게시글 삭제에 실패하였습니다.", null);
		}
		return path;
	}
	
	// 자유게시판 게시글 수정 화면 전환(11)
	@RequestMapping(value="updateForm", method=RequestMethod.POST)
	public String updateForm(@RequestParam("freeNo") int freeNo,
							 Model model) {
		
		// 카테고리 목록 조회
		List<Category> category = service.selectCategory();
		
		// 게시글 상세 조회
		Board board = service.selectBoard(freeNo);
		
		model.addAttribute("category", category);
		model.addAttribute("board", board);
		
		return "freeboard/boardUpdate";
	}
	
	// 자유게시판 게시글 수정 화면 이미지 삭제 시(12)
	@ResponseBody
	@RequestMapping(value="deleteImage", method=RequestMethod.POST)
	public String deleteFile(@RequestParam("src") String src) {
		
		// src에서 파일명 추출해 반환
		String[] arr = src.split("/");
		String fileName = null;
		for(int i=arr.length-1; i>=arr.length-1; i--) {
			fileName = arr[i];
		}
		fileName = "resources/images/freeboard/"+ fileName;
		
		return fileName;
	}
	
	// 자유게시판 게시글 수정(13)
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateBoard(@ModelAttribute Board board,
							  @RequestParam("editordata") String freeContent,
							  @RequestParam("imgs") List<String> imgs,
							  @RequestParam("deleteImgs") List<String> deleteImgs,
							  RedirectAttributes ra, 
							  HttpServletRequest request) {
		
		board.setFreeContent(freeContent);
		
		String webPath = "resources/images/freeboard/";
		
		//for(String s1 : imgs) System.out.println("imgs : "+s1);
		//for(String s2 : deleteImgs) System.out.println("deleteImgs : "+s2);
		
		// 게시글 수정(13)
		int result = service.updateBoard(board, imgs, deleteImgs, webPath, request);
		
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
	
	// 자유게시판 게시글 좋아요 체크(14)
	@ResponseBody
	@RequestMapping(value="likeCheck", method=RequestMethod.POST)
	public boolean likeCheck(@RequestParam("freeNo") int freeNo,
							 @ModelAttribute("loginMember") Member loginMember) {
		
		int memberNo = loginMember.getMemberNo();
		
		return service.likeCheck(freeNo, memberNo);
	}
	
	// 자유게시판 게시글 좋아요 기능(15)
	@ResponseBody
	@RequestMapping(value="like", method=RequestMethod.POST)
	public int freeboardLike(@RequestParam("freeNo") int freeNo,
							 @ModelAttribute("loginMember") Member loginMember) {

		int memberNo = loginMember.getMemberNo();
		
		return service.freeboardLike(freeNo, memberNo);
	}
	
	// 자유게시판 게시글 좋아요 처리 후 좋아요 개수 카운트(16)
	@ResponseBody
	@RequestMapping(value="likeCount", method=RequestMethod.POST)
	public int likeCount(@RequestParam("freeNo") int freeNo) {
		
		return service.selectBoard(freeNo).getLikeCount();
	}
	
}
