package com.cms.model.vo;

import javax.persistence.Entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class SessionVo {

	private String memberId;
	private String memberPw;
}
