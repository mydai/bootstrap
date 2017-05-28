<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/MyTag.tld" prefix="czx"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'emailContent.jsp' starting page</title>
    
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
      .czx{
        margin-left:15px;
      }
    </style>
  </head>
  
  <body>
    <div class="container">
      <div class="row">
       <div class="col-xs-9">
        <h4><span class="label label-default">sendFrom</span><label class="czx"><czx:change myid="${requestScope.email.bid}"/></label></h4>
       </div> 
      </div>
      <div class="row">
       <div class="col-xs-9">
        <h4><span class="label label-default">Time</span><label class="czx"><fmt:formatDate value="${requestScope.email.senddate}" type="both"/></label></h4>
       </div>  
      </div>
        <textarea rows="14" cols="80" disabled>${requestScope.email.msgcontent}</textarea>
    </div>
    <script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
  </body>
</html>
