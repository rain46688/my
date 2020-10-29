package com.kh.spring.board.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.spring.board.model.service.BoardService;
import com.kh.spring.board.model.vo.Attachment;
import com.kh.spring.board.model.vo.Board;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {

	@Autowired
	private BoardService service;

	@Autowired
	private Logger logger;

	@RequestMapping("/board/boardList.do")
	public ModelAndView boardList(@RequestParam(required = false) Map<String, Integer> map) {

		ModelAndView mv = new ModelAndView("board/boardList");
		if (map.get("cPage") == null) {
			map = new HashMap<String, Integer>();
			map.put("cPage", 0);
		}
		map.put("numPerPage", 10);

		List<Map<String, Integer>> list = service.boardList(map);

//		for (Map<String, Integer> m : list) {
//			log.debug("========================");
//			Iterator<String> it = m.keySet().iterator();
//			while (it.hasNext()) {
//				String key = it.next();
//				log.debug("key : " + key + " value : " + m.get(key));
//			}
//			log.debug("========================");
//		}

		mv.addObject("list", list);
		mv.addObject("totalCount", service.boardCount());
		mv.addObject("numPerPage", map.get("numPerPage"));
		return mv;
	}

	@RequestMapping("/board/boardForm.do")
	public ModelAndView boardForm() {
		ModelAndView mv = new ModelAndView("board/boardForm");
		return mv;
	}

	@RequestMapping("/board/boardFormEnd.do")
	// public ModelAndView boardFormEnd(MultipartFile upFile) {//��������ó��!
	public ModelAndView boardFormEnd(Board board, MultipartFile[] upFile, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("common/msg");
		log.debug("=============== ù��° ���� =================");
		log.debug("���ϸ� : " + upFile[0].getOriginalFilename());
		log.debug("����ũ�� : " + upFile[0].getSize());
		log.debug("=============== �ι�° ���� =================");
		log.debug("���ϸ� : " + upFile[1].getOriginalFilename());
		log.debug("����ũ�� : " + upFile[1].getSize());

		// ���� ���ε� ó���ϱ�
		// 1. ���ε� ��� �ҷ�����
		// 2. ���� ������ ó�� �� ���� �����ϱ�

		String saveDir = request.getServletContext().getRealPath("/resources/upload/board");
		File dir = new File(saveDir);
		if (!dir.exists()) {
			// ������ ����� ������ ������
			dir.mkdirs();// s������ �߰� ��� ��� �˾Ƽ� ������ִ°�!!
		}
		List<Attachment> files = new ArrayList<Attachment>();
		// ���� ���ε� ���� ó���ϱ�
		for (MultipartFile f : upFile) {
			if (!f.isEmpty()) {
				// ���޵� ������ ������... ���� ���ε� ó��
				// ���� ������ ó�� -> �ߺ������� ����!
				String originalFileName = f.getOriginalFilename();
				String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd_HHmmssSSS");
				int rndNum = (int) (Math.random() * 1000);
				String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "." + ext;
				try {
					// renamedFileName ���� ������ �����ϱ� -> transferTo(����)
					f.transferTo(new File(saveDir + "/" + renamedFileName));
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				Attachment file = new Attachment();
				file.setOriginalFileName(originalFileName);
				file.setRenamedFileName(renamedFileName);
				files.add(file);
			}
		}
		int result = 0;
		String error = "";
		try {
			// data DB �����ϱ�
			result = service.insertBoard(board, files);
		} catch (RuntimeException e) {
			log.debug("�Է� ����!");
			error = e + "";
		}
		mv.addObject("msg", result > 0 ? "��ϼ���" : "��Ͻ���");
		mv.addObject("loc", "/board/boardList.do");

		log.debug("board : " + board);

		return mv;
	}

	@RequestMapping("/board/boardView.do")
	public ModelAndView boardView(int no, ModelAndView mv) {

		mv.addObject("board", service.selctBoard(no));
		mv.addObject("attachments", service.selctAttachmentList(no));
		mv.setViewName("board/boardView");
		return mv;
	}

	@RequestMapping("/board/fileDown.do")
	public void fileDown(HttpServletRequest request, HttpServletResponse response, String oriName, String reName,
			@RequestHeader(name = "user-agent") String header) {
		// ���� ���丮 ��������
		// ���� �ٿ�ε� ����!
		String path = request.getServletContext().getRealPath("/resources/upload/board");
		File saveFile = new File(path + "/" + reName);
		// ����� ��Ʈ�� ����
		BufferedInputStream bis = null;
		ServletOutputStream sos = null;
		try {
			bis = new BufferedInputStream(new FileInputStream(saveFile));
			sos = response.getOutputStream();
			String encodeRename = "";
			boolean isMSIE = header.indexOf("Trident") != -1 || header.indexOf("MSIE") != -1;
			if (isMSIE) {
				encodeRename = URLEncoder.encode(oriName, "UTF-8");
				encodeRename = encodeRename.replaceAll("\\+", "%20");
			} else {
				encodeRename = new String(oriName.getBytes("UTF-8"), "ISO-8859-1");
			}
			response.setContentType("application/octet-stream;charset=utf-8");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + encodeRename + "\"");
			response.setContentLength((int) saveFile.length());
			int read = -1;
			while ((read = bis.read()) != -1) {
				sos.write(read);
			}
		} catch (IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				sos.close();
				bis.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
