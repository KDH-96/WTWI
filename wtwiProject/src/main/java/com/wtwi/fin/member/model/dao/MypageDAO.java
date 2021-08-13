package com.wtwi.fin.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.member.model.vo.Chat;
import com.wtwi.fin.member.model.vo.Member;
import com.wtwi.fin.member.model.vo.Pagination;
import com.wtwi.fin.member.model.vo.Report;
import com.wtwi.fin.member.model.vo.Review;
import com.wtwi.fin.member.model.vo.Search;
import com.wtwi.fin.qnaboard.model.vo.QnaBoard;

@Repository
public class MypageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 메인 명소추천 목록
	 * @return
	 */
	public List<Review> selectReviewList(int memberNo) {
		System.out.println(memberNo);
		// TODO Auto-generated method stub
		return sqlSession.selectList("myPageMapper.selectReviewList", memberNo);
	}

	/** 내가 쓴 글(자유게시판) 수 조회
	 * @param member
	 * @return
	 */
	public Pagination getFreeListCount(Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getFreeListCount", member);
	}

	/** 내가 쓴 글(자유게시판) 게시글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<Board> selectFreeBoardList(Pagination pagination, String order) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", pagination.getMemberNo());
		map.put("order", order);
		return sqlSession.selectList("myPageMapper.selectFreeBoardList", map, rowBounds);
	}

	/** 내가 쓴 글(자유게시판) 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchFreeListCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getSearchFreeListCount", search);
	}

	/** 내가 쓴 글(자유게시판) 게시글 목록 조회(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	public List<Board> selectFreeBoardList(Search search, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("myPageMapper.selectSearchFreeBoardList", search, rowBounds);
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/** 내가 쓴 글(문의게시판) 수 조회
	 * @param member
	 * @return
	 */
	public Pagination getQnAListCount(Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getQnAListCount", member);
	}

	/** 내가 쓴 글(문의게시판) 게시글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<QnaBoard> selectQnABoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("myPageMapper.selectQnABoardList", pagination.getMemberNo(), rowBounds);
	}

	/** 내가 쓴 글(문의게시판) 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchQnAListCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getSearchQnAListCount", search);
	}

	/** 내가 쓴 글(문의게시판) 게시글 목록 조회(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	public List<QnaBoard> selectQnABoardList(Search search, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("myPageMapper.selectSearchQnABoardList", search, rowBounds);
	}

	
	////////////////////////////////////////////////////////////////////////////////////////////

	/** 1:1문의내역 수 조회
	 * @param member
	 * @return
	 */
	public Pagination getChatListCount(Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getChatListCount", member);
	}

	/** 1:1문의내역 게시글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<Chat> selectChatBoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		
		return sqlSession.selectList("myPageMapper.selectChatBoardList", pagination.getMemberNo(), rowBounds);
	}

	/** 1:1문의내역 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchChatListCount(Search search) {
		Pagination pg = new Pagination();
		List<Chat> chatList = null;
		int listCount = 0;
		chatList = sqlSession.selectList("myPageMapper.selectSearchChatBoardList", search);

		for(Chat c : chatList) {
			if(c.getAttractionNm() != null) {
				listCount++; 
			}
		}

		pg.setListCount(listCount);

		return pg;
	}

	/** 1:1문의내역 게시글 목록 조회(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	public List<Chat> selectChatBoardList(Search search, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		List<Chat> chatList = new ArrayList<Chat>();
		
		List<Chat> returnList = sqlSession.selectList("myPageMapper.selectSearchChatBoardList", search, rowBounds);
		
		for(Chat c : returnList) {
			if(c.getAttractionNm() != null) {
				chatList.add(c);
			}
		}
		return chatList;
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
	
	/** 신고내역 수 조회
	 * @param member
	 * @return
	 */
	public Pagination getReportListCount(Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getReportListCount", member);
	}

	/** 신고내역 게시글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<Report> selectReportBoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		

		return sqlSession.selectList("myPageMapper.selectReportBoardList", pagination.getMemberNo(), rowBounds);
	}

	/** 신고내역 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchReportListCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getSearchReportListCount", search);
	}

	/** 신고내역 게시글 목록 조회(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	public List<Report> selectSearchReportBoardList(Search search, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("myPageMapper.selectSearchReportBoardList", search, rowBounds);
	}

	
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
	
	/** 댓글내역 수 조회
	 * @param member
	 * @return
	 */
	public Pagination getReplyListCount(Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getReplyListCount", member);
	}

	/** 댓글내역 게시글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<Reply> selectReplyBoardList(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		

		return sqlSession.selectList("myPageMapper.selectReplyBoardList", pagination.getMemberNo(), rowBounds);
	}

	/** 댓글내역 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchReplyListCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getSearchReplyListCount", search);
	}

	/** 댓글내역 게시글 목록 조회(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	public List<Reply> selectSearchReplyBoardList(Search search, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 

		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("myPageMapper.selectSearchReplyBoardList", search, rowBounds);
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////
	
	
	/** 명소후기 수 조회
	 * @param member
	 * @return
	 */
	public Pagination getReviewListCount(Member member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getReviewListCount", member);
	}
	
	/** 명소후기 게시글 목록 조회
	 * @param pagination
	 * @return
	 */
	public List<Review> selectReviewBoardList(Pagination pagination, String order) {
		
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 
		
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberNo", pagination.getMemberNo());
		map.put("order", order);
		
		return sqlSession.selectList("myPageMapper.selectReviewBoardList", map, rowBounds);
	}
	
	/** 명소후기 수 조회(검색)
	 * @param search
	 * @return
	 */
	public Pagination getSearchReviewListCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageMapper.getSearchReviewListCount", search);
	}
	
	/** 명소후기 게시글 목록 조회(검색)
	 * @param search
	 * @param pagination
	 * @return
	 */
	public List<Review> selectSearchReviewBoardList(Search search, Pagination pagination) {
		int offset = (pagination.getCurrentPage() - 1) * pagination.getLimit(); 
		
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("myPageMapper.selectSearchReviewBoardList", search, rowBounds);
	}

	

}
