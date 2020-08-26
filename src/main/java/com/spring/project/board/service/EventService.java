package com.spring.project.board.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.project.board.model.EventVO;
import com.spring.project.board.repository.IEventRepository;

@Service
public class EventService{

	@Autowired
	IEventRepository eventRepository;

	public ArrayList<EventVO> getEventList(int page){
		int end = page*10;
		int start = end-9;
		return eventRepository.getEventList(start, end);
	}
	@Transactional(value = "tsManager")
	public EventVO getEvent(int event_rn) {
		EventVO event = eventRepository.getEvent(event_rn);
		eventRepository.updateViews(event.getEvent_number());
		return event;
	}
	
	public String getTitle(int event_rn) {
		return eventRepository.getTitle(event_rn);
	}
	@Transactional(value = "tsManager")
	public void updateEvent(EventVO eventVO) {
		eventRepository.updateEvent(eventVO);
	}
	@Transactional(value = "tsManager")
	public void deleteView(int event_rn) {
		eventRepository.deleteView(event_rn);
	}
	
	public int getTotalCount() {
		return eventRepository.getTotalCount();
	}
	@Transactional(value = "tsManager")
	public void insertEvent(EventVO eventVO) {
		eventVO.setEvent_number(eventRepository.getMaxEventNumber()+1);
		eventRepository.insertEvent(eventVO);
	}
	@Transactional(value = "tsManager")
	public void insertEventWithFile(EventVO eventVO) {
		eventVO.setEvent_number(eventRepository.getMaxEventNumber()+1);
		eventRepository.insertEventWithFile(eventVO);
	}
	
	public EventVO getNoticeInfo(int event_rn) {
		return eventRepository.getEvent(event_rn);
	}
}
