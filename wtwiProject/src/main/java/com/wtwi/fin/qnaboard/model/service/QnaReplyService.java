package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import com.wtwi.fin.qnaboard.model.vo.QnaReply;

public interface QnaReplyService {

	/** 댓글 목록 조회
	 * @param qnaNo
	 * @return rList
	 */
	List<QnaReply> selectList(int qnaNo);

}
