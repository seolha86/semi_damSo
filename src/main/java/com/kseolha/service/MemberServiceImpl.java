package com.kseolha.service;

import java.util.List;

import org.apache.ibatis.javassist.compiler.MemberResolver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kseolha.domain.AttachFileDTO;
import com.kseolha.domain.BoardLikeVO;
import com.kseolha.domain.BoardVO;
import com.kseolha.domain.ClubVO;
import com.kseolha.domain.MemberVO;
import com.kseolha.mapper.AttachMapper;
import com.kseolha.mapper.BoardMapper;
import com.kseolha.mapper.ClubMapper;
import com.kseolha.mapper.ClubMemberMapper;
import com.kseolha.mapper.FriendMapper;
import com.kseolha.mapper.MemberMapper;
import com.kseolha.mapper.MessageMapper;
import com.kseolha.mapper.NotificationMapper;
import com.kseolha.mapper.ReplyMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	
	private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
	
	
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private AttachMapper attachMapper;
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private ReplyMapper replyMapper;
	@Autowired
	private ClubMapper clubMapper;
	@Autowired
	private ClubMemberMapper clubMemberMapper;
	@Autowired
	private FriendMapper friendMapper;
	@Autowired
	private MessageMapper messageMapper;
	@Autowired
	private NotificationMapper notificationMapper;


	
	@Override
    public List<MemberVO> getList() throws Exception{
        return memberMapper.getList();
    }
	
	// 아이디 조회
	public MemberVO read(String id)throws Exception  {
		return memberMapper.get(id);
	}
	
	@Override
	public MemberVO get(String email) {
		return memberMapper.getEmail(email);
	}

	// 회원가입
	@Override
	public void register(MemberVO vo) throws Exception {
		vo.setPw(encoder.encode(vo.getPw()));
		memberMapper.register(vo);
	}
	
	// 로그인
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		MemberVO memberVO = memberMapper.selectOne(vo);
		System.out.println(memberVO.getPw());
		System.out.println(vo.getPw());
		return encoder.matches(vo.getPw(), memberVO.getPw()) ? memberVO : null;
	}
	
	// 이메일,아이디 중복검사
	 @Override
	 public int idCheck(String email) throws Exception {
	    return memberMapper.idCheck(email);
	 }
	 @Override
	 public int nickCheck(String id) throws Exception {
		 return memberMapper.nickCheck(id);
	 }

	// 아이디 찾기 
	 public MemberVO selectId(MemberVO vo) throws Exception{
		 return memberMapper.findId(vo);
	 }

	// 비밀번호 찾기
	@Override
	public void findPw(MemberVO vo) throws Exception {
		 memberMapper.updatePw(vo);
	}
	
	// 회원아이디 검색
	@Override
	public List<MemberVO> searchName(String id) {
		return memberMapper.searchName(id);
	}
	
	// 회원정보 수정
	@Override
	public int modify(MemberVO vo) {
		
		return memberMapper.memberUpdate(vo);
	}
	
	// 비밀번호 변경
	@Override
	public void modifyPw(MemberVO vo) {
		vo.setPw(encoder.encode(vo.getPw()));
		memberMapper.changePw(vo);
	}
	
	// 회원탈퇴
	@Override
	public void memberDelete(String email) {
		System.out.println("email : " + email);
		
//		// 모임장일시 클럽삭제 
//		List<ClubVO> cvo = clubMapper.getListByEmail(email);
//		for(ClubVO i : cvo) {
//			System.out.println("i : " + i.getCleader());
//			if(i.getCleader() == email) {
//				clubMapper.deleteCRLByEmail(email); // 클럽 게시물 댓글 좋아요 일괄삭제
//				clubMapper.deleteCRByEamil(email);  // 클럽 댓글 일괄삭제
//				clubMapper.deleteCBLByEmail(email); // 클럽 게시물 좋아요 일괄삭제 
//				clubMapper.deleteCBAByEmail(email); // 클럽 attach 일괄삭제 
//				clubMapper.deleteCNByEmail(email); // 클럽알림 일괄삭제
//				clubMapper.deleteCBByEmail(email); 	// 모임 게시물삭제 일괄삭제
//				clubMapper.deleteCMByEmail(email); // 클럽 멤버 일괄삭제
//				
//				// 모임 삭제
//				clubMapper.deleteLeader(email);
//			}
//		}
		// 팔로우 삭제 
		friendMapper.delete(email);
		
		// 댓글삭제 
		replyMapper.deleteLikeByEmail(email);
		replyMapper.deleteByEmail(email);
	
		// attach 삭제
		attachMapper.deleteBAByEmail(email);
		
		// 게시물, 게시물 좋아요 삭제
		boardMapper.deleteLikeByEmail(email);
		
		boardMapper.deleteBoardByEmail(email);
		
		// 알림삭제 
		notificationMapper.deleteByEmail(email);
		
		// 메세지 업데이트 
		messageMapper.updateBySender(email);

		messageMapper.updateByReceiver(email);
		
		// 모임탈퇴
		clubMemberMapper.deleteMember(email);
		
		// 회원삭제
		memberMapper.deleteMember(email);
		
		// 클럽멤버 모두 탈퇴
		

		System.out.println("탈퇴완료");
		
	}

	
}
