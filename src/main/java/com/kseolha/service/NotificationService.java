package com.kseolha.service;

import com.kseolha.domain.BoardVO;
import com.kseolha.domain.NotificationVO;

import java.util.List;

public interface NotificationService {
    void register(NotificationVO vo);
    int update(Long nno);
//    int noticnt(String email);
    List<NotificationVO> getUncheckedList(String email);
    int removeByBno(Long bno);
}
