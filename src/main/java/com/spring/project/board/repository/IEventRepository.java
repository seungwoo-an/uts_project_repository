package com.spring.project.board.repository;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.board.model.EventVO;

@Repository
public interface IEventRepository {
	
	//전체 이벤트 목록
	@Select("select * from(select rownum event_rn,n.* from (select * from event_board order by event_number desc) n)"
			+ "where event_rn between #{0} and #{1}")
	public ArrayList<EventVO> getEventList(int start, int end);
	
	//이벤트 제목 클릭
	@Select("select * from(select rownum event_rn,n.* from(select * from event_board order by event_number desc)n)where event_rn=#{event_rn}")
	public EventVO getEvent(int event_rn);
	
	//paging
	@Select("select event_title from(select rownum event_rn,n.* from(select * from event_board order by event_number desc)n)where event_rn=#{event_rn}")
	public String getTitle(int event_rn);
	
	//이벤트 등록(seller)만 가능
	@Insert("insert into event_board (event_title,event_content,event_number,event_img,event_file_name) values(#{member_id},#{event_content},#{event_img},sysdate,0,#{event_group},#{event_step},#{event_title})")
	public void insertEventWithFile(EventVO eventVO);
	
	@Insert("insert into event_board (event_title,event_content,event_number) values(#{event_title},#{event_content},#{event_number})")
	public void insertEvent(EventVO eventVO);
	
	@Select("select nvl(max(event_number),0) from event_board")
	public int getMaxEventNumber();
	
	//이벤트 내용 수정
	@Update("update event_board set event_title= #{event_title}, event_content=#{event_content} where event_number = #{event_number}")
	public void updateEvent(EventVO eventVO);
	
	//이벤트 조회수 +1 증가
	@Update("update event_board set event_views=event_views+1 where event_number=#{event_number}")
	public void updateViews(int event_number);

	@Select("select count(*) from event_board")
	public int getTotalCount();
	
	@Delete("delete event_board where event_number = #{event_number}")
	public void deleteView(int event_rn);
	@Delete("delete event_board where member_id=#{member_id}")
	public void deleteEventByMemberId(String member_id);
	
}
