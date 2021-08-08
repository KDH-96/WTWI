package com.wtwi.fin.freeboard.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.freeboard.model.vo.Reply;

/**
 * @author 세은
 */
@Repository
public class ReplyDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 댓글 목록 조회(17)
	 * @param freeNo
	 * @return replyList
	 */
	public List<Reply> selectReplyList(int freeNo) {
		return sqlSession.selectList("freereplyMapper.selectReplyList", freeNo);
	}

	/** 댓글 삽입(18)
	 * @param reply
	 * @return result
	 */
	public int insertReply(Reply reply) {
		return sqlSession.insert("freereplyMapper.insertReply", reply);
	}

	/** 댓글 수정(19)
	 * @param reply
	 * @return result
	 */
	public int updateReply(Reply reply) {
		return sqlSession.update("freereplyMapper.updateReply", reply);
	}

	/** 댓글 삭제(20)
	 * @param freeReplyNo
	 * @return result
	 */
	public int deleteReply(int freeReplyNo) {
		return sqlSession.update("freereplyMapper.deleteReply", freeReplyNo);
	}

	/** 답글 삽입(22)
	 * @param reply
	 * @return result
	 */
	public int insertReReply(Reply reply) {
		return sqlSession.insert("freereplyMapper.insertReReply", reply);
	}

}
