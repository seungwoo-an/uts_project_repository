package com.spring.project.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.board.model.ReviewVO;

@Repository
public interface IReviewRepository {
	//글 삭제
	@Delete("delete from review_board where member_id=#{member_id} and product_id=#{product_id}")
	public void deleteReview(String member_id, int product_id);
	
	//리뷰 수정
	@Update("update review_board set review_content=#{review_content} where member_id=#{member_id} and product_id=#{product_id}")
	public void updateReview(String member_id, int product_id);
	
	@Select("select count(*) from review_board where product_id = #{product_id}")
	public int getTotalCount(int product_id);
	@Select("select * from (select rownum review_rn, re.* from (select * from review_board where product_id = #{0} order by review_number desc)re)where review_rn between #{1} and #{2}")
	public List<ReviewVO> getReviewList(int product_id, int start, int end);
	
	@Insert("insert into review_board (review_number, member_id, product_id, purchase_date, order_product_count, review_score, review_title, review_content, review_img, review_img_name) "
			+ "values(#{review_number}, #{member_id},#{product_id},#{purchase_date},#{order_product_count},#{review_score},#{review_title},#{review_content},#{review_img},#{review_img_name})")
	public void insertReviewWithImage(ReviewVO reviewVO);
	@Select("select nvl(max(review_number),0) from review_board where product_id=#{product_id}")
	public int getMaxReviewNumber(int product_id);
	
	@Insert("insert into review_board (review_number, member_id, product_id, purchase_date, order_product_count, review_score, review_title, review_content) "
			+ "values(#{review_number}, #{member_id},#{product_id},#{purchase_date},#{order_product_count},#{review_score},#{review_title},#{review_content})")
	public void insertReview(ReviewVO reviewVO);
	
	@Select("select review_img, review_img_name from review_board where product_id=#{0} and review_number=#{1}")
	public ReviewVO getReviewImage(int product_id, int review_number);
	@Delete("delete review_board where member_id=#{member_id}")
	public void deleteReviewByMemberId(String member_id);
}
