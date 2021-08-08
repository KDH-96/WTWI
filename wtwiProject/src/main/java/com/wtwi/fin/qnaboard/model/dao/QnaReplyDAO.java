package com.wtwi.fin.qnaboard.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.qnaboard.model.vo.QnaReply;

/**
 * @author richi
 *
 */
@Repository
public class QnaReplyDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 댓글 목록 조회
	 * @param qnaNo
	 * @return
	 */
	public List<QnaReply> selectList(int qnaNo) {
		return sqlSession.selectList("qnareplyMapper.selectList", qnaNo);
	}

	/** 댓글 삽입
	 * @param reply
	 * @return
	 */
	public int insertReply(QnaReply reply) {
		return sqlSession.insert("qnareplyMapper.insertReply", reply);
	}

	/** 댓글 수정
	 * @param reply
	 * @return result
	 */
	public int updateReply(QnaReply reply) {
		return sqlSession.update("qnareplyMapper.updateReply", reply);
	}

	/** 댓글 삭제
	 * @param replyNo
	 * @return result
	 */
	public int deleteReply(int qnaReplyNo) {
		return sqlSession.update("qnareplyMapper.deleteReply", qnaReplyNo);
	}

}
