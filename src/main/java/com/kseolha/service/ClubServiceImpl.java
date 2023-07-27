package com.kseolha.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kseolha.domain.AttachVO;
import com.kseolha.domain.BoardVO;
import com.kseolha.domain.ClubVO;
import com.kseolha.domain.Criteria;
import com.kseolha.domain.MemberVO;
import com.kseolha.mapper.AttachMapper;
import com.kseolha.mapper.BoardMapper;
import com.kseolha.mapper.ClubMapper;
import com.kseolha.mapper.ClubMemberMapper;
import com.kseolha.mapper.MemberMapper;
import com.kseolha.mapper.NotificationMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
@ToString
public class ClubServiceImpl implements ClubService {
	
	@Setter
	@Autowired
	private ClubMapper clubMapper;
	private AttachMapper attachMapper;
	private NotificationMapper notiMapper;
	
	@Override
	public void register(ClubVO vo) {
		clubMapper.insert(vo);
		Long cno = vo.getCno();
		List<AttachVO> attaches = vo.getAttaches();
		
		for(AttachVO attach : attaches) {
			attach.setCno(cno);
			attachMapper.insert(attach);
		}
	}
	
	@Override
	public ClubVO get(Long cno) {
		return clubMapper.read(cno);
	}
	
	@Override
	public List<ClubVO> getList() {
		return clubMapper.getList();
	}
	
	@Override
	public List<ClubVO> searchName(String keyword) {
		return clubMapper.searchName(keyword);
	}
	
	@Override
	public List<ClubVO> getMyClubList(String email) {
		return clubMapper.getMyClubList(email);
	}
	
	@Override
	public boolean modify(ClubVO vo) {
		return clubMapper.update(vo) > 0;
	}
	
	@Override
	public boolean remove(Long cno) {
		notiMapper.deleteByCno(cno);
		attachMapper.deleteByCno(cno);
		return clubMapper.delete(cno) > 0;
	}
	
}
