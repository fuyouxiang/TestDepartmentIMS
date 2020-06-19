<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'sysMessage.jsp' starting page</title>
    <link href="<%=path %>/bootstrap/css/bootstrap.css" rel='stylesheet' type='text/css'/>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  </head>	
	<script src="<%=path %>/js/jquery-3.2.1.min.js"></script>
	<script src="<%=path %>/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript">
	</script>
  <body style="margin-left:30px;">

  <div class="container">
      <%
      String info=(String)  request.getAttribute("info");
      %>

      <div class="jumbotron">
  		<h2>调用成功!</h2>
  		<p><textarea type="text" name="voucher" id='voucher' class="form-control" style="width:600px;height:400px"><%=info %></textarea></p>
  		<p><a class="btn btn-primary btn-lg" href="User/AsspPBankService.jsp" role="button">关闭</a></p>
	</div>

</div>

  </body>
</html>
