package com.bootstrap.entity;

import java.util.Date;

public class Email {
	private int msgid;
	private int bid;
	private String title;
	private String msgcontent;
	private int state;
	private String sendto;
	private Date senddate;
	
	public Email() {
		super();
	}

	public Email(int msgid, int bid, String title, String msgcontent,
			int state, String sendto, Date senddate) {
		super();
		this.msgid = msgid;
		this.bid = bid;
		this.title = title;
		this.msgcontent = msgcontent;
		this.state = state;
		this.sendto = sendto;
		this.senddate = senddate;
	}

	public int getMsgid() {
		return msgid;
	}

	public void setMsgid(int msgid) {
		this.msgid = msgid;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMsgcontent() {
		return msgcontent;
	}

	public void setMsgcontent(String msgcontent) {
		this.msgcontent = msgcontent;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getSendto() {
		return sendto;
	}

	public void setSendto(String sendto) {
		this.sendto = sendto;
	}

	public Date getSenddate() {
		return senddate;
	}

	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}

}
