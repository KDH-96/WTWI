package com.wtwi.fin.attraction.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.attraction.model.vo.Attraction;

@Repository
public class AttractionDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int insertAttrList(List<Attraction> attrList) {
		return sqlSession.insert("attractionMapper.insertAttrList", attrList);
	}

}
