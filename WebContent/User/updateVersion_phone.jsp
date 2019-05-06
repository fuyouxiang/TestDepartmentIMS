<%@ page language="java" import="java.util.*,cn.com.shxt.model.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Sys_Version version = (Sys_Version)request.getAttribute("version");
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
			    	var V_MONTH=document.getElementById("V_MONTH").value;
			    	var V_DATE=document.getElementById("V_DATE").value;
			    	var V_WEEK=document.getElementById("V_WEEK").value;
			    	var V_NAME=document.getElementById("V_NAME").value;
			    	var V_BASICS=document.getElementById("V_BASICS").value;
			    	var V_WORK=document.getElementById("V_WORK").value;
			    	var V_TIME=document.getElementById("V_TIME").value;
			    	var V_TYPE=document.getElementById("V_TYPE").value;
			    	var V_BUG=document.getElementById("V_BUG").value;
			    	var V_DOCUMENT=document.getElementById("V_DOCUMENT").value;
			    	var V_CASE=document.getElementById("V_CASE").value;
			    	*/
			    	var V_MONTH=document.formname.V_MONTH.value;
			    	var V_DATE=document.formname.V_DATE.value;
			    	var V_WEEK=document.formname.V_WEEK.value;
			    	var V_NAME=document.formname.V_NAME.value;
			    	var V_BASICS=document.formname.V_BASICS.value;
			    	var V_WORK=document.formname.V_WORK.value;
			    	var V_TIME=document.formname.V_TIME.value;
			    	var V_TYPE=document.formname.V_TYPE.value;
			    	var V_BUG=document.formname.V_BUG.value;
			    	var V_DOCUMENT=document.formname.V_DOCUMENT.value;
			    	var V_CASE=document.formname.V_CASE.value;


			    	//判断除了只能是数字 或带一个小数点，正则表达式
			    	var stop=new RegExp("^\\d+(\\.\\d+)?$");
			    	
			    	
			    	//为了判断日期与月份是否相符，创建数组，截取
			    	var str =[];
			    	str=V_DATE.split("-");
					var V_MONTH_DATE = str[1];


			    	
			    	//校验
			    	if(V_MONTH == ''){
			    		alert('请选择月份!');      
		 				return false;
			    	}
			    	else if(V_DATE == ''){
			    		alert('请选择日期!');      
		 				return false;
			    	}
			    	else if(V_MONTH_DATE != V_MONTH){
			    		alert("月份与日期不符！");      
		 				return false;
			    	}
			    	else if(V_WEEK == ''){
			    		alert('请选择星期!');      
		 				return false;
			    	}
			    	else if(V_NAME == ''){
			    		alert('请输入姓名!');      
		 				return false;
			    	}
			    	else if(V_BASICS == ''){
			    		alert('请输入基本工作!');      
		 				return false;
			    	}
			    	else if(V_WORK == ''){
			    		alert('请输入工作内容!');      
		 				return false;
			    	}
			    	else if(V_TIME == ''){
			    		alert('请输入工时!');      
		 				return false;
			    	}
			    	else if(V_TYPE == ''){
			    		alert('请选择工作类型!');      
		 				return false;
			    	}
			    	else if(!stop.test(V_TIME)||!stop.test(V_BUG)||!stop.test(V_DOCUMENT)||!stop.test(V_CASE)){
			    		alert('工时、产出必须为数字类型!');      
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
</script><!-- 日期控件 -->
  </head>
  
  <body class="ContentBody">

	<form action="<%=path%>/UpdateOneVersionServlet_Phone" method="post" id =formId onsubmit="return submitMyForm()" name="formname">
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >工作情况修改</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<div class="msg">当前位置：首页 >> 工作情况汇总 >> 工作情况修改</div>
		
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>填写工作情况信息</legend>
	
					  <table border="0" cellpadding="2" cellspacing="7" style="width:70%;">
					  					  
  					 <!-- 第一行 -->
					  <tr>
					  	<td nowrap align="center" style="font-size:18px;"><strong>月份:</strong></td>
				        <td align="left">
					    <select style="height:23px;font-weight:bold;" name="V_MONTH"  id="V_MONTH">
					     <option style="font-size:15px;" value="<%=version.getV_month() %>"> &nbsp;&nbsp;<%=version.getV_month() %>&nbsp;&nbsp;</option>                                
					     <option style="font-size:15px;" value="01"> &nbsp;&nbsp;一月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="02"> &nbsp;&nbsp;二月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="03"> &nbsp;&nbsp;三月&nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="04"> &nbsp;&nbsp;四月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="05"> &nbsp;&nbsp;五月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="06"> &nbsp;&nbsp;六月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="07"> &nbsp;&nbsp;七月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="08"> &nbsp;&nbsp;八月&nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="09"> &nbsp;&nbsp;九月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="10"> &nbsp;&nbsp;十月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="11"> &nbsp;&nbsp;十一月 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="12"> &nbsp;&nbsp;十二月 &nbsp;&nbsp;</option>
					     </select>
					    </td>
					    
    
					    
					    <td nowrap align="right" style="font-size:18px;"><strong>日期:</strong></td>
					    <td align="left"><input value="<%=version.getV_date() %>" name="V_DATE" id="V_DATE" style="width:150px;height:23px;"  type="text" size="12" class="Wdate" onFocus="WdatePicker({lang:'zh-cn'})"/></td>

				        </tr>
			        
			        	<!-- 第四行 -->
					  <tr>
				  		<td nowrap align="center" style="font-size:18px;"><strong>星期:</strong></td>
				        <td align="left">
					    <select style="height:23px;font-weight:bold;" name="V_WEEK"  id="V_WEEK">
					     <option style="font-size:15px;" value="<%=version.getV_week() %>"> &nbsp;&nbsp;<%=version.getV_week() %>&nbsp;&nbsp;</option>                                
					     <option style="font-size:15px;" value="1"> &nbsp;&nbsp;星期一 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="2"> &nbsp;&nbsp;星期二 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="3"> &nbsp;&nbsp;星期三&nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="4"> &nbsp;&nbsp;星期四 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="5"> &nbsp;&nbsp;星期五 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="6"> &nbsp;&nbsp;星期六 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="7"> &nbsp;&nbsp;星期日 &nbsp;&nbsp;</option>
					     </select>
					     </td>
					    <td nowrap align="right" style="font-size:18px;"><strong>姓名:</strong></td>
					    <td align="left"><input readOnly="true" name="V_NAME" id="V_NAME" value="<%=version.getV_name() %>" style="width:150px;height:23px;" type="text" size="12" class="text"/></td>
				        </tr>
			        
			        
			        <!-- 第二行 -->
					  <tr>
					    <td nowrap align="center" style="font-size:18px;"><strong>基础工作:</strong></td>
					    <td colspan=3><input name="V_BASICS" id="V_BASICS" value="<%=version.getV_basics() %>" class="" type="text" style="width:425px;height:23px;" type="text" size="40"  maxlength="400"/>
				        <span class="red">200字内</span></td>
				        </tr>
			        

			        <!-- 第三行 -->
					  <tr>
					    <td nowrap align="center" style="font-size:18px;"><strong>工作内容:</strong></td>
					    <td colspan=3><textarea name="V_WORK" id="V_WORK"  class="text"  style="width:425px;height:80px;"/><%=version.getV_work() %></textarea>
				        <span class="red">500字内</span></td>
				      </tr>		

					<!-- 第三行 -->
					<tr>
						<td nowrap align="center" style="font-size:18px;"><strong>测试工时:</strong></td>
					    <td align="left"><input name="V_TIME" id="V_TIME" value="<%=version.getV_time() %>" style="width:120px;height:23px;" type="text" size="12" class="text"/>					
						<span>小时</span></td>
						<td ><input  readonly="readonly" name="V_ID" id="V_ID" value = "<%=version.getV_id() %>"  style="width:50px" type="hidden" size="40" />
					</tr>



			        <!-- 第五行 -->
			        	<tr>
			        	<td nowrap align="center" style="font-size:18px;"><strong>工作类型:</strong></td>
				        <td align="left" style="width:150px;height:23px;">
					    <select style="height:23px;font-weight:bold;" name="V_TYPE"  id="V_TYPE">
					     <option style="font-size:15px;" value="<%=version.getV_type() %>"> &nbsp;&nbsp;<%=version.getV_type() %>&nbsp;&nbsp;</option>                                
					     <option style="font-size:15px;" value="系统测试 "> &nbsp;&nbsp;系统测试 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="敏捷测试"> &nbsp;&nbsp;敏捷测试 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="补丁测试"> &nbsp;&nbsp;补丁测试&nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="性能测试"> &nbsp;&nbsp;性能测试 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="文档编辑"> &nbsp;&nbsp;文档编辑 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="自动化测试"> &nbsp;&nbsp;自动化测试 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="会议"> &nbsp;&nbsp;会议 &nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="培训"> &nbsp;&nbsp;培训&nbsp;&nbsp;</option>
					     <option style="font-size:15px;" value="其他"> &nbsp;&nbsp;其他 &nbsp;&nbsp;</option>
					     </select>
						</td>			
			        	<td nowrap align="right" style="font-size:18px;"><strong>BUG产出:</strong></td>
					    <td align="left"><input name="V_BUG" id="V_BUG" value="<%=version.getV_bug() %>" style="width:150px;height:23px;" type="text" size="12" class="text"/></td>
			        	</tr>
			      
			      <!-- 第六行 -->
			        	<tr>
			        	<td nowrap align="center" style="font-size:18px;"><strong>文档编辑:</strong></td>
					    <td align="left"><input name="V_DOCUMENT" id="V_DOCUMENT" value="<%=version.getV_document() %>" style="width:150px;height:23px;" type="text" size="12" class="text"/></td>
			        	<td nowrap align="right" style="font-size:18px;"><strong>用例产出:</strong></td>
					    <td align="left"><input name="V_CASE" id="V_CASE" value="<%=version.getV_case() %>" style="width:150px;height:23px;" type="text" size="12" class="text"/></td>
			        	
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
			<input type="submit" value="保存" />　
			
			<input type="button" value="返回" onclick="window.history.go(-1);"/></TD>
		</TR>
		</TABLE>

    
</div>
</form>
</body>
</html>
