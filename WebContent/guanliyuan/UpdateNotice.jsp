<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.utils.MD5Helper;" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//List<Map<String, String>> stuMap = (List<Map<String, String>>)request.getAttribute("stuMap");
Sys_user user = (Sys_user)request.getAttribute("user");
%>
<% String username = (String)session.getAttribute("username"); %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <base target="_self"/>
    
    
    <title>用户修改</title>
    <style type="text/css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.tabfont01 {	
	font-family: "宋体";
	font-size: 9px;
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
html { overflow-x: auto; overflow-y: auto; border:0;} 

</style>
<script type="text/javascript">
		 $(document).ready(function(){  
	     	
	     	//为input type="text" id="userNameId"， 绑定一个失去焦点事件
	     	$("#NameId").blur(function(){
	     		 
	     		var userName=$(this).val();
	     		//定义通过异步方式发送到servlet的参数
	     		//alert(userName);
	     		if(userName != ""){
	     			var urlPath='<%=path%>';
		     		 $.post(urlPath+"/CheckUserNameServlet",{userName:userName,math:Math.random() },function(data){
		     			 //接收回调函数接收服务端响应回的数据
		     			
		     			 alert(data);
		     		 });
	     		}
	     		
	     		
	     	});
	     	
	     	 
	     });
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

			  	}
	</script>
<style type="text/css">
<!--
.atten {font-size:12px;font-weight:normal;color:#F00;}
-->
</style>
  </head>
  <body>
    
<div class="MainDiv">
<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  <tr>
      <th class="tablestyle_title" >发布新通知</th>
  </tr>
  <tr>
    <td class="CPanel">
		<form action="<%=path%>/UpdateNoticeServlet" method="post" id =formId onsubmit="return submitMyForm()" name="formname">

		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">


 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>发布新通知</legend>
	
					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					 
					  <tr>

					    <td align="right">通知标题:</td>
					    <td><input  name="JI_TITLE" id="JI_TITLE" class="text" type="text" style="width:360px"/><span class="red">勿超过30字</span></td></tr>
					  	<tr >
					    <td align="right">通知第一行:</td>
					    <td><input  name="J1" id="J1" class="text" type="text" style="width:360px"/><span class="red">勿超过30字</span></td>
					    </tr>
					     <tr > 
					    <td align="right">通知第二行:</td>
					    <td><input  id="J2" name="J2" class="text" type="text" style="width:360px"/><span class="red">勿超过30字</span></td>
					    </tr>
					    <tr > 
					    <td align="right">通知第三行:</td>
					    <td><input  id="J3" name="J3" class="text" type="text" style="width:360px"/><span class="red">勿超过30字</span></td>
					    </tr>
					  </table>
			 <br />
				</fieldset>			</TD>
				
		</TR>
				<TR>
			<TD colspan="2" align="center" height="50px">
			<input type="submit" name="Submit" value="保存"/>　
			
			<input type="button" name="Submit2" value="返回" class="button" onclick="window.history.go(-1);"/></TD>
		</TR>
		</TABLE>
	
	</form>

</div>
  </body>
</html>
