package com.spring.project.board.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.spring.project.board.model.NoticeVO;

@Repository
public interface INoticeRepository {
	//select =================
	//전체 공지사항 목록
	@Select("select * from(select rownum notice_rn,n.* from (select * from notice_board order by notice_number desc) n)"
			+ "where notice_rn between #{0} and #{1}")
	public List<NoticeVO> getNoticeList(int start, int end);
	
	//공지사항 하나 클릭(제목)
	@Select("select * from(select rownum notice_rn,n.* from(select * from notice_board order by notice_number desc)n)where notice_rn=#{notice_rn}")
	public NoticeVO getNotice(int notice_rn);

	//공지시항 이전/다음 페이지 처리
	@Select("select notice_title from(select rownum notice_rn,n.* from(select * from notice_board order by notice_number desc)n)where notice_rn=#{notice_rn}")
	public String getTitle(int notice_rn);

	@Select("select count(*) from notice_board")
	public int getTotalCount();
	
	
	//update =================
	//공지사항 조회수 +1증가
	@Update("update notice_board set notice_views=notice_views+1 where notice_number =#{notice_number}")
	public void updateViews(int notice_number);
	
	// 공지사항 view 수정
	@Update("update notice_board set notice_title= #{notice_title}, notice_content=#{notice_content} where notice_number = #{notice_number}")
	public void updateView(NoticeVO noticeVO);
	
	//insert =================
	//공지등록(파일 포함)
	@Insert("insert into notice_board (notice_title,notice_content,notice_number,notice_file,notice_file_name) values(#{notice_title},#{notice_content},#{notice_number},#{notice_file},#{notice_file_name})")
	public void insertNoticeWithFile(NoticeVO noticeVO);
	//공지등록(파일 미포함)
	@Insert("insert into notice_board (notice_title,notice_content,notice_number) values(#{notice_title},#{notice_content},#{notice_number})")
	public void insertNotice(NoticeVO noticeVO);
	@Select("select nvl(max(notice_number),0) from notice_board")
	public int getMaxNoticeNumber();
	
	//delete =================
	@Delete("delete notice_board where notice_number = #{notice_number}")
	public void deleteView(int notice_rn);

}
