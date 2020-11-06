package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.spring.member.model.vo.Member;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	private Logger log = LoggerFactory.getLogger(LoggerInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		// 로그인 확인하기
		Member login = (Member) request.getSession().getAttribute("loginMember");
		if (login == null) {
			log.warn("로그인 하지않고 접근함 !" + request.getRequestURI());
			request.setAttribute("msg", "로그인 후 이용이 가능합니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/msg").forward(request, response);
			return false;
		} else {
			return super.preHandle(request, response, handler);
		}
	}

}
