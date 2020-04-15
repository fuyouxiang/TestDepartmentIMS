<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Map<String,String>> RInfoList= (List<Map<String , String>>) request.getAttribute("RList");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>测试部工作管理系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<LINK href="css/admin.css" type="text/css" rel="stylesheet">
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
  </head>
<%String name1=(String)request.getAttribute( "name1");%>

<FRAMESET border=0 frameSpacing=0 rows="44,*" >
	<FRAME name=header src="header.jsp?name1=<%=name1%>" frameBorder=0 noResize scrolling=no>
	<FRAMESET cols="172, *" id="pgFrame" name="pgFrame">
		<FRAME src="frame.jsp" name="left" scrolling=no frameBorder=0 marginwidth=1px marginheight=1px>
		<FRAME src="<%=path %>/selectAllUrlServlet" name=right frameBorder=0 noResize scrolling=no marginwidth=1px marginheight=1px>
</FRAMESET>
</FRAMESET>
</html>
