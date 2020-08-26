package com.spring.project.board.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.spring.project.board.model.QnAVO;
import com.spring.project.board.model.ReviewVO;
import com.spring.project.board.service.EventService;
import com.spring.project.board.service.FAQService;
import com.spring.project.board.service.NoticeService;
import com.spring.project.board.service.QnAService;
import com.spring.project.board.service.ReviewService;

@RestController
@RequestMapping("/board/rest")
public class BoardRestController {
	
	@Autowired
	QnAService qnAService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	EventService eventService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	FAQService faqService;
	
	@PostMapping("/review/upload")
	public void reviewInsert(@RequestParam(value = "file", required = false) MultipartFile file, ReviewVO reviewVO, int order_number) {
		if (file != null&&!file.isEmpty()) {
			try {
				reviewVO.setReview_img(file.getBytes());
				reviewVO.setReview_img_name(file.getOriginalFilename());
			} catch (IOException e) {
				System.out.println("reivew without image, error : "+e.getMessage());
			}
		}
		reviewService.insertReview(reviewVO, order_number);
	}
	@PostMapping("/qna/insert")
	public void qnaInsert(QnAVO qna) {
		qnAService.insertQnA(qna);
	}
	@RequestMapping(value="/fre_content" , produces = "application/json;charset=UTF-8")
	public String fre_content(@RequestParam(value="fre_number")int fre_number) {
		return faqService.getContent(fre_number); 
	}
	

}
