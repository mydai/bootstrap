<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
      #sendto,#title,#sendbtn{
        width:150px;
      }
    </style>
  </head>
  
  <body>
     <div class="container">
        <br>
        <div class="row">
         <div class="col-xs-3">    
          <h4><span class="label label-default">sendto</span><input type="text" placeholder="sendto" id="sendto" value="${requestScope.sendfrom}"/></h4> 
         </div>
         <div class="col-xs-3">
           <h4><span class="label label-default">title</span><input type="text" placeholder="title" id="title"/></h4> 
         </div>
         <div class="col-xs-1 col-xs-offset-2">
          <h4><span class="label"> </span><input class="btn btn-default" type="button" value="Send" id="sendbtn" onclick="sendemail()"></h4>
         </div>
        </div> 

          <textarea rows="15" cols="78" id="textarea" placeholder="Please Enter The Message Content"></textarea>
     </div>
     <script type="text/javascript" src="js/jquery.js"></script>
	 <script type="text/javascript" src="js/bootstrap.min.js"></script>
     <script type="text/javascript" src="layer/layer.js"></script>
     <script type="text/javascript">
        function sendemail(){
        	for (var i = 0; i < 2; i++) {
				if ($("input:eq(" + i + ")").val().trim() == "") {
					layer.tips($("input:eq(" + i + ")").attr("placeholder")
							+ "不能为空!", $("input:eq(" + i + ")"));
					return;
				}
			}
        	var textarea=$("#textarea").val();
        	if(textarea.trim()==""){
        		layer.tips("textarea不能为空","#textarea");
        		return;
        	}
        	var sendto = $("#sendto").val();
			var jsonStr1 = {
				bname : sendto,
				where : "checkname",
			};
			$.ajax({
				url : "BootstrapFront",
				type : "post",
				async : false,
				data : jsonStr1,
				dataType : "json",
				success : function(result1) {
					if (result1 == false) {
						layer.tips("该用户不存在，无法发送邮件！", "#sendto");
						return;
					} else {
						otherAjax();
					}
				},
				error : function() {
					layer.msg("请求失败！");
				}
			});
		}
		function otherAjax(){
			var sendto = $("#sendto").val();
			var title = $("#title").val();
			var textarea = $("#textarea").val();
			var jsonStr2 = {
					sendto : sendto,
					title : title,
					msgcontent : textarea,
					where : "sendemail"
				};
			$.ajax({
				url : "BootstrapFront",
				type : "post",
				async : false,
				data : jsonStr2,
				dataType : "json",
				success : function(result2) {
					if (result2 == true) {
						layer.msg("发送成功！");
					} else {
						layer.msg("发送失败，请稍后重试！");
					}
				},
				error : function() {
					layer.msg("请求失败！");
				}
			});
		}
     </script>
  </body>
</html>
