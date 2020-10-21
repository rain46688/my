package com.kh.spring.member.contoller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

@Controller
//@SessionAttributes(value={"loginMember","member"})
//하나뿐 아니라 여러개 넣을수있음
@SessionAttributes("loginMember")
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private BCryptPasswordEncoder encoder;

	@RequestMapping("/member/memberUpdateEnd.do")
	public ModelAndView memberUpdateEnd(Member m, ModelAndView mv) {
		int result = service.updateMember(m);

		String msg = "";
		if (result > 0) {
			msg = "회원 수정 성공";
			mv.addObject("loginMember", m);
		} else {
			msg = "회원 수정 실패";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", "/");
		mv.setViewName("common/msg");
		return mv;
	}

	@RequestMapping("/member/memberUpade.do")
	public ModelAndView memberUpdate(HttpSession session, ModelAndView mv) {
		Member member = (Member) session.getAttribute("loginMember");
		Member m = service.loginMember(member);
		// 반환하는값을 ModelAndView객체를 이용해보자
		// ModelAndView - > Model 데이터를 보환, View 클라이언트에게 보여줄 화면
		// 전송할 데이터와 View를 한번에 설정하는 객체

		// 데이터를 보관하기 위해서 addObject를 사용함.
		mv.addObject("member", m);
		// 화면 선택 -> ViewResolver에게 전송이됨
		mv.setViewName("member/memberUpdate");

		return mv;
	}

	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll() {
		// member/memberEnroll.jsp
		return "member/memberEnroll";
	}

	@RequestMapping("/member/memberLogout.do")
	public String memberLogout(HttpSession session, SessionStatus status) {
		// session을 삭제하려면
		// isComplete()로 확인 setComplete()로 제거

		if (!status.isComplete()) {
			status.setComplete();// 이게 세션 삭제 로그아웃
		}
		// if (session != null)
		// session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/member/memberLogin.do", method = RequestMethod.POST)
	public String memberLogin(Member member, Model m) {
//@session을 사용하면 파라미터에서 세션을 받을 필요가없다.
		Member login = service.loginMember(member);
		boolean lo = false;
		if (login != null) {
			lo = encoder.matches(member.getPassword(), login.getPassword());
			System.out.println("입력한 비번 : " + member.getPassword());
			System.out.println("디비에서 가져온 비번 : " + login.getPassword());
		}

		String msg = "";
		String loc = "";
		String path = "";

		if (lo && login != null) {
			msg = "로그인 성공.";
			path = "redirect:/";
			// session.setAttribute("loginMember", member);
			// spring에서는 model에 있는 값을 session에서 관리하게 처리할수있음
			// @SessionAttributes선언 -> 클래스 선언부에
			System.out.println("member : " + login);
			m.addAttribute("loginMember", login);
		} else {
			msg = "해당 아이디 혹은 비밀번호가 틀립니다.";
			loc = "/";
			path = "common/msg";
		}

		m.addAttribute("msg", msg);
		m.addAttribute("loc", loc);
		return path;
	}

	// 회원저장 /member/memberEnrollEnd.do
	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollEnd(Member member, Model m) {

		System.out.println("원본 : " + member.getPassword());
		String endodePw = encoder.encode(member.getPassword());
		System.out.println("암호화 된 값 : " + endodePw);

		// encoder.matches(rawPassword, encodedPassword)
		// 를 통해서 암호가 맞는지 여부를 증명한다

		member.setPassword(endodePw);
		int result = service.insertMember(member);

		String msg = "";
		String loc = "";
		if (result > 0) {
			msg = "회원가입성공";
			loc = "/";
		} else {
			msg = "회원가입실패";
			loc = "/member/memberEnroll.do";
		}
		m.addAttribute("msg", msg);
		m.addAttribute("loc", loc);

		return "common/msg";
	}
}
