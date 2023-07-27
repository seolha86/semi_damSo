package com.kseolha.controller;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kseolha.domain.MessageRoomVO;
import com.kseolha.service.MessageRoomService;
import com.kseolha.service.MessageService;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("messageroom/*")
@Data
@Log4j
public class MessageRoomController {
	
	private MessageService messageService;
	private MessageRoomService messageRoomService;
	
	@GetMapping("{mrno}")
	public MessageRoomVO get(@PathVariable Long mrno){
		return messageRoomService.get(mrno);
	}

//	사용하진 않음 -> messageController에 있음
	@PostMapping("new")
	public MessageRoomVO register(@RequestBody MessageRoomVO vo){
		messageRoomService.register(vo);
		log.info(vo.getMrno());
		log.info(vo.getName());
		return vo;
	}
	
	@PutMapping("setname/{mrno}")
	public MessageRoomVO setName(@PathVariable Long mrno, @RequestBody MessageRoomVO vo){
		messageRoomService.update(vo);
		log.info(vo.getMrno());
		log.info(vo.getName());
		return vo; 
	}
	
//  사용하진 않음 -> messageController에 있음
	@DeleteMapping("remove/{mrno}")
	public MessageRoomVO remove(@PathVariable Long mrno) {
		MessageRoomVO vo = messageRoomService.get(mrno);
		messageRoomService.delete(mrno);
		return vo;
	}
	
}
