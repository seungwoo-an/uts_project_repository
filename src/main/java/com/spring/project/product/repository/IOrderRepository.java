package com.spring.project.product.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.product.model.OrderedVO;
import com.spring.project.product.model.OrdersVO;

@Repository
public interface IOrderRepository {
	//결제 완료된 나의 주문내역
//	@Select("select ord.product_id product_id, ord.member_id member_id,pr.product_name product_name, "
//			+ "order_date, order_receiver_main_address,order_receiver_sub_address, order_receiver_name, "
//			+ "order_receiver_tel,order_product_count, order_price, order_request, order_status, order_number, "
//			+ "review_check, order_group_number "
//			+ "from orders ord "
//			+ "join products pr "
//			+ "on ord.product_id = pr.product_id "
//			+ "where ord.member_id=#{member_id} "
//			+ "order by order_group_number desc")
//	public List<OrdersVO> getOrderList(String member_id);
	@Select("select ord.member_id member_id, order_group_number,prd.product_name product_name, order_date, order_price * order_product_count as order_price, "
			+ "order_receiver_main_address, order_receiver_sub_address, order_receiver_tel, order_delivery_price "
			+ "from orders ord "
			+ "join products prd "
			+ "on ord.product_id = prd.product_id "
			+ "where ord.member_id = #{member_id} "
			+ "order by order_group_number desc")
	public List<OrdersVO> getOrderList(String member_id);
	
	
	// 결제하기 버튼 클릭 후 주문완료 페이지 띄우기 전에 주문목록에 넣어주는 sql
	@Insert("insert into orders"
			+ "(member_id,product_id,order_receiver_main_address,order_receiver_sub_address,order_receiver_name,"
			+ "order_receiver_tel,order_product_count,order_price,order_request,order_number,order_group_number,order_delivery_price) "
			+ "values"
			+ "(#{member_id},#{product_id},#{order_receiver_main_address},#{order_receiver_sub_address},#{order_receiver_name},"
			+ "#{order_receiver_tel},#{order_product_count},#{order_price},#{order_request},#{order_number},#{order_group_number},#{order_delivery_price})")
	public void paymentInOrder(OrdersVO ordersVO);
	
//	//주문취소시 삭제
//	@Delete("delete from orders where member_id=#{member_id} and product_id=#{product_id}")
//	public void deleteOrder(String member_id, int product_id);
	
	
	@Select("select ord.member_id member_id, order_date, ord.product_id product_id, prd.product_name product_name, order_product_count, order_number, product_weight "
			+ "from orders ord "
			+ "join products prd "
			+ "on ord.product_id = prd.product_id "
			+ "where ord.order_number=#{order_number}")
	public OrdersVO getOrderByOrderNumber(int order_number);

	@Update("update orders set review_check = 1 where order_number=#{order_number}")
	public void updateReviewCheck(int order_number);

	@Delete("delete orders where order_group_number=#{0}")
	public void deleteOrder(int order_group_number);

	@Select("select ord.product_id product_id, order_number, prd.product_name, order_price, order_product_count, order_request, order_status, order_group_number,"
			+ "ord.member_id, review_check, order_delivery_price, seller_company_name "
			+ "from orders ord "
			+ "join products prd "
			+ "on ord.product_id = prd.product_id "
			+ "join seller_info sel "
			+ "on sel.member_id = prd.member_id "
			+ "where ord.member_id =#{0} and order_group_number =#{1} "
			+ "order by seller_company_name desc")
	public List<OrdersVO> getOrder(String member_id, int order_group_number);

	@Select("select count(*) from orders where member_id = #{member_id}")
	public int getTotalCount(String member_id); 

	@Select("select * from orders where member_id = #{member_id}")
	public List<OrdersVO> getMyOrderList(String member_id);

	@Select("select nvl(max(order_group_number),0) from orders")
	public int getMaxOrderGroupNumber();
	@Select("select nvl(max(order_number),0) from orders")
	public int getMaxOrderNumber();

	@Select("select order_group_number, order_date, order_price * order_product_count as ordered_price, mem.member_name as orderer_name, order_delivery_price "
			+ "from orders ord "
			+ "join members mem "
			+ "on ord.member_id = mem.member_id "
			+ "where order_group_number = #{order_group_number}")
	public List<OrderedVO> getOrderResult(int order_group_number);

	@Select("select o.member_id member_id, o.product_id product_id, p.product_name product_name, o.order_date, ORDER_RECEIVER_MAIN_ADDRESS, ORDER_RECEIVER_NAME, order_receiver_tel, order_product_count, order_price, order_status, order_number, order_receiver_sub_address, order_request, order_group_number,order_delivery_price from orders o"
			+ " join PRODUCTS p on o.product_id = p.product_id" 
			+ " join members m on p.member_id = m.member_id"
			+ " join seller_info s on s.member_id = #{member_id} ")
	public List<OrdersVO> getSellerAdminOrderList(String member_id);

	@Select("select product_id, order_product_count from orders where order_group_number=#{order_group_number}")
	public List<OrdersVO> getOrderByOrderGroupNumber(int order_group_number);

	@Update("update orders set order_status = #{1} where order_number = #{0}")
	public void updateStatus(int order_num, String status);

	@Select("select o.order_status from orders o join members m on m.member_id = o.member_id where o.order_number = #{order_num}")
	public String statusChange(int order_num);

	@Delete("delete orders where member_id = #{member_id}")
	public void deleteOrderByMemberId(String member_id);
	
	


}


