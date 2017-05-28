package com.bootstrap.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bootstrap.entity.User;

public class LoginFilter implements Filter {

	public void destroy() {

	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		    HttpServletRequest request=(HttpServletRequest)req;
		    HttpServletResponse response=(HttpServletResponse)res;
		    HttpSession session = request.getSession();
		    User user =(User)session.getAttribute("user");
		    if(user==null){
		    	res.getWriter().print("<script>alert('请登录!');location.href='login.jsp'</script>");
		        return;
		    }
		    chain.doFilter(request, response);
	}
	
	public void init(FilterConfig arg0) throws ServletException {

	}

}
