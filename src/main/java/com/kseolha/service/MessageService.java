package com.kseolha.service;

import java.util.List;
import java.util.Optional;

import com.kseolha.domain.MessageVO;

public interface MessageService {
	
	void send(MessageVO vo); // insert
	
	MessageVO get(Long mno); // selectOne
	
	List<MessageVO> chat(String receiver, String sender);
	
	List<MessageVO> chatOfRoom(Long room);
	
	List<MessageVO> uncheckedList(String receiver, String sender);
	
	boolean setRoom(Long room, Long mno);
	
	boolean receive(Long mno);
	
	boolean removeMessage(Long mno);
	
	boolean removeRoom(Long mno);
}
