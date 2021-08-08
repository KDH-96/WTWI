package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.qnaboard.model.dao.QnaReplyDAO;
import com.wtwi.fin.qnaboard.model.vo.QnaReply;

@Service
public class QnaReplyServiceImpl implements QnaReplyService{

	@Autowired
	private QnaReplyDAO dao;
	
	// 댓글 목록 조회
	@Override
	public List<QnaReply> selectList(int qnaNo) {
		
		return dao.selectList(qnaNo);
	}

	// 댓글 삽입
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertReply(QnaReply reply) {
		
		// 크로스사이트 스크립트 방지 처리
		reply.setQnaReplyContent(QnaBoardServiceImpl.replaceParameter(reply.getQnaReplyContent()));
		
		// 개행문자
		reply.setQnaReplyContent(reply.getQnaReplyContent().replace("(\r\n|\r|\n|\n\r)", "<br>"));
		
		return dao.insertReply(reply);
	}

	// 댓글 수정
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateReply(QnaReply reply) {
		// 크로스사이트 스크립트 방지 처리
		reply.setQnaReplyContent(QnaBoardServiceImpl.replaceParameter(reply.getQnaReplyContent()));
		
		// 개행문자
		reply.setQnaReplyContent(reply.getQnaReplyContent().replace("(\r\n|\r|\n|\n\r)", "<br>"));
		return dao.updateReply(reply);
	}

	// 댓글 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteReply(int qnaReplyNo) {
		return dao.deleteReply(qnaReplyNo);
	}

}
