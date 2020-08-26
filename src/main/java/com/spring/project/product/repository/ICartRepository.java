package com.spring.project.product.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.product.model.CartVO;

@Repository
public interface ICartRepository {

	//장바구니 전체 목록(모든 client)
//	@Select("select * from cart")
//	public ArrayList<CartVO> getCartList();
	
	//내 장바구니 보기(products, members 테이블 join - 추가적으로 필요한 정보 끌어옴
	@Select("select c.member_id as member_id, c.product_id as product_id, cart_product_count, product_name, product_price, sel.seller_company_name, sel.product_delivery_price, cart_product_count * product_price product_total_price "
			+ "from cart c "
			+ "join products p "
			+ "on c.product_id = p.product_id "
			+ "join seller_info sel "
			+ "on sel.member_id = p.member_id "
			+ "where c.member_id=#{member_id} "
			+ "order by sel.seller_company_name desc")
	public List<CartVO> getCart(String member_id);
	
	//결제시 장바구니에서 삭제
	@Delete("delete from cart where member_id=#{0} and product_id=#{1}")
	public void deleteCart(String member_id, int product_id);

	//장바구니 담기
	@Insert("insert into cart values(#{0},#{1},#{2},#{3})")
	public void insertCart(String member_id, int product_id, int cart_product_count, int cart_delivery_price);
	//장바구니 수정
	@Update("update cart set cart_product_count=#{2}, cart_delivery_price=#{3} where product_id = #{1} and member_id = #{0}")
	public void updateCart(String member_id, Integer product_id, Integer cart_product_count,int cart_delivery_price);
	
	@Select("select member_id from cart where member_id=#{0} and product_id=#{1}")
	public String getMemberId(String member_id, int product_id);

	//장바구니에서 선택된 상품만 가져가기
	@Select("select c.member_id as member_id, cart_delivery_price, c.product_id as product_id, cart_product_count, product_info, product_name, product_price, m.member_name as seller_name,m.MEMBER_EMAIL as seller_email,m.MEMBER_ID as seller_id,m.MEMBER_TEL as seller_tel,sel.seller_company_name " 
			+ "from cart c join products p "
			+ "on c.product_id = p.product_id "
			+ "join members m "
			+ "on m.member_id = p.member_id "
			+ "join seller_info sel "
			+ "on p.member_id = sel.member_id "
			+ "where c.member_id=#{0} and c.product_id=#{1}")
	public CartVO getSelectedCart(String member_id, int product_id);
	
	@Select("select c.member_id as member_id,cart_delivery_price, c.product_id as product_id, cart_product_count, product_info, product_name, product_price, m.member_name as seller_name,m.MEMBER_EMAIL as seller_email,m.MEMBER_ID as seller_id,m.MEMBER_TEL as seller_tel " 
			+ "from cart c join products p "
			+ "on c.product_id = p.product_id "
			+ "join members m "
			+ "on m.member_id = p.member_id "
			+ "where c.member_id=#{member_id}")
	public List<CartVO> getCartInOrderSheet(String member_id);
	@Delete("delete cart where member_id=#{member_id}")
	public void deleteCartByMemberId(String member_id);
}
