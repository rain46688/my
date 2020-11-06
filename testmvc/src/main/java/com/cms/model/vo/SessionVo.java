package com.cms.model.vo;

import javax.persistence.Entity;

import lombok.Data;
import lombok.ToString;

@Data
@Entity
@ToString
public class SessionVo {

	private String memberId;
	private String memberPw;
	private String nickname;
	private int usid;
	private String curRoomBid;
	private boolean host;
}
