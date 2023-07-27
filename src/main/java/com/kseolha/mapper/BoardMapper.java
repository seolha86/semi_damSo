package com.kseolha.mapper;

import com.kseolha.domain.BoardLikeVO;
import com.kseolha.domain.BoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {
    // 글 목록
    List<BoardVO> getList(@Param("bno") Long bno, @Param("category") Long category, @Param("email") String email, @Param("id") String id);
    List<BoardVO> getAllList(@Param("category") Long category, @Param("email") String email);

    // 글 등록
    void insert(BoardVO vo);

    // 조회
    BoardVO read(@Param("bno") Long bno, @Param("id") String id);

    int delete(Long bno);

    int update(BoardVO vo);

    void insertLike(@Param("bno") Long bno, @Param("id") String id);

    int deleteLike(@Param("bno") Long bno, @Param("id") String id);

    int deleteLikeByBno(Long bno);

    int deleteBoardByEmail(String email);
    int deleteLikeByEmail(String email);
}
