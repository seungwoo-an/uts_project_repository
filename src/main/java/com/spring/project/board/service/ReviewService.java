package com.spring.project.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.board.model.ReviewVO;
import com.spring.project.board.repository.IReviewRepository;
import com.spring.project.product.repository.IOrderRepository;

@Service
public class ReviewService{
	
	@Autowired
	IReviewRepository reviewRepository;
	@Autowired
	IOrderRepository orderRepository;
	
	@Transactional(value = "tsManager")
	public void deleteReview(String member_id, int product_id) {
		reviewRepository.deleteReview(member_id, product_id);
	}
	@Transactional(value = "tsManager")
	public void updateReview(String member_id, int product_id) {
		reviewRepository.updateReview(member_id, product_id);
	}
	
	public int getTotalCount(int product_id) {
		return reviewRepository.getTotalCount(product_id);
	}

	public List<ReviewVO> getReviewList(int product_id, int nowPage) {
		int end = nowPage*10;
		int start = end-9;
		return reviewRepository.getReviewList(product_id, start, end);
	}
	@Transactional(value = "tsManager")
	public void insertReview(ReviewVO reviewVO, int order_number) {
		reviewVO.setReview_number(reviewRepository.getMaxReviewNumber(reviewVO.getProduct_id())+1);
		if(reviewVO.getReview_img()==null && reviewVO.getReview_img_name()==null) reviewRepository.insertReview(reviewVO);
		else reviewRepository.insertReviewWithImage(reviewVO);
		orderRepository.updateReviewCheck(order_number);
	}


	public ReviewVO getReviewImage(int product_id, int review_number) {
		return reviewRepository.getReviewImage(product_id, review_number);
	}
}
