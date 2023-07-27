package com.kseolha.service;

import java.util.List;

import com.kseolha.domain.ClubVO;
import com.kseolha.domain.Criteria;
import com.kseolha.domain.MemberVO;

public interface ClubService {
	void register(ClubVO vo);
	ClubVO get(Long cno);
	boolean modify(ClubVO vo);
	boolean remove(Long cno);
	List<ClubVO> getList();
	List<ClubVO> getMyClubList(String email);
	List<ClubVO> searchName(String keyword);
}
