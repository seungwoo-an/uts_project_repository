package com.spring.project.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import com.spring.project.board.model.FreVO;

@Repository
public interface IFAQRepository {
	
	@Select("select * from(select rownum rn , n.* from (select * from Frequently_Asked_Questions order by fre_number asc) n)"
			+ "where rn between #{0} and #{1}")
	public List<FreVO> getFAQList(int start, int end);

	@Select("select count(*) from Frequently_Asked_Questions")
	public int getTotalCount();

	@Select("select fre_content from Frequently_Asked_Questions where fre_number = #{fre_number}")
	public String getContent(int fre_number);

}
