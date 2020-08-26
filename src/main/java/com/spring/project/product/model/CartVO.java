package com.spring.project.product.model;

public class CartVO {
	private String member_id;
	private int product_id;
	private int cart_product_count;
	private String product_info;
	private String product_name;
	private String product_price;
	private String seller_company_name;
	private String product_delivery_price;
	private String product_total_price;
	private int cart_delivery_price;
	
	
	@Override
	public String toString() {
		return "CartVO [member_id=" + member_id + ", product_id=" + product_id + ", cart_product_count="
				+ cart_product_count + ", product_info=" + product_info + ", product_name=" + product_name
				+ ", product_price=" + product_price + ", seller_company_name=" + seller_company_name
				+ ", product_delivery_price=" + product_delivery_price + ", product_total_price=" + product_total_price
				+ ", cart_delivery_price=" + cart_delivery_price + "]";
	}

	public int getCart_delivery_price() {
		return cart_delivery_price;
	}

	public void setCart_delivery_price(int cart_delivery_price) {
		this.cart_delivery_price = cart_delivery_price;
	}

	public String getProduct_info() {
		return product_info;
	}

	public String getProduct_total_price() {
		return product_total_price;
	}

	public void setProduct_total_price(String product_total_price) {
		this.product_total_price = product_total_price;
	}

	public String getProduct_delivery_price() {
		return product_delivery_price;
	}

	public void setProduct_delivery_price(String product_delivery_price) {
		this.product_delivery_price = product_delivery_price;
	}

	public String getSeller_company_name() {
		return seller_company_name;
	}

	public void setSeller_company_name(String seller_company_name) {
		this.seller_company_name = seller_company_name;
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

	public String getProduct_price() {
		return product_price;
	}

	public void setProduct_price(String product_price) {
		this.product_price = product_price;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getCart_product_count() {
		return cart_product_count;
	}

	public void setCart_product_count(int cart_product_count) {
		this.cart_product_count = cart_product_count;
	}
}
