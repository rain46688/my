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
	// 정규화체크(공백이없는 2~6자리 문자)
	@Pattern(regexp = "\\S{2,6}", message = "이름은 2~6자로 입력해주세요.")
	private String name;
	@Column
	@NotNull
	@Pattern(regexp = "\\d{1,3}", message = "숫자만 입력가능합니다.")
	// int형태는 size체크 불가
	private String age;
	@Id // 테이블의 primary key로 매핑됨
	@Size(min = 4, max = 8, message = "아이디는 4~8자리이어야 합니다.")
	private String id;
	@Column
	@NotNull
	@Pattern(regexp = "\\S", message = "공백문자를 입력할 수 없습니다.")
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
