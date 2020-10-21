package com.kh.spring.demo.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.demo.model.service.DemoService;
import com.kh.spring.demo.model.vo.Demo;

//web mvc ������Ʈ���� controller ��ü�� spring-bean���� ����Ҷ���
//@Controller�� �����
@Controller
public class DemoController {

	@Autowired
	@Qualifier("service")
	private DemoService service;

	@RequestMapping("/demo/demoList.do")
	public String selectDemo(Model m) {
		List<Demo> list = service.selectDemoList();
		m.addAttribute("list", list);
		return "demo/demoList";
	}

	@RequestMapping("/insertDev.do")
	public String insertDev(Demo demo) {

		int result = service.insertDev(demo);
		System.out.println(result);
		// return "index";
		// return "redirect:WEB-INF/index.jsp";//�̷��� ���� �ȵ�!! ���̷�Ʈ�� JSP�� ���� ���Ѵ�.
		return "redirect:/"; // �̷������� ���� ��û���� ���ư��ߵȴ�.
		// 1.msg.jsp�� �̿��ϴ� ���!
		// 2. sendRedirect�̿��ϴ� ���! -> String ���ϰ��� redirect:��������.jsp
		// ���������� �����ʰ� �� ������������ �ּҰ��� �ٲ����
	}

	@RequestMapping(value = "/updateDev.do", method = RequestMethod.GET)
	public String updateDevEnd(Demo demo, Model m) {
		String loc = "";
		String msg = "";
		System.out.println("GET");
		System.out.println("demo : " + demo);

		for (String s : demo.getDevLang()) {
			System.out.println(s + " ");
		}

		try {
			int result = service.updateDev(demo);
			m.addAttribute("loc", "/demo/demoList.do");
			m.addAttribute("msg", "���� �����߽��ϴ�.");
			return "common/msg";
		} catch (Exception e) {
			m.addAttribute("loc", "/demo/demoList.do");
			m.addAttribute("msg", "���� �����߽��ϴ�.");
			return "common/msg";
		}
	}

	@RequestMapping("/deleteDev.do")
	public String deleteDev(String dno, Model m) {
		String loc = "";
		String msg = "";
		try {
			int result = service.deleteDev(dno);
			m.addAttribute("loc", "/demo/demoList.do");
			m.addAttribute("msg", "���� �����Ͽ����ϴ�.");
			return "common/msg";
		} catch (Exception e) {
			m.addAttribute("loc", "/demo/demoList.do");
			m.addAttribute("msg", "���� �����Ͽ����ϴ�.");
			return "common/msg";
		}
	}

//	@Autowired
//	private DemoServiceImpl service2;
// �̷������� ����ԵǸ� ��� �׽�Ʈ�� ���񽺷� �׽�Ʈ �غ��� �� ���񽺿��� �׽�Ʈ�Ϸ��� �ٽ� �� �������� �ٲ�ߵ�, �������̽����ϸ� �׳� ������ ���ְ� �׽�Ʈ ���񽺸�
// ���������־ ���� �׷��� �������� �׸��� �������̽����ϸ� �������� ���� Impl ��ü�� ���ü�����

	// Ŭ���̾�Ʈ�� ��û�� �ּҶ� ���εǴ� �޼ҵ带 �����ؼ� ó��
	// �ּҿ� ������ �ϱ� ���ؼ��� @RequestMapping�� �޼ҵ� ���� ���
	@RequestMapping(value = "/demo/demo.do", method = RequestMethod.GET)
	public String demo() {
		// ��ȯ���� �ƹ��ų� �ᵵ�� void����(�ƹ��͵� ��ȯ���Ҷ� ajax ������ ��ȯ���� �ʿ������ ���) �ٵ� ���� �������ϰ� String�� ��

		return "demo/demo";// RequestDispatcher().forward() ȣ��� ����
		// ���� bean���� ����� ViewResolver���� ��
		// <beans:bean
		// servlet-context.xml ���Ͼȿ�
		// class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		// �̳����� ��

	}

	// Ŭ���̾�Ʈ�� ������ �����ͳ� ��û������ mappring�޼ҵ忡�� ó���Ϸ���
	// HttpServletRequest.get
	// �� ������ �Ű������� �����ؼ� ó���Ҽ��� ����
	// �Ű������� �����ϸ� �ڷ����� �´� ���� spring�� ��������
	// mapping�޼ҵ��� �Ű������� �����Ҽ��ִ� Ÿ��
	// HttpServletRequest / HttpServletResponse ��ü
	// HttpSession
	// java.util.Locale ���� ����
	// InputStream, Reader
	// OutputStream, Writer

	// �Ķ���Ͱ�, ������ ���� �����ϴ� ��ü�� �����Ҽ�����
	// Map, Model, ModelAndView
	// �Ķ���Ͱ��� �޴� Vo��ü

	// �Ķ���Ϳ� ������̼��� ���ؼ� Ư�� ���� �޾ƿü�������
	// @RequestParam(Value="name") String name
	// @RequestHeader(Value="���Ű��") ���������
	// @CookieValue(Value="��ŰŰ��") String name

	// @PathValiable("��") String name -> Rest������� �ּҸ� �ۼ�������
	// ex ) @RequestMapping("value=/demo/demo/{��}") -> �������� ó�����Ҽ�����, ?no= �̷��� ������ �ʰ�
	// ������ ���

	// @ResponseBody -> Ŭ���̾�Ʈ���� json������� ���� �����Ҷ�, return�Ǵ� ���� �״�� �����ϴ°�,
	// *springBoot����
	// default�� �����̵�.
	// @RequestBody -> Ŭ���̾�Ʈ���� json����� ������, �׳� String���ι޾Ƽ� ó���ص��ȴ���
	// * ��ü���� spring bean�� ����������. -> jackson

	@RequestMapping("/demo/demo")
	public void demoParam(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException, ServletException {
		String devName = request.getParameter("devName");
		int devAge = Integer.parseInt(request.getParameter("devAge"));
		String devEmail = request.getParameter("devEmail");
		String devGender = request.getParameter("devGender");
		String[] devLang = request.getParameterValues("devLang");

		System.out.println(devName + devAge + devEmail + devGender);
		for (String s : devLang) {
			System.out.printf(s + " ");
		}
		System.out.println();

		// ���� ����
		// Demo demo =
		// Demo.builder().devName(devName).devAge(devAge).devEmail(devEmail).devGender(devGender)
		// .devLang(devLang).build();

		Demo demo = new Demo(0, devName, devAge, devEmail, devGender, devLang);

		request.setAttribute("demo", demo);
		session.setAttribute("userId", devName);

//		response.setContentType("text/html;charset=utf-8");
//		response.getWriter().write("�Ķ���� Ȯ�οϷ�");
		request.getRequestDispatcher("/WEB-INF/views/demo/demoResult.jsp").forward(request, response);
//		return "demo/demoResult";
	}

	// ======================================================================================================================

	// @RequestParaml���� Ŭ���̾�Ʈ ������ �ޱ�
	@RequestMapping("/demo/demo2")
//	public String demo2(@RequestParam(value = "devName") String devName,
//			@RequestParam(value = "devAge", defaultValue = "0") int devAge,
//			@RequestParam(value = "devEmail") String devEmail, @RequestParam(value = "devGender") String devGender,
//			@RequestParam(value = "devLang", required = false) String[] devLang) {
// String���� �ȳѰܵ� ���� ""���� �ѱ� , int�� [] �迭 ���� ��� 400 ������ �߻��� (�߸��� ��û�̶�� ���� ������)
// required = false�� �����ϸ� �ȳ־ ""���� ü���� , defaultValue ������ ���� �ȳѾ�ð�� �⺻���� �־��ټ�����
	// INT���� required �����ϸ� �ȵ� NULL�� ���� INT�� �����Ҷ� ���ܸ� �߻��ϴ� �ȵǴ°�

	public String demo2(String devName, int devAge, String devEmail, String devGender, String[] devLang, Model model) {
		// �̷��Ը� ��� �˾Ƽ� ��Ī�ؼ� �Ѱ��� ��� �� ������ �ɼǵ��� �����ϴ� �����ϱ�
		// HttpServletRequest, HttpSession�� ������
		// Model��ü�� �̿��Ͽ� �����͸� ������ �� ���� -> scope ������ rqquest�� ����
		// Model��ü�� Ȱ���ϴ� ����� request�� ���
		// addAttribute(String,Object)
		// model.addAttribute("demo",
		// Demo.builder().devName(devName).devAge(devAge).devEmail(devEmail)
		// .devGender(devGender).devLang(devLang).build());
		model.addAttribute("demo", new Demo(0, devName, devAge, devEmail, devGender, devLang));
		System.out.println(devName + " " + devAge + " " + devEmail + " " + devGender + " " + devLang);
		return "demo/demoResult";
	}

	// Command�� ������ ó���ϱ� -> �ٷ� Vo��ü�� ������ �ޱ�
	// name�� == setter�� �̸��������ϸ� ������ ����
	// Data Ÿ�Կ� �����ؾ���. 4000 error
	@RequestMapping("/demo/demo3")
	public String demo3(Demo demo, Model m) {

//		System.out.println(demo);

		return "demo/demoResult";
	}

	// Map ��ü�� Ŭ���̾�Ʈ�� ������ �� �޾ƿ��� -> @RequestParam Map map���� ����
	// Map�� key���� �ڵ����� input�±��� name������ �����ȴ�.
	@RequestMapping("/demo/demo4")
	public String demo4(@RequestParam Map<String, Object> param, String[] devLang, Model m) {
//		for (String p : param.keySet()) {
//			System.out.println(param.get(p));
//		}
		System.out.println(param);
		for (String l : devLang) {
			System.out.println(l);
		}
		return "demo/demoResult";
	}

	// ��Ÿ������������
	// @RequestHeader, @CookieValue
	@RequestMapping("/demo/demo.do")
	public String demo(@CookieValue(value = "userId", required = false) String userId,
			@CookieValue(value = "email", defaultValue = "prince0324") String email,
			@RequestHeader(value = "User-agent") String userAgent, @RequestHeader(value = "Referer") String prev) {
		// �⺻���� �ְų� required�� false�� ��� ������ ���Ҽ��ֵ�.
		System.out.println("��Ű�� Ȯ�� : " + userId);
		System.out.println("��Ű�� Ȯ�� : " + email);
		System.out.println("request��� Ȯ�� userAgent : " + userAgent);
		System.out.println("request��� Ȯ�� Referer : " + prev);

		System.out.println("mapping���ҵ� ȣ��");
		return "demo/demo";
	}

}
