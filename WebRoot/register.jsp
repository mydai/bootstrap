<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'register.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<style type="text/css">
body {
	background-color: #F8F8FF;
}
</style>
</head>

<body>

	<div class="container-fluid" id="reg">
		<div class="row">
			<h1 class="col-xs-3 col-sm-3 col-xs-offset-4">Register</h1>
		</div>
		<div class="row">
			<div class="form-group has-feedback col-xs-8 col-xs-offset-2">
				<label class="control-label" for="bname"> </label> <input
					type="text" class="form-control input-lg" placeholder="Username"
					id="bname">
			</div>
		</div>
		<div class="row">
			<div class="form-group has-feedback col-xs-8 col-xs-offset-2">
				<label class="control-label" for="bpass"> </label> <input
					type="password" class="form-control input-lg" placeholder="Password"
					id="bpass">
			</div>
		</div>
		<div class="row">
			<div class="form-group has-feedback col-xs-8 col-xs-offset-2">
				<label class="control-label" for="brepass"> </label> <input
					type="password" class="form-control input-lg" placeholder="Repassword"
					id="brepass">
			</div>
		</div>
		<div class="row">
			<div class="form-group col-xs-8 col-xs-offset-2">
				<label class="control-label" for="bemail"> </label> <input
					type="text" class="form-control input-lg" placeholder="Email"
					id="bemail">
			</div>
		</div>
		<div class="row">
			<button class="btn btn-primary btn-lg col-xs-3 col-xs-offset-2"
				type="button" value="Register" onclick="register()" id="register">Register</button>
			<button class="btn btn-default btn-lg col-xs-3 col-xs-offset-2"
				type="button" value="Reset" onclick="reset()" id="reset">Reset</button>
		</div>

	</div>
	<script type="text/javascript" src="js/jquery.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="layer/layer.js"></script>
	<script type="text/javascript">
		var flag = true;
		function register() {
			for (var i = 0; i < 4; i++) {
				if ($("input:eq(" + i + ")").val().trim() == "") {
					layer.tips($("input:eq(" + i + ")").attr("placeholder")
							+ "不能为空!", $("input:eq(" + i + ")"));
					return;
				}
			}
			for (var i = 0; i < 4; i++) {
				if (i == 0) {
					var reg = /^[a-zA-Z][a-zA-Z0-9_]{5,}$/;
					var v = $("input:eq(" + i + ")").val();
					if (!reg.test(v)) {
						layer.tips("用户名格式不正确，至少6位！", "#bname");
						return;
					}
				} else if (i == 1) {
					var reg = /^\w{6,}$/;
					var v = $("input:eq(" + i + ")").val();
					if (!reg.test(v)) {
						layer.tips("密码格式不正确，至少6位！", "#bpass");
						return;
					}
				} else if (i == 2) {
					var v1 = $("input:eq(" + (i - 1) + ")").val();
					var v2 = $("input:eq(" + i + ")").val();
					if (v1 != v2) {
						layer.tips("两次密码输入不一致！", "#brepass");
						return;
					}
				} else if (i == 3) {
					var reg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
					var v = $("input:eq(" + i + ")").val();
					if (!reg.test(v)) {
						layer.tips("邮箱格式错误！", "#bemail");
						return;
					}
				}
			}
			var bname = $("#bname").val();
			var jsonStr1 = {
				bname : bname,
				where : "checkname",
			};
			$.ajax({
				url : "BootstrapFront",
				type : "post",
				async : false,
				data : jsonStr1,
				dataType : "json",
				success : function(result1) {
					if (result1 == true) {
						flag = false;
						layer.tips("账号名已存在！", "#bname");
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
			var bname = $("#bname").val();
			var bpass = $("#bpass").val();
			var bemail = $("#bemail").val();
			var jsonStr2 = {
					bname : bname,
					bpass : bpass,
					bemail : bemail,
					where : "userregister"
				};
			$.ajax({
				url : "BootstrapFront",
				type : "post",
				async : false,
				data : jsonStr2,
				dataType : "json",
				success : function(result2) {
					if (result2 == true) {
						layer.msg("注册成功！");
					} else {
						layer.msg("注册失败，请稍后重试！");
					}
				},
				error : function() {
					layer.msg("请求失败！");
				}
			});
		}
		function reset() {
			$("input").val("");
		}
	</script>
</body>
</html>
