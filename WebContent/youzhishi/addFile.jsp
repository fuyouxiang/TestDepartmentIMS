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

			  //监听ATTACH_PATH，随时获取文件后缀
			  	window.setTimeout(function() {
			  	document.getElementById("ATTACH_PATH").addEventListener("change",function () {  
			  	    console.log("change"); 
			  	    var ATTACH_PATH=document.formname.ATTACH_PATH.value;
			  		var dian=ATTACH_PATH.lastIndexOf(".");
			  		var ATTACH_TYPE=ATTACH_PATH.substring(dian+1);
			  		document.getElementById("ATTACH_TYPE").value=ATTACH_TYPE;
			  		
			  		var gang=ATTACH_PATH.lastIndexOf("\\");
			  		var ATTACH_NAME1=ATTACH_PATH.substring(gang+1);//斜杠后面的所有字符输出
			  		var ATTACH_NAME=ATTACH_NAME1.substring(0,ATTACH_NAME1.lastIndexOf("."));
			  		document.getElementById("ATTACH_NAME").value=ATTACH_NAME;
			  	}, false);
			  	},500);  
			  
			  //通过js提交表单
			  	function  submitMyForm(){

			    	//校验
			    	if(ATTACH_NAME == ''){
			    		alert('请填写文件名称!');      
		 				return false;
			    	}
			    	else if(ATTACH_PATH == ''){
			    		alert('请选择文件!');      
		 				return false;
			    	}
			    	else if(ATTACH_TYPE == ''){
			    		alert('请先选择要上传的文件路径!');      
		 				return false;
			    	}
			    	else if(APPID == ''){
			    		alert('请选择文件子系统!');      
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

	<form action="<%=path%>/AddFileServlet" method="post" id ="form1"  name="form1"  onsubmit="return submitMyForm()">
		
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >文件上传</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		<div class="msg">当前位置：首页 >> 文档管理 >> 文件上传>> 文件信息填写</div>
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>第二步：填写文件信息</legend>
	      <%
      String name=(String)request.getAttribute("name");
	      String type=(String)request.getAttribute("type");
	      String info=(String)request.getAttribute("info"); 
      %>

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
					    <td><input readonly name="ATTACH_NAME" id="ATTACH_NAME" class="text" style="width:500px;height:30px" type="text" size="200" value="<%=name%>"/> 
				        </td>
						</tr>
						<tr>
						<td nowrap align="right" width="13%"></td>
					    <td><span class="red">注：自动增加时间戳保证文件唯一性。</span></td>
						</tr>
						<tr>
				        <td align="right">文件类型:</td>
				        <td><input name="ATTACH_TYPE" id="ATTACH_TYPE" class="text" style="width:500px;height:30px" type="text" size="40" value="<%=type%>"/></td>
						</tr>
				       <tr>
				       <td align="right">文件分类:</td>
				       <td>
				       <select style="width:500px;height:30px;color:blue;font-weight:bold;font-size:14px;" name="APPID"  id="APPID">                            
					   <option value="003"> &nbsp;&nbsp;测试用例 &nbsp;&nbsp;</option>
					   <option value="001"> &nbsp;&nbsp;新人必读 &nbsp;&nbsp;</option>				     
					   <option value="002"> &nbsp;&nbsp;项目文档 &nbsp;&nbsp;</option>
					   <option value="004"> &nbsp;&nbsp;知识分享 &nbsp;&nbsp;</option>
					   </select><span class="red"></span>
				       </td>
				       </tr>
				       
				       <tr>
				       <td align="right">关键词:</td>
				       <td><input name="ITEM_TYPE" id="ITEM_TYPE" class="text" style="width:500px;height:30px" type="text" size="100" value="无"/></td>
				       </tr>
				       <tr> 
				       <td align="right">文件说明:</td>
				       <td><textarea name="REMARK" id="REMARK" class="text" style="width:500px;height:80px"/>无</textarea>(100字以内)</td>
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
