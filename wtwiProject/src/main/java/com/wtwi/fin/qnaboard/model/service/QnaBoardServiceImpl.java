package com.wtwi.fin.qnaboard.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wtwi.fin.qnaboard.model.dao.QnaBoardDAO;

@Service
public class QnaBoardServiceImpl implements QnaBoardService{

	@Autowired
	private QnaBoardDAO dao;
}
