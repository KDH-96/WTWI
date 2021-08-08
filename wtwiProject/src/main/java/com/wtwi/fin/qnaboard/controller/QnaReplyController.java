package com.wtwi.fin.qnaboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wtwi.fin.qnaboard.model.service.QnaReplyService;
import com.wtwi.fin.qnaboard.model.vo.QnaReply;

@RestController
@RequestMapping("/qnaReply/*")
@SessionAttributes({"loginMember"})
public class QnaReplyController {
	
	@Autowired
	private QnaReplyService service;
	
	@RequestMapping(value="list",method = RequestMethod.POST)
	public String selectList(int qnaNo) {
		
		List<QnaReply> rList = service.selectList(qnaNo);
		
		System.out.println(rList);
		System.out.println(qnaNo);
		Gson gson = new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm").create();
		
		
		return gson.toJson(rList);
	}
	// 댓글 삽입
	@RequestMapping(value="insertReply",method=RequestMethod.POST)
	public int insertReply(QnaReply reply) {
		return service.insertReply(reply);
	}

	// 댓글 수정
	@RequestMapping(value="updateReply", method=RequestMethod.POST)
	public int updateReply(QnaReply reply) {
		return service.updateReply(reply);
	}
	
	// 댓글 삭제
	@RequestMapping(value="deleteReply", method=RequestMethod.GET)
	public int deleteReply(int qnaReplyNo) {
		return service.deleteReply(qnaReplyNo);
	}
}
