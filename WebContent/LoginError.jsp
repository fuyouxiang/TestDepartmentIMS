<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'sysMessage.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	//小窗口关闭事件
		function winclose(){
			
			var obj = new Object();
			obj.flag = '1';
			window.returnValue = obj;
			window.close();
		
		}
		//三秒后自动关闭小窗口
		window.onload = function tishi(){
			 
			setTimeout("winclose()",2000);
		}
		
	
	
	</script>
	

  </head>
  
  <body>
      <h1>系统消息</h1>
      <%
      String info=(String)  request.getAttribute("info");
      %>
      
      <%=info!=null?info:"系统消息" %>  
      <!--创建按钮关闭小窗口 - -->
      <table>
      <tr>
      <td>
      <input type = "button" value = "关闭小窗口" onclick="window.history.go(-1);"/>
      </td>
      </tr>
      </table>
  </body>
</html>
