package com.spring.project.board.model;

import java.sql.Date;

public class EventVO {
	private int event_rn;
	private int event_number;
	private String member_id;
	private String event_title;
	private String event_content;
	private byte[] event_img;
	private Date event_date;
	private int event_views;
	private String event_img_name;
	
	public int getEvent_number() {
		return event_number;
	}

	public void setEvent_number(int event_number) {
		this.event_number = event_number;
	}

	public String getEvent_img_name() {
		return event_img_name;
	}

	public void setEvent_img_name(String event_img_name) {
		this.event_img_name = event_img_name;
	}

	public int getEvent_rn() {
		return event_rn;
	}

	public void setEvent_rn(int event_rn) {
		this.event_rn = event_rn;
	}

	public String getEvent_title() {
		return event_title;
	}

	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}

	public int getEvent_views() {
		return event_views;
	}

	public void setEvent_views(int event_views) {
		this.event_views = event_views;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}

	public byte[] getEvent_img() {
		return event_img;
	}

	public void setEvent_img(byte[] event_img) {
		this.event_img = event_img;
	}

	public Date getEvent_date() {
		return event_date;
	}

	public void setEvent_date(Date event_date) {
		this.event_date = event_date;
	}
}
