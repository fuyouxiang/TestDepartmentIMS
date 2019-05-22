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
    
    <title>测试部绩效管理系统V1.0</title>
    
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

<FRAMESET border=0 frameSpacing=0 rows="40,*" >
<FRAME name=header src="header.jsp?name1=<%=name1%>" height=""frameBorder=0 noResize scrolling=no>
<FRAMESET cols="170, *">
<FRAME src="menu.jsp" name="left" scrolling=no frameBorder=0 marginwidth=1px marginheight=1px>
<FRAME src="<%=path %>/selectAllUrlServlet" name=right frameBorder=0 noResize scrolling=no marginwidth=1px marginheight=1px>
</FRAMESET>
</FRAMESET>
</html>
