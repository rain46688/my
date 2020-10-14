package com.cms.model.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Entity
public class PersonVO {

	@Column
	@NotNull
	// ����ȭüũ(�����̾��� 2~6�ڸ� ����)
	@Pattern(regexp = "\\S{2,6}", message = "�̸��� 2~6�ڷ� �Է����ּ���.")
	private String name;
	@Column
	@NotNull
	@Pattern(regexp = "\\d{1,3}", message = "���ڸ� �Է°����մϴ�.")
	// int���´� sizeüũ �Ұ�
	private String age;
	@Id // ���̺��� primary key�� ���ε�
	@Size(min = 4, max = 8, message = "���̵�� 4~8�ڸ��̾�� �մϴ�.")
	private String id;
	@Column
	@NotNull
	@Pattern(regexp = "\\S", message = "���鹮�ڸ� �Է��� �� �����ϴ�.")
	private String address;

	// getter, setter
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
