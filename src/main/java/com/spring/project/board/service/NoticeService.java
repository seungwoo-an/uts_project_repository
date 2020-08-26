package com.spring.project.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.board.model.NoticeVO;
import com.spring.project.board.repository.INoticeRepository;

@Service
public class NoticeService {

	@Autowired
	INoticeRepository noticeRepository;
	
	public List<NoticeVO> getNoticeList(int page){
		int end = page*10;
		int start = end-9;
		return noticeRepository.getNoticeList(start,end);
	}
	@Transactional(value = "tsManager")	
	public NoticeVO getNotice(int notice_rn) {
		NoticeVO notice = noticeRepository.getNotice(notice_rn);
		noticeRepository.updateViews(notice.getNotice_number());
		return notice;
	}
	
	public String getTitle(int notice_rn) {
		return noticeRepository.getTitle(notice_rn);
	}
	
	public NoticeVO getNoticeInfo(int notice_rn) {
		return noticeRepository.getNotice(notice_rn);
	}
	
	@Transactional(value = "tsManager")
	public void updateView(NoticeVO noticeVo) {
		noticeRepository.updateView(noticeVo);
	}
	
	@Transactional(value = "tsManager")
	public void deleteView(int notice_number) {
		noticeRepository.deleteView(notice_number);
	}
	
	
	public int getTotalCount() {
		return noticeRepository.getTotalCount();
	}

	@Transactional(value = "tsManager")
	public void insertNotice(NoticeVO noticeVO) {
		noticeVO.setNotice_number(noticeRepository.getMaxNoticeNumber()+1);
		noticeRepository.insertNotice(noticeVO);
	}

	public void insertNoticeWithFile(NoticeVO noticeVO) {
		noticeVO.setNotice_number(noticeRepository.getMaxNoticeNumber()+1);
		noticeRepository.insertNoticeWithFile(noticeVO);
	}
	

}
