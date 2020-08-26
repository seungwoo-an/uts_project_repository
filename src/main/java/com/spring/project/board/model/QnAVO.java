package com.spring.project.board.model;

import java.sql.Date;

public class QnAVO {
	private int product_id;
	private int q_rn;
	private int q_number;
	private String member_id;
	private String member_name;
	private Date q_date;
	private String q_title;
	private String q_category;
	private byte[] q_img;
	private String q_content;
	private int q_group;
	private int q_step;
	
	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public int getQ_rn() {
		return q_rn;
	}

	public void setQ_rn(int q_rn) {
		this.q_rn = q_rn;
	}

	public int getQ_number() {
		return q_number;
	}

	public void setQ_number(int q_number) {
		this.q_number = q_number;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public Date getQ_date() {
		return q_date;
	}

	public void setQ_date(Date q_date) {
		this.q_date = q_date;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_category() {
		return q_category;
	}

	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}

	public byte[] getQ_img() {
		return q_img;
	}

	public void setQ_img(byte[] q_img) {
		this.q_img = q_img;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public int getQ_group() {
		return q_group;
	}

	public void setQ_group(int q_group) {
		this.q_group = q_group;
	}

	public int getQ_step() {
		return q_step;
	}

	public void setQ_step(int q_step) {
		this.q_step = q_step;
	}
}
