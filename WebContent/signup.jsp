<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<html>
<head>
<title>数字财政产品中心测试部</title>
<link rel="icon" href="img/logo.ico"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Internship Sign In & Sign Up Form Responsive Widget,Login form widgets, Sign up Web forms , Login signup Responsive web form,Flat Pricing table,Flat Drop downs,Registration Forms,News letter Forms,Elements" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- Custom Theme files -->
<link href="css/font-awesome2.min.css" rel="stylesheet" type="text/css" media="all">
<link href="css/snow.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style4.css" rel="stylesheet" type="text/css" media="all" />
<!-- //Custom Theme files -->
<!-- web font -->
<!--<link href="//fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
-->
<!-- //web font -->
<script>
function validate() {
    var pwd1 = document.getElementById("u_password").value;
    var pwd2 = document.getElementById("u_password2").value;
 
    if(pwd1 == pwd2)
     {
        document.getElementById("tishi").innerHTML="<font color='#7FFF00'>两次密码一致</font>";
        document.getElementById("button").disabled = false;
     }
else {
        document.getElementById("tishi").innerHTML="<font color='#FF4500'>两次密码不一致</font>";
        document.getElementById("button").disabled = true;
     }
}
</script>
</head>
<body>
<div class="snow-container">
			  <div class="snow foreground"></div>
			  <div class="snow foreground layered"></div>
			  <div class="snow middleground"></div>
			  <div class="snow middleground layered"></div>
			  <div class="snow background"></div>
			  <div class="snow background layered"></div>
			</div>

<div class="top-buttons-agileinfo">
<a href="login.jsp">登录</a><a href="signup.jsp" class="active">注册</a>
</div>
<h1>数字财政产品中心测试部
</h1>
<div class="main-agileits">
<!--form-stars-here-->
		<div class="form-w3-agile">
			<h2 class="sub-agileits-w3layouts">文档用户注册</h2>
			<form action="<%=path%>/AddUserMyselfServlet" method="post">
					<input type="text" name="u_name" id="u_name" placeholder="用户名" required="required" />
					<input type="password" name="u_password" id="u_password"  placeholder="密码" required="required" />
					<input type="password" name="u_password2" id="u_password2"  placeholder="确认密码" required="required" onkeyup="validate()"><span id="tishi"></span>
				<div class="submit-w3l">
					<input id="button" type="submit" value="确认">
				</div>
			</form>
		</div>
		</div>
<!--//form-ends-here-->
<!-- copyright -->
	<div class="copyright w3-agile">
		<p> @ 2018年   V2.1.0版    测试部研发  <br /><a href="tel:15210643559" target="_blank">联系我们</a></p>
	</div>
	<!-- //copyright --> 
	<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>

</body>
</html>