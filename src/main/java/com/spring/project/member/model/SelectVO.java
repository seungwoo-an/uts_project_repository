package com.spring.project.member.model;

public class SelectVO {

	private int page;
	private String select_word;
	private String select_option;
	private String select_auth;
	private String select_enabled;
	
	

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public String getSelect_word() {
		return select_word;
	}

	public void setSelect_word(String select_word) {
		this.select_word = select_word;
	}

	public String getSelect_option() {
		return select_option;
	}

	public void setSelect_option(String select_option) {
		this.select_option = select_option;
	}

	public String getSelect_auth() {
		return select_auth;
	}

	public void setSelect_auth(String select_auth) {
		this.select_auth = select_auth;
	}

	public String getSelect_enabled() {
		return select_enabled;
	}

	public void setSelect_enabled(String select_enabled) {
		this.select_enabled = select_enabled;
	}

}
