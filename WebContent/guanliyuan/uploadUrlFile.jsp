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
    <link rel="stylesheet" rev="stylesheet" href="css/style.css" type="text/css" media="all" />
        <style type="text/css">     
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
		<!--
	兼容手机及iphone
	-->
	<meta name="viewport" content=" initial-scale=1.0,user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />

<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.tabfont01 {	
	font-family: "宋体";
	font-size: 19px;
	color: #555555;
	text-decoration: none;
	text-align: center;
}
.font051 {font-family: "宋体";
	font-size: 12px;
	color: #333333;
	text-decoration: none;
	line-height: 20px;
}
.font201 {font-family: "宋体";
	font-size: 12px;
	color: #FF0000;
	text-decoration: none;
}
.button {
	font-family: "宋体";
	font-size: 14px;
	height: 37px;
}
option{
color: red;
color: blue;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 
-->
</style>
<script type="text/javascript" src="js/jquery-1.11.3.js"></script>  
<script type= "text/javascript" src= "js/ajaxfileupload.js" ></script>  




	<script type="text/javascript">
				
				//判断表单是否可以提交
			  	function  checkForm(){
			    	if( checkName()&&checkpassword()&& checkEmile()&&checkScar() ){
					return true;
					}
			    	return  false;
			  	}

	</script>
<style type="text/css">
<!--
.atten {font-size:12px;font-weight:normal;color:#F00;}
-->
</style>
<script type="text/JavaScript" src="<%=path %>/My97DatePicker/WdatePicker.js">
</script>
  </head>
  
  <body class="ContentBody">
		 <%  
        //获得urlid
        String urlid=request.getParameter("URL_ID");  
        int URL_ID=Integer.parseInt(urlid);  
     %>  
	<form action="<%=path%>/UploadUrlFileServlet?URL_ID=<%=URL_ID %>" method="post" id =formId  name="formname"  enctype="multipart/form-data" >
		
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >附件上传</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		<div class="msg">当前位置：首页 >> Url管理 >> 相关附件上传</div>
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>第一步：选择附件上传</legend>

					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
				        <tr>
				        <td align="left">文件选择:<input name="file" id="file" class="text" style="width:400px;height:40px"  type="file" size="40"/></td>
						</tr>
				        <tr>
				        <td align="left"><span class="red">注：一个URL服务只能上传一个附件，再上传会替换之前的附件。</span></td>
						</tr>
					  </table>
			 <br />
				</fieldset>			</TD>
				
		</TR>
		
		</TABLE>
	
	
	 </td>
  </tr>
  

		
		
		
		
		<TR>
		<TD colspan="2" align="center" height="50px">
		<input type="submit"  value="上传"/>　
          </td>
		</TR>
		</TABLE>

    
</div>
</form>
</form>
</body>
</html>
