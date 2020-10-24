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
		log.info(" ===== LoginInterceptor 거쳐감 ===== ");
		HttpSession session = request.getSession();
		if (session.getAttribute("loginnedMember") == null && session.getAttribute("gname") == null) {
			log.info(" ===== 해당 페이지는 로그인 없이 접근할수없음 ===== ");
			request.setAttribute("msg", "로그인을 해주세요");
			request.setAttribute("loc", "/loginPage");
			request.getRequestDispatcher("/msg").forward(request, response);
			return false;
		}
		return true;
	}
}
