package com.spring.project.member.model;

public class SellerInfoVO {
	private String member_id;
	private String seller_reg_num;
	private String seller_company_info;
	private String seller_company_tel;
	private String seller_company_main_address;
	private String seller_company_sub_address;
	private String seller_company_email;
	private String seller_company_name;
	private String seller_company_head_name;
	private int product_delivery_price;
	
	
	public int getProduct_delivery_price() {
		return product_delivery_price;
	}
	public void setProduct_delivery_price(int product_delivery_price) {
		this.product_delivery_price = product_delivery_price;
	}
	public String getSeller_company_main_address() {
		return seller_company_main_address;
	}
	public void setSeller_company_main_address(String seller_company_main_address) {
		this.seller_company_main_address = seller_company_main_address;
	}
	public String getSeller_company_sub_address() {
		return seller_company_sub_address;
	}
	public void setSeller_company_sub_address(String seller_company_sub_address) {
		this.seller_company_sub_address = seller_company_sub_address;
	}
	public String getSeller_company_head_name() {
		return seller_company_head_name;
	}
	public void setSeller_company_head_name(String seller_company_head_name) {
		this.seller_company_head_name = seller_company_head_name;
	}
	public String getSeller_company_name() {
		return seller_company_name;
	}
	public void setSeller_company_name(String seller_company_name) {
		this.seller_company_name = seller_company_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getSeller_reg_num() {
		return seller_reg_num;
	}
	public void setSeller_reg_num(String seller_reg_num) {
		this.seller_reg_num = seller_reg_num;
	}
	public String getSeller_company_info() {
		return seller_company_info;
	}
	public void setSeller_company_info(String seller_company_info) {
		this.seller_company_info = seller_company_info;
	}
	public String getSeller_company_tel() {
		return seller_company_tel;
	}
	public void setSeller_company_tel(String seller_company_tel) {
		this.seller_company_tel = seller_company_tel;
	}
	public String getSeller_company_email() {
		return seller_company_email;
	}
	public void setSeller_company_email(String seller_company_email) {
		this.seller_company_email = seller_company_email;
	}
	
	
	
	
}
