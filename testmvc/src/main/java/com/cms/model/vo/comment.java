package com.cms.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {

	private int com_Id;// 댓글 식별자
	private int cboard_Id;// 댓글 달린 게시물 아이디
	private String content;// 댓글 내용
	private Date cenroll_Date;// 댓글 작성 날짜
	private Boolean secret;// 비밀 댓글 여부
	private String cwriter_Nickname;// 작성자 닉네임
	private int com_Layer;// 대댓글 레벨
	private String com_Profile;// 프로필 이미지 경로
	private int com_Ref;// 댓글 참조값
}
