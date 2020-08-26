package com.spring.project.member.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.board.repository.IEventRepository;
import com.spring.project.board.repository.IQnARepository;
import com.spring.project.board.repository.IReviewRepository;
import com.spring.project.member.model.MemberVO;
import com.spring.project.member.model.SelectVO;
import com.spring.project.member.model.SellerInfoVO;
import com.spring.project.member.repository.IMemberRepository;
import com.spring.project.product.model.OrdersVO;
import com.spring.project.product.repository.ICartRepository;
import com.spring.project.product.repository.IOrderRepository;
import com.spring.project.product.repository.IProductRepository;

@Service
public class MemberService implements IMemberService {

	@Autowired
	IMemberRepository memberRepository;
	@Autowired
	IReviewRepository reviewRepository;
	@Autowired
	IQnARepository qnaRepository;
	@Autowired
	IProductRepository productRepository;
	@Autowired
	IOrderRepository orderRepository;
	@Autowired
	IEventRepository eventRepository;
	@Autowired
	ICartRepository cartRepository;
	@Override
	public String getMemberPassword(String userId) {
		return memberRepository.getMemberPassword(userId);
	}
	@Override
	public MemberVO getMemberInfo(String userId) {
		return memberRepository.getMemberInfo(userId);
	}
	@Override
	public List<MemberVO> getMemberList(int memberPage, SelectVO select) {
		int start = (memberPage - 1) * 10 + 1;
		int end = start + 9;
		return memberRepository.getSelectMemberList(start, end , select.getSelect_auth() , select.getSelect_enabled() , select.getSelect_word());
	}

	@Override
	public int getMemberCount(SelectVO select) {
		return memberRepository.getMemberCount(select.getSelect_auth() , select.getSelect_enabled() , select.getSelect_word());
	}

	@Override
	public List<MemberVO> getPermissionList(int permissionPage, String permission_word) {
		int start = (permissionPage - 1) * 10 + 1;
		int end = start + 9;
		if (permission_word != null) {
			if (!permission_word.equals("")) {
				return memberRepository.getSelectPermissionList(start, end, permission_word);
			}
		}
		return memberRepository.getPermissionList(start, end);
	}

	@Override
	public int getPermissionCount(String permission_word) {
		if (permission_word != null) {
			if (!permission_word.equals("")) {
				return memberRepository.getSelectPermissionCount(permission_word);
			}
		}
		return memberRepository.getPermissionCount();
	}

	@Override
	@Transactional(value = "tsManager")
	public void memberInsert(MemberVO member) {
			memberRepository.memberJoin(member);
			memberRepository.authJoin(member.getUsername(), member.getMember_auth());
	}

	@Override
	@Transactional(value = "tsManager")
	public void updateMember(MemberVO member) {
		memberRepository.updateMember(member);
	}
	@Override
	@Transactional(value = "tsManager")
	public void changePwd(String member_pw, String member_id) {
		memberRepository.changePwd(member_pw, member_id);
	}
	
	
	@Override
	@Transactional(value = "tsManager")
	public void memberDelete(String member_id) {
		memberRepository.sellerDelete(member_id);
		reviewRepository.deleteReviewByMemberId(member_id);
		qnaRepository.deleteQnAByMemberId(member_id);
		productRepository.deleteProductByMemberId(member_id);
		orderRepository.deleteOrderByMemberId(member_id);
		eventRepository.deleteEventByMemberId(member_id);
		cartRepository.deleteCartByMemberId(member_id);
		memberRepository.authDelete(member_id);
		memberRepository.memberDelete(member_id);

	}

	@Override
	@Transactional(value = "tsManager")
	public void member_enable(int enable , String member_id) {
		memberRepository.member_enable(enable ,member_id);
	}

	@Override
	public MemberVO getMemberEmail(String member_email) {
		return memberRepository.getEmail(member_email);
	}
	
	@Override
	public List<List<OrdersVO>> getMonthlySales(String member_id, int year) {
		List<List<OrdersVO>> list = new ArrayList<List<OrdersVO>>();
		for(int month = 1 ; month <= 12 ; month++) {
			List<OrdersVO> innerList = memberRepository.getMonthlySales(member_id ,year, month);
			list.add(innerList);
		}
		return list;
	}
	
	@Override
	@Transactional(value = "tsManager")
	public void insertSellerRegNum(String member_id, String seller_reg_num) {
		memberRepository.insertSellerRegNum(member_id, seller_reg_num);
	}

	@Override
	public SellerInfoVO getSellerInfo(String member_id) {
		return memberRepository.getSellerInfo(member_id);
	}

	@Override
	public boolean getSellerRegNum(String seller_reg_num) {
		if(memberRepository.getSellerRegNum(seller_reg_num)==null)return true;
		else return false;
	}
	@Override
	@Transactional(value = "tsManager")
	public void updateSellerInfo(SellerInfoVO sellerInfo) {
		memberRepository.updateSellerInfo(sellerInfo);
	}
	@Override
	@Transactional(value = "tsManager")
	public void deleteSelectedMembers(String[] member_ids) {
		for (int i = 0; i < member_ids.length; i++) {
			memberRepository.sellerDelete(member_ids[i]);
			reviewRepository.deleteReviewByMemberId(member_ids[i]);
			qnaRepository.deleteQnAByMemberId(member_ids[i]);
			productRepository.deleteProductByMemberId(member_ids[i]);
			orderRepository.deleteOrderByMemberId(member_ids[i]);
			eventRepository.deleteEventByMemberId(member_ids[i]);
			cartRepository.deleteCartByMemberId(member_ids[i]);
			memberRepository.authDelete(member_ids[i]);
			memberRepository.memberDelete(member_ids[i]);
		}
	}
}
