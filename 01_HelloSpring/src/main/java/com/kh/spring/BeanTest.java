package com.kh.spring;

/*@Component*/
public class BeanTest {
//java ���� �տ� S��� ������ ������ Bean���� ��ϵǼ� ���������� �����ȴٴ� �ǹ�
//�Ϲ� POJO��ü�� @Component ������̼� ó���� ���� �������� �����ϴ� ���Ϸ� ���������

//	private String name = "test��ü";
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
