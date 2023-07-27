package com.kseolha.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("message")
public class MessageVO {
	private Long mno;
	private String receiver;
	private String sender;
	private String message;
	private Date sdate;
	private Date rdate;
	private Long room;
}
