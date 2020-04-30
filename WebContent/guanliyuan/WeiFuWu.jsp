<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.SimpleDateFormat,java.util.Calendar,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
PageBean pageBean2=(PageBean)request.getAttribute("pageBean2");

//获取用户名称和角色
String username = (String)session.getAttribute("username");
if(username==null){
	response.getWriter().println("<script>alert('抱歉，用户信息已失效！请重新登录！');window.top.location='login.jsp';</script>");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
    <link href="bootstrap/css/bootstrap.css" rel='stylesheet' type='text/css'/>
</head>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>


<script>
$(function(){
  $("#selectbutton").click(function(){
    $("#themodal").modal();
  });
  $("#selectbutton").click(function(){
	    $("#themodal").modal();
  });
});


//通过js提交表单
	function  submitMyForm(){
	var W_NAME=document.formname.W_NAME.value;
	var B_NAME=document.formname.B_NAME.value;
	
	//校验
	if(W_NAME == ''){
		alert('请选择部门!');      
			return false;
	}
	else if(B_NAME == ''){
		alert('请填写微服务名称!');      
			return false;
	}else{
		return true;
	}
}
</script>
<body>
<div style="position:absolute; height:100%; overflow:auto">
<div style="margin-left:50px;">
	<br>
	<form action="<%=path%>/UpdateWeiFuWuServlet?type=add" onsubmit="return submitMyForm()" name="formname" method="post" id="formname">
	<div class="input-group" >
		<div class="input-group-addon" ><strong>部门：</strong></div>
		<select style="high:150;font-weight:bold;width:230px;" name="B_NAME"  id="B_NAME" class="selectpicker show-tick form-control">
					<option  value=""></option>
					<%
                      if(pageBean2!=null){
                       List<Map<String, String>>  resList=  pageBean2.getResList();
                       if(resList!=null && resList.size()>0){                          		
                          for(int i=0;i<resList.size();i++){
                          Map<String, String>  stuMap= resList.get(i);	  
                          %>    
					<option  value="<%=stuMap.get("B_NAME") %>"><%=stuMap.get("B_NAME") %></option>
					<%     
                          }                        	  
                       }
                      }
                        %>
		</select>
	</div>
	<div class="input-group" style="margin-top:10px;:10px;">
      <div class="input-group-addon"><strong>微服务：</strong></div>
      <input type="text" name="W_NAME" id='W_NAME' class="form-control" style="width:214px">
      &nbsp;<input class="btn btn-success" type="submit" value="新增">
      &nbsp;&nbsp;<button class="btn btn-primary" type="button" id="selectbutton">快速查询</button>   
    </div>    
	<br>
	</form>
	
<div class="modal" id="themodal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span
                        class="sr-only">Close</span></button>
                <h4 class="modal-title">快速查询</h4>
            </div>
            <div class="modal-body">
                <p>您可以使用键盘的<h1><strong>Ctrl+F</strong></h1>打开浏览器的快速查询，很好用哦~</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>	



<table class="table table-striped table-bordered table-hover table-condensed" style="width:700px;text-align:center;" border="1">
	<tr></tr>
	<tr>
		<td id="div_title" height="28" colspan="4" align="center" style="font-size:16px;background-color:#44a0ff;color:#ffffff;">微服务列表</td>
	</tr>
	<tr>
	    <td  style="font-size:12px;font-weight:bold"></td>
        <td  style="font-size:12px;font-weight:bold">部门</td>
        <td  style="font-size:12px;font-weight:bold">微服务</td>
        <td  style="font-size:12px;font-weight:bold">操作</td>
	</tr>
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
	<tr>
	
<form  action="<%=path %>/UpdateWeiFuWuServlet?type=update&oldB_NAME=<%=stuMap.get("B_NAME") %>&oldW_NAME=<%=stuMap.get("W_NAME") %>" method="post"  name="UpdateWFWForm" id="UpdateWFWForm">
	     <td style="font-size:12px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
         <td style="font-size:12px;text-align:center;font-weight:bold">
         <select style="high:150;font-weight:bold;width:230px;" name="B_NAME"  id="B_NAME" class="selectpicker show-tick form-control">
					<option  value="<%=stuMap.get("B_NAME") %>"><%=stuMap.get("B_NAME") %></option>
					<%
                      if(pageBean2!=null){
                       List<Map<String, String>>  resList3=  pageBean2.getResList();
                       if(resList3!=null && resList3.size()>0){                          		
                           for(int n=0;n<resList3.size();n++){
                        	   Map<String, String>  stuMap3= resList3.get(n);	   
                          %>    
					<option  value="<%=stuMap3.get("B_NAME") %>"><%=stuMap3.get("B_NAME") %></option>
					<%     
                          }                        	  
                       }
                      }
                        %>
         </select>
         </td>
         <td style="font-size:12px;text-align:center;font-weight:bold"><input type="text" name="W_NAME" id='W_NAME' class="form-control" value="<%=stuMap.get("W_NAME") %>"></td>
         <td style="font-size:12px;text-align:center;font-weight:bold">
         <button type="button" class="btn btn-danger" onclick="if(window.confirm('您确定要删除吗？')){window.location.href='UpdateWeiFuWuServlet?type=delete&B_NAME=<%=stuMap.get("B_NAME") %>&W_NAME=<%=stuMap.get("W_NAME")%>'}">删除</button>
         <button type="submit" value="提交" class="btn btn-warning">保存</button>
         </td>
	</form>
	</tr>
	                          <%     
                               }  
                           } 
                          }
                   
                        
                        %>
</table>
</div>
</div>
</body>
</html>