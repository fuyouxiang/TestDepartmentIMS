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
				
				//判断表单是否可以提交
			  	function  checkForm(){
			    	if( checkName()&&checkpassword()&& checkEmile()&&checkScar() ){
					return true;
					}
			    	return  false;
			  	}

			  //通过js提交表单
			  	function  submitMyForm(){
			    	var formObj=document.getElementById("formId");
			    	/*
			    	var u_name=document.getElementById("u_name").value;
			    	var u_state=document.getElementById("u_state").value;
			    	var u_password=document.getElementById("u_password").value;
			    	var u_password2=document.getElementById("u_password2").value;
			    	*/
			    	var u_name=document.formname.u_name.value;
			    	var u_state=document.formname.u_state.value;
			    	var u_password=document.formname.u_password.value;
			    	var u_password2=document.formname.u_password2.value;
			    	
			    	//校验
			    	if(u_name == ''){
			    		alert('请填写员工姓名!');      
		 				return false;
			    	}
			    	else if(u_state == '未知'){
			    		alert('请选择员工状态!');      
		 				return false;
			    	}
			    	else if(u_password == ''){
			    		alert('请填写密码！');      
		 				return false;
			    	}
			    	else if(u_password != u_password2){
			    		alert('两次输入的密码不一致！');      
		 				return false;
			    	}
					else if(checkForm()){
				  		return true;				  		
					}else{
						alert("无法提交 请核对信息");
						return false;
					}
			   
			  	}
	</script>
<style type="text/css">
<!--
.atten {font-size:12px;font-weight:normal;color:#F00;}
-->
</style>
  </head>
    <%String url=(String)request.getAttribute( "url");%>
  <body class="ContentBody">

	<form action="<%=path%>/" method="post" id =formId onsubmit="return submitMyForm()" name="formname">
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >数据库连接</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>填写数据库信息</legend>
	
					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					 
					  <tr>
					    <td nowrap align="right" width="13%">数据库IP:</td>
					    <td width="41%"><input name="u_name" id="u_name" class="text" style="width:250px" type="text" size="40" value="<%=url%>"/>
				        <span class="red"> *</span></td>
				        </tr>
				        					  <tr>
					    <td nowrap align="right" width="13%">数据库实例名:</td>
					    <td width="41%"><input name="u_name" id="u_name" class="text" style="width:250px" type="text" size="40" value="orcl"/>
				        <span class="red"> *</span></td>
				        </tr>
				        <tr>
					    <td nowrap align="right" width="13%">数据库名:</td>
					    <td width="41%"><input name="u_name" id="u_name" class="text" style="width:250px" type="text" size="40" />
				        <span class="red"> *</span></td>
				        </tr>
				        <tr>
					    <td nowrap align="right" width="13%">数据库密码:</td>
					    <td width="41%"><input name="u_name" id="u_name" class="text" style="width:250px" type="text" size="40" />
				        <span class="red"> *</span></td>
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
			<input type="submit"  value="保存" />　
			&nbsp;&nbsp;&nbsp;
			<input type="reset" value="重置" /></TD>
		</TR>
		</TABLE>

    
</div>
</form>
</body>
</html>
