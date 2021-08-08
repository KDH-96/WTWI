package com.wtwi.fin.qnaboard.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.qnaboard.model.vo.QnaReply;

@Repository
public class QnaReplyDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<QnaReply> selectList(int qnaNo) {
		return sqlSession.selectList("qnareplyMapper.selectList", qnaNo);
	}

}
