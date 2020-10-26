package com.kh.spring.board.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Board {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private String boardContent;
	private Date boardDate;
	private int readCount;
	private int fileCount;
}
