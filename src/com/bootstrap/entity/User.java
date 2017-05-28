package com.bootstrap.entity;

public class User {
	private int bid;
	private String bname;
	private String bpass;
	private String bemail;
	
	public User() {
		super();
	}

	public User(int bid, String bname, String bpass, String bemail) {
		super();
		this.bid = bid;
		this.bname = bname;
		this.bpass = bpass;
		this.bemail = bemail;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBpass() {
		return bpass;
	}

	public void setBpass(String bpass) {
		this.bpass = bpass;
	}

	public String getBemail() {
		return bemail;
	}

	public void setBemail(String bemail) {
		this.bemail = bemail;
	}

	
}
