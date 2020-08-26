package com.spring.project.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.board.model.QnAVO;
import com.spring.project.board.repository.IQnARepository;

@Service
public class QnAService{

	@Autowired
	IQnARepository qnARepository;
	
	public List<QnAVO> getQnAList(int page){
		int end = page*10;
		int start = end-9;
		return qnARepository.getQnAList(start, end);
	}
	@Transactional(value = "tsManager")
	public void updateQnA(String q_title, String q_content, String member_id) {
		qnARepository.updateQnA(q_title, q_content, member_id);
	}
	@Transactional(value = "tsManager")
	public void answerQnA(String member_id, String q_title, String q_category, String q_content,
			int q_group,int q_step) {
		qnARepository.answerQnA(member_id, q_title, q_category, q_content, q_group, q_step);
	}
	@Transactional(value = "tsManager")
	public void deleteQnA(String member_id, String q_title) {
		qnARepository.deleteQnA(member_id, q_title);
	}
	
	public int getTotalCount(int product_id) {
		return qnARepository.getTotalCount(product_id);
	}
	@Transactional(value = "tsManager")
	public void insertQnA(QnAVO qna) {
		qna.setQ_number(qnARepository.getMaxQnaNumber()+1);
		qnARepository.insertQnA(qna);
	}
}
