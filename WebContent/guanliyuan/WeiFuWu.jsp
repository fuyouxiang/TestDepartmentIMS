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
<body>
<div style="margin-left:50px;">
	<br><br>
	<form action="<%=path%>/UpdateWeiFuWuServlet?type=add" onsubmit="return submitMyForm()" name="formname" method="post" id="formname">
	<div class="input-group">
		<div class="input-group-addon">微服务：</div>
		<select style="high:150;font-weight:bold;width:200px;" name="D_ISJXXC"  id="D_ISJXXC" class="selectpicker show-tick form-control">
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
	<br>
	<div class="input-group">
      <div class="input-group-addon">部门：</div>
      <input type="text" name="D_BUMEN" id='D_BUMEN' class="form-control" style="width:214px">
      &nbsp;<input class="btn btn-success" type="submit" value="新增">   
    </div>
	<br>
	
	</form>

<table class="table table-striped table-bordered table-hover table-condensed" style="width:500px;text-align:center;" border="1">
	<tr></tr>
	<tr>
		<td id="div_title" height="28" colspan="4" align="center" style="font-size:16px;background-color:#44a0ff;color:#ffffff;">微服务列表</td>
	</tr>
	<tr>
	    <td  style="font-size:15px;font-weight:bold"></td>
        <td  style="font-size:15px;font-weight:bold">部门</td>
        <td  style="font-size:15px;font-weight:bold">微服务</td>
        <td  style="font-size:15px;font-weight:bold">操作</td>
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
	     <td style="font-size:15px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
         <td style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("B_NAME") %></td>
         <td style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("W_NAME") %></td>
         <td style="font-size:15px;text-align:center;font-weight:bold">
         <button type="button" class="btn btn-danger">删除</button>
         <button type="button" class="btn btn-warning">修改</button>
         </td>
	</tr>
	                          <%     
                               }  
                           } 
                          }
                   
                        
                        %>
</table>
</div>
</body>
</html>