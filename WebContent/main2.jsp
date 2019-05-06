<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="gb2312"%>
<%@ page language="java" import="java.util.*"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String userName = (String)session.getAttribute("userName");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'main.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="styles.css">
	
	<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<script type="text/javascript">
	/**
	获取当前日期
	*/
 function getDateTime(){
		 var dateTime=new Date();
		 //年份
		 var  fullYear= dateTime.getFullYear();
		 //月份
		 var month=dateTime.getMonth();
		 //日期
		 var day= dateTime.getDate() ;
		var hours=dateTime.getHours();
		var minutes=dateTime.getMinutes();
		 var secondes=dateTime.getSeconds();
		 
		 document.getElementById("showDateTimeId").innerHTML=fullYear+"年"+(month+1)+"月"+day+"日";
}
   window.onload=function (){
       //每隔1s钟执行numadd()函数
        setInterval("getDateTime()",1000);
	   
	   //1s钟之后执行numadd()函数，仅能执行一次
	   //setTimeout("getDateTime()",5000);    
   }


</script>
  </head>
  <body>
  	<% String username = (String)session.getAttribute("username"); %>
  <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
  <TR height=28>
    <TD background=images/title_bg1.jpg>当前位置: </TD></TR>
  <TR>
    <TD bgColor=#b1ceef height=1></TD></TR>
  <TR height=20>
    <TD background=images/shadow_bg.jpg></TD></TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="90%" align=center border=0>
  <TR height=100>
    <TD align=middle width=100><IMG height=100 src="images/admin_p.gif" 
      width=90></TD>
    <TD width=60>&nbsp;</TD>
    <TD>
      <TABLE height=100 cellSpacing=0 cellPadding=0 width="100%" border=0>
        
        <TR>
          <TD>当前时间：<span><font size="2"></font><label class="fr_1"  id = "showDateTimeId"></label></span></TD></TR>
        <TR>
          <TD ><font size="5" face="隶书"><%=username%>&nbsp;&nbsp;您好！</TD></TR>
        <TR>
        
          <TD><font size="5" face="隶书">欢迎进入测试部工作情况管理系统！</TD></TR></TABLE></TD></TR>
  <TR>
  
    <TD colSpan=3 height=10></TD></TR></TABLE>
</body>
</html>
