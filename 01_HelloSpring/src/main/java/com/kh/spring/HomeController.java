package com.kh.spring;

import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller // spring bean으로 등록, 역할을 지정 -> controller(servlet 역할)
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	@Qualifier("test2")
	private BeanTest test;
	// 선언해놓고 빈을 끊어버리면 서버 실행 단계에서 찾을수없다는 에러를 발생시킴
	// @Autowired는 bean을 타입으로 검색함
	// @Qualifier("test1")는 bean 이름을 지정해서 검색을 한다.

	// @Inject, Resource : 자바 라이브러리에서 제공 java EE에서
	// @Autowired : 스프링 프레임워크에서 제공함

	@Autowired
	@Qualifier("test3")
	private BeanTest test2;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletResponse response) {
		// 메인 페이지로 연결하는 서블릿

		// System.out.println("beanTest Test 출력 : " + test.getName());
		// System.out.println("beanTest Test2 출력 : " + test2.getName());
		Cookie c = new Cookie("userId", "admin");
		c.setMaxAge(60 * 60);
		response.addCookie(c);

		return "index";
	}

}
