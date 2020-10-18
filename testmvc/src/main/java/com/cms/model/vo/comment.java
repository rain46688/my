package com.cms.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {

	private int com_Id;// ��� �ĺ���
	private int cboard_Id;// ��� �޸� �Խù� ���̵�
	private String content;// ��� ����
	private Date cenroll_Date;// ��� �ۼ� ��¥
	private Boolean secret;// ��� ��� ����
	private String cwriter_Nickname;// �ۼ��� �г���
	private int com_Layer;// ���� ����
	private String com_Profile;// ������ �̹��� ���
	private int com_Ref;// ��� ������
}
