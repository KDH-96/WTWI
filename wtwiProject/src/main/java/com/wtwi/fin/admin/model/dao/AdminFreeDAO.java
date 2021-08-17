package com.wtwi.fin.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.freeboard.model.vo.Board;
import com.wtwi.fin.freeboard.model.vo.Pagination;
import com.wtwi.fin.freeboard.model.vo.Reply;
import com.wtwi.fin.freeboard.model.vo.Search;

@Repository
public class AdminFreeDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/** 게시글 수 조회(27-1)
	 * @return pagination
	 */
	public Pagination getListCountAll() {
		return sqlSession.selectOne("freeboardMapper.getListCountAll");
	}

	/** 게시글 목록 조회(27-2)
	 * @param pagination
	 * @return boardList
	 */
	public List<Board> selectBoardListAll(Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("freeboardMapper.selectBoardListAll", 1, rowBounds);
	}

	/** 게시글 상태 변경(28)
	 * @param board
	 * @return result
	 */
	public int changeFreeStatus(Board board) {
		return sqlSession.update("freeboardMapper.changeFreeStatus", board);
	}

	/** 검색게시글 수 조회(29-1)
	 * @param search
	 * @return pagination
	 */
	public Pagination getSearchListCountAll(Search search) {
		return sqlSession.selectOne("freeboardMapper.getSearchListCountAll", search);
	}

	/** 검색 게시글 목록 조회 (29-2)
	 * @param search
	 * @param pagination
	 * @return boardList
	 */
	public List<Board> selectSearchBoardListAll(Search search, Pagination pagination) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("freeboardMapper.selectSearchBoardListAll", search, rowBounds);
	}

	/** 관리자 페이지 게시글 상세조회(30)
	 * @param freeNo
	 * @return board
	 */
	public Board selectFreeboard(int freeNo) {
		return sqlSession.selectOne("freeboardMapper.selectFreeBoard", freeNo);
	}
	
	/** 댓글 개수 조회(31-1)
	 * @param freeNo
	 * @return pagination
	 */
	public Pagination getReplyCount(int freeNo) {
		return sqlSession.selectOne("freereplyMapper.getReplyCount", freeNo);
	}

	/** 댓글 목록 조회(31)
	 * @param pagination 
	 * @param freeNo
	 * @return replyList
	 */
	public List<Reply> selectReplyListAll(Pagination pagination, int freeNo) {
		
		int offset = (pagination.getCurrentPage()-1)*pagination.getLimit();
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("freereplyMapper.selectReplyListAll", freeNo, rowBounds);
	}

	/** 관리자 페이지 댓글 상태 변경(32)
	 * @param reply
	 * @return result
	 */
	public int changeFreeReplyStatus(Reply reply) {
		return sqlSession.update("freereplyMapper.changeFreeReplyStatus", reply);
	}

	/** 관리자 페이지 댓글 수정(37)
	 * @param reply
	 * @return result
	 */
	public int updateFreeReply(Reply reply) {
		return sqlSession.update("freereplyMapper.updateFreeReply", reply);
	}

}
