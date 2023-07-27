package com.kseolha.mapper;

import com.kseolha.domain.AttachFileDTO;
import com.kseolha.domain.AttachVO;

import java.util.List;

public interface AttachMapper {
    void insert(AttachVO vo);
    void delete(String uuid);
    List<AttachFileDTO> findBy(Long bno);
    void deleteByBno(Long bno);
    void deleteByCno(Long cno);
    void deleteBAByEmail(String email);
}
