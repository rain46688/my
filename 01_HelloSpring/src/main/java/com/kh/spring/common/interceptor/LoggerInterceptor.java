package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter {

	private Logger log = LoggerFactory.getLogger(LoggerInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub

		log.debug(" =========== start =========== ");
		log.debug(request.getRequestURI());
		log.debug(" ----------------------------- ");

		return super.preHandle(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

		log.debug(request.getRequestURI() + "실행 종료");
		log.debug("연결화면 : " + modelAndView.getViewName());
		log.debug(" =========== end =========== ");

		super.postHandle(request, response, handler, modelAndView);
	}

}
