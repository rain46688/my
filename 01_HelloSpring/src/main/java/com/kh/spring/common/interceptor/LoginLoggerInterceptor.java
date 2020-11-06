package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginLoggerInterceptor extends HandlerInterceptorAdapter {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		log.debug("로그인 아이디 : " + request.getParameter("userId"));

		return super.preHandle(request, response, handler);
	}

}
