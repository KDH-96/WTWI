package com.wtwi.fin.chat.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.wtwi.fin.chat.model.service.ChatService;

public class ChatWebSocketHandler extends TextWebSocketHandler {

	@Autowired
	private ChatService service;
	
	
}
