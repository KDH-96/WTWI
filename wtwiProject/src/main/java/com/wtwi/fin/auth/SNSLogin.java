package com.wtwi.fin.auth;

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

	// scribejava가 제공하는 service
	// 빌드패턴으로 만들어져 있기 때문에 new해서 생성하는 것이 아니라 빌더로 빌드하는 것임
	// 밑에 메소드도 원래라면 우리가 네이버 왔다갔다 해야되고 그런 건데 그게 귀찮으니까 scribejava 쓰는 거임
	private OAuth20Service oauthService;
	private SnsValue sns;

	public SNSLogin(SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId()).apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl()).defaultScope("profile").build(sns.getApi20Instance());

		this.sns = sns;

	}

	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public Member getUserProfile(String code) throws Exception {
		System.out.println("code : " + code);
		System.out.println("naver.getprofileurl : " + this.sns.getProfileUrl());
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
			if (sns.isGoogle())
			member.setMemberNick(rootNode.get("name").asText("여행자"));   
			member.setMemberEmail(rootNode.get("email").asText());
			member.setMemberGrade("G");
		} else if (this.sns.isNaver()) {
			JsonNode resNode = rootNode.get("response");
			member.setMemberNick(resNode.get("nickname").asText("여행자"));
			member.setMemberEmail(resNode.get("email").asText());
			member.setMemberGrade("N");
		}
		
		return member;
	}
}
