package com.kseolha.mapper;

import com.kseolha.domain.NotificationVO;

import java.util.List;

public interface NotificationMapper {
    void insert(NotificationVO vo);
    int update(Long nno);
    int noticnt(String email);
    List<NotificationVO> uncheckedList(String email);
    int deleteByBno(Long bno);
    int deleteByCno(Long cno);
    int deleteByEmail(String email);
}
