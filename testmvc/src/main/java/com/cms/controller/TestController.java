package com.cms.controller;

import java.sql.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Set;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.cms.common.exception.IdPasswordNotMatchingException;
import com.cms.common.exception.MemberInsertFailedException;
import com.cms.common.temp.AESCrypto;
import com.cms.model.service.TestService;
import com.cms.model.vo.Login;
import com.cms.model.vo.Member;
import com.cms.model.vo.SessionVo;

import lombok.extern.java.Log;

@Controller
@Log
public class TestController {

	private final int noticeNumPerPage = 5;
	private final int boardNumPerPage = 8;

	@Resource(name = "testService")
	private TestService testService;

	@RequestMapping(value = "/noticeTest")
	public ModelAndView testNoticeList(Map<String, Object> commandMap, String cPage) throws Exception {
		log.info(" ===== testNoticeList ���� ===== ");
		ModelAndView mv = new ModelAndView("/notice/noticeList");
		if (cPage == null)
			cPage = "1";
		commandMap.put("cPage", cPage);
		commandMap.put("numPerPage", noticeNumPerPage);
		List<Map<String, Object>> list = testService.selectNoticeList(commandMap);
		int totalData = testService.getNoticeCount();
		mv.addObject("totalData", totalData);
		mv.addObject("list", list);
		return mv;
	}

	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public ModelAndView loginForm(Login login, @CookieValue(value = "saveId", required = false) Cookie rememberMe)
			throws Exception {
		log.info(" ===== loginForm ���� ===== ");
		if (rememberMe != null) {
			login.setMemberId(rememberMe.getValue());
			login.setRememberMe(true);
		}

		ModelAndView mv = new ModelAndView("/member/loginPage");
		return mv;
	}

	@RequestMapping(value = "/loginPage", method = RequestMethod.POST)
	public ModelAndView loginSuccess(@Valid Login login, BindingResult bindingResult, HttpSession session,
			HttpServletResponse response, HttpServletRequest request) throws Exception {
		log.info(" ===== loginSuccess ���� ===== ");

		if (bindingResult.hasErrors()) {
			log.info(" ===== vo ������! ===== ");
			ModelAndView mv = new ModelAndView("/member/loginPage");
			return mv;
		}

		if (!login.getMemberId().equals("admin@kh.com")) {
			try {
				login.setMemberId(AESCrypto.encrypt(login.getMemberId()));
			} catch (Exception e) {
			}
		}

		login.setMemberPw(request.getParameter("memberPw"));
		// �̷��� ������ ���� ��� name���̶� vo ����������̶� ���ƾߵ�!!
		log.info("login :  " + login.getMemberId() + " " + login.getMemberPw() + " " + login.isRememberMe());
		try {
			SessionVo sv = testService.loginCheck(login);
			session.setAttribute("loginnedMember", sv);

			Cookie c = new Cookie("saveId", login.getMemberId());
			c.setPath("/");
			if (login.isRememberMe()) {
				c.setMaxAge(7 * 24 * 60 * 60);// �����ϰ� �����Ұ���
			} else {
				c.setMaxAge(0);
			}
			response.addCookie(c);

		} catch (IdPasswordNotMatchingException e) {
			log.info(" ===== loginSuccess �����κ� ���� ===== ");
			ModelAndView mv = new ModelAndView("/member/loginPage");
			bindingResult.rejectValue("memberPw", "notMatch", "���̵� Ȥ�� ��й�ȣ�� ��ġ�����ʽ��ϴ�. ");
			log.info(" ===== �α��� ���� �α� ===== ");
			return mv;
		}

		ModelAndView mv = new ModelAndView("/common/msg");
		mv.addObject("loc", "/");
		mv.addObject("msg", "�α��� ����");
		log.info(" ===== �α��� ���� �α� ===== ");
		return mv;
	}

	@RequestMapping(value = "/logout")
	public ModelAndView logOut(HttpSession session) throws Exception {
		log.info(" ===== logOut ���� ===== ");
		session.invalidate();
		ModelAndView mv = new ModelAndView("../../index");
		return mv;
	}

	@RequestMapping(value = "/msg")
	public ModelAndView error() throws Exception {
		log.info(" ===== error ���� ===== ");
		ModelAndView mv = new ModelAndView("/common/msg");
		return mv;
	}

	@RequestMapping(value = "/joinPage", method = RequestMethod.GET)
	public ModelAndView JoinForm(@Valid Member member, BindingResult bindingResult) throws Exception {
		log.info(" ===== JoinForm ���� ===== ");
		ModelAndView mv = new ModelAndView("/member/joinPage");
		return mv;
	}

	@RequestMapping(value = "/joinPage", method = RequestMethod.POST)
	public ModelAndView JoinEndForm(@Valid Member member, BindingResult bindingResult, String address1, String address2,
			String year, String month, String date) throws Exception {
		log.info(" ===== JoinEndForm ���� ===== ");

		if (bindingResult.hasErrors()) {
			log.info("ȸ�� ���� ���� �����߻�");
			return new ModelAndView("/member/joinPage");
		}
		String strbirthday = year + "-" + month + "-" + date;
		Date birthday = Date.valueOf(strbirthday);
		String address = address1 + " " + address2;
		member.setBirthday(birthday);
		member.setAddress(address);
		try {
			member.setMemberId(AESCrypto.encrypt(member.getMemberId()));
			member.setPhone(AESCrypto.encrypt(member.getPhone()));
			member.setAddress(AESCrypto.encrypt(member.getAddress()));
		} catch (Exception e) {
			log.info("ȸ�� ���� ��ȣȭ ���� �����߻�");
		}

		log.info(member.toString());
		try {
			testService.joinMember(member);
		} catch (MemberInsertFailedException e) {
			ModelAndView mv = new ModelAndView("/common/msg");
			mv.addObject("loc", "/joinPage");
			mv.addObject("msg", "ȸ������ ����");
			log.info(" ===== ȸ������ ���� �α� ===== ");
			return mv;
		}
		ModelAndView mv = new ModelAndView("/common/msg");
		mv.addObject("loc", "/loginPage");
		mv.addObject("msg", "ȸ������ ����");
		log.info(" ===== ȸ������ ���� �α� ===== ");
		return mv;
	}

	@RequestMapping(value = "/certiEmail", method = RequestMethod.POST)
	public ModelAndView CertiEmail(String email, HttpServletRequest request) throws Exception {
		log.info(" ===== CertiEmail ���� ===== " + email);
		String host = "smtp.gmail.com";
		String user = "minsu87750@gmail.com";
		String password = "alstn8775*";
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 10; i++) {
			int rIndex = rnd.nextInt(3);
			switch (rIndex) {
			case 0:
				temp.append((char) ((rnd.nextInt(26)) + 97));
				break;
			case 1:
				temp.append((char) ((rnd.nextInt(26)) + 65));
				break;
			case 2:
				temp.append((rnd.nextInt(10)));
				break;
			}
		}
		String AuthenticationKey = temp.toString();
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "nbbang"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			msg.setSubject("nbbang ������ ���� ������ȣ�� ���� �����Դϴ� ^~^");
			msg.setText("���� ��ȣ�� " + temp + "�Դϴ�. ������ȣ â�� �Է����ּ���!");
			Transport.send(msg);

		} catch (Exception e) {
			e.printStackTrace();
		}
		HttpSession saveKey = request.getSession();
		saveKey.setAttribute("certiKey", AuthenticationKey);
		ModelAndView mv = new ModelAndView("/member/certiResult");
		return mv;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/board")
	public ModelAndView boardList(Map<String, Object> commandMap, String cPage, String boardTitle) throws Exception {
		log.info(" ===== boardList ���� ===== ");
		ModelAndView mv = new ModelAndView("/board/boardList");
		if (cPage == null)
			cPage = "1";
		commandMap.put("cPage", cPage);
		commandMap.put("numPerPage", boardNumPerPage);
		commandMap.put("boardTitle", boardTitle);
		List<Map<String, Object>> list = testService.selectBoardList(commandMap);
		for (Map m : list) {
			Set<String> s = m.keySet();
			Iterator<String> it = s.iterator();
			log.info("===============Map==================");
			while (it.hasNext()) {
				String key = it.next();
				if (key.equals("TRADE_AREA")) {
					String trade = String.valueOf(m.get(key));
					m.put(key, AESCrypto.decrypt(trade));
				}
				log.info(key + " : " + m.get(key));
			}
		}
		log.info("================Map=================");
		int totalData = testService.getBoardCount(commandMap);
		mv.addObject("totalData", totalData);
		mv.addObject("list", list);
		mv.addObject("boardTitle", boardTitle);
		return mv;
	}

}
