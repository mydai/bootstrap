package com.bootstrap.dao;

import java.util.Date;
import java.util.List;

import com.bootstrap.entity.Email;
import com.bootstrap.entity.User;

public interface FrontDao {
	
    public User userLogin(String bname,String bpass);
    
    public boolean checkNameIsExist(String bname);
    
    public boolean userRegister(String bname,String bpass,String bemail);
    
    public List<Email> getEmailListByName(String bname);
    
    public String getNameById(int bid);
    
    public abstract int  getEmailCount(String sendto,int state);
    
	public abstract List<Email> showEmailList(int page, int size,String sendto,int state);
	
	public boolean delEmail(int msgid);
	
	public boolean sendEmail(int bid,String sendto, String title, String msgcontent,Date senddate);
	
	public Email showEmail(int msgid);
    
//    public List<Email> getEmailByPage(int pageIndex, int pageSize,String sendto,int state);
//    
//    public int getPageCount(int pageSize,String sendto,int state);
}
