<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="css/style_jPaginate.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.paginate.js"></script>
    <script type="text/javascript" src="js/format.js"></script>
<style>
body {
	background: #a7c7dc url(bg.png) repeat-x top left;
	font-family: verdana;
	padding: 0px;
	margin: 0px;
	letter-spacing: 2px;
}

.header {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 100%;
	height: 80px;
}

.header h1 {
	color: #fff;
	font-size: 38px;
	margin: 0px 0px 0px 30px;
	font-weight: 100;
	line-height: 80px;
	padding: 0px;
}

.footer {
	width: 100%;
	margin: 10px 0px 5px 0px;
}

a img {
	border: none;
	outline: none;
}

.content {
	margin-top: 100px;
	padding: 0px;
	bottom: 0px;
}

.about {
	width: 100%;
	height: 400px;
	background: transparent url(about.png) repeat-x top left;
	border-top: 2px solid #ccc;
	border-bottom: 2px solid #000;
}

.about .text {
	width: 16%;
	margin: 5px 2% 10px 2%;
	height: 380px;
	float: left;
	color: #FCFEF3;
	font-size: 16px;
	text-align: justify;
	letter-spacing: 0px;
}

.about .text h1 {
	border-bottom: 1px dashed #ccc;
	color: #fff;
}

.demo {
	width: 580px;
	padding: 10px;
	margin: 10px auto;
	border: 1px solid #fff;
	background-color: #f7f7f7;
}

h1 {
	color: #404347;
	margin: 5px 30px 20px 0px;
	font-weight: 100;
}

.pagedemo {
	border: 1px solid #CCC;
	width: 310px;
	margin: 2px;
	padding: 50px 10px;
	text-align: center;
	background-color: white;
}

.mytab{
	font-family:'微软雅黑';
	font-size:14px;
	margin:10px auto;
	width:800px;
	border-left: 1px solid #666;
	border-top: 1px solid #666;
	border-collapse: collapse;
}
.mytab tr td,th{
	padding:10px;
	border-right: 1px solid #666;
	border-bottom: 1px solid #666;
}
</style>

<script type="text/javascript">
        //页容量
    	var pageSize=6;
        var sendto="czx";
        var state=0;
        //总页数
    	var pageCount;
    	$(function(){
    		//获取总页数
    		getPageCounts(pageSize);
    		
    	});
    	
    	function  getPageCounts(pageSize){
    		var jsonStr={
    				pSize:pageSize,
    				sendto:sendto,
    				state:state,
    				where:"getpagecount"
    				};
    		$.ajax({
    			url:"BootstrapFront",
    			type:"post",
    			data:jsonStr,
    			dataType:"json",
    			success:function (data){
    				pageCount=data.pcount;
    				/*调用进行分页的方法*/
    				setPages();
    			}
    		});
    	}
    	
    	/*分页的函数*/
    	function setPages(){
    		$("#demo2").paginate({
    			count : pageCount, //${6}此处要写清本次分页的总页数,不支持动态改变,不可写非int型数.个人建议在进入页面的时候就把页数传过来
    			start : 1, //开始页码,从1开始,一般设置成1
    			display : 6, //在分页条上显示的个数,分页数等于或超过本设置会显示设置的个数,不够的话会显示真实个数,不过就不会出现滚动效果了.
    			border : false, //是否显示外框
    			text_color : '#888', //文字颜色
    			background_color : '#EEE', //背景颜色
    			text_hover_color : 'black', //鼠标放上去时文字的颜色
    			background_hover_color : '#CFCFCF',//鼠标放上去时背景的颜色
    			rotate : true, //是否滚动
    			images : false, //
    			mouse : 'press', //可选值为'press'和'slide',具体差别请自己体验.
    			onChange : function(page) {//本插件唯一可触发的事件,在点击页数的时候触发,只传过来当前被选中的页数,我想这其实足够了.
    				getPageData(page, pageSize);
    			}
    		});
    		//调用ajax异步实现每页的数据
    		getPageData(1, pageSize);

    	}
    	function getPageData(pageIndex,pageSize){
    		var jsonStr={
    				start : pageIndex,
    				pageSize : pageSize,
    				sendto:sendto,
    				state:state,
    				where : "getemaillist"
    			};
    		$.ajax({
    			url : "BootstrapFront",
    			type : "post",
    			data : jsonStr,
    			dataType : "json",
    			timeout : 10000,
    			error : function() {
    				alert('请求超时，请稍候再试');
    			},
    			success : function(result) {
    				var s = new StringBuffer();
    			var str="";
    			 
    			
    				$.each(result, function(index, value) {
    				 
    			    str+=$.format( "<tr><td>{id}</td><td>{empName}</td> <td>{email}</td> <td>{loginId}</td> <td><a href='#' onclik=\"javascript:modify('{empid}')\">更新</a> </td> </tr>",
    			{id:index+1,empName:value.empName,email:value.email,loginId:value.loginId,empid:value.empId});
    			 
    					s.append("<tr>").append("<td>").append((index + 1)).append(
    							"</td>");
    					s.append("<td>").append(value.empName).append("</td>")
    							.append("<td>");
    					s.append(value.email).append("</td>").append("<td>");
    					s.append(value.loginId).append("</td>").append("<td>");
    					s.append("<a href='#' onclik=\"javascript:modify('")
    							.append(value.empId);
    					s.append("')\">更新</a>").append("</td>").append("</tr>");  
    				});
    				$("#mytbody").html(str);
    			}
    		});
    	}
    	
    	function StringBuffer() {
    		this.__string__ = new Array();
    	}
    	StringBuffer.prototype.append = function(str) {
    		this.__string__.push(str);
    		return this;
    	};
    	StringBuffer.prototype.toString = function() {
    		return this.__string__.join("");
    	};
    	
    </script>
  </head>
  
  <body>
     <table class="mytab" >
		<thead>
			<tr>
				<th>编号</th>
				<th>姓名</th>
				<th>邮箱</th>
				<th>登录名</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="mytbody">

		</tbody>
	</table>
	<div id="pagination0"></div>
	<div class="content">
		<div class="demo">
			<h1>Demo 2</h1>
			<div id="demo2"></div>
		</div>
	</div>
  </body>
</html>
