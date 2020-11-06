package com.cms.model.vo;

import javax.persistence.Entity;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@ToString
@EqualsAndHashCode
public class Login {

	@NotEmpty(message = "아이디를 정확히 입력해주세요.")
	@Size(min = 4, max = 16)
	private String memberId;

	@NotEmpty(message = "비밀번호를 정확히 입력해주세요.")
	@Size(min = 4, max = 16)
	private String memberPw;

	private boolean rememberMe;

	private String nickname;
	private int usid;

	public boolean checkPassword(String pw) {
		return this.memberPw.equals(pw);
	}

}
