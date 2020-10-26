package com.kh.spring.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Attachment {

	private int attachementNo;
	private int boardNo;
	private String originalFileName;
	private String renamedFileName;
	private Date uploadDate;
	private int downLoadCount;

}
