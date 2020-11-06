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

@Component // 빈등록하는거
@Aspect
public class LoggerAspect {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	// 포인트컷 , advice
	@Pointcut("execution(* com.kh.spring..*(..))")
	public void loggerPointCut() {
	}

	// advice 각 @Before, @After, @Around

	// Aspect객체로 공통으로 실행될 메소드를 지정
	@Before("loggerPointCut()")
	public void before(JoinPoint join) throws Exception {
		log.info("LoggerAspect");
		Signature sig = join.getSignature();// 파라미터값 확인
		Object[] params = join.getArgs();
		for (Object obj : params) {
			System.out.println(obj);
		}
		log.debug("@Before aspect클래스에서 출력 !!" + sig.getDeclaringTypeName() + " : " + sig.getName());
	}

	// 포인트컷 , advice
	@Pointcut("execution(* com.kh.spring..*dao..insert*(..))")
	public void InsertPointCut() {
	}

	// advice after 적용하기
	@After("InsertPointCut()")
	public void after(JoinPoint join) throws Exception {
		Signature sig = join.getSignature();
		log.debug("@After 메소드 종료 후 출력 하기 " + sig.getDeclaringTypeName() + " : " + sig.getName());
	}

	// Around실행하기
	// 메소드 실행전, 메소드 실행 후 로직을 한번에 구현할 수 있는것
	// Controller는 클래스명임
	@Pointcut("execution(* com.kh.spring..*Controller.*(..))")
	public void controllerAll() {
	};

	@Around("controllerAll()")
	// around 할때는 메소드에서 Object를 반환값으로 넣어줘야된다.
	public Object loggerAround(ProceedingJoinPoint joinPoint) throws Throwable {
		// after 코드
		String methodName = joinPoint.getSignature().getName();
		log.debug(methodName + "() 메소드 시작!");
		// 메소드 실행 시간
		StopWatch stopWatch = new StopWatch();

		stopWatch.start();
		// return joinPoint.proceed();//이렇게 여기서 막으면 before랑 같은것임

		Object obj = joinPoint.proceed();// 전&후를 나누는 기준, 이거 되는순간 후처리로 바뀌는거
		// before 코드
		stopWatch.stop();
		// stopWatch는 시작과 끝값 시간을 갖고 있음

		log.debug(methodName + "() 소요시간 : " + stopWatch.getTotalTimeMillis() + " 초(ms) ");

		return obj;
	}
}
