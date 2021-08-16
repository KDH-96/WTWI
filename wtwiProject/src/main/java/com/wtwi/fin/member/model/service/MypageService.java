package com.wtwi.fin.member.model.service;

import java.util.List;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Review;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;
import com.wtwi.fin.member.model.vo.Chat;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.member.model.vo.News;

public interface MypageService {
	
	/** 메인 명소추천 목록
	 * @param memberNo 
	 * @return
	 */
	List<Review> selectReviewList(int memberNo);

	/** 내가 쓴 글(자유게시판) 페이징 처리
	 * @param loginMember
	 * @param pg
	 * @param order 
	 * @return
	 */
	Pagination getFreePagination(Member member, Pagination pg);

	/** 내가 쓴 글(자유게시판) 전체 게시글 목록
	 * @param pagination
	 * @return
	 */
	List<Board> selectFreeBoardList(Pagination pagination, String order);

	/** 내가 쓴 글(자유게시판) 전체 게시글 수 조회(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getFreePagination(Search search, Pagination pg);

	/** 내가 쓴 글(자유게시판) 전체 게시글 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Board> selectSearchFreeBoardList(Search search, Pagination pagination);

	/** 내가 쓴 글(문의게시판) 페이징 처리
	 * @param memberNo
	 * @param pg
	 * @return
	 */
	Pagination getQnAPagination(Member member, Pagination pg);

	/**  내가 쓴 글(문의게시판) 전체 게시글 목록
	 * @param pagination
	 * @return
	 */
	List<QnaBoard> selectQnABoardList(Pagination pagination);

	/** 내가 쓴 글(자유게시판) 전체 게시글 수 조회(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getQnAPagination(Search search, Pagination pg);

	/** 내가 쓴 글(문의게시판) 전체 게시글 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<QnaBoard> selectSearchQnABoardList(Search search, Pagination pagination);

	/** 1:1 문의내역 페이징 처리
	 * @param memberNo
	 * @param pg
	 * @return
	 */
	Pagination getChatPagination(Member member, Pagination pg);

	/**  1:1 문의내역 전체 게시글 목록
	 * @param pagination
	 * @return
	 */
	List<Chat> selectChatBoardList(Pagination pagination);

	/** 1:1 문의내역 전체 게시글 수 조회(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getChatPagination(Search search, Pagination pg);

	/** 1:1 문의내역 전체 게시글 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Chat> selectSearchChatBoardList(Search search, Pagination pagination);

	/** 신고내역 페이징 처리
	 * @param member
	 * @param pg
	 * @return
	 */
	Pagination getReportPagination(Member member, Pagination pg);

	/** 신고내역 전체 게시글 목록 
	 * @param pagination
	 * @param order
	 * @return
	 */
	List<Report> selectReportBoardList(Pagination pagination, String order);

	/** 신고내역 전체 게시글 수 조회(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getReportPagination(Search search, Pagination pg);

	/** 신고내역 전체 게시글 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Report> selectSearchReportBoardList(Search search, Pagination pagination);

	/** 댓글 내역 페이징 처리
	 * @param member
	 * @param pg
	 * @return
	 */
	Pagination getReplyPagination(Member member, Pagination pg);

	/** 댓글 내역 전체 목록 
	 * @param pagination
	 * @param order
	 * @return
	 */
	List<Reply> selectReplyBoardList(Pagination pagination, String order);

	/** 댓글 내역 페이징처리(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getReplyPagination(Search search, Pagination pg);

	/** 댓글 내역 전체 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Reply> selectSearchReplyBoardList(Search search, Pagination pagination);

	/** 명소후기 페이징 처리
	 * @param member
	 * @param pg
	 * @return
	 */
	Pagination getReviewPagination(Member member, Pagination pg);

	/** 명소후기 전체 목록 
	 * @param pagination
	 * @param order
	 * @return
	 */
	List<Review> selectReviewBoardList(Pagination pagination, String order);

	/** 명소후기 페이징 처리(검색)
	 * @param search
	 * @param pg
	 * @return
	 */
	Pagination getReviewPagination(Search search, Pagination pg);

	/** 명소후기 전체 목록(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	List<Review> selectSearchReviewBoardList(Search search, Pagination pagination);

	/** 추천 명소 날씨 가져오기
	 * @return
	 */
	String getWeatherInfo(String latitude, String longitude, String check);

	/** 네이버 뉴스 가져오기
	 * @return
	 */
	List<News> getNaverNews();

	/** 추천 명소 사진 가져오기
	 * @param reviewList
	 * @return
	 */
	List<Review> getAttractionSrc(List<Review> reviewList);

	

}
