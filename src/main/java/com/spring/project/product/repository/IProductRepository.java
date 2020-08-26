package com.spring.project.product.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.product.model.ProductsVO;

@Repository
public interface IProductRepository {
	// select======================================
	// 전체 목록 가져오기
	@Select("select * from products")
	public ArrayList<ProductsVO> getProductList();

	@Select("select * from products where member_id = #{0}")
	public ArrayList<ProductsVO> getSellerProductList(String member_id);

	// 상품 한개의 정보 가져오기
	@Select("select * from products where product_id=#{product_id}")
	public ProductsVO getProduct(int product_id);

	@Select("select nvl(max(product_id),0) from products")
	public int getMaxProductId();

	// 판매자 등록 상품 총 갯수
	@Select("select count(*) from products where member_id=#{member_id} ")
	public int getTotalCount(String member_id);

	// 메인 페이지 오늘의 신상품
	@Select("select prd.product_id, prd.member_id, prd.product_name, prd.product_price, sel.seller_company_name "
			+ "from products prd " + "join seller_info sel " + "on prd.member_id = sel.member_id " + "where rownum <=4 "
			+ "order by prd.product_upload_date desc")
	public List<ProductsVO> getNewestProducts();

	// delete======================================
	// 판매자 페이지 등록된 상품 삭제
	@Delete("delete from products where product_id=#{product_id}")
	public void deleteSellerProduct(int product_id);

	// update======================================
	// 물량 감소
	@Update("update products set product_count=product_count-#{minusCount} where product_id=#{product_id}")
	public void minusProductCount(int minusCount, int product_id);

	// 물량 증가
	@Update("update products set product_count=product_count+#{plusCount} where product_id=#{product_id}")
	public void plusProductCount(int plusCount, int product_id);

	// 주문 완료 후 총 수량 수정
	@Update("update products set product_count=product_count-#{1}, product_sold_count=product_sold_count+#{1} where product_id=#{0}")
	public void afterPayment(int product_id, int order_product_count);

	// 등록된 상품 수정(파일수정 x)
	@Update("update products set product_name=#{product_name}, product_weight=#{product_weight}, product_count=#{product_count}, product_price=#{product_price}, product_info=#{product_info} where product_id=#{product_id}")
	public void updateProduct(ProductsVO productVo);

	// 등록된 상품 수정(파일수정 o)
	@Update("update products set product_img=#{product_img}, product_img_name=#{product_img_name}, product_name=#{product_name}, product_weight=#{product_weight}, product_count=#{product_count}, product_price=#{product_price}, product_info=#{product_info} where product_id=#{product_id}")
	public void updateProductWithImage(ProductsVO productVo);

	// insert======================================
	// 상품입고
	@Insert("insert into products "
			+ "(product_id, member_id, product_info, product_name, product_img, product_count, product_price, product_weight, product_img_name) "
			+ "values(#{product_id}, #{member_id}, #{product_info}, #{product_name}, #{product_img}, #{product_count}, #{product_price}, #{product_weight}, #{product_img_name})")
	public void insertProduct(ProductsVO product);

	@Select("select prd.product_id, prd.member_id, prd.product_name, prd.product_price, sel.seller_company_name "
			+ "from products prd " + "join seller_info sel " + "on prd.member_id = sel.member_id " + "where rownum <=4 "
			+ "order by prd.product_sold_count desc")
	public List<ProductsVO> getPopularProductList();

	@Update("update products " + "set product_count=product_count + #{1}, "
			+ "product_sold_count = product_sold_count - #{1}, "
			+ "product_canceled_count = product_canceled_count + #{1} " + "where product_id = #{0}")
	public void cancelOrder(int product_id, int order_product_count);

	@Select("select sel.seller_company_name from products prd join seller_info sel on prd.member_id = sel.member_id where product_id=#{product_id}")
	public String getSellerCompanyName(int product_id);

	@Select("select * from products where product_name like '%'||#{search}||'%'")
	public List<ProductsVO> getProductListBySearch(String search);

	@Delete("delete products where member_id = #{member_id}")
	public void deleteProductByMemberId(String member_id);

}
