package com.cms.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Alarm {

	private int alarm_id;
	private int send_mem_usid;
	private int receive_mem_usid;
	private String type;
	private String alarm_content;
	private String send_mem_nickname;

}
