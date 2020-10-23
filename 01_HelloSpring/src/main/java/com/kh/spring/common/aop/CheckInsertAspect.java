package com.kh.spring.common.aop;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.springframework.beans.factory.annotation.Autowired;

public class CheckInsertAspect {

	@Autowired
	private CheckDao dao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void after(JoinPoint join) throws Exception {
		System.out.println("CheckInsertAspect ½ÇÇàµÊ?");
		Map param = new HashMap();
		Signature sig = join.getSignature();
		param.put("uri", sig.getDeclaringTypeName() + "." + sig.getName() + "()");
		param.put("day", new Date());
		dao.insertCheck(param);

	}

}
