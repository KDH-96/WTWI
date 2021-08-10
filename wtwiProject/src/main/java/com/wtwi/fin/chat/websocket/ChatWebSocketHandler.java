package com.wtwi.fin.chat.websocket;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.wtwi.fin.chat.model.service.ChatService;
import com.wtwi.fin.chat.model.vo.ChatMessage;
import com.wtwi.fin.member.model.vo.Member;

import edu.emory.mathcs.backport.java.util.Collections;

public class ChatWebSocketHandler extends TextWebSocketHandler {

	@Autowired
	private ChatService service;
	
	// 클라이언트-서버 전이중 통신 담당(WebScoketSession)
	private Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<WebSocketSession>());
	
	// 클라이언트-서버 연결 후 통신 준비가 되면 실행
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// 채팅을 이용하는 사람의 정보를 Set에 저장
		sessions.add(session);
		
		//System.out.println(session.getId()+" 연결");
		//System.out.println(((Member)session.getAttributes().get("loginMember")).getMemberNick()+" 참가");
	}
	
	// 클라이언트로부터 텍스트를 받았을 때 실행
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//System.out.println("전달받은 내용 : "+message.getPayload());
		
		// JSON 문자열을 -> JsonObject로 변환 (값을 꺼내어 쓸 수 있게함)
		JsonObject convertedObj = new Gson().fromJson(message.getPayload(), JsonObject.class);
		
		String memberNick = convertedObj.get("memberNick").toString();
		String chatContent = convertedObj.get("chatContent").toString();
		
		memberNick = memberNick.substring(1, memberNick.length()-1);
		chatContent = chatContent.substring(1, chatContent.length()-1);
		
		//System.out.println("입력한 사람 : "+memberNick);
		//System.out.println("채팅 내용 : "+chatContent);
		
		// 채팅방 번호
		int chatRoomNo = Integer.parseInt(convertedObj.get("chatRoomNo").toString().replaceAll("\"", ""));
		
		// 회원 번호
		int memberNo = Integer.parseInt(convertedObj.get("memberNo").toString().replaceAll("\"", ""));
		
		// CHAT_MESSAGE 테이블에 삽입할 컬럼 내용을 VO에 담기
		ChatMessage cm = new ChatMessage();
		cm.setMemberNo(memberNo);	  // 회원번호
		cm.setChatRoomNo(chatRoomNo); // 채팅방 번호
		cm.setChatContent(chatContent);	  // 채팅 메세지
		
		// 해당 채팅방에 참가한 다른 회원이 현재 세션에 있는지 검사하기
		// 다른 회원의 회원 번호 가져오기(25-0)
		int chatMemberNo = service.selectChatMemberNo(chatRoomNo, memberNo);
		
		boolean flag = false;
		
		for(WebSocketSession s : sessions) {
			int no = ((Member)s.getAttributes().get("loginMember")).getMemberNo();
			if(chatMemberNo==no) flag = true;
		}
		
		// 채팅 메세지 DB에 삽입(25)
		int result = service.insertChatMessage(cm, flag);
		
		if(result>0) {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			convertedObj.addProperty("chatCreateDate", sdf.format(new Date()));
			
			for(WebSocketSession s : sessions) {
				
				int joinChatRoomNo = ((Integer)s.getAttributes().get("chatRoomNo"));
				
				// 채팅방에 접속한 회원의 채팅방 번호와 메세지를 전송한 회원의 채팅방 번호가 같을 경우
				if(chatRoomNo==joinChatRoomNo) {
					
					// 메세지를 전달
					s.sendMessage(new TextMessage(new Gson().toJson(convertedObj)));
				}
			}
		}
	}
	
	// 클라이언트-서버 연결 종료될 때 실행
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	}
	
}
