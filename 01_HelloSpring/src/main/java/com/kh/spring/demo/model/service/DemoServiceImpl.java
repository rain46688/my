package com.kh.spring.demo.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.demo.model.dao.DemoDao;
import com.kh.spring.demo.model.vo.Demo;

//web mvc ������Ʈ���� service ������ �ϴ� ��ü�� spring-bean���� ����Ϸ���
//@Service�� �̿���.

@Service("service")
public class DemoServiceImpl implements DemoService {

	@Autowired
	private DemoDao dao;

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertDev(Demo demo) {
		// TODO Auto-generated method stub
		// SqlSession ����
		// dao���� �ش� ���� ȣ��
		return dao.insertDev(session, demo);
	}

	@Override
	public List<Demo> selectDemoList() {
		// TODO Auto-generated method stub
		List<Demo> list = dao.selectDemoList(session);
		return list;
	}

	@Override
	public int deleteDev(String dno) {
		// TODO Auto-generated method stub
		return dao.deleteDev(session, dno);

	}

	@Override
	public int updateDev(Demo demo) {
		// TODO Auto-generated method stub
		return dao.updateDev(session, demo);
	}

}
