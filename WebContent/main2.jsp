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
	
	<!-- �����ֻ��� -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<script type="text/javascript">
	/**
	��ȡ��ǰ����
	*/
 function getDateTime(){
		 var dateTime=new Date();
		 //���
		 var  fullYear= dateTime.getFullYear();
		 //�·�
		 var month=dateTime.getMonth();
		 //����
		 var day= dateTime.getDate() ;
		var hours=dateTime.getHours();
		var minutes=dateTime.getMinutes();
		 var secondes=dateTime.getSeconds();
		 
		 document.getElementById("showDateTimeId").innerHTML=fullYear+"��"+(month+1)+"��"+day+"��";
}
   window.onload=function (){
       //ÿ��1s��ִ��numadd()����
        setInterval("getDateTime()",1000);
	   
	   //1s��֮��ִ��numadd()����������ִ��һ��
	   //setTimeout("getDateTime()",5000);    
   }


</script>
  </head>
  <body>
  	<% String username = (String)session.getAttribute("username"); %>
  <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
  <TR height=28>
    <TD background=images/title_bg1.jpg>��ǰλ��: </TD></TR>
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
          <TD>��ǰʱ�䣺<span><font size="2"></font><label class="fr_1"  id = "showDateTimeId"></label></span></TD></TR>
        <TR>
          <TD ><font size="5" face="����"><%=username%>&nbsp;&nbsp;���ã�</TD></TR>
        <TR>
        
          <TD><font size="5" face="����">��ӭ������Բ������������ϵͳ��</TD></TR></TABLE></TD></TR>
  <TR>
  
    <TD colSpan=3 height=10></TD></TR></TABLE>
</body>
</html>
