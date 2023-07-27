package com.kseolha.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kseolha.domain.ClubMemberVO;


public interface ClubMemberMapper {
	
	void insert(@Param("member") String member, @Param("club") Long club, @Param("answer") String answer);
	
	ClubMemberVO read(@Param("member") String member, @Param("club") Long club);
	
	List<ClubMemberVO> getList();
	List<ClubMemberVO> getClubList(Long club);
	List<ClubMemberVO> getMemberList(String member);
	
	int delete(@Param("member")String member, @Param("club") Long club);
	int deleteMember(String member);
	int deleteClub(Long club);
	
}