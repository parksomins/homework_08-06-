package com.koreait.reply;

import java.util.ArrayList;

import com.koreait.board.BoardDTO;

public class ReplyDTO {
	private int idx;
	private String userid;
	private String content;
	private String regdate;
	private int boardidx;
	private ArrayList<BoardDTO> replyDto;
	public ArrayList<BoardDTO> getReplyDto() {
		return replyDto;
	}
	public void setReplyDto(ArrayList<BoardDTO> replyDto) {
		this.replyDto = replyDto;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getBoardidx() {
		return boardidx;
	}
	public void setBoardidx(int boardidx) {
		this.boardidx = boardidx;
	}
	@Override
	public String toString() {
		return "ReplyDTO [idx=" + idx + ", userid=" + userid + ", content=" + content + ", regdate=" + regdate
				+ ", boardidx=" + boardidx + ", replyDto=" + replyDto + "]";
	}
	
}
