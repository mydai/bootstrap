package com.bootstrap.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Cache;
import javax.sql.rowset.CachedRowSet;

import sun.security.jca.GetInstance;

import com.bootstrap.dao.FrontDao;
import com.bootstrap.entity.Email;
import com.bootstrap.entity.User;
import com.bootstrap.util.DBUtil;
import com.bootstrap.util.DateToDate;

public class FrontDaoImpl implements FrontDao{

	public User userLogin(String bname, String bpass) {
		String sql="select * from buser where bname = ? and bpass = ?";
		CachedRowSet rs = DBUtil.execQuery(sql,bname,bpass);
		User user=null;
		try {
			if(rs.next()){
				user=new User();
				user.setBid(rs.getInt("bid"));
				user.setBname(rs.getString("bname"));
				user.setBpass(rs.getString("bpass"));
				user.setBemail(rs.getString("bemail"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public boolean checkNameIsExist(String bname) {
		boolean flag=true;
		String sql="select count(*) as num from buser where bname = ?";
		CachedRowSet rs=DBUtil.execQuery(sql, bname);
		try {
			if(rs.next()){
				int count=rs.getInt("num");
				if(count<=0){
					flag=false;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean userRegister(String bname, String bpass, String bemail) {
		boolean flag=false;
		String sql="insert into buser (bname,bpass,bemail) values(?,?,?)";
		int count=DBUtil.execUpdate(sql, bname,bpass,bemail);
		if(count>0){
			flag=true;
		}
		return flag;
	}

	public List<Email> getEmailListByName(String bname) {
		String sql="select * from bmsg where sendto = ?";
		CachedRowSet rs = DBUtil.execQuery(sql, bname);
		Email email=null;
		List<Email> list = new ArrayList<Email>(); 
		try {
			while(rs.next()){
				email=new Email();
				email.setMsgid(rs.getInt("msgid"));
				email.setBid(rs.getInt("bid"));
				email.setTitle(rs.getString("title"));
				email.setMsgcontent(rs.getString("msgcontent"));
				email.setState(rs.getInt("state"));
				email.setSendto(rs.getString("sendto"));
				email.setSenddate(DateToDate.toUtilDate(rs.getDate("senddate")));
				list.add(email);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public String getNameById(int bid) {
		String sql="select bname from buser where bid=?";
		CachedRowSet rs = DBUtil.execQuery(sql, bid);
		String bname="";
		try {
			while(rs.next()){
				bname=rs.getString("bname");
			}
		} catch (Exception e) {
		}
		return bname;
	}

	public int getEmailCount(String sendto,int state) { 
		int count=0;
		String sql="";
		if(state<0){
			sql="select count(*) as snum from bmsg where sendto = '"+sendto+"'";
		}else{
			sql="select count(*) as snum from bmsg where sendto = '"+sendto+"' and state = "+state;
		}
		CachedRowSet rs=DBUtil.execQuery(sql);
		try {
			if(rs.next()){
				count=rs.getInt("snum");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public List<Email> showEmailList(int page, int size, String sendto, int state) {
		Email email=null;
		String sql="";
		if(state<0){
		   sql="select * from(select rownum as num,b.* from(select rownum as snum,s.* from bmsg s where sendto = '"+sendto+"') b where b.snum<="+page*size+") c where c.num> "+(page-1)*size;
	    }else{
		   sql="select * from(select rownum as num,b.* from(select rownum as snum,s.* from bmsg s where sendto = '"+sendto+"' and state = "+state+") b where b.snum<="+page*size+") c where c.num>"+(page-1)*size;
	    }
		List<Email> list=new ArrayList<Email>();
		CachedRowSet rs = DBUtil.execQuery(sql);
		try {
			while(rs.next()) {
				email=new Email();
				email.setMsgid(rs.getInt("msgid"));
				email.setBid(rs.getInt("bid"));
				email.setTitle(rs.getString("title"));
				email.setMsgcontent(rs.getString("msgcontent"));
				email.setState(rs.getInt("state"));
				email.setSendto(rs.getString("sendto"));
				email.setSenddate(DateToDate.toUtilDate(rs.getDate("senddate")));
				list.add(email); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean delEmail(int msgid) {
		String sql="delete from bmsg where msgid = ?";
		int count=0;
		count=DBUtil.execUpdate(sql, msgid);
		if(count>0){
			return true;
		}
		return false;
	}

	public boolean sendEmail(int bid,String sendto, String title, String msgcontent,Date senddate) {
		String sql="insert into bmsg (bid,sendto,title,msgcontent,senddate) values(?,?,?,?,?)";
		int count=0;
		count=DBUtil.execUpdate(sql,bid,sendto,title,msgcontent,DateToDate.toSqlDate(senddate));
		if(count>0){
			return true;
		}else{
			return false;
		}
	}

	public Email showEmail(int msgid) {
		String sql="select * from bmsg where msgid = ?";
		CachedRowSet rs = DBUtil.execQuery(sql, msgid);
		Email email =null;
		try {
			while(rs.next()){
				email = new Email();
				email.setMsgid(msgid);
				email.setMsgid(rs.getInt("msgid"));
				email.setBid(rs.getInt("bid"));
				email.setTitle(rs.getString("title"));
				email.setMsgcontent(rs.getString("msgcontent"));
				email.setState(rs.getInt("state"));
				email.setSendto(rs.getString("sendto"));
				email.setSenddate(DateToDate.toUtilDate(rs.getDate("senddate")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return email;
	}

//	public int getPageCount(String bname) {
//		String sql="select count(*) as num from bmsg where bname = ?";
//		CachedRowSet rs = DBUtil.execQuery(sql, bname);
//		int count=0;
//		try {
//			if(rs.next()){
//				count=rs.getInt("num");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return count;
//	}
//	
//	public List<Email> getEmailByPage(int pageIndex, int pageSize,String sendto,int state) {
//		StringBuilder sb = new StringBuilder();
//		sb.append("select * from(select rownum as num,b.* from(select rownum as snum,s.* from bmsg s");
//		if(state<0){
//			sb.append("where sendto = 'czx' ) b");
//		}else{
//			sb.append("where sendto = 'czx' and state = '0') b");	
//		}
//		sb.append("where b.snum<='5') c where c.num> 0");
//		sb.append("where b.snum<="+pageIndex*pageSize+") c where c.num> "+(pageIndex-1)*pageSize);
//		if(state<0){
//			sb.append("select * from(select rownum as num,b.* from(select rownum as snum,s.* from bmsg s where sendto = "+sendto+") b where b.snum<='5') c where c.num> '0'");
//		}else{
//			sb.append("select * from(select rownum as num,b.* from(select rownum as snum,s.* from bmsg s where sendto = 'czx' and state = "+state+") b where b.snum<='5') c where c.num> '0'");
//		}
//		CachedRowSet rs = DBUtil.execQuery(sb.toString());
//		Email email=null;
//		List<Email> list = new ArrayList<Email>(); 
//		try {
//			while(rs.next()){
//				email=new Email();
//				email.setMsgid(rs.getInt("msgid"));
//				email.setBid(rs.getInt("bid"));
//				email.setTitle(rs.getString("title"));
//				email.setMsgcontent(rs.getString("msgcontent"));
//				email.setState(rs.getInt("state"));
//				email.setSendto(rs.getString("sendto"));
//				email.setSenddate(DateToDate.toUtilDate(rs.getDate("senddate")));
//				list.add(email);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
//	
//	public int getPageCount(int pageSize,String sendto,int state) {
//		int count=0;
//		String sql="";
//		if(state<0){
//			sql="select count(*) as num from bmsg where sendto = ?";
//		}else{
//			sql="select count(*) as num from bmsg where sendto = ? and state = '"+state+"'";
//		}
//		CachedRowSet rs = DBUtil.execQuery(sql, sendto);
//		try {
//			if(rs.next()){
//				count=rs.getInt("num");
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		if (count % pageSize == 0) {
//			return count / pageSize;
//		}
//		return count / pageSize + 1;
//	}
}
