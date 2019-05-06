<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  	<% String username = (String)session.getAttribute("username"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" type="text/css" href="static/css/onlinebooking.css?2014-03-07-1" media="all" />
		
<link rel="stylesheet" type="text/css" href="static/css/datepicker.css?2014-03-07-1" media="all" />

		<link rel="stylesheet" type="text/css" href="static/css/template/weimob-ui-1-1.css?2014-03-07-1" media="all" />

		<link rel="stylesheet" type="text/css" href="static/css/template/common.css?2014-03-07-1" media="all" />

		<script type="text/javascript" src="static/src/jQuery.js?2014-03-07-1"></script>

		<script type="text/javascript" src="static/src/jquery-ui.js?2014-03-07-1"></script>
		<title>密码修改</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">       
        <!-- Mobile Devices Support @begin -->
            <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
            <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
            <meta content="no-cache" http-equiv="pragma">
            <meta content="0" http-equiv="expires">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- Mobile Devices Support @end -->
        <link rel="shortcut icon" href="static/img/favicon.ico" />
        <style>
            img{max-width:100%!important;}
        </style>
        <script type="text/JavaScript" src="<%=path %>/My97DatePicker/WdatePicker.js">
</script>
    </head>
    <body onselectstart="return true;" ondragstart="return false;">
        <body id="onlinebooking">

	<div class="qiandaobanner"> 
		<img src="static/img/head_pic5.jpg">
	</div>
<form action="<%=path%>/updatePassword_Phone" method="post" id =formId onsubmit="return submitMyForm()">

	<!--粉丝填写过的信息的，直接就显示名字电话，粉丝没有填写过信息的话，这里就直接留空让粉丝填写-->
	<ul class="round">
		
		<li class="title mb"><span class="none">请输入：</span></li>
				<li class="nob">
			<input name="formhash" id="formhash" value="2be3071a" type="hidden">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>用户名:</th>
					<td><input name="u_name" id="u_name" class="px" type="text" value="<%=username%>"></td>
				</tr>
			</table>
		</li>

		
		<li class="nob">
			<input name="formhash" id="formhash" value="2be3071a" type="hidden">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>原密码:</th>
					<td><input name="u_password" id="u_password" class="px" type="text">
					</td>
				</tr>
				</table>	
		</li>
		<li class="nob">
			<input name="formhash" id="formhash" value="2be3071a" type="hidden">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>新密码:</th>
					<td><input name="u_password2" id="u_password2" class="px" type="text">
					</td>
				</tr>
				</table>	
		</li>
			
		
		<li class="nob">
			<input name="formhash" id="formhash" value="2be3071a" type="hidden">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
				<td  align="center"><input value="提交" type="submit"  class="submit" > </td>
			
				</tr>
			
		</li>
	</ul>
	</table>
	</form>



</body>        		
	</body>

</html>
