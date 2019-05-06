<%@ page language="java" import="java.util.*,cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//List<Map<String, String>> stuMap = (List<Map<String, String>>)request.getAttribute("stuMap");
Sys_user user = (Sys_user)request.getAttribute("user");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <base target="_self"/>
    
    
    <title>密码修改</title>
    <style type="text/css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style>
　　
　　body{font－size:22px; line－height=16px;}
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
			    	var formObj=document.getElementById("formId");
			    	var u_name=document.getElementById("u_name").value;
			    	var u_state=document.getElementById("u_state").value;
			    	var u_password=document.getElementById("u_password").value;
			    	var u_password2=document.getElementById("u_password2").value;
			    	
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
  <body class="ContentBody">

	<form action="<%=path%>/updatePassword_Phone2" method="post" id =formId onsubmit="return submitMyForm()">
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >用户添加</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		<div class="msg">当前位置：首页 >> 用户管理 >> 用户添加</div>
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>填写用户信息</legend>
	
					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					  <tr>
					    <td nowrap align="right" width="13%">用户姓名:</td>
					    <td width="41%"><input readonly="readonly" name="u_name" id="u_name" class="text" style="width:250px" type="text" size="40" value = "<%=user.getU_name() %>" />
				        <span class="red"> *</span></td></tr>
					  <tr>
					    <td align="right">密码:</td>
					    <td><input name="u_password" id="u_password" type="password" class="text" style="width:250px" /><span class="red">（不超过32字节）</span></td>					    
					    </tr><tr>
					    <td align="right">确认密码:</td>
					    <td><input id="u_password2" class="text" type="password" style="width:250px" /><span class="red"></span></td>	
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
			<input type="reset" value="返回" onclick="window.history.go(-1);"/></TD>
		</TR>
		</TABLE>

    
</div>
</form>
</body>
</html>
