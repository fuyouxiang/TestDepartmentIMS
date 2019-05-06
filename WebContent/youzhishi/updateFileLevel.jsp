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

			  
			  //通过js提交表单
			  	function  submitMyForm(){

			    	//校验
			    	if(FILE_CATALOG == ''){
			    		alert('请选择或录入二级文件目录!');      
		 				return false;
			    	}
			    	else if(checkForm()){
				  		return true;				  		
					}else{
						alert("无法提交 请核对信息");
						return false;
					}
			   
			  	}
			  
			  	 $(function(){
			  		  $(":radio").click(function(){
			  			  if($(this).val()=='1'){
			  				var aaa =document.getElementById("FILE_CATALOG1");
			  				aaa.style.display="block";
			  				var aaa =document.getElementById("FILE_CATALOG2");
			  				aaa.style.display="none";
			  			  }else{
				  			var aaa =document.getElementById("FILE_CATALOG1");
				  			aaa.style.display="none";
				  			var aaa =document.getElementById("FILE_CATALOG2");
				  			aaa.style.display="block";
			  			  }
			  		   
			  		  });
			  	});
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
  	String ATTACH_NAME = (String)request.getAttribute("ATTACH_NAME");
    ATTACH_NAME = new String(ATTACH_NAME.getBytes("ISO8859-1"), "utf-8");
  	String APPID = (String)request.getAttribute("APPID");
  	String FILE_CATALOG = (String)request.getAttribute("FILE_CATALOG");
  %>

	<form action="<%=path%>/AddFileLevelServlet" method="post" id ="form1"  name="form1"  onsubmit="return submitMyForm()">
		
		<div class="MainDiv">

			<table width="99%" border="0" cellpadding="0" cellspacing="0" class="CContent">
  				<tr>
      				<th class="tablestyle_title" >文件修改</th>
  				</tr>
  				<tr>
    				<td class="CPanel">
		
		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">

		<div class="msg"> 文件夹选择</div>
 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>文件夹选择</legend>


					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
						<tr>
					    <td nowrap align="right" width="13%">文件名称:</td>
					    <td><input readonly name="ATTACH_NAME" id="ATTACH_NAME" class="text" style="width:500px;height:30px" type="text" size="200" value="<%=ATTACH_NAME%>"/> 
				        </td>
						</tr>
						<tr>
				        <td align="right">文件类型:</td>
				        <td><input  readonly name="APPID" id="APPID" class="text" style="width:500px;height:30px" type="text" size="40" value="<%=APPID%>"/></td>
						</tr>
						
						
						<tr>
						<td align="right">文件夹:</td>
				       <td>
				        <input type="radio" name="radio" value="1" checked>选择现有文件夹
 						<input type="radio" name="radio" value="0">新建文件夹
 						</td>
						</tr>
						
				       <tr>
				       <td align="right"></td>
				       <td>
				       
				       <select name="FILE_CATALOG_choose" id="FILE_CATALOG1" style="width:500px;height:30px;color:blue;font-weight:bold;font-size:14px;" value="<%=FILE_CATALOG%>">
				       <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean.getResList();
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                          		//传递学生信息
                          		
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
                            	  
                          %>                          
					   <option value="<%=stuMap.get("FILE_CATALOG") %>"><%=stuMap.get("FILE_CATALOG") %></option>
					   
					    <%     
              
                               }
                        	  
                           }
                        %>
                           
	      
                        <%  
                          }
                   
                        
                        %>
                        </select>
					   <span class="red"></span>
				       </td>
				       </tr>
				       	<tr>
				       	<td align="right"></td>
				       <td>				       
						<input  name="FILE_CATALOG_input"  id="FILE_CATALOG2" style="width:500px;height:30px;display:none" type="text" size="40"/>
						</td>
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
		<input type="submit"  value="保存"/>　
          </td>
		</TR>
		</TABLE>

    
</div>
</form>
</form>
</body>
</html>
