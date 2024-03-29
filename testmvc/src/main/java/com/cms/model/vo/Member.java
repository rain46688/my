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

	private int usid; // 유저식별값
	@Column
	@NotNull
	@Size(min = 4, max = 20, message = "4글자 이상 20글자 미만으로 입력해주세요.")
	@Pattern(regexp = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$", message = "*이메일 형식을 맞춰서 입력해주세요.")
	private String memberId; // 이메일&아이디
	@Column
	@NotNull
	@Size(min = 4, max = 16)
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{4,16}$", message = "*비밀번호 형식을 맞춰서 입력해주세요.")
	private String memberPwd; // 회원 비밀번호(단방향) 영문,숫자 혼합 4~16자
	@Column
	@NotNull
	@Size(min = 2, max = 5)
	@Pattern(regexp = "[a-zA-Z가-힣]{2,5}$", message = "*이름 형식을 맞춰서 입력해주세요.")
	private String memberName; // 회원 이름 한글 기준 2~5자
	@Column
	@NotNull
	@Size(min = 2, max = 10)
	@Pattern(regexp = "[0-9]|[a-z]|[A-Z]|[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{1,10}", message = "*닉네임 형식을 맞춰서 입력해주세요.")
	private String nickname; // 회원 닉네임 한글 기준 10자
	@Column
	@NotNull
	@Size(min = 10, max = 11)
	@Pattern(regexp = "^[0-9]{10,11}$", message = "*전화번호 형식을 맞춰서 입력해주세요.")
	private String phone; // 전화번호(양방향) -없이 11자
	private String gender; // 성별 M or F
	private Date birthday; // 생년월일
	private String address; // 주소(양방향)
	private Date enrollDate; // 가입일
	private int point; // 포인트수치(현금화 포인트임 등급이랑은 무관)
	private Boolean leaveMem; // 회원 탈퇴여부 (1은 탈퇴유저, 0은 탈퇴 안한 유저)
	private int nbbangScore; // N빵 점수 (일정 이상 모을 수록 회원 등급 상승)
	private String memberPicture; // 회원 프로필 사진 (파일 이름, 확장자명)
	private boolean pwIsUuid; // 임시비번임을 알려주는 용도의 변수^!^

}
