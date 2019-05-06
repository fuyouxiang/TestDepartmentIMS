<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>友知识文档管理系统</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,  user-scalable=no">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1,  user-scalable=no">
		<meta http-equiv="pragma" content="no-cache">
	 	<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	
<link rel="stylesheet" href="css/base.css">
<link rel="stylesheet" href="css/style3.css" media="screen" type="text/css" />
<script type="text/javascript" src="js/jquery-3.2.1.min.js" ></script>
</head>
<body style="background: url(images/bg_youzhishi.jpg) no-repeat;background-size:  cover;">
<!--音乐代码部分begin-->
<div id="lanren"><a href="guanliyuan/UpdatePassword.jsp">
	<div id="audio-btn" class="on" onClick="lanren.changeClass(this,'media')"></div></a>
</div>
<!--音乐代码部分END-->

<div class="radmenu">
	<a href="article.html" class="spe1 show" ><img src="images/1.png" /></a>
	<ul>
		<li><a href="<%=path %>/selectNewShareFileLevelServlet"><img src="images/2.png" /></a></li>
		<li><a href="<%=path %>/selectTestCaseLevelServlet"><img src="images/3.png" /></a></li>
		<li><a href="<%=path %>/selectNewPersonFileLevelServlet" ><img src="images/4.png" /></a></li>
		<li><a href="<%=path %>/selectItemFileLevelServlet"><img src="images/5.png" /></a></li>
		<li><a href="Error.jsp"><img src="images/6.png" /></a></li>
	</ul>
</div>

<script type="text/javascript" src="js/index_youzhishi.js"></script>
</body>
</html>