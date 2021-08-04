package com.wtwi.fin.member.controller;

import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wtwi.fin.member.model.service.MemberService;
import com.wtwi.fin.member.model.vo.Member;

import net.nurigo.java_sdk.Coolsms;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@RestController
@RequestMapping(value = "/coolSMS/*", method = RequestMethod.GET)
public class SMSController {
	
	@Autowired
	private MemberService service;

	@RequestMapping(value = "send", method = RequestMethod.POST)
	public int sendSMS(Member inputMember, Model model) throws Exception { // 휴대폰 문자보내기
		
		int result = 0;
		Member member = service.selectPhone(inputMember);
		
		if(member == null) {
			String api_key = "NCS12NM3LKSYPLKI";
			String api_secret = "VQMFOYNFRLZNHFMOTW9UWCCEPMFHKL5Y";
			int checkNum = (int) (Math.random() * 100000);
			Message coolsms = new Message(api_key, api_secret);
			
			// 4 params(to, from, type, text) are mandatory. must be filled
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("to", "010-9799-2724");    // 수신전화번호
			params.put("from", member.getMemberPhone());    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
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
	
	@ResponseBody
	@RequestMapping(value="searchPw", method=RequestMethod.POST)
	public int searchPw(Member inputMember) {
		int result = 0;
		
		Member member = service.selectPhone(inputMember);
		
		if(member != null) {
			String api_key = "NCS12NM3LKSYPLKI";
			String api_secret = "VQMFOYNFRLZNHFMOTW9UWCCEPMFHKL5Y";
			int checkNum = (int) (Math.random() * 100000);
			Message coolsms = new Message(api_key, api_secret);
			
			// 4 params(to, from, type, text) are mandatory. must be filled
			HashMap<String, String> params = new HashMap<String, String>();
			params.put("to", "010-9799-2724");    // 수신전화번호
			params.put("from", member.getMemberPhone());    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
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
		
       // 잘못된 전화번호 = 1, 아이디나 전화번호 일치X = 2, 인증번호 발신 성공 = checkNum(인증번호)
        return result;
		
	}
	
	@ResponseBody
	@RequestMapping(value="sendPw", method=RequestMethod.POST)
	public int sendPw(Member member) {
		int result = 0;
		String api_key = "NCS12NM3LKSYPLKI";
		String api_secret = "VQMFOYNFRLZNHFMOTW9UWCCEPMFHKL5Y";
		String pw = getRamdomPassword(8);
		Message coolsms = new Message(api_key, api_secret);
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", "010-9799-2724");    // 수신전화번호
		params.put("from", member.getMemberPhone());    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS");
		params.put("text", "Where the Weather is... 임시비밀번호는" + "["+pw+"]" + "입니다.");
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			result = Integer.parseInt(String.valueOf(obj.get("error_count")));
			if(result == 0) {
				System.out.println(member);
				member.setMemberPw(pw);
				result = service.changePwd(member);
				System.out.println("result : " + result);
			}
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		return result;
	}
	
	public String getRamdomPassword(int size) { 
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
									'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 
									'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 
									'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 
									'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 
									's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}; 
		StringBuffer sb = new StringBuffer(); 
		SecureRandom sr = new SecureRandom(); 
		sr.setSeed(new Date().getTime()); 
		
		int idx = 0; 
		int len = charSet.length; 
		for (int i=0; i<size; i++) { 
			idx = (int) (len * Math.random()); idx = sr.nextInt(len); 
			// 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다. 
			sb.append(charSet[idx]); } 
		
		return sb.toString(); 
		
	}
		
	

		
	
}
