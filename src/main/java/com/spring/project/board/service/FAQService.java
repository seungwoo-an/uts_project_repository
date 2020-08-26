package com.spring.project.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.project.board.model.FreVO;
import com.spring.project.board.repository.IFAQRepository;

@Service
public class FAQService {
	@Autowired
	IFAQRepository faqRepository;
	
	public List<FreVO> getNoticeList(int page){
		int end = page*10;
		int start = end-9;
		return faqRepository.getFAQList(start, end);
	}

	public int getTotalCount() {
		return faqRepository.getTotalCount();
	}

	public String getContent(int fre_number) {
		return faqRepository.getContent(fre_number);
	}
	
}
