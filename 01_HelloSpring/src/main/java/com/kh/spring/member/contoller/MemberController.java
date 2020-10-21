package com.kh.spring.member.contoller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@RequestMapping("/member/memberEnroll.do")
	public String memberEnroll() {
		// member/memberEnroll.jsp
		return "member/memberEnroll";
	}
	
	//회원저장 /member/memberEnrollEnd.do
	@RequestMapping("/member/memberEnrollEnd.do")
	public String memberEnrollEnd(Member member, Model m) {
		
		int result=service.insertMember(member);
		
		String msg="";
		String loc="";
		if(result>0) {
			msg="회원가입성공";
			loc="/";
		}
		else {
			msg="회원가입실패";
			loc="/member/memberEnroll.do";
		}
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		
		return "common/msg";
	}
}













