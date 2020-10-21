package com.cms.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {

	private int chat_board_id;
	private String chat_writer_nickname;
	private String chat_content;
	private String chat_profile_image;
	private String chat_time;

}
