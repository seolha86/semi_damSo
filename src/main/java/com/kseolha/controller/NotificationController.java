package com.kseolha.controller;

import com.kseolha.domain.MemberVO;
import com.kseolha.domain.NotificationVO;
import com.kseolha.service.MemberService;
import com.kseolha.service.NotificationService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/noti/")
@RestController
@Log4j
@AllArgsConstructor
public class NotificationController {
    @Autowired
    private NotificationService notiService;

    @Autowired
    private MemberService memberService;

    @PostMapping("insert")
    public void insertNoti(@RequestBody NotificationVO vo) {
        if (!getIdByEmail(vo.getSender()).equals(vo.getReceiver())) {
            if (vo.getType().equals("clubRegister")) {
                vo.setReceiver(getIdByEmail(vo.getReceiver()));
            }
            notiService.register(vo);
        }
    }

    @PutMapping("{nno}")
    public int check(@PathVariable Long nno) {
        return notiService.update(nno);
    }

    @GetMapping("{email}/uncheck")
    public List<NotificationVO> uncheckedList(@PathVariable String email) {
        return notiService.getUncheckedList(email);
    }

    private String getIdByEmail(String email) {
        MemberVO member = memberService.get(email);
        String id = null;
        if (email != null) {
            id = member.getId();
        }
        return id;
    }
}
