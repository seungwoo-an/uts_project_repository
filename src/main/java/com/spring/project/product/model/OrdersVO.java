package com.spring.project.product.model;

import java.sql.Date;

public class OrdersVO {
	private String member_id;
	private String product_name;
	private int product_id; 
	private Date order_date;
	private String order_receiver_main_address;
	private String order_receiver_sub_address;
	private String order_receiver_name;
	private String order_receiver_tel;
	private int order_product_count;
	private int order_price;
	private String order_request;
	private String order_status;
	private int order_number;
	private int order_group_number;
	private int review_check;
	private int product_weight;
	private String seller_company_name;
	private String seller_company_tel;
	private int order_delivery_price;
	private int sales_month;
	private int sales_year;
	

	
	@Override
	public String toString() {
		return "OrdersVO [member_id=" + member_id + ", product_name=" + product_name + ", product_id=" + product_id
				+ ", order_date=" + order_date + ", order_receiver_main_address=" + order_receiver_main_address
				+ ", order_receiver_sub_address=" + order_receiver_sub_address + ", order_receiver_name="
				+ order_receiver_name + ", order_receiver_tel=" + order_receiver_tel + ", order_product_count="
				+ order_product_count + ", order_price=" + order_price + ", order_request=" + order_request
				+ ", order_status=" + order_status + ", order_number=" + order_number + ", order_group_number="
				+ order_group_number + ", review_check=" + review_check + ", product_weight=" + product_weight
				+ ", seller_company_name=" + seller_company_name + ", seller_company_tel=" + seller_company_tel
				+ ", order_delivery_price=" + order_delivery_price + ", sales_month=" + sales_month + ", sales_year="
				+ sales_year + "]";
	}

	public int getSales_month() {
		return sales_month;
	}

	public void setSales_month(int sales_month) {
		this.sales_month = sales_month;
	}

	public int getSales_year() {
		return sales_year;
	}

	public void setSales_year(int sales_year) {
		this.sales_year = sales_year;
	}

	public int getOrder_delivery_price() {
		return order_delivery_price;
	}

	public void setOrder_delivery_price(int order_delivery_price) {
		this.order_delivery_price = order_delivery_price;
	}

	public String getSeller_company_name() {
		return seller_company_name;
	}

	public void setSeller_company_name(String seller_company_name) {
		this.seller_company_name = seller_company_name;
	}

	public String getSeller_company_tel() {
		return seller_company_tel;
	}

	public void setSeller_company_tel(String seller_company_tel) {
		this.seller_company_tel = seller_company_tel;
	}

	public int getOrder_group_number() {
		return order_group_number;
	}

	public void setOrder_group_number(int order_group_number) {
		this.order_group_number = order_group_number;
	}

	public int getProduct_weight() {
		return product_weight;
	}

	public void setProduct_weight(int product_weight) {
		this.product_weight = product_weight;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getOrder_number() {
		return order_number;
	}

	public void setOrder_number(int order_number) {
		this.order_number = order_number;
	}

	public int getReview_check() {
		return review_check;
	}

	public void setReview_check(int review_check) {
		this.review_check = review_check;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public int getOrder_price() {
		return order_price;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	public String getOrder_request() {
		return order_request;
	}

	public void setOrder_request(String order_request) {
		this.order_request = order_request;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getOrder_receiver_name() {
		return order_receiver_name;
	}

	public void setOrder_receiver_name(String order_receiver_name) {
		this.order_receiver_name = order_receiver_name;
	}

	public String getOrder_receiver_tel() {
		return order_receiver_tel;
	}

	public void setOrder_receiver_tel(String order_receiver_tel) {
		this.order_receiver_tel = order_receiver_tel;
	}

	public int getOrder_product_count() {
		return order_product_count;
	}

	public void setOrder_product_count(int order_product_count) {
		this.order_product_count = order_product_count;
	}

	public String getOrder_receiver_main_address() {
		return order_receiver_main_address;
	}

	public void setOrder_receiver_main_address(String order_receiver_main_address) {
		this.order_receiver_main_address = order_receiver_main_address;
	}

	public String getOrder_receiver_sub_address() {
		return order_receiver_sub_address;
	}

	public void setOrder_receiver_sub_address(String order_receiver_sub_address) {
		this.order_receiver_sub_address = order_receiver_sub_address;
	}
	
}
