package com.kh.spring.common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

@Component // �����ϴ°�
@Aspect
public class LoggerAspect {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	// ����Ʈ�� , advice
	@Pointcut("execution(* com.kh.spring..*(..))")
	public void loggerPointCut() {
	}

	// advice �� @Before, @After, @Around

	// Aspect��ü�� �������� ����� �޼ҵ带 ����
	@Before("loggerPointCut()")
	public void before(JoinPoint join) throws Exception {
		log.info("LoggerAspect");
		Signature sig = join.getSignature();// �Ķ���Ͱ� Ȯ��
		Object[] params = join.getArgs();
		for (Object obj : params) {
			System.out.println(obj);
		}
		log.debug("@Before aspectŬ�������� ��� !!" + sig.getDeclaringTypeName() + " : " + sig.getName());
	}

	// ����Ʈ�� , advice
	@Pointcut("execution(* com.kh.spring..*dao..insert*(..))")
	public void InsertPointCut() {
	}

	// advice after �����ϱ�
	@After("InsertPointCut()")
	public void after(JoinPoint join) throws Exception {
		Signature sig = join.getSignature();
		log.debug("@After �޼ҵ� ���� �� ��� �ϱ� " + sig.getDeclaringTypeName() + " : " + sig.getName());
	}

	// Around�����ϱ�
	// �޼ҵ� ������, �޼ҵ� ���� �� ������ �ѹ��� ������ �� �ִ°�
	// Controller�� Ŭ��������
	@Pointcut("execution(* com.kh.spring..*Controller.*(..))")
	public void controllerAll() {
	};

	@Around("controllerAll()")
	// around �Ҷ��� �޼ҵ忡�� Object�� ��ȯ������ �־���ߵȴ�.
	public Object loggerAround(ProceedingJoinPoint joinPoint) throws Throwable {
		// after �ڵ�
		String methodName = joinPoint.getSignature().getName();
		log.debug(methodName + "() �޼ҵ� ����!");
		// �޼ҵ� ���� �ð�
		StopWatch stopWatch = new StopWatch();

		stopWatch.start();
		// return joinPoint.proceed();//�̷��� ���⼭ ������ before�� ��������

		Object obj = joinPoint.proceed();// ��&�ĸ� ������ ����, �̰� �Ǵ¼��� ��ó���� �ٲ�°�
		// before �ڵ�
		stopWatch.stop();
		// stopWatch�� ���۰� ���� �ð��� ���� ����

		log.debug(methodName + "() �ҿ�ð� : " + stopWatch.getTotalTimeMillis() + " ��(ms) ");

		return obj;
	}
}
