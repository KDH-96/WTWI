package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import com.wtwi.fin.qnaboard.model.vo.QnaReply;

public interface QnaReplyService {

	/** 댓글 목록 조회
	 * @param qnaNo
	 * @return rList
	 */
	List<QnaReply> selectList(int qnaNo);

	/** 댓글 삽입
	 * @param reply
	 * @return result
	 */
	int insertReply(QnaReply reply);

	/** 댓글 수정
	 * @param reply
	 * @return result
	 */
	int updateReply(QnaReply reply);

	/** 댓글 삭제
	 * @param replyNo
	 * @return result
	 */
	int deleteReply(int qnaReplyNo);


}
