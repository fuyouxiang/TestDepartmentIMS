<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.Ping" pageEncoding="UTF-8"  %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>财政云测试申请</title>
<link href="css/style5.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Pink Contact Form ,Login Forms,Sign up Forms,Registration Forms,News latter Forms,Elements"./>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<!--webfonts-->
<link href='http://fonts.useso.com/css?family=Lato:100,300,400,700,100italic,300italic,400italic|Lora:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
<link href='http://fonts.useso.com/css?family=Raleway:400,200,300,500,600,800,700,900' rel='stylesheet' type='text/css'>
<!--//webfonts-->
</head>
<script language="javascript">
//取出传回来的参数error并与yes比较
var errori ='<%=request.getParameter("answer")%>';
if(errori=='yes'){
 alert("版本测试申请单提交成功！已邮件通知测试经理。");
 window.location.href="<%=path%>/TestApplicationServlet";
}else if(errori=='no'){
 alert("单元测试申请单提交失败，请联系管理员！");
 window.location.href="<%=path%>/TestApplicationServlet";
}
</script>
<body>
		<%
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date= format.format(new Date());
		%>
	<div class="top-buttons-agileinfo">
		<a class="active" href="<%=path%>/TestApplicationServlet">版本测试申请</a><a href="<%=path%>/DYTestApplicationServlet" >单元测试申请</a>
	</div>
	<h1>版本测试申请单</h1>
	<form action="<%=path%>/AddBanBenTestServlet" name="formname" method="post" id =formId>
	<div class="login-01">
			<form>
				<ul>
				

				<li class="first">
					<a href="#" class=" icon user"></a>
					<select name="bumen">
					<%
                      if(pageBean!=null){
                       //本页的结果集
                       List<Map<String, String>>  resList=  pageBean.getResList();
                       //System.out.print(resList);
                       if(resList!=null && resList.size()>0){                          		
                          for(int i=0;i<resList.size();i++){
                          Map<String, String>  stuMap= resList.get(i);	  
                          %>    
					<option  value="<%=stuMap.get("B_NAME") %>;<%=stuMap.get("B_USER") %>;<%=stuMap.get("EMAIL") %>"><%=stuMap.get("B_NAME") %></option>
					<%     
                          }                        	  
                       }
                      }
                        %>
					</select>
					<div class="clear"></div>
				</li>
				
				<li class="first">
					<a href="#" class=" icon user"></a><input name="kaifa" type="text" class="text" placeholder="开发人员" required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email"></a><input name="k_email" type="text"  class="text" placeholder="开发人员邮箱，用于接收通知邮件"  required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email"></a><input name="date" type="text"  readonly="readonly" class="text" value="<%=date%>"  required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg"></a><input name="weiServer" type="text" class="text" placeholder="微服务名称" required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg"></a><input name="banbenNo" type="text" class="text" placeholder="版本号" required="required">
					<div class="clear"></div>
				</li>
				<!-- 
				<li class="first">
					<a href="#" class=" icon phone"></a><input type="text" class="text" value="Phone" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Phone';}" >
					<div class="clear"></div>
				</li> -->
				<li class="second">
				<a href="#" class=" icon msg"></a><textarea name="content" placeholder="版本构造内容" required="required"></textarea>
				<div class="clear"></div>
				<li class="second">
				<a href="#" class=" icon msg"></a><textarea name="biaozhun" placeholder="测试通过标准" required="required"></textarea>
				<div class="clear"></div>
				</li>
			</ul>
			<input type="submit" value="提交" >
			<div class="clear"></div>
		</form>
</div>
</form>
	<!--start-copyright-->
   		<div class="copy-right">
   			<div class="wrap">
				<p>财政云产品测试部&nbsp;&copy;2020&nbsp;&nbsp;京ICP备20002763号-1&nbsp;&nbsp;<a target="_blank" href="http://www.yonyougov.vip/">系统首页</a></p>
		</div>
	</div>
	<!--//end-copyright-->
</body>
</html>