package com.wtwi.fin.freeboard.model.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Category;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Search;

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
	 * @return category
	 */
	List<Category> selectCategory();

	/** 검색 게시글 수 조회(5)
	 * @param search
	 * @param pg
	 * @return pagination
	 */
	Pagination getPaganation(Search search, Pagination pg);

	/** 검색 게시글 목록 조회(6)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	List<Board> selectBoardList(Search search, Pagination pagination);

	/** 이미지 파일을 서버에 저장(7)
	 * @param file
	 * @param webPath
	 * @param savePath
	 * @return fileName
	 */
	String uploadFile(MultipartFile file, String webPath, String savePath);

	/** 게시글 삽입(8)
	 * @param board
	 * @param imgs
	 * @param webPath
	 * @return
	 */
	int insertBoard(Board board, List<String> imgs, String webPath);

	/** DB에서 24시간보다 이전에 추가된 파일명 조회(9)
	 * @param standard
	 * @return dbList
	 */
	List<String> selectDbList(String standard);

	/** 게시글 삭제(10)
	 * @param freeNo
	 * @return result
	 */
	int deleteBoard(int freeNo);

	/** 게시글 수정(13)
	 * @param board
	 * @param imgs
	 * @param deleteImgs
	 * @param webPath
	 * @param request 
	 * @return result
	 */
	int updateBoard(Board board, List<String> imgs, List<String> deleteImgs, String webPath, HttpServletRequest request);

	/** 좋아요 체크(14)
	 * @param freeNo
	 * @param memberNo
	 * @return flag
	 */
	boolean likeCheck(int freeNo, int memberNo);

	/** 좋아요 기능(15)
	 * @param freeNo
	 * @param memberNo
	 * @return result
	 */
	int freeboardLike(int freeNo, int memberNo);

	/** 정렬 게시글 목록 조회(16)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	List<Board> selectSortList(Search search, Pagination pagination);

}
