package com.wtwi.fin.chat.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wtwi.fin.chat.model.dao.ChatDAO;
import com.wtwi.fin.chat.model.vo.ChatMessage;
import com.wtwi.fin.chat.model.vo.ChatRoom;
import com.wtwi.fin.freeboard.model.service.BoardServiceImpl;

@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	private ChatDAO dao;

	
	// 채팅방 만들기 (23)
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int openChatRoom(int memberNo, int attractionNo) {
		
		// 23-1) 명소 담당자 번호 조회
		int managerNo = dao.getManagerNo(attractionNo);
		System.out.println("managerNo : "+managerNo);
		int chatRoomNo = 0;
		int result = 0;
		if(managerNo>0) {
			
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("managerNo", managerNo);
			map.put("memberNo", memberNo);
			System.out.println("map : "+map);
			// 23-2) 명소 담당자가 참가한 채팅방 중 회원이 참가한 곳이 있는지 검사
			chatRoomNo = dao.chatRoomExist(map);
			System.out.println("chatRoomNo : "+chatRoomNo);
			// 채팅방이 없으면 채팅방을 새로 만들어 회원과 담당자 참가시키기
			if(!(chatRoomNo>0)) {
				
				// 23-3) 다음 채팅방 번호 얻어오기
				chatRoomNo = dao.nextChatRoomNo();
				
				if(chatRoomNo>0) { // 번호 조회 성공
					
					ChatRoom chatRoom = new ChatRoom();
					chatRoom.setChatRoomNo(chatRoomNo);
					
					// 23-4) 채팅방에 회원 INSERT
					chatRoom.setMemberNo(memberNo);
					result = dao.openChatRoom(chatRoom);
					if(result==0) {
						chatRoomNo = 0;
					} else {
						
						// 23-5) 채팅방에 담당자 INSERT
						chatRoom.setMemberNo(managerNo);
						result = dao.openChatRoom(chatRoom);
						if(result==0) {
							chatRoomNo = 0;
							
						} else {
							// 23-6) 담당자 메세지 INSERT
							ChatMessage cm = new ChatMessage();
							cm.setChatRoomNo(chatRoomNo);
							cm.setMemberNo(managerNo);
							dao.insertFirstMessage(cm);
						}
					}
				}
			}
		}
		return chatRoomNo;
	}
	
	// 명소 이름 조회 (24-0)
	@Override
	public String getAttractionName(int chatRoomNo) {
		return dao.getAttractionName(chatRoomNo);
	}

	// 채팅 메세지 조회 (24)
	@Transactional(rollbackFor = Exception.class)
	@Override
	public List<ChatMessage> selectCmList(int chatRoomNo, int memberNo) {
		
		// 24-1) 채팅 메세지 조회해오기
		List<ChatMessage> cmList = dao.selectCmList(chatRoomNo);
		
		// 24-2) 조회한 채팅 메세지 중 다른 회원이 보낸 메세지를 상태=읽음 으로 변경
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("chatRoomNo", chatRoomNo);
		map.put("memberNo", memberNo);
		
		dao.changeStatus(map);
		
		return cmList;
	}

	// 다른 회원의 회원 번호 가져오기(25-0)
	@Override
	public int selectChatMemberNo(int chatRoomNo, int memberNo) {
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("chatRoomNo", chatRoomNo);
		map.put("memberNo", memberNo);
		
		return dao.selectChatMemberNo(map);
	}

	// 채팅 메세지 DB에 삽입(25)
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertChatMessage(ChatMessage cm, boolean flag) {
		
		// XSS 방지
		cm.setChatContent(BoardServiceImpl.replaceParameter(cm.getChatContent()));

		// 개행문자 처리
		//System.out.println("개행문자 처리 전 : "+cm.getChatContent());
		cm.setChatContent(cm.getChatContent().replaceAll("(\\\\r\\\\n|\\\\r|\\\\n|\\\\n\\\\r)", "<br>"));
		//System.out.println("개행문자 처리 후 : "+cm.getChatContent());

		int result = 0;
		
		// 25-1) 상대방이 현재 채팅에 참가중
		if(flag) {
			result = dao.insertChatMessageJoined(cm);
			
		// 25-2) 상대방이 현재 채팅에 참가중이 아님
		} else {
			result = dao.insertChatMessage(cm);
		}
		
		return result;
	}
	
	// 새로운 채팅 메세지가 있는지 조회(26)
	@Override
	public int newChatExist(int memberNo) {
		return dao.newChatExist(memberNo);
	}
	
	

}
