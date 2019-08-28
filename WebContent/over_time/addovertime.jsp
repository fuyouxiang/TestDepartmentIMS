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
	<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height:100%,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
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
			    	//var o_name=document.getElementById("o_name").value;
			    	//var o_date=document.getElementById("o_date").value;
			    	//var o_time=document.getElementById("o_time").value;
			    	
			    	var o_name=document.formname.o_name.value;
			    	var o_month=document.formname.o_month.value;
			    	var o_date=document.formname.o_date.value;
			    	var o_time=document.formname.o_time.value;
			    	var o_hold1=document.formname.o_hold1.value;
			    	var floatCheck=/^[+-]?[1-9]?[0-9]*\.[0-9]*$/;;
			    	
			    	
			    	//校验
			    	if(o_name == ''){
			    		alert('请填写员工姓名!');      
		 				return false;
			    	}
			    	else if(o_month == ''){
			    		alert('请选择加班月份!');      
		 				return false;
			    	}
			    	else if(o_date == ''){
			    		alert('请选择加班日期!');      
		 				return false;
			    	}
			    	else if(o_time == ''){
			    		alert('请填写加班时间!');      
		 				return false;
			    	}
			    	else if(isNaN(o_time)){
			    		alert('您输入的加班时间不是数字,请重新输入！');      
		 				return false;
			    	}
			    	else if(o_hold1 == ''){
			    		alert('请填写加班事由!');      
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
<script type="text/JavaScript" src="<%=path %>/My97DatePicker/WdatePicker.js">
</script>
  </head>
  
  <body class="ContentBody">

	<form action="<%=path%>/AddOvertimeServlet" name="formname" method="post" id =formId onsubmit="return submitMyForm()">
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >加班情况添加</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		<div class="msg">当前位置：首页 >> 加班情况汇总 >> 加班情况添加</div>
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>填写加班情况</legend>
	
					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					 
					  <tr>
					    <td nowrap align="right" width="13%">员工姓名:</td>
					    <td width="41%"><input name="o_name" id="o_name" class="text" style="width:154px" type="text" size="40" />
				        <span class="red"> *</span></td>
				        </tr>
				        <tr>
				        <td align="right">加班月份:</td>
				        <td>
					    <select style="high:150;font-weight:bold;" name="o_month"  id="o_month">
					     <option style="font-size:13px;" value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
					     <option style="font-size:13px;" value="01"> &nbsp;&nbsp;一月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="02"> &nbsp;&nbsp;二月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="03"> &nbsp;&nbsp;三月&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="04"> &nbsp;&nbsp;四月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="05"> &nbsp;&nbsp;五月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="06"> &nbsp;&nbsp;六月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="07"> &nbsp;&nbsp;七月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="08"> &nbsp;&nbsp;八月&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="09"> &nbsp;&nbsp;九月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="10"> &nbsp;&nbsp;十月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="11"> &nbsp;&nbsp;十一月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="12"> &nbsp;&nbsp;十二月 &nbsp;&nbsp;</option>
					     </select>
					    </td>
						</tr>
				        <tr>
				        <td align="right">加班日期:</td>
				        <td><input name="o_date" id="o_date" type="text" size="12" class="Wdate" onFocus="WdatePicker({lang:'zh-cn'})"/></td>
						</tr>
						
				       <tr>
				       <td align="right">加班时间:</td>
				       <td><input name="o_time" id="o_time" type="text" class="text" style="width:154px" /><span class="red">人/天</span></td>
				       </tr>
				       <tr>
				       <td align="right">加班事由:</td>
				       <td><textarea name="o_hold1" id="o_hold1" class="text" style="width:154px;height:80px" /></textarea><span class="red">(100字以内)</span></td>
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
