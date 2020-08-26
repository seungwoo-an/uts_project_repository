package com.spring.project.product.model;

import java.sql.Date;

public class OrderedVO {
	private int order_group_number;
	private Date order_date;
	private int ordered_price;
	private String orderer_name;
	private int order_delivery_price;
	@Override
	public String toString() {
		return "OrderedVO [order_group_number=" + order_group_number + ", order_date=" + order_date + ", ordered_price="
				+ ordered_price + ", orderer_name=" + orderer_name + ", order_delivery_price=" + order_delivery_price
				+ "]";
	}

	public String getOrderer_name() {
		return orderer_name;
	}

	public void setOrderer_name(String orderer_name) {
		this.orderer_name = orderer_name;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	

	public int getOrder_group_number() {
		return order_group_number;
	}

	public void setOrder_group_number(int order_group_number) {
		this.order_group_number = order_group_number;
	}

	public int getOrdered_price() {
		return ordered_price;
	}

	public void setOrdered_price(int ordered_price) {
		this.ordered_price = ordered_price;
	}
	public int getOrder_delivery_price() {
		return order_delivery_price;
	}
	public void setOrder_delivery_price(int order_delivery_price) {
		this.order_delivery_price = order_delivery_price;
	}
}
