package com.kseolha.service;

import com.kseolha.controller.UploadController;
import com.kseolha.domain.AttachFileDTO;
import com.kseolha.domain.AttachVO;
import com.kseolha.domain.BoardLikeVO;
import com.kseolha.domain.BoardVO;
import com.kseolha.mapper.AttachMapper;
import com.kseolha.mapper.BoardMapper;
import com.kseolha.mapper.NotificationMapper;
import com.kseolha.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.List;

@Log4j @Service @AllArgsConstructor @ToString
public class BoardServiceImpl implements BoardService {
    @Setter
    @Autowired
    private BoardMapper boardMapper;
    private ReplyMapper replyMapper;
    private AttachMapper attachMapper;
    private NotificationMapper notificationMapper;

    @Override
    public void register(BoardVO vo) {
        boardMapper.insert(vo);
        Long bno = vo.getBno();
        List<AttachVO> attaches = vo.getAttaches();

        for (AttachVO attach : attaches) {
            attach.setBno(bno);
            attachMapper.insert(attach);
        }
    }

    @Override
    public BoardVO get(Long bno, String id) {
        return boardMapper.read(bno, id);
    }

    @Override
    public int modify(BoardVO vo) {
        return boardMapper.update(vo);
    }

    @Override
    public int remove(Long bno) {
        notificationMapper.deleteByBno(bno);
        replyMapper.deleteByBnoRlno(bno);
        boardMapper.deleteLikeByBno(bno);
        replyMapper.deleteByBno(bno);
        attachMapper.deleteByBno(bno);
        return boardMapper.delete(bno);
    }

    @Override
    public List<BoardVO> getList(Long bno, Long category, String email, String id) {
        return boardMapper.getList(bno, category, email, id);
    }

    @Override
    public List<BoardVO> getAll(Long category, String email) {
        return boardMapper.getAllList(category, email);
    }

    @Override
    public void like(Long bno, String id) {
        boardMapper.insertLike(bno, id);
    }

    @Override
    public int unlike(Long bno, String id) {
        return boardMapper.deleteLike(bno, id);
    }

    @Override
    public String deleteFile(AttachFileDTO dto) {
        String s = UploadController.getPATH() + "/" + dto.getPath() + "/" + dto.getUuid() + "_" + dto.getName();
        File file = new File(s);
        file.delete();

        if (dto.isImage()) {
            s = UploadController.getPATH() + "/" + dto.getPath() + "/s_" + dto.getUuid() + "_" + dto.getName();
            file = new File(s);
            file.delete();
        }
        return dto.getUuid();
    }
}
