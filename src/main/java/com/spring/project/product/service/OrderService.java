package com.spring.project.product.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.product.model.OrderedVO;
import com.spring.project.product.model.OrdersVO;
import com.spring.project.product.repository.IOrderRepository;
import com.spring.project.product.repository.IProductRepository;

@Service
public class OrderService{
	
	@Autowired
	IOrderRepository orderRepository;
	@Autowired
	IProductRepository productRepository;
	
	public List<List<OrdersVO>> getOrderList(String member_id) {
		List<OrdersVO> totalList = orderRepository.getOrderList(member_id);
		List<OrdersVO> orderListByGroupNum = new ArrayList<OrdersVO>();
		List<List<OrdersVO>> orderList = new ArrayList<List<OrdersVO>>();
		for (int i = 0; i < totalList.size(); i++) {
			if(i==0) {
				orderListByGroupNum.add(totalList.get(i));
				if(totalList.size()==1)orderList.add(orderListByGroupNum);
			}
			else if(totalList.get(i-1).getOrder_group_number()==totalList.get(i).getOrder_group_number()) {
				orderListByGroupNum.add(totalList.get(i));
				if(i==totalList.size()-1)orderList.add(orderListByGroupNum);
			}
			else {
				orderList.add(orderListByGroupNum);
				orderListByGroupNum = new ArrayList<OrdersVO>();
				orderListByGroupNum.add(totalList.get(i));
				if(i==totalList.size()-1)orderList.add(orderListByGroupNum);
			}
		}
		return orderList; 
	}
	@Transactional(value = "tsManager")	
	public void paymentInOrder(OrdersVO ordersVO,int[] product_id,int[] order_product_count,int[] order_price, String[] order_requests, String[] order_statuses) {
		ordersVO.setOrder_group_number(orderRepository.getMaxOrderGroupNumber()+1);
		for (int i = 0; i < product_id.length; i++) {
			ordersVO.setOrder_number(orderRepository.getMaxOrderNumber()+1);
			ordersVO.setProduct_id(product_id[i]);
			ordersVO.setOrder_product_count(order_product_count[i]);
			ordersVO.setOrder_price(order_price[i]);
			ordersVO.setOrder_request(order_requests[i]);
			ordersVO.setOrder_status(order_statuses[i]);
			orderRepository.paymentInOrder(ordersVO);
		}
	}

	public OrdersVO getOrderByOrderNumber(int order_number) {
		return orderRepository.getOrderByOrderNumber(order_number);
	}
	@Transactional(value = "tsManager")
	public void deleteOrder(int order_group_number) {
		List<OrdersVO> list = orderRepository.getOrderByOrderGroupNumber(order_group_number);
		for (int i = 0; i < list.size(); i++) {
			productRepository.cancelOrder(list.get(i).getProduct_id(),list.get(i).getOrder_product_count());
		}
		orderRepository.deleteOrder(order_group_number);
	}
	public List<List<OrdersVO>> getOrder(String member_id, int order_group_number) {
		List<OrdersVO> totalList = orderRepository.getOrder(member_id, order_group_number);
		List<OrdersVO> orderListByCompanyName = new ArrayList<OrdersVO>();
		List<List<OrdersVO>> orderList = new ArrayList<List<OrdersVO>>();
		for (int i = 0; i < totalList.size(); i++) {
			if(i==0) {
				orderListByCompanyName.add(totalList.get(i));
				if(totalList.size()==1)orderList.add(orderListByCompanyName);
			}
			else if(totalList.get(i-1).getSeller_company_name().equals(totalList.get(i).getSeller_company_name())) {
				orderListByCompanyName.add(totalList.get(i));
				if(i==totalList.size()-1)orderList.add(orderListByCompanyName);
			}
			else {
				orderList.add(orderListByCompanyName);
				orderListByCompanyName = new ArrayList<OrdersVO>();
				orderListByCompanyName.add(totalList.get(i));
				if(i==totalList.size()-1)orderList.add(orderListByCompanyName);
			}
		}
		return orderList; 

	}
	public int getTotalCount(String member_id) {
		return orderRepository.getTotalCount(member_id);
	}
	public List<OrdersVO> getMyOrderList(String member_id) {
		return orderRepository.getMyOrderList(member_id);
	}
	public List<OrderedVO> getOrderResult(int order_group_number) {
		return orderRepository.getOrderResult(order_group_number);
	}
	public List<OrdersVO> getSellerAdminOrderList(String member_id) {
		return orderRepository.getSellerAdminOrderList(member_id);
	}
	@Transactional(value = "tsManager")
	public void updateStatus(int order_num, String status) {
		orderRepository.updateStatus(order_num, status);
	}
	public String statuschange(int order_num) {
		return orderRepository.statusChange(order_num);
	}
}
