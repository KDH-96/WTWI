package com.wtwi.fin.freeboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.freeboard.model.dao.ReplyDAO;
import com.wtwi.fin.freeboard.model.vo.Reply;

/**
 * @author 세은
 */
@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyDAO dao;

	// 댓글 목록 조회(17)
	@Override
	public List<Reply> selectReplyList(int freeNo) {
		return dao.selectReplyList(freeNo);
	}

	// 댓글 삽입(18)
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int insertReply(Reply reply) {
		
		// XSS 방지
		reply.setFreeReplyContent(BoardServiceImpl.replaceParameter(reply.getFreeReplyContent()));
		
		// 개행문자
		reply.setFreeReplyContent(reply.getFreeReplyContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		return dao.insertReply(reply);
	}

	// 댓글 수정(19)
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int updateReply(Reply reply) {
		
		// XSS 방지
		reply.setFreeReplyContent(BoardServiceImpl.replaceParameter(reply.getFreeReplyContent()));
		
		// 개행문자
		reply.setFreeReplyContent(reply.getFreeReplyContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		return dao.updateReply(reply);
	}

	// 댓글 삭제(20)
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int deleteReply(int freeReplyNo) {
		return dao.deleteReply(freeReplyNo);
	}

	// 답글 삽입(22)
	@Transactional(rollbackFor=Exception.class)
	@Override
	public int insertReReply(Reply reply) {
		return dao.insertReReply(reply);
	}
	

}
