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
			    	var u_role=document.formname.u_role.value;
			    	var email=document.formname.email.value;
			    	
			    	//校验
			    	if(u_name == ''){
			    		alert('请填写员工姓名!');      
		 				return false;
			    	}
			    	else if(u_state == '未知'){
			    		alert('请选择员工状态!');      
		 				return false;
			    	}
			    	else if(u_role == '未知'){
			    		alert('请选择角色！');      
		 				return false;
			    	}
			    	else if(u_password == ''){
			    		alert('请填写密码！');      
		 				return false;
			    	}
			    	else if(email == ''){
			    		alert('请填写工作邮箱！');      
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

	<form action="<%=path%>/AddUserServlet" method="post" id =formId onsubmit="return submitMyForm()" name="formname">
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
					    <td width="41%"><input name="u_name" id="u_name" class="text" style="width:250px" type="text" size="40" />
				        <span class="red"> *</span></td>
				        <td align="right">用户状态:</td>
				        <td>
					    <select style="high:150;font-weight:bold;color:blue" name="u_state"  id="u_state">
					     <option style="font-size:15px;color:blue" value="未知"> &nbsp;&nbsp;&nbsp;&nbsp;</option>            
						 <option style="font-size:15px;color:blue" value="在职"> &nbsp;&nbsp;北京在职 &nbsp;&nbsp;</option>				     
					     <option style="font-size:15px;color:blue" value="外地"> &nbsp;&nbsp;外地在职 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;color:blue" value="实习"> &nbsp;&nbsp;实习生 &nbsp;&nbsp;</option>
					     </select><span class="red">（外地用户不显示在签到表中，文档用户随意选择）</span>
					    </td>
				        </tr>
				        <tr>
				        <td align="right">角色选择:</td>
				        <td>
					    <select style="high:150;font-weight:bold;color:blue" name="u_role"  id="u_role">                               
						<option style="font-size:15px;color:blue" value="未知"> &nbsp;&nbsp;&nbsp;&nbsp;</option>
						<option style="font-size:15px;color:blue" value="普通"> &nbsp;&nbsp;普通 &nbsp;&nbsp;</option>
						<option style="font-size:15px;color:blue" value="文档"> &nbsp;&nbsp;文档 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;color:blue" value="管理员"> &nbsp;&nbsp;管理员 &nbsp;&nbsp;</option>
					     </select>
					    </td>
				        </tr>

				        
				        <tr>
				        <td align="right">新人必读:</td>
				        <td>
					    <select style="high:150;font-weight:bold;color:blue" name="xinren"  id="xinren">                               
						<option style="font-size:15px;color:blue" value="0"> &nbsp;&nbsp;关闭&nbsp;&nbsp;</option>
						<option style="font-size:15px;color:blue" value="1"> &nbsp;&nbsp;开启&nbsp;&nbsp;</option>
					    </select>
						</td>
				        </tr>
				        <tr>
				        <td align="right">项目文档:</td>
				        <td>
					    <select style="high:150;font-weight:bold;color:blue" name="xiangmu"  id="xiangmu">                               
						<option style="font-size:15px;color:blue" value="0"> &nbsp;&nbsp;关闭&nbsp;&nbsp;</option>
						<option style="font-size:15px;color:blue" value="1"> &nbsp;&nbsp;开启&nbsp;&nbsp;</option>
					    </select>
						</td>
				        </tr>
				        
				        <tr>
				        <td align="right">测试用例:</td>
				        <td>
					    <select style="high:150;font-weight:bold;color:blue" name="yongli"  id="yongli">                               
						<option style="font-size:15px;color:blue" value="0"> &nbsp;&nbsp;关闭&nbsp;&nbsp;</option>
						<option style="font-size:15px;color:blue" value="1"> &nbsp;&nbsp;开启&nbsp;&nbsp;</option>
					    </select>
						</td>
				        </tr>
				        
				        <tr>
				        <td align="right">知识分享:</td>
				        <td>
					    <select style="high:150;font-weight:bold;color:blue" name="fenxiang"  id="fenxiang">                               
						<option style="font-size:15px;color:blue" value="0"> &nbsp;&nbsp;关闭&nbsp;&nbsp;</option>
						<option style="font-size:15px;color:blue" value="1"> &nbsp;&nbsp;开启&nbsp;&nbsp;</option>
					    </select>
						</td>
				        </tr>


					  <tr>
					    <td align="right">密码:</td>
					    <td><input name="u_password" id="u_password" type="password" class="text" style="width:154px" /><span class="red">（不超过32字节）</span></td>					    
					    <td align="right">确认密码:</td>
					    <td><input id="u_password2" name="u_password2" class="text" type="password" style="width:154px" /><span class="red"></span></td>	
					  </tr>
					  
					  <tr>
					    <td align="right">工作邮箱:</td>
					    <td><input name="email" id="email" type="text" class="text" style="width:154px" /><span class="red">（必填）</span></td>					    
					    <td align="right">电话:</td>
					    <td><input id="phone" name="phone" class="text" type="text" style="width:154px" /><span class="red"></span></td>	
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
