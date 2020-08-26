package com.spring.project.login.service;

import com.spring.project.member.model.MemberVO;

public interface ILoginService {
	public MemberVO getMemberInfo(String member_id);
}
