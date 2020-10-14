package com.cms.model.vo;

import javax.persistence.Entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Entity
@ToString
public class SessionVo {

	private String memberId;
	private String memberPw;
	private String nickname;
	private int usid;
}
