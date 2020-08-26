package com.spring.project.board.model;

import java.sql.Date;
import java.util.Arrays;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReviewVO {
	private int review_number;
	private String member_id;
	private int product_id;
	private String review_title;
	private Date purchase_date;
	private int order_product_count;
	private String review_content;
	private int review_score;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date review_date;
	private int review_views;
	private byte[] review_img;
	private String review_img_name;
	
	
	
	@Override
	public String toString() {
		return "ReviewVO [review_number=" + review_number + ", member_id=" + member_id + ", product_id=" + product_id
				+ ", review_title=" + review_title + ", purchase_date=" + purchase_date + ", order_product_count="
				+ order_product_count + ", review_content=" + review_content + ", review_score=" + review_score
				+ ", review_date=" + review_date + ", review_views=" + review_views + ", review_img="
				+ Arrays.toString(review_img) + ", review_img_name=" + review_img_name + "]";
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public byte[] getReview_img() {
		return review_img;
	}

	public void setReview_img(byte[] review_img) {
		this.review_img = review_img;
	}

	public String getReview_img_name() {
		return review_img_name;
	}

	public void setReview_img_name(String review_img_name) {
		this.review_img_name = review_img_name;
	}

	public int getReview_number() {
		return review_number;
	}

	public void setReview_number(int review_number) {
		this.review_number = review_number;
	}

	public int getReview_views() {
		return review_views;
	}

	public void setReview_views(int review_views) {
		this.review_views = review_views;
	}
	public Date getReview_date() {
		return review_date;
	}

	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}

	public int getOrder_product_count() {
		return order_product_count;
	}

	public void setOrder_product_count(int order_product_count) {
		this.order_product_count = order_product_count;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public int getReview_score() {
		return review_score;
	}

	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getPurchase_date() {
		return purchase_date;
	}

	public void setPurchase_date(Date purchase_date) {
		this.purchase_date = purchase_date;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
}
