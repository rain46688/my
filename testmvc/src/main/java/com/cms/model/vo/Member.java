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

	private int usid; // À¯Àú½Äº°°ª
	@Column
	@NotNull
	@Size(min = 4, max = 20, message = "4±ÛÀÚ ÀÌ»ó 20±ÛÀÚ ¹Ì¸¸À¸·Î ÀÔ·ÂÇØÁÖ¼¼¿ä.")
	@Pattern(regexp = "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$", message = "*ÀÌ¸ŞÀÏ Çü½ÄÀ» ¸ÂÃç¼­ ÀÔ·ÂÇØÁÖ¼¼¿ä.")
	private String memberId; // ÀÌ¸ŞÀÏ&¾ÆÀÌµğ
	@Column
	@NotNull
	@Size(min = 4, max = 16)
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]{4,16}$", message = "*ºñ¹Ğ¹øÈ£ Çü½ÄÀ» ¸ÂÃç¼­ ÀÔ·ÂÇØÁÖ¼¼¿ä.")
	private String memberPwd; // È¸¿ø ºñ¹Ğ¹øÈ£(´Ü¹æÇâ) ¿µ¹®,¼ıÀÚ È¥ÇÕ 4~16ÀÚ
	@Column
	@NotNull
	@Size(min = 2, max = 5)
	@Pattern(regexp = "[a-zA-Z°¡-ÆR]{2,5}$", message = "*ÀÌ¸§ Çü½ÄÀ» ¸ÂÃç¼­ ÀÔ·ÂÇØÁÖ¼¼¿ä.")
	private String memberName; // È¸¿ø ÀÌ¸§ ÇÑ±Û ±âÁØ 2~5ÀÚ
	@Column
	@NotNull
	@Size(min = 2, max = 10)
	@Pattern(regexp = "[0-9]|[a-z]|[A-Z]|[¤¡-¤¾|¤¿-¤Ó|°¡-ÆR]{1,10}", message = "*´Ğ³×ÀÓ Çü½ÄÀ» ¸ÂÃç¼­ ÀÔ·ÂÇØÁÖ¼¼¿ä.")
	private String nickname; // È¸¿ø ´Ğ³×ÀÓ ÇÑ±Û ±âÁØ 10ÀÚ
	@Column
	@NotNull
	@Size(min = 10, max = 11)
	@Pattern(regexp = "^[0-9]{10,11}$", message = "*ÀüÈ­¹øÈ£ Çü½ÄÀ» ¸ÂÃç¼­ ÀÔ·ÂÇØÁÖ¼¼¿ä.")
	private String phone; // ÀüÈ­¹øÈ£(¾ç¹æÇâ) -¾øÀÌ 11ÀÚ
	private String gender; // ¼ºº° M or F
	private Date birthday; // »ı³â¿ùÀÏ
	private String address; // ÁÖ¼Ò(¾ç¹æÇâ)
	private Date enrollDate; // °¡ÀÔÀÏ
	private int point; // Æ÷ÀÎÆ®¼öÄ¡(Çö±İÈ­ Æ÷ÀÎÆ®ÀÓ µî±ŞÀÌ¶ûÀº ¹«°ü)
	private Boolean leaveMem; // È¸¿ø Å»Åğ¿©ºÎ (1Àº Å»ÅğÀ¯Àú, 0Àº Å»Åğ ¾ÈÇÑ À¯Àú)
	private int nbbangScore; // N»§ Á¡¼ö (ÀÏÁ¤ ÀÌ»ó ¸ğÀ» ¼ö·Ï È¸¿ø µî±Ş »ó½Â)
	private String memberPicture; // È¸¿ø ÇÁ·ÎÇÊ »çÁø (ÆÄÀÏ ÀÌ¸§, È®ÀåÀÚ¸í)
	private boolean pwIsUuid; // ÀÓ½Ãºñ¹øÀÓÀ» ¾Ë·ÁÁÖ´Â ¿ëµµÀÇ º¯¼ö^!^

}
