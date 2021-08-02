package com.wtwi.fin.qnaboard.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QnaBoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
