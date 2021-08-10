package com.wtwi.fin.attraction.model.service;

import java.util.List;

import com.wtwi.fin.attraction.model.vo.Attraction;

public interface AttractionService {

	 
	/** 명소 데이터 저장(1회용) Service
	 * @param attrList
	 * @return successInt
	 */
	int insertAttrList(List<Attraction> attrList);

}
