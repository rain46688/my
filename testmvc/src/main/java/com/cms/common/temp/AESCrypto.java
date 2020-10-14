package com.cms.common.temp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AESCrypto {
	private static SecretKey key;
	private String path;

	Logger log = LoggerFactory.getLogger(this.getClass());

	public AESCrypto() {
		log.info("============ AESCrypto ============");
		this.path = AESCrypto.class.getResource("/").getPath();
		this.path = path.substring(0, path.indexOf("classes"));
		log.info(this.path + "/nbbang.nb");
		File f = new File(this.path + "/nbbang.nb");

		if (f.exists()) {
			try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(f))) {
				key = (SecretKey) (ois.readObject());
				log.info("============ AESCrypto Ű ���� ============");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			if (key == null) {
				log.info("============ AESCrypto Ű ���� ============");
				getGenerator();
			}
		}
	}

	private void getGenerator() {
		log.info("============ getGenerator ============");
		SecureRandom scr = new SecureRandom();
		KeyGenerator keygen = null;
		try {
			keygen = KeyGenerator.getInstance("AES");
			keygen.init(128, scr);
			this.key = keygen.generateKey();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		File f = new File(this.path + "/nbbang.nb");
		try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(f))) {
			oos.writeObject(this.key);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String encrypt(String str) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance("AES");
		cipher.init(Cipher.ENCRYPT_MODE, key);
		byte[] encrypt = str.getBytes(Charset.forName("UTF-8"));
		byte[] result = cipher.doFinal(encrypt);
		String strResult = Base64.getEncoder().encodeToString(result);
		return strResult;
	}

	public static String decrypt(String str) throws NoSuchAlgorithmException, NoSuchPaddingException,
			InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance("AES");
		cipher.init(Cipher.DECRYPT_MODE, key);
		byte[] decodeStr = Base64.getDecoder().decode(str.getBytes());
		byte[] decrypt = cipher.doFinal(decodeStr);
		return new String(decrypt, StandardCharsets.UTF_8);
	}
}
