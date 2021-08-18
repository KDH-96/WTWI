package com.wtwi.fin.common.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.wtwi.fin.member.model.vo.Member;

@Component
public class LogoutInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String destUri = request.getRequestURI();
		String destQuery = request.getQueryString();
		String dest = (destQuery == null) ? destUri : destUri+"?"+destQuery;
		dest = dest.substring(5);
		
		Member member = (Member)session.getAttribute("loginMember");
		
		
		 if(member != null){
			 return true;
		 }
	        else {
	        	request.getSession().setAttribute("dest", "이미 로그아웃이 완료된 상태입니다.");
	            response.sendRedirect("/wtwi/main");
	            return false;
		     }
		
	}
	
}
