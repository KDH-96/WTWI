package com.wtwi.fin.freeboard.controller;

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
import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Image;
import com.wtwi.fin.freeboard.model.vo.Pagination;
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
	
	// 자유게시판 목록 조회(1, 2) + 검색(5, 6)
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
			// 댓글 조회 추가하기
			
			model.addAttribute("board", board);
			
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
			MemberController.swalSetMessage(ra, "success", "게시글이 성공적으로 작성되었습니다.", null);
		
		} else { // 삽입 실패
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "success", "게시글 작성에 실패하였습니다.", null);
		}
		return path;
	}
	

}
