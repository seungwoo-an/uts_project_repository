package com.spring.project.member.service;

import java.util.List;

import com.spring.project.member.model.MemberVO;
import com.spring.project.member.model.SelectVO;
import com.spring.project.member.model.SellerInfoVO;
import com.spring.project.product.model.OrdersVO;

public interface IMemberService {
	public String getMemberPassword(String member_id);
	public MemberVO getMemberInfo(String member_id);
	public void memberInsert(MemberVO member);
	public void updateMember(MemberVO member);
	public List<MemberVO> getMemberList(int memberPage , SelectVO select);
	public int getMemberCount(SelectVO select);
	public void memberDelete(String member_id);
	public MemberVO getMemberEmail(String member_email);
	public void changePwd(String member_pw, String member_id);
	
	public List<MemberVO> getPermissionList(int permissionPage ,String permission_word);
	public int getPermissionCount(String permission_word);
	
	public void member_enable(int enable ,String member_id);
	
	public void insertSellerRegNum(String member_id, String seller_reg_num);
	public SellerInfoVO getSellerInfo(String member_id);
	public boolean getSellerRegNum(String seller_reg_num);
	public void updateSellerInfo(SellerInfoVO sellerInfo);
	public List<List<OrdersVO>> getMonthlySales(String name, int year);
	public void deleteSelectedMembers(String[] member_ids);
}
