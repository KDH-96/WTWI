package com.wtwi.fin.freeboard.model.service;

import java.util.List;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Pagination;

/**
 * @author 세은
 */
public interface BoardService {
	
	/** 전체 게시글 수 조회(1)
	 * @param pg
	 * @return pagination
	 */
	Pagination getPaganation(Pagination pg);

	/** 게시글 목록 조회(2)
	 * @param pagination
	 * @return boardList
	 */
	List<Board> selectBoardList(Pagination pagination);

	/** 게시글 상세 조회(3)
	 * @param boardNo
	 * @return
	 */
	Board selectBoard(int boardNo);

	/** 카테고리 조회(4)
	 * @return
	 */
	List<Category> selectCategory();

}
