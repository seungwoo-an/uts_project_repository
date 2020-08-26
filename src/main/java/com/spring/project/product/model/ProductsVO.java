package com.spring.project.product.model;

import java.sql.Date;

public class ProductsVO {
	private int product_id;
	private String member_id;
	private String product_info;
	private String product_name;
	private int product_count;
	private int product_price;
	private float product_weight;
	private byte[] product_img;
	private String product_img_name;
	private Date product_upload_date;
	private int product_rn;
	private String seller_company_name;
	private int product_sold_count;
	private int product_canceled_count;
	
	
	public int getProduct_sold_count() {
		return product_sold_count;
	}

	public void setProduct_sold_count(int product_sold_count) {
		this.product_sold_count = product_sold_count;
	}

	public int getProduct_canceled_count() {
		return product_canceled_count;
	}

	public void setProduct_canceled_count(int product_canceled_count) {
		this.product_canceled_count = product_canceled_count;
	}

	public String getSeller_company_name() {
		return seller_company_name;
	}

	public void setSeller_company_name(String seller_company_name) {
		this.seller_company_name = seller_company_name;
	}

	public int getProduct_rn() {
		return product_rn;
	}

	public void setProduct_rn(int product_rn) {
		this.product_rn = product_rn;
	}

	public Date getProduct_upload_date() {
		return product_upload_date;
	}

	public void setProduct_upload_date(Date product_upload_date) {
		this.product_upload_date = product_upload_date;
	}

	public byte[] getProduct_img() {
		return product_img;
	}

	public void setProduct_img(byte[] product_img) {
		this.product_img = product_img;
	}

	public String getProduct_img_name() {
		return product_img_name;
	}

	public void setProduct_img_name(String product_img_name) {
		this.product_img_name = product_img_name;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getProduct_info() {
		return product_info;
	}

	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public float getProduct_weight() {
		return product_weight;
	}

	public void setProduct_weight(float product_weight) {
		this.product_weight = product_weight;
	}
}
