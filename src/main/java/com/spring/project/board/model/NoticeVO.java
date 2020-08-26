package com.spring.project.board.model;

import java.sql.Date;

public class NoticeVO {
	private int notice_rn;
	private int notice_number;
	private String notice_title;
	private String notice_content;
	private Date notice_date;
	private int notice_views;
	private byte[] notice_file;
	private String notice_file_name;
	
	public byte[] getNotice_file() {
		return notice_file;
	}

	public void setNotice_file(byte[] notice_file) {
		this.notice_file = notice_file;
	}

	public String getNotice_file_name() {
		return notice_file_name;
	}

	public void setNotice_file_name(String notice_file_name) {
		this.notice_file_name = notice_file_name;
	}

	public int getNotice_rn() {
		return notice_rn;
	}

	public void setNotice_rn(int notice_rn) {
		this.notice_rn = notice_rn;
	}

	public int getNotice_number() {
		return notice_number;
	}

	public void setNotice_number(int notice_number) {
		this.notice_number = notice_number;
	}

	public int getNotice_views() {
		return notice_views;
	}

	public void setNotice_views(int notice_views) {
		this.notice_views = notice_views;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public Date getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}
}
