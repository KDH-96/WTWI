package com.wtwi.fin.attraction.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.attraction.model.dao.AttractionDAO;
import com.wtwi.fin.attraction.model.vo.Attraction;

@Service
public class AttractionServiceImpl implements AttractionService {

	@Autowired
	private AttractionDAO dao ;

	@Transactional(rollbackFor = Exception.class) // 모든 예외 발생 시 롤백
	@Override
	public int insertAttrList(List<Attraction> attrList) {
		return dao.insertAttrList(attrList);
	}
	
	
}
