<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userDetails.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
  </head>
  
  <body>
    <div class="container">
      <div class="row">
         <div class="col-md-4 col-md-offset-1">
	       <h1>个人资料</h1>
	     </div> 
      </div>
      <div class="row">
       <div class="col-md-5 col-md-offset-2">
        <h3><span class="label label-primary">Username</span>&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.user.bname}</h3>
       </div> 
      </div>
      <br>
      <div class="row">
       <div class="col-md-5 col-md-offset-2">
        <h3><span class="label label-primary">Useremail</span>&nbsp;&nbsp;&nbsp;&nbsp;${sessionScope.user.bemail}</h3>
       </div> 
      </div>
    </div>
  	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
  </body>
</html>
