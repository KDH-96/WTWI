package com.wtwi.fin.qnaboard.model.service;

import java.util.List;

import com.wtwi.fin.qnaboard.model.vo.Pagination;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;

public interface QnaBoardService {

	/** 전체 게시글 수 + 게시판 이름 조회
	 * @param pg
	 * @return pagination
	 */
	Pagination getPagination(Pagination pg);

	/** 게시판 이름 조회
	 * @param pagination
	 * @return boardList
	 */
	List<QnaBoard> selectBoardList(Pagination pagination);


}
