package com.kh.spring.demo.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.demo.model.dao.DemoDao;
import com.kh.spring.demo.model.vo.Demo;

//web mvc 프로젝트에서 service 역할을 하는 객체를 spring-bean으로 등록하려면
//@Service를 이용함.

@Service("service")
public class DemoServiceImpl implements DemoService {

	@Autowired
	private DemoDao dao;

	@Autowired
	private SqlSessionTemplate session;

	@Override
	public int insertDev(Demo demo) {
		// TODO Auto-generated method stub
		// SqlSession 생성
		// dao에서 해당 서비스 호출
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
