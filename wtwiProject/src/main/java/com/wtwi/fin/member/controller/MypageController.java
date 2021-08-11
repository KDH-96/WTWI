package com.wtwi.fin.member.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Review;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.member.model.service.MypageService;
import com.wtwi.fin.member.model.vo.Chat;
import com.wtwi.fin.member.model.vo.Member;

@Controller
@RequestMapping(value = "/myPage/*", method = RequestMethod.GET)
@SessionAttributes({ "loginMember" })
public class MypageController {

	@Autowired
	private MypageService service;

	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main(@ModelAttribute("loginMember") Member loginMember, Model model) {
		
		List<Review> reviewList = service.selectReviewList(loginMember.getMemberNo());
		model.addAttribute("reviewList", reviewList);
		System.out.println(reviewList);

		return "myPage/main";

	}
	
	@ResponseBody
	@RequestMapping(value = "info", method = RequestMethod.POST)
	public String getInfo(@RequestParam("latitude") String latitude, @RequestParam("longitude") String longitude, String check) {
		System.out.println("latitude : " + latitude);
		System.out.println("longitude : " + longitude);
		String result = "";
		String apiId = "fab85c55ea80aa78f7d32ab07532fe33";   
		URL url;
		try {
			BufferedReader bf;
			if(check.equals("all")) {
				url = new URL(" https://api.openweathermap.org/data/2.5/forecast?lat=" + latitude + "&lon=" + longitude + "&exclude=current,hourly,minutely&units=metric&appid="+ apiId);				
				bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				result = bf.readLine();
			} else {
				url = new URL(" https://api.openweathermap.org/data/2.5/weather?lat=" + latitude + "&lon=" + longitude + "&appid="+ apiId);				
				bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				result = bf.readLine();
			}
			System.out.println(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;

	}

	

	@RequestMapping(value = "post", method = RequestMethod.GET)
	public String viewFreeBoard(@ModelAttribute("loginMember") Member loginMember, Member member,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model,
			Pagination pg/* 페이징 처리에 사용할 비어있는 객체 */, Search search/* 검색용 커맨드 객체 */,
			@RequestParam(value = "order", required = false) String order) {
		
		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<Board> freeBoardList = null;
		int imageCount = 0;

		if (search.getSv() == null) { // 검색 X 
			pagination = service.getFreePagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());
			
			freeBoardList = service.selectFreeBoardList(pagination, order);

		} else { // 검색 O -> 
			pagination = service.getFreePagination(search, pg); 

			freeBoardList = service.selectSearchFreeBoardList(search, pagination);
		}

		model.addAttribute("freeBoardList", freeBoardList);
		model.addAttribute("pagination", pagination);
		return "myPage/freeBoard";

	}

	@RequestMapping(value = "qnaBoard", method = RequestMethod.GET)
	public String viewQnABoard(@ModelAttribute("loginMember") Member loginMember, Member member,
			@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model, Pagination pg,
			Search search) {

		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<QnaBoard> qnaBoardList = null;

		if (search.getSv() == null) { // 검색 X 
			pagination = service.getQnAPagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());
		
			qnaBoardList = service.selectQnABoardList(pagination);
		} else { // 검색 O 

			pagination = service.getQnAPagination(search, pg); 
			
			qnaBoardList = service.selectSearchQnABoardList(search, pagination);
		}
		model.addAttribute("QnABoardList", qnaBoardList);
		model.addAttribute("pagination", pagination);
		return "myPage/QnABoard";

	}

	@RequestMapping(value = "reviewBoard", method = RequestMethod.GET)
	public String viewReviewBoard(@ModelAttribute("loginMember") Member loginMember, Member member,
								@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model,
								Pagination pg/* 페이징 처리에 사용할 비어있는 객체 */, Search search/* 검색용 커맨드 객체 */,
								@RequestParam(value = "order", required = false) String order) {
		
		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<Reply> replyBoardList = null;

		System.out.println("sv : "+ search.getSv());
		if (search.getSv() == null) { // 검색 X 
			pagination = service.getReplyPagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());

			replyBoardList = service.selectReplyBoardList(pagination, order);
		} else { // 검색 O 
			System.out.println("sv : "+ search.getSv());
			pagination = service.getReplyPagination(search, pg);
			
			replyBoardList = service.selectSearchReplyBoardList(search, pagination);
		}

		model.addAttribute("replyBoardList", replyBoardList);
		model.addAttribute("pagination", pagination);

		return "myPage/reviewBoard";

	}

	@RequestMapping(value = "reply", method = RequestMethod.GET)
	public String viewReply(@ModelAttribute("loginMember") Member loginMember, Member member,
							@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model,
							Pagination pg/* 페이징 처리에 사용할 비어있는 객체 */, Search search/* 검색용 커맨드 객체 */,
							@RequestParam(value = "order", required = false) String order) {
		
		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<Reply> replyBoardList = null;

		System.out.println("sv : "+ search.getSv());
		if (search.getSv() == null) { // 검색 X 
			pagination = service.getReplyPagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());

			replyBoardList = service.selectReplyBoardList(pagination, order);
		} else { // 검색 O 
			System.out.println("sv : "+ search.getSv());
			pagination = service.getReplyPagination(search, pg);
			
			replyBoardList = service.selectSearchReplyBoardList(search, pagination);
		}

		model.addAttribute("replyBoardList", replyBoardList);
		model.addAttribute("pagination", pagination);



		return "myPage/replyBoard";

	}

	@RequestMapping(value = "report", method = RequestMethod.GET)
	public String viewReport(@ModelAttribute("loginMember") Member loginMember, Member member,
							@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model,
							Pagination pg/* 페이징 처리에 사용할 비어있는 객체 */, Search search/* 검색용 커맨드 객체 */,
							@RequestParam(value = "order", required = false) String order) {
		
		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<Report> reportBoardList = null;


		if (search.getSv() == null) { // 검색 X 
			pagination = service.getReportPagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());
			
			reportBoardList = service.selectReportBoardList(pagination, order);
		} else { // 검색 O

			pagination = service.getReportPagination(search, pg); 
			
			reportBoardList = service.selectSearchReportBoardList(search, pagination);
		}

		model.addAttribute("reportBoardList", reportBoardList);
		model.addAttribute("pagination", pagination);

		return "myPage/reportBoard";

	}

	@RequestMapping(value = "chat", method = RequestMethod.GET)
	public String viewChat(@ModelAttribute("loginMember") Member loginMember, Member member,
							@RequestParam(value = "cp", required = false, defaultValue = "1") int cp, Model model, Pagination pg,
							Search search) {

		pg.setCurrentPage(cp);
		member.setMemberNo(loginMember.getMemberNo());
		search.setMemberNo(loginMember.getMemberNo());

		Pagination pagination = null;
		List<Chat> chatList = null;

		if (search.getSv() == null) { 
			pagination = service.getChatPagination(member, pg);
			pagination.setMemberNo(loginMember.getMemberNo());
			chatList = service.selectChatBoardList(pagination);
		} else { 
			pagination = service.getChatPagination(search, pg); 
			chatList = service.selectSearchChatBoardList(search, pagination);
		}
		model.addAttribute("chatList", chatList);
		model.addAttribute("pagination", pagination);
		return "myPage/chatBoard";
	}

}
