<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
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


<script type="text/javascript">
  
</script>


	<script type="text/javascript">
				
				//判断表单是否可以提交
			  	function  checkForm(){
			    	if( checkName()&&checkpassword()&& checkEmile()&&checkScar() ){
					return true;
					}
			    	return  false;
			  	}
			  
			  //通过js提交表单
			  	function  submitMyForm(){

				  return true;
			   
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
      String name=(String)request.getAttribute("name");
	      String info=(String)request.getAttribute("info"); 
	      String URL_ID=(String)request.getAttribute("URL_ID");
      %>
	<form action="<%=path%>/UpdateUrlServlet?URL_ID=<%=URL_ID %>&ATTACH_NAME=<%=name %>&caozuo=file" method="post" id ="form1"  name="form1"  onsubmit="return submitMyForm()">
		
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >文件信息确认</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		<div class="msg">当前位置：首页 >> Url管理 >> 相关附件上传>> 文件信息确认</div>
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>第二步：附件信息确认</legend>


					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
						<tr>
						<tr>
					    <td nowrap align="right" width="13%">提示：</td>
					    <td><b><%=info%></b></td>
						</tr> 
						<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						</tr>
						<tr>
					    <td nowrap align="right" width="13%">文件名称:</td>
					    <td><input readonly name="ATTACH_NAME2" id="ATTACH_NAME2" class="text" style="width:500px;height:30px" type="text" size="200" value="<%=name%>"/> 
				        </td>
						</tr>
						<tr>
						<td nowrap align="right" width="13%"></td>
					    <td><span class="red">注：自动增加时间戳保证文件唯一性。</span></td>
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
		<input type="submit"  value="下一步"/>　
          </td>
		</TR>
		</TABLE>

    
</div>
</form>
</form>
</body>
</html>
