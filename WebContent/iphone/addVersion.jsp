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
		<title>工作情况添加</title>
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
		 $(document).ready(function(){  
	     	
	     	//为input type="text" id="userNameId"， 绑定一个失去焦点事件
	     	$("#NameId").blur(function(){
	     		 
	     		var userName=$(this).val();
	     		//定义通过异步方式发送到servlet的参数
	     		//alert(userName);
	     		if(userName != ""){
	     			var urlPath='<%=path%>';
		     		 $.post(urlPath+"/CheckUserNameServlet",{userName:userName,math:Math.random() },function(data){
		     			 //接收回调函数接收服务端响应回的数据
		     			
		     			 alert(data);
		     		 });
	     		}
	     		
	     		
	     	});
	     	
	     	 
	     });
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
			  	/*
			  		var formObj=document.getElementById("formId");
			    	var V_MONTH=document.getElementById("V_MONTH").value;
			    	var V_DATE=document.getElementById("V_DATE").value;
			    	var V_WEEK=document.getElementById("V_WEEK").value;
			    	var V_NAME=document.getElementById("V_NAME").value;
			    	var V_BASICS=document.getElementById("V_BASICS").value;
			    	var V_WORK=document.getElementById("V_WORK").value;
			    	var V_TIME=document.getElementById("V_TIME").value;
			    	var V_TYPE=document.getElementById("V_TYPE").value;
			    	var V_BUG=document.getElementById("V_BUG").value;
			    	var V_DOCUMENT=document.getElementById("V_DOCUMENT").value;
			    	var V_CASE=document.getElementById("V_CASE").value;
				*/
			    	var V_MONTH=document.formname.V_MONTH.value;
			    	var V_DATE=document.formname.V_DATE.value;
			    	var V_WEEK=document.formname.V_WEEK.value;
			    	var V_NAME=document.formname.V_NAME.value;
			    	var V_BASICS=document.formname.V_BASICS.value;
			    	var V_WORK=document.formname.V_WORK.value;
			    	var V_TIME=document.formname.V_TIME.value;
			    	var V_TYPE=document.formname.V_TYPE.value;
			    	var V_BUG=document.formname.V_BUG.value;
			    	var V_DOCUMENT=document.formname.V_DOCUMENT.value;
			    	var V_CASE=document.formname.V_CASE.value;
			    	
			    	//判断除了只能是数字 或带一个小数点，正则表达式
			    	var stop=new RegExp("^\\d+(\\.\\d+)?$");			    	
			    	
			    	
			    	
			    	//为了判断日期与月份是否相符，创建数组，截取
			    	var str =[];
			    	str=V_DATE.split("-");
					var V_MONTH_DATE = str[1];
			    	
			    	//校验
			    	if(V_MONTH == ''){
			    		alert('请选择月份!');      
		 				return false;
			    	}
			    	else if(V_DATE == ''){
			    		alert('请选择日期!');      
		 				return false;
			    	}
			    	else if(V_MONTH_DATE != V_MONTH){
			    		alert("月份与日期不符！");      
		 				return false;
			    	}
			    	else if(V_WEEK == ''){
			    		alert('请选择星期!');      
		 				return false;
			    	}
			    	else if(V_NAME == ''){
			    		alert('请输入姓名!');      
		 				return false;
			    	}
			    	else if(V_BASICS == ''){
			    		alert('请输入基本工作!');      
		 				return false;
			    	}
			    	else if(V_WORK == ''){
			    		alert('请输入工作内容!');      
		 				return false;
			    	}
			    	else if(V_TIME == ''){
			    		alert('请输入工时!');      
		 				return false;
			    	}
			    	else if(V_TYPE == ''){
			    		alert('请选择工作类型!');      
		 				return false;
			    	}
			    	else if(!stop.test(V_TIME)||!stop.test(V_BUG)||!stop.test(V_DOCUMENT)||!stop.test(V_CASE)){
			    		alert('工时、产出必须为数字类型!');      
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
		<img src="static/img/head_pic4.jpg">
	</div>
<form action="<%=path%>/AddVersionServlet_Phone" method="post" id =formId onsubmit="return submitMyForm()" name="formname">


	<ul class="round">
		
		<li class="title mb"><span class="none">请真实的填写表单</span></li>
		
		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>月份:</th>
					<td><select style="high:150;font-weight:bold;" name="V_MONTH"  id="V_MONTH"  class="px">
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
					<th>日期:</th>
					<td><input name="V_DATE" id="V_DATE"  type="text" class="px" onFocus="WdatePicker({lang:'zh-cn'})" ></td>
				</tr>
			</table>
		</li>
		
		<li class="nob">
		
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>星期:</th>
					<td><select style="high:150;font-weight:bold;" name="V_WEEK"  id="V_WEEK"  class="px">
					     <option  value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
					     <option value="1"> &nbsp;&nbsp;星期一 &nbsp;&nbsp;</option>
					     <option value="2"> &nbsp;&nbsp;星期二 &nbsp;&nbsp;</option>
					     <option value="3"> &nbsp;&nbsp;星期三&nbsp;&nbsp;</option>
					     <option value="4"> &nbsp;&nbsp;星期四 &nbsp;&nbsp;</option>
					     <option value="5"> &nbsp;&nbsp;星期五 &nbsp;&nbsp;</option>
					     <option value="6"> &nbsp;&nbsp;星期六 &nbsp;&nbsp;</option>
					     <option value="7"> &nbsp;&nbsp;星期日 &nbsp;&nbsp;</option>
					     </select>
					     </td>
				</tr>
			</table>
		</li>
		
		<li class="nob">

			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>姓名:</th>
					<td><input name="V_NAME" id="V_NAME" class="px" id="truename" type="text"></td>
				</tr>
			</table>
		</li>
			
			
		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>基础工作:</th>
					<td><textarea cols="15" rows="3" name="V_BASICS" id="V_BASICS" class="px"  type="text" style="height:50px;"></textarea></td>
				</tr>
			</table>
		</li>
		
		<li class="nob">

			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<th>工作内容:</th>
					<td><textarea cols="15" rows="6" name="V_WORK" id="V_WORK" class="px" id="truename" type="text" style="height:100px;">参加站立会，了解当天工作任务。</textarea></td>
				</tr>
			</table>
		</li>
			

		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>工时:</th>
				<td>
				<input id="V_TIME" type="text" class="px" name="V_TIME" value="7.5"/>
					</td>
				</tr>
			</table>
		</li>
		
		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>工作类型:</th>
					<td><select style="high:150;font-weight:bold;" name="V_TYPE"  id="V_TYPE"  class="px">
					     <option  value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
					     <option value="系统测试"> &nbsp;&nbsp;系统测试&nbsp;&nbsp;</option>
					     <option value="敏捷测试"> &nbsp;&nbsp;敏捷测试&nbsp;&nbsp;</option>
					     <option value="补丁测试"> &nbsp;&nbsp;补丁测试&nbsp;&nbsp;</option>
						 <option value="性能测试"> &nbsp;&nbsp;性能测试 &nbsp;&nbsp;</option>
					     <option value="文档编辑"> &nbsp;&nbsp;文档编辑 &nbsp;&nbsp;</option>
					     <option value="自动化测试"> &nbsp;&nbsp;自动化测试 &nbsp;&nbsp;</option>
					     <option value="会议"> &nbsp;&nbsp;会议 &nbsp;&nbsp;</option>
					     <option value="培训"> &nbsp;&nbsp;培训&nbsp;&nbsp;</option>
					     <option value="其他"> &nbsp;&nbsp;其他 &nbsp;&nbsp;</option>
					     </select>
					     </td>
				</tr>
			</table>
		</li>
		
		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>BUG产出:</th>
				<td>
				<input id="V_BUG" type="text" class="px" name="V_BUG" value="0"/>
					</td>
				</tr>
			</table>
		</li>	
		
		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>文档编辑:</th>
				<td>
				<input id="V_DOCUMENT" type="text" class="px" name="V_DOCUMENT" value="0"/>
					</td>
				</tr>
			</table>
		</li>
		
		<li class="nob">
			<table class="kuang" border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<th>用例产出:</th>
				<td>
				<input id="V_CASE" type="text" class="px" name="V_CASE" value="0"/>
					</td>
				</tr>
			</table>
		</li>
		
		<li class="nob">
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
<script> 
//取出传回来的参数error并与yes比较
  var errori ='<%=request.getParameter("answer")%>';
  if(errori=='yes'){
   alert("工作日报保存成功！");
  }else if(errori=='no'){
   alert("工作日报保存失败！");
  }
</script>