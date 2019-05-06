<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'sysMessage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		
<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	var i = 6;
	function shownum(){ 
	i=i-1; 
	document.getElementById("time").innerHTML=i+"秒后自动跳转登陆界面";
	setTimeout('shownum()',3000); } 
	</script>
	

  </head>
  <meta http-equiv="refresh" content ="5;url=<%=basePath%>ceshi.jsp"> 
  <%String name1=(String)request.getAttribute( "name1");%>
  <body onload="shownum()">
      <h1>系统消息</h1>
      <%
      String info=(String)  request.getAttribute("info");
      %>
      
      <%=info!=null?info:"系统消息" %>
      <%=info!=null?info:"2秒后自动跳转" %>
 
      <!--创建按钮关闭小窗口 - -->
      <table>
      <tr></tr>
      <tr>
      <td>
      <input type = "button" value = "关闭" onclick="javascrtpt:window.location.href='main2.jsp?name1=<%=name1%>'"/>

      </td>
      </tr>
      </table>
  </body>
</html>
