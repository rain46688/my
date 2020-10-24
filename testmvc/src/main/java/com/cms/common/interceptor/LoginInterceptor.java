package com.cms.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	protected Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.info(" ===== LoginInterceptor ���İ� ===== ");
		HttpSession session = request.getSession();
		if (session.getAttribute("loginnedMember") == null && session.getAttribute("gname") == null) {
			log.info(" ===== �ش� �������� �α��� ���� �����Ҽ����� ===== ");
			request.setAttribute("msg", "�α����� ���ּ���");
			request.setAttribute("loc", "/loginPage");
			request.getRequestDispatcher("/msg").forward(request, response);
			return false;
		}
		return true;
	}
}
