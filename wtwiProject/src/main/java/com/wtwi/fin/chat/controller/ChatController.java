package com.wtwi.fin.chat.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.wtwi.fin.chat.model.service.ChatService;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService service;
	
	// (23)

}
