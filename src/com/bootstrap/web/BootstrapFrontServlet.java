package com.bootstrap.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.bootstrap.biz.FrontBiz;
import com.bootstrap.biz.impl.FrontBizImpl;
import com.bootstrap.entity.Email;
import com.bootstrap.entity.User;

public class BootstrapFrontServlet extends HttpServlet {
    FrontBiz fb = new FrontBizImpl();
	/**
	 * Constructor of the object.
	 */
	public BootstrapFrontServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String where=request.getParameter("where");
		if(where.equals("checkname")){
			checkNameIsExist(request,response,out);
		}else if(where.equals("userregister")){
			userRegister(request,response,out);
		}else if(where.equals("userlogin")){
			userLogin(request,response,out);
		}else if(where.equals("logoff")){
			userLogOff(request,response,out);
		}else if(where.equals("getemaillist")){
			getEmailListByName(request,response,out);
		}else if(where.equals("showemaillist")){
			showEmailList(request,response,out);
		}else if(where.equals("delemail")){
			delEmail(request,response,out);
		}else if(where.equals("showemail")){
			showEmail(request,response,out);
		}else if(where.equals("sendemail")){
			sendEmail(request,response,out);
		}else if(where.equals("backemail")){
			backEmail(request,response,out);
		}
//		else if(where.equals("getpagecount")){
//			getPageCount(request,response,out);
//		}else if(where.equals("getemaillist")){
//			getEmailList(request,response,out);
//		}
		
		out.flush();
		out.close();
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}  	

	public void userLogin(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
        
		 String bname=request.getParameter("bname");
		 String bpass=request.getParameter("bpass");
		 User user = fb.userLogin(bname, bpass); 
		 List<Email> list=fb.getEmailListByName(bname);
		 if(user!=null){
			 HttpSession hs=request.getSession();
			 hs.setAttribute("user", user);
			 hs.setAttribute("list", list);
			 out.print(true);
		 }else{
			 out.print(false);
		 }
    }  
	
	public void checkNameIsExist(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 String bname=request.getParameter("bname");
		 boolean flag = fb.checkNameIsExist(bname);
		 if(flag){
		    out.print(true);
	     }else{
	    	 out.print(false);
	     }
   }
	
	public void userRegister(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException { 
		 String bname=request.getParameter("bname");
		 String bpass=request.getParameter("bpass");
		 String bemail=request.getParameter("bemail");
		 boolean flag=fb.userRegister(bname, bpass, bemail);
		 if(flag){
			 out.print(true);
		 }else{
			 out.print(false);
		 }
    }  
	
	public void userLogOff(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 HttpSession session = request.getSession();
		 session.removeAttribute("user");
		 session.removeAttribute("list");
		 response.sendRedirect("login.jsp");
    }  
	
	public void getEmailListByName(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 HttpSession session = request.getSession();
		 User user=(User)session.getAttribute("user");
		 List<Email> list=fb.getEmailListByName(user.getBname());
		 session.setAttribute("list", list);
		 response.sendRedirect("emailDetails.jsp");
    } 
	
	public void showEmailList(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		int pageIndex=1;
		int pageSize=8;
		HttpSession session = request.getSession();
		User user=(User)session.getAttribute("user");
		String sendto =user.getBname();
		int state=-1;
		if(request.getParameter("state")!=null){
			state = Integer.parseInt(request.getParameter("state"));
		}
		int recordCount=fb.getEmailCount(sendto,state);
		int pageCount=(recordCount + pageSize - 1) / pageSize;
	    if(request.getParameter("page")!=null){
	    	pageIndex=Integer.parseInt(request.getParameter("page"));
	    }
		List<Email> list=fb.showEmailList(pageIndex, pageSize,sendto,state);
		request.setAttribute("pageIndex", pageIndex);
		request.setAttribute("pageCount", pageCount);
		session.setAttribute("list", list);
		request.getRequestDispatcher("emailList.jsp").forward(request, response);
    } 
    
	public void delEmail(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 int msgid=Integer.parseInt(request.getParameter("msgid"));
		 boolean flag=false;
		 flag=fb.delEmail(msgid);
		 if(flag){
			 response.sendRedirect("BootstrapFront?where=showemaillist");
		 }	 
    }
	
	public void showEmail(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 int msgid = Integer.parseInt(request.getParameter("msgid"));
		 Email email=fb.showEmail(msgid);
		 request.setAttribute("email", email);
		 request.getRequestDispatcher("emailContent.jsp").forward(request, response);
    }  
	
	public void backEmail(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 
		 int bid = Integer.parseInt(request.getParameter("bid"));
		 String sendfrom = fb.getNameById(bid);
		 request.setAttribute("sendfrom", sendfrom);
		 request.getRequestDispatcher("backEmail.jsp").forward(request, response);
   }  
	
	public void sendEmail(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
		 HttpSession session = request.getSession();
		 User user=(User)session.getAttribute("user");
		 int bid = user.getBid();
		 String sendto = request.getParameter("sendto");
		 String title = request.getParameter("title");
		 String msgcontent = request.getParameter("msgcontent");
		 Date senddate = new Date();
		 boolean flag=false;
		 flag=fb.sendEmail(bid, sendto, title, msgcontent, senddate);
		 if(flag){
			 out.print(true);
		 }else{
			 out.print(false);
		 }
    } 
	
//	public void getPageCount(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
//        int pageSize=Integer.parseInt(request.getParameter("pSize"));
//		int pCounts=fb.getPageCount(pageSize);	
//		Map<String, Integer> map=new HashMap<String, Integer>();
//		map.put("pcount", pCounts);
//		JSONObject jsonStr=JSONObject.fromObject(map); 
//		PrintWriter out = response.getWriter();
//		out.write(jsonStr.toString());
//    } 
	
//	public void getPageCount(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
//       
//		int pageSize=Integer.parseInt(request.getParameter("pSize"));
//		String sendto=request.getParameter("sendto");
//		int state=Integer.parseInt(request.getParameter("state"));
//		int pCounts=fb.getPageCount(pageSize, sendto, state);
//		Map<String, Integer> map=new HashMap<String, Integer>();
//		map.put("pcount", pCounts);
//		JSONObject jsonStr=JSONObject.fromObject(map); 
//		out.write(jsonStr.toString());
//    } 
//	
//	public void getEmailList(HttpServletRequest request, HttpServletResponse response,PrintWriter out)	throws ServletException, IOException {
//	       
//		int pageIndex=Integer.parseInt(request.getParameter("start"));
//		int pageSize=Integer.parseInt(request.getParameter("pageSize"));
//		String sendto=request.getParameter("sendto");
//		int state=Integer.parseInt(request.getParameter("state"));
//		List<Email> list=fb.getEmailByPage(pageIndex, pageSize, sendto, state);
//		JSONArray jsonArr=JSONArray.fromObject(list);
//		out.write(jsonArr.toString());
//    } 
	
}
