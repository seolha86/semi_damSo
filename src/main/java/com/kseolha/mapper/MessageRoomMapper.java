package com.kseolha.mapper;

import org.apache.ibatis.annotations.Param;

import com.kseolha.domain.MessageRoomVO;

public interface MessageRoomMapper {
	
	void insert(MessageRoomVO vo);
	
	MessageRoomVO selectRoom(Long mrno);
	
	int delete(Long mrno);
	
	int update(MessageRoomVO vo);
	
}
