<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height:100%,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<SCRIPT language=javascript>
	function expand(el)
	{
		childObj = document.getElementById("child" + el);

		if (childObj.style.display == 'none')
		{
			childObj.style.display = 'block';
		}
		else
		{
			childObj.style.display = 'none';
		}
		return;
	}
</SCRIPT>
  </head>
  
  <body>
  <TABLE height="100%" cellSpacing=0 cellPadding=0 width=170 
background=images/menu_bg.jpg border=0>
  <TR>
    <TD vAlign=top align=center>
            
      <TABLE id=child14 style="DISPLAY: none" cellSpacing=0 cellPadding=0 
      width=150 border=0></TABLE>
 
        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>      
        <TR>
          <TD height=10></TD></TR></TABLE>
       <TABLE cellSpacing=0 cellPadding=0 width=150 border=0>       
        <TR height=22>
          <TD style="PADDING-LEFT: 30px" background=images/menu_bt.jpg><A 
            href="<%=path %>/selectAllUrlServlet" target="right">首页工作台</A></TD></TR>
        <TR height=4>
          <TD></TD></TR></TABLE>

     <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>      
        <TR>
          <TD height=10></TD></TR></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=150 border=0>       
        <TR height=22>
          <TD style="PADDING-LEFT: 30px" background=images/menu_bt.jpg><A 
            class=menuParent onclick=expand(10) 
            href="javascript:void(0);">测试申请汇总</A></TD></TR>
        <TR height=4>
          <TD></TD></TR></TABLE>
      <TABLE id=child10 style="DISPLAY: none" cellSpacing=0 cellPadding=0 
      width=150 border=0>
        <TR height=20>
          <TD align=center width=30><IMG height=9 
            src="images/menu_icon.gif" width=9></TD>
          <TD>
         	 <A href="<%=path %>/TestApplicationServlet"   target="_blank">提交测试申请</A>
         </TD>
        </TR>
        <TR height=20>
          <TD align=center width=30><IMG height=9 
            src="images/menu_icon.gif" width=9></TD>
          <TD><A 
            href="<%=path %>/selectBanBenServlet?type=1" 
            target="right">版本测试汇总</A></TD></TR>
        <TR height=20>
          <TD align=center width=30><IMG height=9 
            src="images/menu_icon.gif" width=9></TD>
          <TD><A 
            href="<%=path %>/AddDanYuanTestServlet?type=2" 
            target="right">单元测试汇总</A></TD></TR>  
        <TR height=4>
          <TD colSpan=2></TD></TR></TABLE>  

          
     </TD>
    <TD width=1 bgColor=#d1e6f7></TD></TR></TABLE>
    
  </body>
</html>
