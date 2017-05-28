package com.bootstrap.biz;

import java.util.Date;
import java.util.List;

import com.bootstrap.entity.Email;
import com.bootstrap.entity.User;

public interface FrontBiz {
	public User userLogin(String bname,String bpass);
	
    public boolean checkNameIsExist(String bname);
    
    public boolean userRegister(String bname,String bpass,String bemail);
    
    public String getNameById(int bid);
    
    public List<Email> getEmailListByName(String bname);
    
    public abstract int  getEmailCount(String sendto,int state);
    
	public abstract List<Email> showEmailList(int page, int size,String sendto,int state);
    
	public boolean delEmail(int msgid);
	
	public boolean sendEmail(int bid,String sendto, String title, String msgcontent,Date senddate);
	
	public Email showEmail(int msgid);
	
//  public int getPageCount(String bname);
    
//  public list<email> getemailbypage(int pageindex, int pagesize,string sendto,int state);
//  
//  public int getpagecount(int pagesize,string sendto,int state);

    
    
}
