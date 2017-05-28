<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css"/>
    <style type="text/css">
       #login{
	     margin-top:140px;
       }
       body {
		background-color: #F8F8FF;
	   }
    </style>
  </head>
  
  <body>
   <div class="container row" id="login">
     <h1 class="col-xs-4 col-md-offset-6">Login</h1>
     <br><br><br><br>
    <div class="input-group col-xs-4 col-md-offset-5">
	  <span class="input-group-addon"></span>
	  <input type="text" class="form-control input-lg" placeholder="Username" id="bname">
	</div>
	<br>
	<div class="input-group col-xs-4 col-md-offset-5">
	  <span class="input-group-addon"></span>
	  <input type="password" class="form-control input-lg" placeholder="Password" id="bpass">
	</div>
	<br>
	   <input class="btn btn-warning btn-xs col-xs-1 col-md-offset-8" type="button" value="register" onclick="register()"/>
	  <br>
	  <br>
	   <button class="btn btn-primary btn-lg col-xs-1 col-md-offset-5" type="button" value="Login" onclick="login()">Login</button>
	   <button class="btn btn-default btn-lg col-xs-1 col-md-offset-2" type="button" value="Reset" onclick="reset()">Reset</button>
   </div> 
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script type="text/javascript">
       function login(){
	   	   for(var i=0;i<2;i++){
				if ($("input:eq("+i+")").val().trim() == "") {
					layer.tips($("input:eq("+i+")").attr("placeholder")+"不能为空!", $("input:eq("+i+")"));
					return;
				}
			}	    
	   	    var bname=$("#bname").val();
	   	    var bpass=$("#bpass").val();
		   	var jsonStr={bname:bname,bpass:bpass,where:"userlogin"};
			 $.ajax({
				url:"BootstrapFront",
				type:"post",
				data:jsonStr,
				dataType:"json",
				success:function(result){
					if(result==true){			
						location.href = "index.jsp";
					}else{
						layer.msg("账号或密码有误！");
					}
				},
				error:function(){
					layer.msg("请求失败！");
				}
			 });	   
       }  
       function register(){
    	   layer.open({
	   			type : 2,
	   			title : '用户注册',
	   			shadeClose : true,
	   			shade : 0.5,
	   			area : [ '600px', '450px' ],
	   			content : "register.jsp"
   		  });
       }
       function reset(){
    	   $("#bname").val("");
    	   $("#bpass").val("");
       }
    </script>
  </body>
</html>
