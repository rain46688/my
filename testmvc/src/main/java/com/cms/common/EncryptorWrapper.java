package com.cms.common;

import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EncryptorWrapper extends HttpServletRequestWrapper {
	protected Logger log = LoggerFactory.getLogger(this.getClass());

	public EncryptorWrapper(HttpServletRequest request) {
		super(request);
		// TODO Auto-generated constructor stub
	}

	@Override
	public String getParameter(String name) {
		String returnValue = "";
		if (name.equals("memberPw") || name.equals("newPw")) {
			String pw = super.getParameter(name);
			log.info("pw : " + pw);
			String encPw = getSha512(pw);
			returnValue = encPw;
		} else {
			returnValue = super.getParameter(name);
		}
		log.info("returnValue : " + returnValue);
		return returnValue;
	}

	private String getSha512(String value) {
		String encPwd = null;
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA-512");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		byte[] bytes = value.getBytes(Charset.forName("UTF-8"));
		md.update(bytes);
		encPwd = Base64.getEncoder().encodeToString(md.digest());
		return encPwd;
	}
}
