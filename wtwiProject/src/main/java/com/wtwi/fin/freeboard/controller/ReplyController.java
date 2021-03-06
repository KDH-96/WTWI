package com.wtwi.fin.freeboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.wtwi.fin.freeboard.model.service.ReplyService;
import com.wtwi.fin.freeboard.model.vo.Reply;

/**
 * @author 세은
 */
@RestController
@RequestMapping("/freereply/*")
@SessionAttributes({"loginMember"})
public class ReplyController {
	
	@Autowired
	private ReplyService service;

	// 댓글 목록 조회(17)
	@RequestMapping(value="selectReplyList", method=RequestMethod.POST)
	public String selectReplyList(@RequestParam("freeNo") int freeNo) {

		List<Reply> replyList = service.selectReplyList(freeNo);
		
		return new Gson().toJson(replyList);
	}
	
	// 댓글 삽입(18)
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	public int insertReply(Reply reply) {
		return service.insertReply(reply);
	}
	
	// 댓글 수정(19)
	@RequestMapping(value="updateReply", method=RequestMethod.POST)
	public int updateReply(Reply reply) {
		return service.updateReply(reply);
	}
	
	// 댓글 삭제(20)
	@RequestMapping(value="deleteRpely", method=RequestMethod.POST)
	public int deleteReply(@RequestParam("freeReplyNo") int freeReplyNo) {
		return service.deleteReply(freeReplyNo);
	}
	
	// 답글 삽입(22)
	@RequestMapping(value="insertReReply", method=RequestMethod.POST)
	public int insertReReply(Reply reply) {
		return service.insertReReply(reply);
	}
	
	
}
