package com.bootstrap.util;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.bootstrap.biz.FrontBiz;
import com.bootstrap.biz.impl.FrontBizImpl;

public class MyTag extends TagSupport{
	private int myid;

	public int getMyid() {
		return myid;
	}

	public void setMyid(int myid) {
		this.myid = myid;
	}
	
	public int doStartTag() throws JspException {
		FrontBiz fb = new FrontBizImpl();
		String bname=fb.getNameById(getMyid());
		JspWriter out = this.pageContext.getOut();
		try {
			out.print(bname);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
	
	public int doEndTag() throws JspException {

        return EVAL_PAGE;

    }
	
	 public void release() {

	        super.release();

	    }
}
