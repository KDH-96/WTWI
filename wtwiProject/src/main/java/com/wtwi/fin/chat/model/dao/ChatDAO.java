package com.wtwi.fin.chat.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wtwi.fin.chat.model.vo.ChatMessage;
import com.wtwi.fin.chat.model.vo.ChatRoom;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/** 명소 담당자 번호 얻어오기(23-1)
	 * @param attractionNo
	 * @return memberNo
	 */
	public int getManagerNo(int attractionNo) {
		return sqlSession.selectOne("chatMapper.getManagerNo", attractionNo);
	}
	
	/** 명소 담당자가 참가한 채팅방 중 회원이 참가한 곳이 있는지 검사(23-2)
	 * @param map
	 * @return flag
	 */
	public int chatRoomExist(Map<String, Integer> map) {
		return sqlSession.selectOne("chatMapper.chatRoomExist", map);
	}
	
	/** 다음 채팅방 번호 얻어오기(23-3)
	 * @return chatRoomNo
	 */
	public int nextChatRoomNo() {
		return sqlSession.selectOne("chatMapper.nextChatRoomNo");
	}

	/** 채팅방 만들기 혹은 회원/담당자 INSERT(23-4, 23-5)
	 * @param chatRoom
	 * @return result
	 */
	public int openChatRoom(ChatRoom chatRoom) {
		return sqlSession.insert("chatMapper.openChatRoom", chatRoom);
	}

	/** 채팅 메세지 조회 (24-1)
	 * @param chatRoom
	 * @return cmList
	 */
	public List<ChatMessage> selectCmList(int chatRoomNo) {
		return sqlSession.selectList("chatMapper.selectCmList", chatRoomNo);
	}

	/** 메세지 상태 변경(24-2)
	 * @param map
	 */
	public void changeStatus(Map<String, Integer> map) {
		sqlSession.update("chatMapper.changeStatus", map);
	}
	
	/** 채팅 메세지 DB에 삽입(25)
	 * @param cm
	 * @return result
	 */
	public int insertChatMessage(ChatMessage cm) {
		return sqlSession.insert("chatMapper.insertChatMessage", cm);
	}

	/** 새로운 채팅 메세지가 있는지 조회(26)
	 * @param memberNo
	 * @return result
	 */
	public int newChatExist(int memberNo) {
		return sqlSession.selectOne("chatMapper.newChatExist", memberNo);
	}


	
}
