package com.kseolha.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("reply") 
public class ReplyVO {
	
	private Long rno;
	private Long bno;
	private String content;
	private String writer;
	private Date regdate;
	private Date updatedate;
	
	private int likecnt;
	private Boolean likeOn;
}
