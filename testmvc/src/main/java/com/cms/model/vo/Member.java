package com.cms.model.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Member {

	private int usid; // �����ĺ���
	@Column
	@NotNull
	@Size(min = 4, max = 20, message = "4���� �̻� 20���� �̸����� �Է����ּ���.")
	@Pattern(regexp = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$", message = "*�̸��� ������ ���缭 �Է����ּ���.")
	private String memberId; // �̸���&���̵�
	@Column
	@NotNull
	@Size(min = 4, max = 16)
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{4,16}$", message = "*��й�ȣ ������ ���缭 �Է����ּ���.")
	private String memberPwd; // ȸ�� ��й�ȣ(�ܹ���) ����,���� ȥ�� 4~16��
	@Column
	@NotNull
	@Size(min = 2, max = 5)
	@Pattern(regexp = "[a-zA-Z��-�R]{2,5}$", message = "*�̸� ������ ���缭 �Է����ּ���.")
	private String memberName; // ȸ�� �̸� �ѱ� ���� 2~5��
	@Column
	@NotNull
	@Size(min = 2, max = 10)
	@Pattern(regexp = "[0-9]|[a-z]|[A-Z]|[��-��|��-��|��-�R]{1,10}", message = "*�г��� ������ ���缭 �Է����ּ���.")
	private String nickname; // ȸ�� �г��� �ѱ� ���� 10��
	@Column
	@NotNull
	@Size(min = 10, max = 11)
	@Pattern(regexp = "^[0-9]{10,11}$", message = "*��ȭ��ȣ ������ ���缭 �Է����ּ���.")
	private String phone; // ��ȭ��ȣ(�����) -���� 11��
	private String gender; // ���� M or F
	private Date birthday; // �������
	private String address; // �ּ�(�����)
	private Date enrollDate; // ������
	private int point; // ����Ʈ��ġ(����ȭ ����Ʈ�� ����̶��� ����)
	private Boolean leaveMem; // ȸ�� Ż�𿩺� (1�� Ż������, 0�� Ż�� ���� ����)
	private int nbbangScore; // N�� ���� (���� �̻� ���� ���� ȸ�� ��� ���)
	private String memberPicture; // ȸ�� ������ ���� (���� �̸�, Ȯ���ڸ�)
	private boolean pwIsUuid; // �ӽú������ �˷��ִ� �뵵�� ����^!^

}
