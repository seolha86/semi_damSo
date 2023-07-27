package com.kseolha.service;

import com.kseolha.domain.AttachFileDTO;
import com.kseolha.domain.BoardLikeVO;
import com.kseolha.domain.BoardVO;

import java.util.List;

public interface BoardService {
    void register(BoardVO vo);
    BoardVO get(Long bno, String id);
    int modify(BoardVO vo);
    int remove(Long bno);
    List<BoardVO> getList(Long bno, Long category, String email, String id);
    List<BoardVO> getAll(Long category, String email);
    void like(Long bno, String id);
    int unlike(Long bno, String id);
    String deleteFile(AttachFileDTO dto);
}
