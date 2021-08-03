package com.wtwi.fin.member.controller;

import java.util.HashMap;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wtwi.fin.member.model.service.MemberService;

import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@RestController
@RequestMapping(value = "/coolSMS/*", method = RequestMethod.GET)
public class SMSController {
	
	@Autowired
	private MemberService service;

	@RequestMapping(value = "send", method = RequestMethod.POST)
	public int sendSMS(String memberPhone, Model model) throws Exception { // 휴대폰 문자보내기
		
		int result = 0;
		result = service.selectPhone(memberPhone);
		
		if(result ==  0) {
			String api_key = "NCS12NM3LKSYPLKI";
			String api_secret = "VQMFOYNFRLZNHFMOTW9UWCCEPMFHKL5Y";
			int checkNum = (int) (Math.random() * 100000);
			Message coolsms = new Message(api_key, api_secret);
			
			// 4 params(to, from, type, text) are mandatory. must be filled
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("to", "010-9799-2724");    // 수신전화번호
			params.put("from", memberPhone);    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
			params.put("type", "SMS");
			params.put("text", "Where the Weather is... 인증번호는" + "["+checkNum+"]" + "입니다.");
			params.put("app_version", "test app 1.2"); // application name and version

			try {
				JSONObject obj = (JSONObject) coolsms.send(params);
				result = Integer.parseInt(String.valueOf(obj.get("error_count")));
				if(result == 0) {
					result = checkNum;
				} 
			} catch (CoolsmsException e) {
				System.out.println(e.getMessage());
				System.out.println(e.getCode());
			}
		} else {
			result = 2;
		}
		
       // 잘못된 전화번호 = 1, 존재하는 전화번호 = 2, 인증번호 발신 성공 = checkNum(인증번호)
        return result;
	}
}
