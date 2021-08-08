package com.wtwi.fin.auth;

import java.nio.file.spi.FileSystemProvider;

import javax.servlet.http.HttpSession;

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

	public SNSLogin() {
		// TODO Auto-generated constructor stub
	}

	public SNSLogin(SNSValue sns) {

		this.oauthService = new ServiceBuilder(sns.getClientId()).apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl()).build(sns.getApi20Instance());

		this.sns = sns;

	}

	public String getSNSAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public Member getUserProfile(String code) throws Exception {
	
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request);

		Response response = oauthService.execute(request);
		return parseJson(response.getBody());

	}

	private Member parseJson(String body) throws Exception {
		Member member = new Member();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);

		if (this.sns.isGoogle()) {
			member.setMemberNick(rootNode.get("name").asText("여행자"));
			member.setMemberPw("socialLogin");
			member.setMemberEmail(rootNode.get("email").asText());
			member.setMemberGrade("G");
			
		} else if (this.sns.isNaver()) {
			JsonNode resNode = rootNode.get("response");
			member.setMemberNick(resNode.get("nickname").asText("여행자"));
			member.setMemberPw("socialLogin");
			member.setMemberEmail(resNode.get("email").asText());
			member.setMemberGrade("N");
		} 
		

		return member;
	}
	
	
	// 카카오
	// 1) code를 이용해 accessToken GET
	public Member getKakaoProfile(String code) throws Exception {

		String accessToken = "";
		RestTemplate rt = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "b87de33b6c8fe6b2977868b55731dae3");
		params.add("redirect_uri", "http://localhost:8080/fin/member/auth/kakao/callback");
		params.add("code", code);
		params.add("client_secret", "flqtQy9HB3KdhcMBhnlDllJetmlSg4kf");

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
		return parseKakaoJson(response.getBody());
	}

	// 3) 이용자 정보를 파싱하여 Member 객체 반환
	private Member parseKakaoJson(String body) throws Exception {
		Member member = new Member();

		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);

		JsonNode properties = rootNode.path("properties");
		member.setMemberNick(properties.get("nickname").asText("여행자"));
		member.setMemberPw("socialLogin");
		
		JsonNode kakaoAccount = rootNode.path("kakao_account");
		member.setMemberEmail(kakaoAccount.get("email").asText());
		member.setMemberGrade("K");
		
		return member;
	}

}
