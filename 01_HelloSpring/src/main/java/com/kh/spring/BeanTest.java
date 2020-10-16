package com.kh.spring;

/*@Component*/
public class BeanTest {
//java 파일 앞에 S라는 문양이 있으면 Bean으로 등록되서 스프링에서 관리된다는 의미
//일반 POJO객체를 @Component 어노테이션 처리로 인해 스프링이 관리하는 파일로 만들수있음

//	private String name = "test객체";
	private String name;

	public BeanTest() {
		// TODO Auto-generated constructor stub
	}

	public BeanTest(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
