package com.wtwi.fin.freeboard.model.service;

import java.util.List;

import com.wtwi.fin.freeboard.model.vo.Reply;

/**
 * @author 세은
 */
public interface ReplyService {

	/** 댓글 목록 조회(17)
	 * @param freeNo
	 * @return replyList
	 */
	List<Reply> selectReplyList(int freeNo);

	/** 댓글 삽입(18)
	 * @param reply
	 * @return result
	 */
	int insertReply(Reply reply);

}
