package com.wtwi.fin.chat.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.wtwi.fin.chat.model.service.ChatService;
import com.wtwi.fin.chat.model.vo.ChatMessage;
import com.wtwi.fin.chat.model.vo.ChatRoom;
import com.wtwi.fin.member.controller.MemberController;
import com.wtwi.fin.member.model.vo.Member;

@Controller
@SessionAttributes({"loginMember", "chatRoomNo"})
public class ChatController {
	
	@Autowired
	private ChatService service;
	
	// 채팅방 만들기 (23) 혹은 채팅방 열기
	@RequestMapping("/chat/openChatRoom/{attractionNo}")
	public String openChatRoom(@ModelAttribute("loginMember") Member loginMember,
							   RedirectAttributes ra,
							   HttpServletRequest request,
							   @PathVariable("attractionNo") int attractionNo) {
		System.out.println("attractionNo : "+attractionNo);
		// 채팅방 만들기 (23)
		int chatRoomNo = service.openChatRoom(loginMember.getMemberNo(), attractionNo);
		
		String path = "";
		
		// 채팅방이 만들어진 경우
		if(chatRoomNo>0) {
			path = "redirect:/chat/room/"+chatRoomNo;
			
		// 채팅방이 만들어지지 않은 경우
		} else {
			path = "redirect:"+request.getHeader("referer");
			MemberController.swalSetMessage(ra, "error", "채팅 연결에 실패하였습니다.", null);
		}
		return path;
	}
	
	// 채팅 메세지 조회 (24)
	@RequestMapping("/chat/room/{chatRoomNo}")
	public String joinChatRoom(@ModelAttribute("loginMember") Member loginMember,
							   Model model,
							   ChatRoom chatRoom,
							   @PathVariable("chatRoomNo") int chatRoomNo) {
		
		chatRoom.setChatRoomNo(chatRoomNo);
		chatRoom.setMemberNo(loginMember.getMemberNo());
		
		// 채팅 메세지 조회 (24)
		List<ChatMessage> cmList = service.selectCmList(chatRoom.getChatRoomNo(), loginMember.getMemberNo());
		
		model.addAttribute("cmList", cmList);
		model.addAttribute("chatRoomNo", chatRoomNo);
		
		return "chat/chatRoom";
	}

	// 새로운 채팅 메세지가 있는지 조회(26)
	@ResponseBody
	@RequestMapping(value="/chat/newChatExist", method=RequestMethod.POST)
	public int newChatExist(@RequestParam("memberNo") int memberNo) {
		return service.newChatExist(memberNo);
	}
}
