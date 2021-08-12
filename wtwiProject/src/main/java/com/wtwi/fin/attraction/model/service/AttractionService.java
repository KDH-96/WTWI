package com.wtwi.fin.attraction.model.service;

import java.util.List;

import com.wtwi.fin.attraction.model.vo.Attraction;

public interface AttractionService {

	 
	/** 명소 데이터 저장(1회용) Service
	 * @param attrList
	 * @return successInt
	 */
	int insertAttrList(List<Attraction> attrList);

	/** 명소별 평균점수 구하기(준석)
	 * @param attractionNo
	 * @return avgPoint
	 */
	double getAvgPoint(int attractionNo);

	/** 명소별 총 리뷰 수 구하기(준석)
	 * @param attractionNo
	 * @return totalReviewCount
	 */
	int getReviewCount(int attractionNo);

}
