<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
		<title>加班添加</title>
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
			    	//var o_name=document.getElementById("o_name").value;
			    	//var o_date=document.getElementById("o_date").value;
			    	//var o_time=document.getElementById("o_time").value;
			    	
			    	var o_name=document.formname.o_name.value;
			    	var o_month=document.formname.o_month.value;
			    	var o_date=document.formname.o_date.value;
			    	var o_time=document.formname.o_time.value;
			    	var o_hold1=document.formname.o_hold1.value;
			    	
			    	
			    	//校验
			    	if(o_name == ''){
			    		alert('请填写员工姓名!');      
		 				return false;
			    	}
			    	else if(o_month == ''){
			    		alert('请选择加班月份!');      
		 				return false;
			    	}
			    	else if(o_date == ''){
			    		alert('请选择加班日期!');      
		 				return false;
			    	}
			    	else if(o_time == ''){
			    		alert('请填写加班时间!');      
		 				return false;
			    	}
			    	else if(o_hold1 == ''){
			    		alert('请填写加班事由!');      
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
    </head>
    <body onselectstart="return true;" ondragstart="return false;">
        <body id="onlinebooking">

	<div class="qiandaobanner"> 
		<img src="static/img/head_pic.jpg">
	</div>
<form action="<%=path%>/AddOvertimeServlet_Phone" method="post" id =formId onsubmit="return submitMyForm()" name="formname">

	<!--粉丝填写过的信息的，直接就显示名字电话，粉丝没有填写过信息的话，这里就直接留空让粉丝填写-->
	<ul class="round">
		
		<li class="title mb"><span class="none">请真实的填写表单</span></li>
				<li class="nob">
			<input name="formhash" id="formhash" value="2be3071a" type="hidden">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>员工姓名:</th>
					<td><input name="o_name" id="o_name" class="px" id="truename" type="text"></td>
				</tr>
			</table>
		</li>
						<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>加班月份:</th>
					<td><select style="high:150;font-weight:bold;" name="o_month"  id="o_month"  class="px">
					     <option  value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
					     <option value="01"> &nbsp;&nbsp;一月 &nbsp;&nbsp;</option>
					     <option value="02"> &nbsp;&nbsp;二月 &nbsp;&nbsp;</option>
					     <option value="03"> &nbsp;&nbsp;三月&nbsp;&nbsp;</option>
					     <option value="04"> &nbsp;&nbsp;四月 &nbsp;&nbsp;</option>
					     <option value="05"> &nbsp;&nbsp;五月 &nbsp;&nbsp;</option>
					     <option value="06"> &nbsp;&nbsp;六月 &nbsp;&nbsp;</option>
					     <option value="07"> &nbsp;&nbsp;七月 &nbsp;&nbsp;</option>
					     <option value="08"> &nbsp;&nbsp;八月&nbsp;&nbsp;</option>
					     <option value="09"> &nbsp;&nbsp;九月 &nbsp;&nbsp;</option>
					     <option value="10"> &nbsp;&nbsp;十月 &nbsp;&nbsp;</option>
					     <option value="11"> &nbsp;&nbsp;十一月 &nbsp;&nbsp;</option>
					     <option value="12"> &nbsp;&nbsp;十二月 &nbsp;&nbsp;</option>
					     </select>
					     </td>
				</tr>
			</table>
		</li>
						<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>加班日期:</th>
				<td>
					<input type="text" class="px" name="o_date" onFocus="WdatePicker({lang:'zh-cn'})"/>
				</td>
				</tr>
			</table>
		</li>
						<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>加班时间:</th>
				<td>
				<select style="high:150;font-weight:bold;" name="o_time" id="o_time"  class="px">
					     <option value="0.5"> &nbsp;&nbsp;0.5人/天&nbsp;&nbsp;</option>                                
					     <option value="1"> &nbsp;&nbsp;1.0人/天&nbsp;&nbsp;</option>
					     </select>
					</td>
				</tr>
			</table>
		</li>
		
		<li class="nob">
			<input name="formhash" id="formhash" value="2be3071a" type="hidden">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>加班事由:</th>
					<td><textarea cols="15" rows="3" name="o_hold1" id="o_hold1" class="px" type="text" style="height:50px;"></textarea>
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
