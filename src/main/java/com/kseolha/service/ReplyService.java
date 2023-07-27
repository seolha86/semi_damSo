package com.kseolha.service;

import java.util.List;

import com.kseolha.domain.ReplyLikeVO;
import com.kseolha.domain.ReplyVO;

public interface ReplyService {
	int register(ReplyVO vo);
	
	ReplyVO get(Long rno);
	
	int remove(Long rno);
	
	int modify(ReplyVO vo);
	
	List<ReplyVO> getList(Long bno, Long rno, String id);
	
	int like(Long rno, String id);
	
//	int unlike(Long rno, String id);
	
	List<ReplyLikeVO> getLikeList(String id);
}
