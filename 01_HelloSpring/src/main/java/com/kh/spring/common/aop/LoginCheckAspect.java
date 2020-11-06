package com.kh.spring.common.aop;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.kh.spring.member.model.vo.Member;

@Component // 빈등록하는거
@Aspect
public class LoginCheckAspect {

	@Around("execution(* com.kh.spring.memo..insert*(..))")
	public Object loginCheck(ProceedingJoinPoint join) throws Throwable {

		// session의 id값이 admin이면 진행하고 아니면 차단

		// 일반 클래스에서 session 가져오기
		HttpSession session = (HttpSession) RequestContextHolder.currentRequestAttributes()
				.resolveReference(RequestAttributes.REFERENCE_SESSION);
		Member login = (Member) session.getAttribute("loginMember");
		if (login == null || !login.getUserId().equals("admin")) {
			// 등록 로직 취소
			// 예외를 발생시켜서 멈춤!
			throw new LoginException("등록 권한이 없습니다.");
		}

		return join.proceed();// 전처리만
	}

}
