package com.wtwi.fin.admin.model.service;

import java.util.List;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Search;

public interface AdminFreeService {

	/** 게시글 수 조회 + 페이지네이션 생성(27-1)
	 * @param pg
	 * @return pagination
	 */
	Pagination getPagination(Pagination pg);

	/** 게시글 목록 조회(27-2)
	 * @param pagination
	 * @return boardList
	 */
	List<Board> selectBoardListAll(Pagination pagination);

	/** 게시글 상태 변경(28)
	 * @param board
	 * @return result
	 */
	int changeFreeStatus(Board board);

	/** 검색 게시글 수 조회 + 페이지네이션(29-1)
	 * @param search
	 * @param pg
	 * @return pagination
	 */
	Pagination getPagination(Search search, Pagination pg);

	/** 검색 게시글 목록 조회 (29-2)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	List<Board> selectSearchBoardListAll(Search search, Pagination pagination);

}
