package com.bootstrap.biz.impl;
import java.util.Date;
import java.util.List;

import com.bootstrap.biz.FrontBiz;
import com.bootstrap.dao.FrontDao;
import com.bootstrap.dao.impl.FrontDaoImpl;
import com.bootstrap.entity.Email;
import com.bootstrap.entity.User;

public class FrontBizImpl implements FrontBiz{
    FrontDao fd=new FrontDaoImpl();
	public User userLogin(String bname, String bpass) {
		return fd.userLogin(bname, bpass);
	}
	
	public boolean checkNameIsExist(String bname) {
		return fd.checkNameIsExist(bname);
	}
	
	public boolean userRegister(String bname, String bpass, String bemail) {
		return fd.userRegister(bname, bpass, bemail);
	}

	public List<Email> getEmailListByName(String bname) {
		return fd.getEmailListByName(bname);
	}

	public String getNameById(int bid) {
		return fd.getNameById(bid);
	}

	public int getEmailCount(String sendto, int state) {
		return fd.getEmailCount(sendto, state);
	}

	public List<Email> showEmailList(int page, int size, String sendto,
			int state) {
		return fd.showEmailList(page, size, sendto, state);
	}

	public boolean delEmail(int msgid) {
		return fd.delEmail(msgid);
	}

	public boolean sendEmail(int bid, String sendto, String title,
			String msgcontent, Date senddate) {
		return fd.sendEmail(bid, sendto, title, msgcontent, senddate);
	}

	public Email showEmail(int msgid) {
		return fd.showEmail(msgid);
	}
	
//	public List<Email> getEmailByPage(int pageIndex, int pageSize,
//			String sendto, int state) {
//		return fd.getEmailByPage(pageIndex, pageSize, sendto, state);
//	}
//
//	public int getPageCount(int pageSize, String sendto, int state) {
//		return fd.getPageCount(pageSize, sendto, state);
//	}


//	public int getPageCount(String bname) {
//		return fd.getPageCount(bname);
//	}
}
