package com.wtwi.fin.auth;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class FacebookAPI20 extends DefaultApi20 implements SnsUrls{
	private FacebookAPI20() {
		
	}
	
	private static class InstanceHolder{
		private static final FacebookAPI20 INSTANCE = new FacebookAPI20();
	}  
	
	public static FacebookAPI20 instance() {
			return InstanceHolder.INSTANCE;
	}

	@Override 
	public String getAccessTokenEndpoint() {
		return FACEBOOK_ACCESS_TOKEN;
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return FACEBOOK_AUTH;
	}
	
	
}
