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
		// �α��� Ȯ���ϱ�
		Member login = (Member) request.getSession().getAttribute("loginMember");
		if (login == null) {
			log.warn("�α��� �����ʰ� ������ !" + request.getRequestURI());
			request.setAttribute("msg", "�α��� �� �̿��� �����մϴ�.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/msg").forward(request, response);
			return false;
		} else {
			return super.preHandle(request, response, handler);
		}
	}

}
