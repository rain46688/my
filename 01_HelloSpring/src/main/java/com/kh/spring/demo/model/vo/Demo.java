package com.kh.spring.demo.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@AllArgsConstructor
@Builder // nw Demo().Build().devName("유병승").age(19) 이런식으로 만듬
public class Demo {

	// private int devNo;
	private String devName;
	private int devAge;
	private String devEmail;
	private String devGender;
	private String[] devLang;

}
