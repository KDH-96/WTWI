package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
