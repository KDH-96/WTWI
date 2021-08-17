package com.wtwi.fin.common.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.wtwi.fin.member.model.vo.Member;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginMember");

		 if(member != null){return true;}
	        
	        else{
	            String destUri = request.getRequestURI();
	            String destQuery = request.getQueryString();
	            String dest = (destQuery == null) ? destUri : destUri+"?"+destQuery;
	            dest = dest.substring(5);
	            request.getSession().setAttribute("dest", dest);
	            System.out.println(dest);
	  
	            response.sendRedirect("/wtwi/member/login");
	            return false;
	        }
		
	}
	
}
