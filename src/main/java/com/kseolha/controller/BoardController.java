package com.kseolha.controller;

import com.kseolha.domain.BoardLikeVO;
import com.kseolha.domain.BoardVO;
import com.kseolha.domain.Criteria;
import com.kseolha.domain.MemberVO;
import com.kseolha.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@RequestMapping("/board/")
@Controller
@Log4j
@AllArgsConstructor
public class BoardController {
    private BoardService service;

    @GetMapping({"list", "list/{bno}", "list/{bno}/{category}","list/{category}/club", "list/member/{id}", "list/{bno}/{category}/club"}) @ResponseBody
    public List<BoardVO> getList(@PathVariable(required = false) Optional <Long> bno, @PathVariable(required = false) Optional <Long> category, HttpSession s, @PathVariable(required = false) Optional<String> id) {
        return service.getList(bno.orElse(Long.MAX_VALUE), category.orElse(null), ((MemberVO) s.getAttribute("member")).getEmail(), id.orElse(null));
    }

    @GetMapping({"{email}/allList"}) @ResponseBody
    public List<BoardVO> getAllList(@PathVariable String email) {
        return service.getAll(null, email);
    }

    @GetMapping("{bno}") @ResponseBody
    public BoardVO get(@PathVariable Long bno, HttpSession s) {
        return service.get(bno, ((MemberVO) s.getAttribute("member")).getEmail());
    }

    @PutMapping("{bno}") @ResponseBody
    public int modify(@PathVariable Long bno, @RequestBody BoardVO vo) {
        log.warn(vo);
        return service.modify(vo);
    }

    @DeleteMapping("{bno}") @ResponseBody
    public int remove(@PathVariable Long bno) {
        return service.remove(bno);
    }

    @PostMapping("like/{bno}") @ResponseBody
    public void like(@PathVariable Long bno, String id) {
        service.like(bno, id);
    }

    @DeleteMapping("unlike/{id}/{bno}") @ResponseBody
    public int unlike(@PathVariable Long bno, @PathVariable String id) {
        return service.unlike(bno, id);
    }

    @GetMapping("feed")
    public String board(HttpSession s) {
        if (s.getAttribute("member") != null){
            return "board/feed";
        } else {
            return "redirect:/member/login";
        }
    }

    @PostMapping("register") @ResponseBody
    public Long register(@RequestBody BoardVO vo) {
        log.warn(vo);
        if (vo.getContent().trim().length() != 0) {
            service.register(vo);
        }
        return vo.getBno();
    }
}
