package com.wtwi.fin.qnaboard.controller;

import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.qnaboard.model.service.QnaBoardService;
import com.wtwi.fin.qnaboard.model.service.QnaBoardServiceImpl;
import com.wtwi.fin.qnaboard.model.service.QnaReplyService;
import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.qnaboard.model.vo.QnaCategory;
import com.wtwi.fin.qnaboard.model.vo.QnaReply;
import com.wtwi.fin.qnaboard.model.vo.Search;

@Controller
@RequestMapping("/qnaboard/*")
@SessionAttributes({"loginMember"})
public class QnaBoardController {

	@Autowired
	private QnaBoardService service;
	
	@Autowired
	private QnaReplyService replyService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	private String selectQnaBoard(@RequestParam(value="cp", required = false, defaultValue = "1") int cp,
									Model model, Pagination pg,
									Search search) {
		
		pg.setCurrentPage(cp);
		
		Pagination pagination = null;
		List<QnaBoard> boardList = null;
		
		if(search.getSk()==null) {// ?????? ??????
			pagination = service.getPagination(pg);
			
			boardList = service.selectBoardList(pagination);
		}else {// ?????? ??????
			pagination = service.getPagination(search,pg);
			
			boardList = service.selectBoardList(search,pagination);
		}
		
		System.out.println(boardList);
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("pagination", pagination);
		
		return "qnaboard/qnaBoardList";
	}
	
	// ????????? ?????? ??????
	@RequestMapping(value="/{qnaNo}", method = RequestMethod.GET)
	private String qnaBoardView(@PathVariable("qnaNo") int qnaNo,
								HttpSession session,
								@RequestParam(value="cp", required=false, defaultValue = "1") int cp,
								Model model, RedirectAttributes ra, QnaBoard board1) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		QnaBoard board = service.selectqnaBoard(qnaNo);
		
		if(loginMember != null) {
			if(loginMember.getMemberGrade().equals("A")) {
				board1 = service.selectqnaPreBoard(qnaNo);
			}else{
				
				board1.setMemberNo(loginMember.getMemberNo());
				board1 = service.selectqnaPreBoard1(board1);
			}
		}else {
			board1 = service.selectqnaPreBoard2(qnaNo);
		}
		
		board.setPreNo(board1.getPreNo());
		board.setNextNo(board1.getNextNo());
		
		System.out.println(board);
		
		if(board!=null) {
			List<QnaReply> rList = replyService.selectList(qnaNo);
			
			model.addAttribute("board", board);
			model.addAttribute("rList", rList);
			
			return "qnaboard/qnaBoardView";
		}else {
			MemberController.swalSetMessage(ra, "error", "???????????? ?????? ??????????????????", null);
			return "redirect:list";
		}
	}
	
	// ??????????????? ????????? ?????? ?????? ??????
	@RequestMapping(value="insertForm", method=RequestMethod.GET)
	public String insertForm(Model model) {
		
		// ???????????? ?????? ??????
		List<QnaCategory> category = service.selectCategory();
		model.addAttribute("category", category);
		
		return "qnaboard/qnaBoardInsert";
	}
	
	// ??????????????? ??????
	@RequestMapping(value="insertForm", method=RequestMethod.POST)
	public String insertBoard(@ModelAttribute QnaBoard board,
								String qnaStatus,
								@ModelAttribute("loginMember") Member loginMember,
								HttpServletRequest request,
								RedirectAttributes ra) throws Exception {
		// ?????? ?????? ????????????
		board.setMemberNo(loginMember.getMemberNo());
		board.setMemberGrade(loginMember.getMemberGrade());
		board.setQnaStatus(qnaStatus);
		
		System.out.println(board);
		System.out.println(loginMember);
		System.out.println("??? : " + board.getQnaStatus());
		if(board.getQnaStatus()==null) {
			board.setQnaStatus("Y");
		}
		System.out.println("??? : " + board.getQnaStatus());
		
		int boardNo = service.insertBoard(board);
		
		String path = null ;
			if(boardNo>0) {
				String setfrom = loginMember.getMemberEmail(); // ????????? ?????? ?????????
				String tomail = "wtwimanager1@gmail.com"; // ?????? ?????? ?????????
				String title = "?????????????????? ???????????? ?????????????????????."; // ??????

				String content = loginMember.getMemberNick()+"??? ?????? ?????? ???????????? ???????????? ??????????????????."+
								"<br>"+
								"??????????????? ?????? ?????? ????????????."+
								"<br>"+
								"<a href='http://localhost:8080/wtwi/qnaboard/"+board.getQnaNo()+"'>????????? ????????????</a>"; // ??????
				try {
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

					messageHelper.setFrom(setfrom); 	// ?????????--> ???????????? ??????????????? ??????
					messageHelper.setTo(tomail); 		// ????????? --> ?????????
					messageHelper.setSubject(title); 	// ??????????????? ?????? ??????
					messageHelper.setText(content,true); // ?????? ??????

					mailSender.send(message);
				} catch (Exception e) {
					System.out.println(e);
					e.printStackTrace();
				}
				
				path = "redirect:" + boardNo;
				MemberController.swalSetMessage(ra, "success", "????????? ?????? ??????!", null);
				
			}else {
				path = "redirect:" + request.getHeader("referer");
				MemberController.swalSetMessage(ra, "error", "????????? ?????? ??????", null);
			}
		return path;
	} 
	
	
	// ??????????????? ????????? ???????????? ?????? ??????
	@RequestMapping(value="insertFormRE", method=RequestMethod.GET)
	public String insertFormRE(Model model) {
		
		// ???????????? ?????? ??????
		List<QnaCategory> category = service.selectCategory();
		model.addAttribute("category", category);
		
		
		return "qnaboard/qnaBoardInsertRE";
	}
	
	// ??????????????? ????????????
	@RequestMapping(value="insertFormRE", method=RequestMethod.POST)
	public String insertBoardRE(@ModelAttribute QnaBoard board,
			String qnaStatus,
			@ModelAttribute("loginMember") Member loginMember,
			HttpServletRequest request,
			RedirectAttributes ra) {
		// ?????? ?????? ????????????
		board.setMemberNo(loginMember.getMemberNo());
		board.setQnaStatus(qnaStatus);

		System.out.println("??? : " + board.getQnaStatus());
		if(board.getQnaStatus()==null) {
			board.setQnaStatus("Y");
		}
		System.out.println("??? : " + board.getQnaStatus());
		
		//System.out.println(board);
		
		int boardNo = service.insertBoardRe(board);
		
		String path = null;
		
		if(boardNo>0) {
			if(board.getQnaStatus() == null) {
				board.setQnaStatus("S");
			}
			path = "redirect:" + boardNo;
			MemberController.swalSetMessage(ra, "success", "????????? ?????? ??????!", null);
		}else {
			path = "redirect:" + request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "????????? ?????? ??????", null);
		}
		return path;
	}
	
	// ??????????????? ?????? ?????? ??????
	@RequestMapping(value="updateForm", method=RequestMethod.POST)
	public String updateForm(int qnaNo, Model model) {
		
		// ???????????? ?????? ??????
		List<QnaCategory> category = service.selectCategory();
		
		QnaBoard board = service.selectUpdateBoard(qnaNo);
		
		System.out.println(category);
		model.addAttribute("category", category);
		model.addAttribute("board", board);
		
		return "qnaboard/qnaBoardUpdate";
	}
	
	// ????????? ??????
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateBoard(@ModelAttribute QnaBoard board,
								String qnaStatus,
								HttpServletRequest request,
								RedirectAttributes ra) {
	
		board.setQnaStatus(qnaStatus);
		
		int result = service.updateBoard(board);
		
		System.out.println(board);
		
		
		String path = null;

		if(result>0) {
			path = "redirect:" + board.getQnaNo();
			MemberController.swalSetMessage(ra, "success", "????????? ?????? ??????", null);
		}else {
			path = "redirect:" + request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "????????? ?????? ??????", null);
		}
		
		return path;
	}
	
	// ????????? ??????
	@RequestMapping(value="delete", method=RequestMethod.POST)
	public String deleteBoard(@RequestParam(value="cp", required=false, defaultValue="1") int cp,
							@RequestParam("qnaNo") int qnaNo,
							RedirectAttributes ra,
							HttpServletRequest request) {
		
		int result = service.deleteBoard(qnaNo);
		
		String path = null;
		
		if(result>0) {
			path = "redirect:list";
			MemberController.swalSetMessage(ra, "success", "????????? ?????? ??????.", null);
		}else {
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "????????? ????????? ?????????????????????.", "??????????????? ?????? ????????????.");
		}
		return path;
	}
	
	
}
