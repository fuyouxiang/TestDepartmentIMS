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
    
    <title>My JSP 'header.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<LINK href="css/admin.css" type="text/css" rel="stylesheet">
	
	
<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
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
		 
		 document.getElementById("showDateTimeId").innerHTML=fullYear+"年"+(month+1)+"月"+day+"日"+"  "+hours+":"+minutes+":"+secondes;
}
   window.onload=function (){
       //每隔1s钟执行numadd()函数
        setInterval("getDateTime()",1000);
	   
	   //1s钟之后执行numadd()函数，仅能执行一次
	   //setTimeout("getDateTime()",5000);    
   }


</script>
<script type="text/javascript">
  $(document).ready(function(){
	  $("#outId").click(function(){
		 if(confirm("您确定要退出吗")){
			// alert("建莱卡 ");
			 //js中页面跳转!!!!
			 window.top.location.href = "<%=path %>/admin/login.jsp";
		 }
		});
	  
  });

	
</script>
  </head>
  	<%String name1=new String(request.getParameter("name1").getBytes("ISO-8859-1"),"GB2312");%>
  <body>
   <TABLE cellSpacing=0 cellPadding=0 width="100%" 
		background="images/header_bg.jpg" border=0>

  <TR height=56>
    <TD width=260><IMG height=56 src="images/header_left.jpg" 
    width=260></TD>
    <TD style="FONT-WEIGHT: bold; COLOR: #fff; PADDING-TOP: 20px" 
      align="center">
            <A style="COLOR: #fff" href="calendar.html" target="right"><font size="4" face="隶书"><%="当前用户:"+name1%></font></A> &nbsp;&nbsp;&nbsp;&nbsp;
            <!--  <label class="fr_1"  id = "showDateTimeId"></label>时间 -->
            <A style="COLOR: #fff" href="guanliyuan/UpdatePassword.jsp" target="right" ><font size="4" face="隶书">密码修改</font></A> &nbsp;&nbsp;
      		<A style="COLOR: #fff" onclick="if (confirm('确定要退出吗？')) return true; else return false;" href="login.jsp" target=_top><font size="4" face="隶书">退出系统</font></A> &nbsp;&nbsp;
      		<A style="COLOR: #fff" href="calendar.html" target="right"><font size="4" face="隶书">日历查询</font></A> 
    </TD>
    
    <td style="FONT-WEIGHT: bold; COLOR: #fff; PADDING-TOP: 25px"><label class="fr_1"  id = "showDateTimeId"></label></td>
    <TD align=right width=268><IMG height=56 
      src="images/header_right.jpg" width=268></TD>   
      </TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TR bgColor=#1c5db6 height=4>
    <TD></TD></TR></TABLE>
  </body>
</html>
