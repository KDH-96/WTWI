package com.wtwi.fin.auth;

import java.io.DataOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.lang.StringUtils;
import org.json.simple.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import com.wtwi.fin.member.model.vo.Member;


public class SNSLogin {
	private OAuth20Service oauthService;
	private SNSValue sns;

	public SNSLogin() {}

	public SNSLogin(SNSValue sns) {

		this.oauthService = new ServiceBuilder(sns.getClientId()).apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl()).build(sns.getApi20Instance());
		
		this.sns = sns;
			
	}

	public String getSNSAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}
	
	
	// 소셜 로그아웃
	public void socialLogout(Member loginMember) throws Exception {
		
		String sendUrl = "";
		String prop1 = "";
		String prop2 = "";
		String method = "";
		
		// 페이스북 ID 얻어오기
		String facebookEmail = loginMember.getMemberEmail();
		String facebookId = StringUtils.remove(facebookEmail, "@facebook.com");

		switch(loginMember.getMemberGrade()) {

		case "G" : sendUrl= "https://accounts.google.com/o/oauth2/revoke?token="+loginMember.getAccessToken(); 
				   prop1 = "Content-Type";
				   prop2 = "application/x-www-form-urlencoded"; 
				   method = "POST"; break;
		case "K" : sendUrl ="https://kapi.kakao.com/v1/user/unlink"; 
				   prop1 = "Authorization";
				   prop2 = "Bearer " + loginMember.getAccessToken(); 
				   method = "POST"; break;
		case "F" : sendUrl ="https://graph.facebook.com/v2.7/"+facebookId+"/permissions?access_token="+loginMember.getAccessToken(); 
				   prop1 = "Content-Type";
				   prop2 = "application/x-www-form-urlencoded"; 
				   method = "DELETE"; break;
		case "N" : sendUrl = this.sns.getLogoutUrl() + "&client_id="+sns.getClientId()+"&client_secret="+sns.getClientSecret()+"&access_token="+loginMember.getAccessToken();
				   prop1 = "service_provider";
				   prop2 = "NAVER"; 
				   method = "POST"; break;
		}

	    URL url = new URL(sendUrl);
	    HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	    connection.setRequestMethod(method); 
	    connection.setRequestProperty(prop1, prop2);
	    connection.setDoOutput(true);

	    //Send request
	    //위에서 세팅한 정보값을 바탕으로 요청
	    DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
	    wr.flush();
	    //요청 실행후 dataOutputStream을 close
	    wr.close();
	    connection.getResponseCode();
	    if (connection != null) {
	      connection.disconnect();
	    }


	}
		  
	// 네이버, 구글, 페이스북 사용자 정보 가져오기
	// 1) code를 이용해 accessToken GET -> accessToken을 이용해 이용자 정보를 GET 
	public Member getUserProfile(String code) throws Exception {
		
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request);
		Response response = oauthService.execute(request);
		
		return parseJson(response.getBody(), accessToken);
		
	}
	
	// 2) 이용자 정보를 파싱하여 Member 객체 반환
	private Member parseJson(String body, OAuth2AccessToken accessToken) throws Exception {
		Member member = new Member();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		
		if (this.sns.isGoogle()) {
			if(rootNode.get("name") != null && rootNode.get("email") != null) {
				member.setMemberNick(rootNode.get("name").asText("여행자"));
				member.setMemberPw("socialLogin");
				member.setMemberEmail(rootNode.get("email").asText());
				member.setMemberGrade("G");				
			}
			
		} else if (this.sns.isNaver()) {
			JsonNode resNode = rootNode.get("response");
			if(resNode.get("nickname") != null && resNode.get("email") != null) {					
				member.setMemberNick(resNode.get("nickname").asText("여행자"));
				member.setMemberPw("socialLogin");
				member.setMemberEmail(resNode.get("email").asText());
			}
			// 네이버는 동의 체크 빠졌을 경우를 위해 memberGrade를 남겨준다.
			member.setMemberGrade("N");
			
		} else if (this.sns.isFacebook()) {
			member.setMemberNick(rootNode.get("name").asText("여행자"));
			member.setMemberPw("socialLogin");
			String id = rootNode.get("id").asText();
			member.setMemberEmail(id+"@facebook.com");
			member.setMemberGrade("F");
		} 

		member.setAccessToken(accessToken.getAccessToken().toString());

		return member;
	}
	
	
	// 카카오 사용자 정보 가져오기
	// 1) code를 이용해 accessToken GET
	public Member getKakaoProfile(String code) throws Exception {

		String accessToken = "";
		RestTemplate rt = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "b87de33b6c8fe6b2977868b55731dae3");
		params.add("redirect_uri", "http://localhost:8080/wtwi/member/auth/kakao/callback");
		params.add("code", code);
		params.add("client_secret", "496Pgfenz4y5ff9FxZtM7o51KEcl4WF0");

		HttpEntity<MultiValueMap<String, String>> kakaoRequest = new HttpEntity<>(params, headers);

		ResponseEntity<JSONObject> apiResponse = rt.postForEntity("https://kauth.kakao.com/oauth/token", kakaoRequest,
				JSONObject.class);
		JSONObject responseBody = apiResponse.getBody();

		accessToken = (String) responseBody.get("access_token");
		return getKaKaoMember(accessToken);
	}
	
	// 2) accessToken을 이용해 이용자 정보를 GET
	private Member getKaKaoMember(String accessToken) throws Exception {
		RestTemplate rt = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "bearer " + accessToken);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers);

		ResponseEntity<String> response = rt.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
				kakaoProfileRequest, String.class);
		return parseKakaoJson(response.getBody(), accessToken);
	}

	// 3) 이용자 정보를 파싱하여 Member 객체 반환
	private Member parseKakaoJson(String body, String accessToken) throws Exception {
		Member member = new Member();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		JsonNode properties = rootNode.path("properties");
		JsonNode kakaoAccount = rootNode.path("kakao_account");
		
		if(properties.get("nickname") != null && kakaoAccount.get("email") != null) {	
			member.setMemberNick(properties.get("nickname").asText("여행자"));
			member.setMemberPw("socialLogin");
			
			member.setMemberEmail(kakaoAccount.get("email").asText());
			member.setMemberGrade("K");
		}
		member.setAccessToken(accessToken);
		
		return member;
	}

}
