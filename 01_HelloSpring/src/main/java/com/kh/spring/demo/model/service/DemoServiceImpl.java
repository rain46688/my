package com.kh.spring.demo.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.demo.model.dao.DemoDao;

//web mvc ������Ʈ���� service ������ �ϴ� ��ü�� spring-bean���� ����Ϸ���
//@Service�� �̿���.

@Service
public class DemoServiceImpl implements DemoService {

	@Autowired
	private DemoDao dao;

}
