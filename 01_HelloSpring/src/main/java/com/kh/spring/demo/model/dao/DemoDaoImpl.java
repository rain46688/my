package com.kh.spring.demo.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.spring.demo.model.vo.Demo;

//dao역할을 하는 객체는 @Repository를 사용함. 
//@Repository
@Repository
public class DemoDaoImpl implements DemoDao {

	@Override
	public int insertDev(SqlSessionTemplate session, Demo demo) {
		// TODO Auto-generated method stub
		return session.insert("dev.insertDev", demo);
	}

	@Override
	public List<Demo> selectDemoList(SqlSessionTemplate session) {
		// TODO Auto-generated method stub
		return session.selectList("dev.selectDemoList");
	}

	@Override
	public int deleteDev(SqlSessionTemplate session, String dno) {
		// TODO Auto-generated method stub
		return session.delete("dev.deleteDev", dno);
	}

	@Override
	public int updateDev(SqlSessionTemplate session, Demo demo) {
		// TODO Auto-generated method stub
		return session.update("dev.updateDev", demo);
	}

}
