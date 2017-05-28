
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/MyPage.tld" prefix="cc"%>
<%@ taglib uri="/WEB-INF/MyTag.tld" prefix="czx"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'emailDetails.jsp' starting page</title>
    
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
       #email{
         margin-top:20px;
       }
    </style>
  </head>
  
  <body>
    <div>
      <input class="btn btn-default" type="button" value="WriteEmail" onclick="sendemail()">
    </div>
    <div class="container" id="email">
		<table class="table">
			<thead>
				<tr>
					<th>#</th>
					<th>SendFrom</th>
					<th>Title</th>
					<th>Time</th>
					<th></th>
					<th>operate</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${sessionScope.list}" var="e" varStatus="status">
					<tr>
					<input type="hidden" id="hidd" value="${e.bid}"/>
						<td>${status.count}</td>
						<td><czx:change myid="${e.bid }"/></td>
						
						<td>${e.title}</td>
						<td><fmt:formatDate value="${e.senddate}" type="both"/><td>
					<%-- 	<td>${e.senddate}</td> --%>
						<td>
						  <a href="javascript:onclick=showEmail('${e.msgid }')"
							class="tablelink">查看</a> <a
							href="javascript:onclick=to_del('${e.msgid }','<czx:change myid="${e.bid }"/>')"
							class="tablelink"> 删除</a><a
							href="javascript:onclick=backEmail('${e.bid }')"
							class="tablelink"> 回信</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
		<div style="padding-left: 600px;">
			<cc:page pageIndex="${requestScope.pageIndex}" url="BootstrapFront?where=showemaillist&" pageMax="${requestScope.pageCount}" />
		</div>
    </div>
    <script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	<script type="text/javascript">
        function to_del(msgid, bname) {
         layer.confirm("您确定要删除来自:【" + bname + "】的短信息吗？", function(index){
    	  layer.close(index);
    	  location.href= "BootstrapFront?msgid=" + msgid+"&where=delemail";
				});
		}
		function showEmail(msgid) {
			layer.open({
				type : 2,
				title : '邮件详情',
				shadeClose : true,
				shade : 0.5,
				area : [ '640px', '450px' ],
				content : "BootstrapFront?msgid=" + msgid+"&where=showemail" //iframe的url
			});
		}
		function backEmail(bid) {
			layer.open({
				type : 2,
				title : '回复邮件',
				shadeClose : true,
				shade : 0.5,
				area : [ '640px', '450px' ],
				content : "BootstrapFront?bid=" + bid+"&where=backemail" //iframe的url
			});
		}
		function sendemail(){
			layer.open({
				type : 2,
				title : '发送邮件',
				shadeClose : true,
				shade : 0.5,
				area : [ '720px', '450px' ],
				content : "emailDetails.jsp"
			});
		}
		
// 		function changeValue(){
// 			FrontBiz fb=new FrontBizImpl();
			
// 			$("#hidd").val();
// 			$("#val").val();
// 		}
	</script>
  </body>
</html>
