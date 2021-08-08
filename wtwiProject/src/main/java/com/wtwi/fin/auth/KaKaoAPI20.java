package com.wtwi.fin.auth;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class KaKaoAPI20 extends DefaultApi20 implements SnsUrls{
	private KaKaoAPI20() {
		
	}
	
	private static class InstanceHolder{
		private static final KaKaoAPI20 INSTANCE = new KaKaoAPI20();
	}  
	
	public static KaKaoAPI20 instance() {
			return InstanceHolder.INSTANCE;
	}

	@Override 
	public String getAccessTokenEndpoint() {
		return KAKAO_ACCESS_TOKEN;
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return KAKAO_AUTH;
	}
	
	
}
