package com.kseolha.mapper;


import java.util.List;

import com.kseolha.domain.ClubVO;
import com.kseolha.domain.Criteria;
import com.kseolha.domain.MemberVO;

public interface ClubMapper {

    void insert(ClubVO vo);

    ClubVO read(Long cno);
    
    List<ClubVO> getList();
    List<ClubVO> getListByEmail(String email);

    List<ClubVO> searchName(String keyword);
    
    List<ClubVO> getMyClubList(String email);

    int delete(Long cno);

    int deleteLeader(String email);

    int update(ClubVO vo);

    void deleteCRLByEmail(String email);
    void deleteCRByEamil(String email);
    void deleteCBAByEmail(String email);
    void deleteCMByEmail(String email);
    void deleteCNByEmail(String email);
    void deleteCBLByEmail(String email);
    void deleteCBByEmail(String email);
}
