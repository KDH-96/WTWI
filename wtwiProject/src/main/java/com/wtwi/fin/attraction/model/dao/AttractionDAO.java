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


	/** 명소별 평균점수 구하기(준석)
	 * @param attractionNo
	 * @return avgPoint
	 */
	public double getAvgPoint(int attractionNo) {
		return sqlSession.selectOne("attractionMapper.getAvgPoint", attractionNo);
	}


	/** 명소별 총 리뷰 수 구하기(준석)
	 * @param attractionNo
	 * @return totalReviewCount
	 */
	public int getReviewCount(int attractionNo) {
		return sqlSession.selectOne("attractionMapper.getReviewCount", attractionNo);
	}

}
