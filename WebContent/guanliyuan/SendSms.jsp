<%@ page language="java" import="java.util.*,cn.com.shxt.model.*,cn.com.shxt.utils.MD5Helper;" pageEncoding="UTF-8"%>
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
    <base target="_self"/>
    
    
    <title>短信发送</title>
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
	font-size: 13px;
	height: 24px;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 

</style>

<script type="text/javascript" src="./js/jquery-1.11.3.js"></script>
<script language="javascript" type="text/javascript">
  /*
  *统一设置所有条目的
  */
  function setItemCheckBox(flag) {
    $(":checkbox[name=checkboxBtn]").prop("checked",flag);
  }
  $(function () {
    //点击全选
    $("#selectAll").click(function(){
      //1.获取全选的状态
      var flag = this.checked;//获取全选的状态
      if(flag){
        $(this).prop("checked", true);
      }else{
        $(this).prop("checked", false);
      }
      //var flag = $(":checkbox[name=selectAll]").attr("checked");//jquery-1.5.1的用法
      //2.让所有条目的复选框与全选的状态同步
      //alert(flag);
      setItemCheckBox(flag);
    });
    //给所有复选框添加事件
    $(":checkbox[name=checkboxBtn]").click(function(){
      var flagV = this.checked;
      if(flagV){
        $(this).prop("checked", true);
      }else{
        $(this).prop("checked", false);
      }
      //获取所有复选框的个数
      var len = $(":checkbox[name=checkboxBtn]").length;
      //获取所有被选中的复选框的个数
      var checked_len = $(":checkbox[name=checkboxBtn]:checked").length;
      if(len == checked_len){
        //alert("全选中了");
        $("#selectAll").prop("checked",true);
      } else if(checked_len == 0) {
        $("#selectAll").prop("checked",false);
      } else {
        $("#selectAll").prop("checked",false);
      }
    });
  });
  
  function send(){
	    var id = document.getElementsByName('checkboxBtn');
	    var value = new Array();
	    for(var i = 0; i < id.length; i++){
	     if(id[i].checked)
	     value.push(id[i].value);
	    } 
	    var teleNumber1 =value.toString();
	    var teleNumber=teleNumber1.replace(/,/g,'');//去掉逗号
	    
	    var Msg=document.getElementById("Msg").value;
	    
	    location.href ='SendSms?tele='+teleNumber+'&Msg='+Msg;
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
		<form class="layui-form"  method="post" id =formId  name="formname">

		<table border="0" cellpadding="0" cellspacing="0" style="width:100%">


 
		<TR>
			<TD width="100%">
				<fieldset style="height:100%;">
				<legend>短信发送</legend>
	
					  <table border="0" cellpadding="2" cellspacing="1" style="width:100%">
					 
					  <tr>
					    <td align="right">短信内容:</td>
					    <td><textarea name="Msg" id="Msg" class="text" style="width:500px;height:80px"/></textarea></td>
					  </tr>
					  

					  <tr>
					    <td align="right">接收人选择:</td>

					    <td>
					    	<fieldset>
        					<legend></legend>
							<input type="checkbox" id="selectAll" name="selectAllBtn"/>全选<br />
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
                            <input type="checkbox" value="N86<%=stuMap.get("PHONE") %>" name="checkboxBtn"/><%=stuMap.get("U_NAME") %><%=stuMap.get("PHONE") %><br />
        				<%     
              
                               }
                        	  
                           }
                        %>
                           
	      
                        <%  
                          }
                   
                        
                        %>
  					  		</fieldset>
  					  	</td>
					  </tr>



		
					  </table>
			 <br />
				</fieldset>			</TD>
				
		</TR>
				<TR>
			<TD colspan="2" align="center" height="50px">
			<!-- <input type="submit" name="Submit" value="发送"/>　 -->
			<input type="button" value="提交" onclick="send()" />
			
			<input type="button" name="Submit2" value="返回" class="button" onclick="window.history.go(-1);"/></TD>
		</TR>
		</TABLE>
	
	</form>

</div>
  </body>
</html>
