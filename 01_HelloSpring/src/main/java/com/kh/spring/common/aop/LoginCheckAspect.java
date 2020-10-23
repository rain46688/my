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

@Component // �����ϴ°�
@Aspect
public class LoginCheckAspect {

	@Around("execution(* com.kh.spring.memo..insert*(..))")
	public Object loginCheck(ProceedingJoinPoint join) throws Throwable {

		// session�� id���� admin�̸� �����ϰ� �ƴϸ� ����

		// �Ϲ� Ŭ�������� session ��������
		HttpSession session = (HttpSession) RequestContextHolder.currentRequestAttributes()
				.resolveReference(RequestAttributes.REFERENCE_SESSION);
		Member login = (Member) session.getAttribute("loginMember");
		if (login == null || !login.getUserId().equals("admin")) {
			// ��� ���� ���
			// ���ܸ� �߻����Ѽ� ����!
			throw new LoginException("��� ������ �����ϴ�.");
		}

		return join.proceed();// ��ó����
	}

}
