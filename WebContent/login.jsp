<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>财政云测试部</title>
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
<link href="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">-->

<!-- //web font -->
</head>
<body>
<!-- 注掉了雪花效果
<div class="snow-container">

			  <div class="snow foreground"></div>
			  <div class="snow foreground layered"></div>
			  <div class="snow middleground"></div>
			  <div class="snow middleground layered"></div>
			  <div class="snow background"></div>
			  <div class="snow background layered"></div>
			</div>
 -->
<div class="top-buttons-agileinfo">
<a href="login.jsp"  class="active">登录</a><a href="signup.jsp">注册</a>
</div>
<h1>财政云产品测试部
</h1>
<div class="main-agileits">
<!--form-stars-here-->
		<div class="form-w3-agile">
			<h2 class="sub-agileits-w3layouts"></h2>
			<form action="<%=path %>/LoginServlet" method="post"  name="myForm">
					<input type="text" id="userName" name="userName" placeholder="用户名" required="required" autocomplete="off"/>
					<input type="password" id="password" name="password" placeholder="密码" required="required" autocomplete="off"/>
<% 
    Calendar calendar=Calendar.getInstance(); 
    int year=calendar.get(Calendar.YEAR); 
 %> 
 								<h2 class="sub-agileits-w3layouts"></h2>
                                <select style="high:400;font-weight:bold;width:80px;height: 30px;font-size:16px;background-color: transparent;color:white;" name="set_year"  id="set_year">                              
					     <option value="<%=year %>" style="color:blue;background-color: transparent;"> &nbsp;&nbsp;<%=year %> &nbsp;&nbsp;</option>
					     <!--<option value="<%=year-1 %>" style="color:blue;background-color: transparent;"> &nbsp;&nbsp;<%=year-1 %> &nbsp;&nbsp;</option>  -->
					     </select>
					     <h2 class="sub-agileits-w3layouts"></h2>
				<div class="submit-w3l">
					<input type="submit" value="登 录">
				</div>
				<p class="p-bottom-w3ls"><a href="signup.jsp">点击注册</a>如果你没有一个文档帐户。</p>
			</form>
		</div>
		</div>
<!--//form-ends-here-->
<!-- copyright -->
	<div class="copyright w3-agile">
		<p>网站备案号：京ICP备20002763号-1<a  href="tel:15210643559"  target="_blank">&nbsp;联系我们</a></p>
	</div>
	<div style="width:300px;margin:0 auto; padding:20px 0;">
		 <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010802030909" style="display:inline-block;text-decoration:none;height:20px;line-height:20px;"><img src="img/beian.png" style="float:left;"/><p style="float:left;height:20px;line-height:20px;margin: 0px 0px 0px 5px; color:#939393;">京公网安备 11010802030909号</p></a>
	</div>
	<!-- //copyright --> 
	<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>

</body>
</html>