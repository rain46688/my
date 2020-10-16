package com.kh.spring.demo.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.spring.demo.model.service.DemoService;
import com.kh.spring.demo.model.vo.Demo;

//web mvc 프로젝트에서 controller 객체를 spring-bean으로 등록할때는
//@Controller를 사용함
@Controller
public class DemoController {

	@Autowired
	private DemoService service;

//	@Autowired
//	private DemoServiceImpl service2;
// 이런식으로 만들게되면 잠깐 테스트용 서비스로 테스트 해보다 본 서비스에서 테스트하려면 다시 다 변수명을 바꿔야됨, 인터페이스로하면 그냥 구현만 해주고 테스트 서비스를
// 돌려볼수있어서 편함 그러니 저렇게함 그리고 인터페이스로하면 다형성에 의해 Impl 객체가 들어올수있음

	// 클라이언트가 요청한 주소랑 매핑되는 메소드를 생성해서 처리
	// 주소와 매핑을 하기 위해서는 @RequestMapping를 메소드 위에 사용
	@RequestMapping(value = "/demo/demo.do", method = RequestMethod.GET)
	public String demo() {
		// 반환형을 아무거나 써도됨 void도됨(아무것도 반환안할때 ajax 쓸때나 반환값이 필요없을때 등등) 근데 보통 베이직하게 String을 씀

		return "demo/demo";// RequestDispatcher().forward() 호출과 동일
		// 내가 bean으로 등록한 ViewResolver에게 줌
		// <beans:bean
		// servlet-context.xml 파일안에
		// class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		// 이넘한테 줌

	}

	// 클라이언트가 전송한 데이터나 요청내용을 mappring메소드에서 처리하려면
	// HttpServletRequest.get
	// 각 정보를 매개변수로 선언해서 처리할수가 있음
	// 매개변수를 선언하면 자료형에 맞는 값을 spring이 대입해줌
	// mapping메소드의 매개변수로 선언할수있는 타입
	// HttpServletRequest / HttpServletResponse 객체
	// HttpSession
	// java.util.Locale 국가 관련
	// InputStream, Reader
	// OutputStream, Writer

	// 파라미터값, 서버의 값을 보관하는 객체를 선언할수있음
	// Map, Model, ModelAndView
	// 파라미터값을 받는 Vo객체

	// 파라미터에 어노테이션을 통해서 특정 값을 받아올수도있음
	// @RequestParam(Value="name") String name
	// @RequestHeader(Value="헤더키값") 헤더정보들
	// @CookieValue(Value="쿠키키값") String name

	// @PathValiable("값") String name -> Rest방식으로 주소를 작성했을때
	// ex ) @RequestMapping("value=/demo/demo/{값}") -> 값가지고 처리를할수있음, ?no= 이렇게 보내지 않고
	// 보내는 방식

	// @ResponseBody -> 클라이언트에게 json방식으로 값을 전송할때, return되는 값을 그대로 전송하는것,
	// *springBoot에서
	// default로 선언이됨.
	// @RequestBody -> 클라이언트에게 json방식을 받을때, 그냥 String으로받아서 처리해도된다함
	// * 객체맵핑 spring bean을 등록해줘야함. -> jackson

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

		// 세션 생성
		Demo demo = Demo.builder().devName(devName).devAge(devAge).devEmail(devEmail).devGender(devGender)
				.devLang(devLang).build();

//		Demo demo = new Demo(0, devName, devAge, devEmail, devGender, devLang);

		request.setAttribute("demo", demo);
		session.setAttribute("userId", devName);

//		response.setContentType("text/html;charset=utf-8");
//		response.getWriter().write("파라미터 확인완료");
		request.getRequestDispatcher("/WEB-INF/views/demo/demoResult.jsp").forward(request, response);
//		return "demo/demoResult";
	}

	// ======================================================================================================================

	// @RequestParaml으로 클라이언트 데이터 받기
	@RequestMapping("/demo/demo2")
//	public String demo2(@RequestParam(value = "devName") String devName,
//			@RequestParam(value = "devAge", defaultValue = "0") int devAge,
//			@RequestParam(value = "devEmail") String devEmail, @RequestParam(value = "devGender") String devGender,
//			@RequestParam(value = "devLang", required = false) String[] devLang) {
// String값은 안넘겨도 공백 ""으로 넘김 , int나 [] 배열 같은 경우 400 에러를 발생함 (잘못된 요청이라는 에러 페이지)
// required = false로 설정하면 안넣어도 ""으로 체워줌 , defaultValue 값으로 값이 안넘어올경우 기본값을 넣어줄수있음
	// INT형은 required 설정하면 안됨 NULL로 들어가고 INT로 변경할때 예외를 발생하니 안되는거

	public String demo2(String devName, int devAge, String devEmail, String devGender, String[] devLang, Model model) {
		// 이렇게만 적어도 알아서 매칭해서 넘겨줌 대신 위 설정값 옵션들은 사용못하니 주의하길
		// HttpServletRequest, HttpSession도 있지만
		// Model객체를 이용하여 데이터를 보관할 수 있음 -> scope 영역은 rqquest와 동일
		// Model객체를 활용하는 방법은 request와 비슷
		// addAttribute(String,Object)
		model.addAttribute("demo", Demo.builder().devName(devName).devAge(devAge).devEmail(devEmail)
				.devGender(devGender).devLang(devLang).build());
		System.out.println(devName + " " + devAge + " " + devEmail + " " + devGender + " " + devLang);
		return "demo/demoResult";
	}

	// Command로 데이터 처리하기 -> 바로 Vo객체로 데이터 받기
	@RequestMapping("/demo/demo3")
	public String demo3(Demo demo, Model m) {
		System.out.println(demo);
		return "demo/demoResult";
	}

}
