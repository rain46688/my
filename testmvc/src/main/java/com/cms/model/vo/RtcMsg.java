package com.cms.model.vo;

import lombok.Data;

@Data
public class RtcMsg {

	private String type;
	private String sdp;
	private String label;
	private String id;
	private String candidate;

}
