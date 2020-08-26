package com.spring.project.product.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.product.model.CartVO;
import com.spring.project.product.repository.ICartRepository;

@Service
public class CartService{
	
	@Autowired
	ICartRepository cartRepository;
	
	public List<List<CartVO>> getCart(String member_id) {
		List<CartVO> totalList = cartRepository.getCart(member_id);
		List<CartVO> cartListByRegNum = new ArrayList<CartVO>();
		List<List<CartVO>> cartList = new ArrayList<List<CartVO>>();
		for (int i = 0; i < totalList.size(); i++) {
			if(i==0) { 
				cartListByRegNum.add(totalList.get(i));
				if(totalList.size()==1)cartList.add(cartListByRegNum);
			}
			else if(totalList.get(i-1).getSeller_company_name().equals(totalList.get(i).getSeller_company_name())) {
				cartListByRegNum.add(totalList.get(i));
				if(i==totalList.size()-1)cartList.add(cartListByRegNum);
			}
			else {
				cartList.add(cartListByRegNum);
				cartListByRegNum = new ArrayList<CartVO>();
				cartListByRegNum.add(totalList.get(i));
				if(i==totalList.size()-1)cartList.add(cartListByRegNum);
			}
		}
		return cartList; 
	}
	@Transactional(value = "tsManager")
	public void deleteCart(String member_id, int[] product_ids){
		for (int i = 0; i < product_ids.length; i++) {
			cartRepository.deleteCart(member_id, product_ids[i]);
		}
	}
	@Transactional(value = "tsManager")
	public int insertCart(String member_id, int product_id, int cart_product_count,int cart_delivery_price) throws Exception {
		if(cartRepository.getMemberId(member_id,product_id)==null) {
			cartRepository.insertCart(member_id, product_id, cart_product_count, cart_delivery_price);
			return 1;
		}else return 0;
	}
	@Transactional(value = "tsManager")
	public void updateCart(String member_id, List<Integer> product_ids, List<Integer> cart_product_counts,int cart_delivery_price) {
		for (int i = 0; i < product_ids.size(); i++) {
			cartRepository.updateCart(member_id,product_ids.get(i),cart_product_counts.get(i),cart_delivery_price);
		}
	}

	public int checkCart(String member_id, int product_id) {
		if(cartRepository.getMemberId(member_id, product_id)==null)return 1;
		else return 0;
	}

	public List<CartVO> getSelectedCart(String member_id, int[] product_ids) {
		List<CartVO> cartList = new ArrayList<CartVO>();
		for (int i = 0; i < product_ids.length; i++) {
			cartList.add(cartRepository.getSelectedCart(member_id,product_ids[i]));
		}
		return cartList;
	}

	public List<CartVO> getCartInOrderSheet(String member_id) {
		return cartRepository.getCartInOrderSheet(member_id);
	}
}
