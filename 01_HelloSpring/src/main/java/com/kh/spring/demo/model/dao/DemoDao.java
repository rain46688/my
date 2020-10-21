package com.kh.spring.demo.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.spring.demo.model.vo.Demo;

public interface DemoDao {

	int insertDev(SqlSessionTemplate session, Demo demo);

	List<Demo> selectDemoList(SqlSessionTemplate session);

	int updateDev(SqlSessionTemplate session, Demo demo);

	int deleteDev(SqlSessionTemplate session, String dno);

}
