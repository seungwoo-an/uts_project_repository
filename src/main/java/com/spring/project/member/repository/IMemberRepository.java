package com.spring.project.member.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.member.model.MemberVO;
import com.spring.project.member.model.SellerInfoVO;
import com.spring.project.product.model.OrdersVO;

@Repository
public interface IMemberRepository {

	@Select("select member_pw from members where member_id=#{member_id}")
	public String getMemberPassword(String member_id);

	@Select("select m.member_id as member_id , member_pw, member_name, member_tel, member_main_addr,member_sub_addr, member_email, member_enabled, au.authority as member_auth "
			+ "from members m " + "join authorities au " + "on m.member_id=au.member_id "
			+ "where m.member_id=#{member_id}")
	public MemberVO getMemberInfo(String member_id);
	
//지현 start==============================	
//	"select * from (select pro.member_id , EXTRACT(MONTH FROM order_date) as sales_month,"
//	+ "EXTRACT(year FROM order_date) as sales_year ,ord.product_id, ord.order_product_count, ord.order_price from orders ord "
//	+ "join products pro on pro.product_id = ord.product_id where pro.member_id = #{0}) "
//	+ "where sales_year = #{} and sales_month = 7"
	//판매자 페이지 월별 판매량
	@Select("select * from (select pro.member_id , EXTRACT(MONTH FROM order_date) as sales_month,"
			+ "EXTRACT(year FROM order_date) as sales_year ,ord.product_id, ord.order_product_count, ord.order_price from orders ord "
			+ "join products pro on pro.product_id = ord.product_id where pro.member_id = #{0}) "
			+ "where sales_year = #{1} and sales_month = #{2}")
	public List<OrdersVO> getMonthlySales(String member_id, int year, int month);
//지현 end==============================	
	// 권한 수정========================================================================
	@Update("update members set member_enabled=#{0} where member_id = #{1}")
	public void member_enable(int enable ,String member_id);

	// 회원 정보 수정
	@Update("update members set member_pw=#{member_pw},member_name=#{member_name}, member_tel=#{member_tel}, member_main_addr=#{member_main_addr},member_sub_addr=#{member_sub_addr}, member_email=#{member_email} "
			+ "where member_id=#{member_id}")
	public void updateMember(MemberVO member);
	
	@Update("update members set member_pw=#{0} where member_id=#{1}")
	public void changePwd(String member_pw,String member_id);
	// =============================================================================

	// 회원가입 sql ===================================================================
	@Insert("insert into members (member_id, member_pw, member_name, member_tel, member_main_addr,member_sub_addr, member_email,member_enabled) "
			+ "values(#{member_id},#{member_pw},#{member_name},#{member_tel},#{member_main_addr},#{member_sub_addr},#{member_email},#{member_enabled})")
	public void memberJoin(MemberVO member);

	@Insert("insert into authorities values(#{0} , #{1})")
	public void authJoin(String member_id, String member_auth);
	// =============================================================================

	// 회원 탈퇴====================================================================
	@Delete("delete from authorities where member_id=#{member_id}")
	public void authDelete(String member_id);

	@Delete("delete from members where member_id=#{member_id}")
	public void memberDelete(String member_id);
	// ==============================================================================

	// 회원 목록 출력=====================================================================

	@Select("select * from (select rownum rn , m.member_id , member_pw, member_name, member_tel, member_main_addr,member_sub_addr, member_email, member_enabled, au.authority as member_auth "
			+ "from members m join authorities au on m.member_id=au.member_id where ${param3} and ${param4} and ${param5} ) "
			+ "where rn between #{0} and #{1}")
	public List<MemberVO> getSelectMemberList(int start, int end, String auth , String enable , String word);

	@Select("select count(*) from members m join authorities au on m.member_id=au.member_id where ${param1} and ${param2} and ${param3}")
	public int getMemberCount(String auth , String enable , String word);
	
	@Select("select count(*) from members m join authorities au on m.member_id=au.member_id where m.member_id like '%'||#{0}||'%' or m.member_name like '%'||#{0}||'%'")
	public int getSelectMemberCount(String member_word);

	@Select("select * from (select rownum rn , m.member_id , member_pw, member_name, member_tel, member_main_addr,member_sub_addr, member_email, member_enabled, au.authority as member_auth "
			+ "from members m join authorities au on m.member_id=au.member_id where member_enabled = 0) "
			+ "where rn between #{0} and #{1} ")
	public List<MemberVO> getPermissionList(int start, int end);

	@Select("select * from (select rownum rn , m.member_id , member_pw, member_name, member_tel, member_main_addr,member_sub_addr, member_email, member_enabled, au.authority as member_auth "
			+ "from members m join authorities au on m.member_id=au.member_id where member_enabled = 0 and m.member_id like '%'||#{2}||'%' or m.member_name like '%'||#{2}||'%')"
			+ "where rn between #{0} and #{1}")
	public List<MemberVO> getSelectPermissionList(int start, int end, String permission_word);

	@Select("select count(*) from members m join authorities au on m.member_id=au.member_id where member_enabled = 0 ")
	public int getPermissionCount();

	@Select("select count(*) from members m join authorities au on m.member_id=au.member_id where member_enabled = 0 and m.member_id like '%'||#{0}||'%' or m.member_name like '%'||#{0}||'%' ")
	public int getSelectPermissionCount(String permission_word);
	
	@Select("select * from members where member_email = #{0}")
	public MemberVO getEmail(String member_email);
	
	
	
	
	// ================================================================================
	
	//--------------------seller_info queries--------------------------------------
	@Insert("insert into seller_info (member_id, seller_reg_num) values(#{0},#{1})")
	public void insertSellerRegNum(String member_id, String seller_reg_num);
	
	
	@Select("select * from seller_info where member_id=#{member_id}")
	public SellerInfoVO getSellerInfo(String member_id);
	@Select("select seller_reg_num from seller_info where seller_reg_num =#{seller_reg_num}")
	public String getSellerRegNum(String seller_reg_num);
	@Update("update seller_info "
			+ "set seller_company_name=#{seller_company_name}, "
			+ "seller_company_info= #{seller_company_info}, "
			+ "seller_company_tel=#{seller_company_tel}, "
			+ "seller_company_main_address=#{seller_company_main_address}, "
			+ "seller_company_sub_address=#{seller_company_sub_address}, "
			+ "seller_company_email=#{seller_company_email}, "
			+ "seller_company_head_name=#{seller_company_head_name}, "
			+ "product_delivery_price = #{product_delivery_price} "
			+ "where seller_reg_num=#{seller_reg_num}")
	public void updateSellerInfo(SellerInfoVO sellerInfo);
	
	@Delete("delete seller_info where member_id=#{member_id}")
	public void sellerDelete(String member_id);

}
