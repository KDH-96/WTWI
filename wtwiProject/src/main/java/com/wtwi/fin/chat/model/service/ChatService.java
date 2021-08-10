package com.wtwi.fin.chat.model.service;

import java.util.List;

import com.wtwi.fin.chat.model.vo.ChatMessage;

public interface ChatService {

	/** 채팅방 만들기 (23)
	 * @param memberNo
	 * @param attractionNo 
	 * @return chatRoomNo
	 */
	int openChatRoom(int memberNo, int attractionNo);

	/** 채팅 메세지 조회 (24)
	 * @param chatRoomNo
	 * @param memberNo 
	 * @return cmList
	 */
	List<ChatMessage> selectCmList(int chatRoomNo, int memberNo);

	/** 채팅 메세지 DB에 삽입 (25)
	 * @param cm
	 * @return result
	 */
	int insertChatMessage(ChatMessage cm);

	/** 새로운 채팅 메세지가 있는지 조회 (26)
	 * @param memberNo
	 * @return result
	 */
	int newChatExist(int memberNo);

}
