package com.spring.project.board.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.project.board.model.EventVO;
import com.spring.project.board.model.NoticeVO;
import com.spring.project.board.model.ReviewVO;
import com.spring.project.board.service.EventService;
import com.spring.project.board.service.FAQService;
import com.spring.project.board.service.NoticeService;
import com.spring.project.board.service.QnAService;
import com.spring.project.board.service.ReviewService;
import com.spring.project.common.PagingManager;
import com.spring.project.member.service.IMemberService;
import com.spring.project.product.model.ProductsVO;
import com.spring.project.product.service.OrderService;
import com.spring.project.product.service.ProductService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	QnAService qnAService;
	@Autowired
	ReviewService reviewService;
	@Autowired
	EventService eventService;
	@Autowired
	NoticeService noticeService;
	@Autowired
	OrderService orderService;
	@Autowired
	FAQService faqService;
	@Autowired
	ProductService productService;
	@Autowired
	IMemberService memberService;
	
	@GetMapping("/notice/list")
	public void noticeList(@RequestParam(value = "notice_page", required = false, defaultValue = "1") int notice_page, 
			@RequestParam(value = "fre_page", required = false, defaultValue = "1") int fre_page,
			@RequestParam(value = "fre", required = false) String freMessage
			,Model model) {
		model.addAttribute("noticeList", noticeService.getNoticeList(notice_page));
		PagingManager noitce_PagingManager = new PagingManager(noticeService.getTotalCount(), notice_page);
		model.addAttribute("notice_pagingManager", noitce_PagingManager);
		
		if(freMessage != null) {
			model.addAttribute("freMessage" , freMessage);
		}
		model.addAttribute("faqList",faqService.getNoticeList(fre_page));
		PagingManager fre_PagingManager = new PagingManager(faqService.getTotalCount(), fre_page);
		model.addAttribute("fre_PagingManager", fre_PagingManager);
	}
	
	@GetMapping("/notice/{notice_rn}")
	public String noticeView(Model model, @PathVariable("notice_rn") int notice_rn) {
		model.addAttribute("notice", noticeService.getNotice(notice_rn));
		int totalCount = noticeService.getTotalCount();
		model.addAttribute("totalCount",totalCount);
		if(notice_rn!=1)model.addAttribute("preTitle",noticeService.getTitle(notice_rn-1));
		if(notice_rn!=totalCount)model.addAttribute("postTitle",noticeService.getTitle(notice_rn+1));
		return "board/notice/view";
	}
	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MASTER')")
	@GetMapping("/notice/form")
	public String noticeForm(Model model) {
		model.addAttribute("msg", "new");
		return "board/notice/form";
	}
	
	
	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MASTER')")
	@GetMapping("/notice/form/{notice_rn}")
	public String getView(@PathVariable("notice_rn") int notice_rn, Model model) {
		model.addAttribute("notice", noticeService.getNoticeInfo(notice_rn) );
		model.addAttribute("msg" , "update");
		return "board/notice/form";
	}

	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MASTER')")
	@PostMapping("/notice/update")
	public String updateView(NoticeVO noticeVo ) {
		noticeService.updateView(noticeVo);
		return "redirect:/board/notice/"+noticeVo.getNotice_rn();
	}
	
	
	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MASTER')")
	@PostMapping("/notice/new")
	public String noticeInsert(@ModelAttribute NoticeVO noticeVO,
			@RequestParam(value = "file", required = false) MultipartFile file) {
		if (file != null&&!file.isEmpty()) {
			try {
				noticeVO.setNotice_file(file.getBytes());
				noticeVO.setNotice_file_name(file.getOriginalFilename());
			} catch (IOException e) {
				System.out.println("notice insert error, error : "+e.getMessage());
			}
			noticeService.insertNoticeWithFile(noticeVO);
		}
		else noticeService.insertNotice(noticeVO);
		return "redirect:/board/notice/list";
	}
	
	@PreAuthorize("isAuthenticated() and hasRole('ROLE_MASTER')")
	@GetMapping("/notice/delete/{notice_number}")
	public String deleteView(@PathVariable("notice_number") int notice_number) {
		noticeService.deleteView(notice_number);
		return "redirect:/board/notice/list";
	}
	
	@GetMapping("/event/list")
	public void eventList(@RequestParam(value="page", required = false, defaultValue = "1")int page, Model model) {
		model.addAttribute("eventList",eventService.getEventList(page));
		PagingManager pagingManager = new PagingManager(eventService.getTotalCount(), page);
		model.addAttribute("pagingManager",pagingManager);
	}
	
	@GetMapping("/event/{event_rn}")
	public String eventView(Model model, @PathVariable("event_rn")int event_rn) {
		int totalCount = eventService.getTotalCount();
		model.addAttribute("event",eventService.getEvent(event_rn));
		model.addAttribute("totalCount",totalCount);
		return "board/event/view";
	}
	@PreAuthorize("isAuthenticated() and hasAnyRole('ROLE_SELLER','ROLE_MASTER')")
	@GetMapping("/event/form")
	public String eventForm(Model model) {
		model.addAttribute("msg", "new");
		return "board/event/form";
	}
	
	@PreAuthorize("isAuthenticated() and hasAnyRole('ROLE_SELLER','ROLE_MASTER')")
	@PostMapping("/event/new")
	public String eventInsert(@ModelAttribute EventVO eventVO, Model model, @RequestParam(value = "file", required = false) MultipartFile file) {
		if (file != null&&!file.isEmpty()) {
			try {
				eventVO.setEvent_img(file.getBytes());
				eventVO.setEvent_img_name(file.getOriginalFilename());
			} catch (IOException e) {
			}
			eventService.insertEventWithFile(eventVO);
		}
		else eventService.insertEvent(eventVO);
		return "redirect:/board/event/list";
	}
	
	@PreAuthorize("isAuthenticated() and hasAnyRole('ROLE_SELLER','ROLE_MASTER')")
	@GetMapping("/event/delete/{event_number}")
	public String deleteEventView(@PathVariable("event_number") int event_number) {
		eventService.deleteView(event_number);
		return "redirect:/board/event/list";
	}
	
	@PreAuthorize("isAuthenticated() and hasAnyRole('ROLE_SELLER','ROLE_MASTER')")
	@GetMapping("/event/form/{event_rn}")
	public String getEventView(@PathVariable("event_rn") int event_rn, Model model) {
		model.addAttribute("event", eventService.getNoticeInfo(event_rn) );
		model.addAttribute("msg" , "update");
		return "board/event/form";
	}
	
	@PreAuthorize("isAuthenticated() and hasAnyRole('ROLE_SELLER','ROLE_MASTER')")
	@PostMapping("/event/update")
	public String updateEventView(EventVO eventVO ) {
		eventService.updateEvent(eventVO);
		return "redirect:/board/event/"+eventVO.getEvent_rn();
	}
	
	@GetMapping("/qna/list")
	public void qnaList(@RequestParam(value="page", required = false, defaultValue = "1")int page, Model model) {
		model.addAttribute("eventList",eventService.getEventList(page));
		PagingManager pagingManager = new PagingManager(eventService.getTotalCount(), page);
		model.addAttribute("pagingManager",pagingManager);
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/qna/form/{product_id}")
	public String qnaForm(@PathVariable("product_id")int product_id, Model model) {
		ProductsVO product = productService.getProduct(product_id);
		model.addAttribute("product",product);
		model.addAttribute("sellerInfo",memberService.getSellerInfo(product.getMember_id()));
		return "board/qna/form";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/review/form")
	public void reviewForm(@RequestParam("member_id")String member_id, @RequestParam("order_number")int order_number,
		@RequestParam("table_number_index") int table_number_index , @RequestParam("order_group_number") int order_group_number, Model model) {
		model.addAttribute("order", orderService.getOrderByOrderNumber(order_number));
		model.addAttribute("table_number_index" , table_number_index);
		model.addAttribute("order_group_number" , order_group_number);
	}

	@RequestMapping("/review/img")
	public ResponseEntity<byte[]> getImage(@RequestParam("product_id")int product_id, @RequestParam("review_number")int review_number) {
		ReviewVO reviewVO = reviewService.getReviewImage(product_id, review_number);
		String review_img_type = reviewVO.getReview_img_name().split("\\.")[1];
		byte[] review_img = reviewVO.getReview_img();
		final HttpHeaders header = new HttpHeaders();
		header.setContentType(new MediaType("image",review_img_type));
		header.setContentDispositionFormData("attachment", reviewVO.getReview_img_name());
		return new ResponseEntity<byte[]>(review_img, header, HttpStatus.OK);
	}
}
