<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'top.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
    <style type="text/css">
    #photo{ 
       padding-top:5px; 
       width:40px;
       hright:40px; 
    }
    </style>
  </head>
  
  <body>
    <nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp"  target="_top">BackToHomePage</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right nav-tabs" role="tablist">
				<li role="presentation"><a href="BootstrapFront?where=logoff"  target="_top">Log
						Off</a></li>
				<!-- 				BootstrapFront?where=logoff -->
			</ul>
			<ul class="nav navbar-nav navbar-right nav-tabs" role="tablist">
				<li role="presentation"><a href="userCenter.jsp">Personal
						center</a></li>
			</ul>	
			<ul class="nav navbar-nav navbar-right nav-tabs" role="tablist">
			   <li role="presentation"><a href=""><span class="glyphicon glyphicon-envelope"></span>
			   <span class="badge ">${sessionScope.list.size()}</span></a>
            </span></li>
			</ul>
			<ul class="nav navbar-nav navbar-right nav-tabs" role="tablist">
				<li role="presentation"><span class="navbar-brand">${sessionScope.user.bname}</span><img
					id="photo" class="img-circle" src="image/monkey.jpg" alt="用户头像" /></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
  </body>
</html>
