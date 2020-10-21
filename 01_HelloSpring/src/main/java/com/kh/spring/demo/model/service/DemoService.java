package com.kh.spring.demo.model.service;

import java.util.List;

import com.kh.spring.demo.model.vo.Demo;

public interface DemoService {

	int insertDev(Demo demo);

	List<Demo> selectDemoList();

	int deleteDev(String dno);

	int updateDev(Demo demo);

}
