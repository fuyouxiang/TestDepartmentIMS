<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="gb2312"%>
<%@ page language="java" import="java.util.*"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String userName = (String)session.getAttribute("userName");
String userrole = (String)session.getAttribute("userrole");
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
	
	
<!-- �����ֻ��� -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
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
		 
		 document.getElementById("showDateTimeId").innerHTML=fullYear+"��"+(month+1)+"��"+day+"��"+"  "+hours+":"+minutes+":"+secondes;
}
   window.onload=function (){
       //ÿ��1s��ִ��numadd()����
        setInterval("getDateTime()",1000);
	   
	   //1s��֮��ִ��numadd()����������ִ��һ��
	   //setTimeout("getDateTime()",5000);    
   }


</script>
<script type="text/javascript">
  $(document).ready(function(){
	  $("#outId").click(function(){
		 if(confirm("��ȷ��Ҫ�˳���")){
			// alert("������ ");
			 //js��ҳ����ת!!!!
			 window.top.location.href = "<%=path %>/admin/login.jsp";
		 }
		});
	  
  });

	
</script>
  </head>
  	<%String name1=new String(request.getParameter("name1").getBytes("ISO-8859-1"),"GB2312");%>
<body>
   <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 style="background-color:#0066ff;">
  	<TR height=40>
    	<TD width=260 style="font-size:17px;text-align:left;color:#fff; PADDING-BOTTOM: 7px;">&nbsp;&nbsp;&nbsp;���������Ʋ�Ʒ���Բ�</TD>
    	<TD style="COLOR: #fff; PADDING-TOP: 10px;padding-bottom: 13px;" align="center">
            <A style="COLOR: #fff" href="guanliyuan/UpdatePassword.jsp" target="right" ><font size="2" >�����޸�</font></A> &nbsp;&nbsp;
            <span class="fr_1" id = "showDateTimeId" ></span>&nbsp;&nbsp;
      		<A style="COLOR: #fff" onclick="if (confirm('ȷ��Ҫ�˳���')) return true; else return false;" href="login.jsp" target=_top><font size="2">�˳�ϵͳ</font></A> 
   	 	</TD>
    	<td style="FONT-WEIGHT: bold; COLOR: #fff; PADDING-TOP: 0px"></td>
    	<TD align=right width=268 style=" COLOR: #fff; PADDING-TOP: 10px;padding-bottom: 13px;font-size: 14px;">��ɫ��<%=userrole %>&nbsp;&nbsp;</TD>   
    </TR>
   </TABLE>
   <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
   		<TR bgColor=#1c5db6 height=4>
    		<TD></TD>
    	</TR>
    </TABLE>
</body>
<!--
  <body>
   <TABLE cellSpacing=0 cellPadding=0 width="100%" 
		background="images/header_bg.jpg" border=0>

  <TR height=40>
    <TD width=260><IMG  height=56 src="images/header_left2.jpg" 
    width=260></TD>
    <TD style="FONT-WEIGHT: bold; COLOR: #fff; PADDING-TOP: 0px;padding-bottom: 15px;" 
      align="center">
            <A style="COLOR: #fff" href="guanliyuan/UpdatePassword.jsp" target="right" ><font size="2" >�����޸�</font></A> &nbsp;&nbsp;
            <span class="fr_1" id = "showDateTimeId" ></span>&nbsp;&nbsp;
      		<A style="COLOR: #fff" onclick="if (confirm('ȷ��Ҫ�˳���')) return true; else return false;" href="login.jsp" target=_top><font size="2">�˳�ϵͳ</font></A> 

    </TD>
    
    <td style="FONT-WEIGHT: bold; COLOR: #fff; PADDING-TOP: 0px"></td>
    <TD align=right width=268><IMG height=56 src="images/header_right.jpg" width=268></TD>   
      </TR></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TR bgColor=#1c5db6 height=4>
    <TD></TD></TR></TABLE>
  </body>
 -->
</html>
