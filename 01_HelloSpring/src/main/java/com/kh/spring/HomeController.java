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
@Controller // spring bean���� ���, ������ ���� -> controller(servlet ����)
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	@Qualifier("test2")
	private BeanTest test;
	// �����س��� ���� ��������� ���� ���� �ܰ迡�� ã�������ٴ� ������ �߻���Ŵ
	// @Autowired�� bean�� Ÿ������ �˻���
	// @Qualifier("test1")�� bean �̸��� �����ؼ� �˻��� �Ѵ�.

	// @Inject, Resource : �ڹ� ���̺귯������ ���� java EE����
	// @Autowired : ������ �����ӿ�ũ���� ������

	@Autowired
	@Qualifier("test3")
	private BeanTest test2;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpServletResponse response) {
		// ���� �������� �����ϴ� ����

		// System.out.println("beanTest Test ��� : " + test.getName());
		// System.out.println("beanTest Test2 ��� : " + test2.getName());
		Cookie c = new Cookie("userId", "admin");
		c.setMaxAge(60 * 60);
		response.addCookie(c);

		return "index";
	}

}
