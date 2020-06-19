<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
%>
<!DOCTYPE">
<html>
<head>
<link href="../bootstrap/css/bootstrap.css" rel='stylesheet' type='text/css'/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>电子凭证库服务端外部接口</title>
</head>
<style type="text/css">
.input-group-addon{
background-color:#1570bf;
color:#ffffff;
border-radius:18px;
}
.btn-success{
background-color:#0d960d;
width:700px
}
</style>
<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
	
	function setAsspType(obj){
		  var val = obj.value;
		  if(val=='readVoucher'){
			document.getElementById("voucher").style.visibility="hidden";
			document.getElementById("voucher_no").style.visibility="hidden";
			document.getElementById("VoucherFlag").style.visibility="hidden";
			document.getElementById("stamp_id").style.visibility="hidden";
			document.getElementById("stamp_no").style.visibility="hidden";
			document.getElementById("srcOrgType").style.visibility="hidden";
			document.getElementById("decOrgType").style.visibility="hidden";
		  }else if(val == 'signStampByNosAndSend'){
		        document.getElementById("voucher").style.visibility="visible";
				document.getElementById("voucher_no").style.visibility="visible";
				document.getElementById("VoucherFlag").style.visibility="visible";
				document.getElementById("stamp_id").style.visibility="visible";
				document.getElementById("stamp_no").style.visibility="visible";
				document.getElementById("srcOrgType").style.visibility="visible";
				document.getElementById("decOrgType").style.visibility="visible";			  
		  }else{
		  }
		}
	
</script>

<body style="margin-left:30px;">

<div style="width:100%;height:95%;overflow: scroll;">

	<form action="<%=path%>/WebService" name="formname" method="post" id=formname>
	<br/>
	<div class="input-group">
      <div class="input-group-addon">凭证库服务地址：</div>
      <input type="text" name="endpoint" id='endpoint' class="form-control"  value="http://10.10.66.37:8071/realware/services/AsspPBankService?wsdl"  style="width:700px">   
    </div><br/>
    <div class="input-group">
      <div class="input-group-addon">凭证库接口名称：</div>
      <select style="high:150;font-weight:bold;width:700px;" name="PointName"  id="PointName" class="selectpicker show-tick form-control"  onchange="setAsspType(this)">
		<option style="font-size:15px;" value="signStampByNosAndSend">signStampByNosAndSend（签章并发送）</option>
		<option style="font-size:15px;" value="readVoucher">readVoucher（读取凭证：1条）</option>
	  </select>     
    </div><br/>
    <div class="input-group"  style="width: 1000px;">
      <div class="input-group-addon">证书ID：</div>
      <input type="text" name="certid" id='certid' class="form-control" style="width:200px" value="TC1803556704">   
      <div class="input-group-addon">区划：</div>
      <input type="text" name="admDivCode" id='admDivCode' value="420000" class="form-control" style="width:200px" >   
      <div class="input-group-addon">年度：</div>
      <input type="text" name="stYear" id='stYear' value="2020" class="form-control" style="width:200px" >   
    </div><br/>
    <div class="input-group"  style="width: 1000px;">
      <div class="input-group-addon">凭证类型：</div>
      <input type="text" name="vtCode" id='vtCode' class="form-control" style="width:200px" > 
      <div class="input-group-addon">凭证号：</div>
      <input type="text" name="voucher_no" id='voucher_no' class="form-control" style="width:200px" >   
      <div class="input-group-addon">是否回单：</div> 
      <select style="high:150;font-weight:bold;width:200px;" name="VoucherFlag"  id="VoucherFlag" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="0"> &nbsp;&nbsp;否&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="1"> &nbsp;&nbsp;是&nbsp;&nbsp;</option>
	  </select>  
    </div><br/>
    <div class="input-group">
      <div class="input-group-addon">凭证原文：</div>
      <textarea type="text" name="voucher" id='voucher' class="form-control" style="width:600px;height:400px">不需要加报文头和尾；不需要base64加密</textarea>   
    </div><br/>
    <div class="input-group"  style="width: 1000px;">
      <div class="input-group-addon">印章ID：</div>
      <input type="text" name="stamp_id" id="stamp_id" class="form-control" style="width:200px" >  
      <div class="input-group-addon">签章位置：</div>
      <input type="text" name="stamp_no" id="stamp_no" class="form-control" style="width:200px" >   
    </div><br/>
    <div class="input-group" style="width: 1000px;">
      <div class="input-group-addon">发送机构：</div>
      <select style="high:150;font-weight:bold;width:200px;" name="srcOrgType"  id="srcOrgType" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="011"> &nbsp;&nbsp;财政011&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="102"> &nbsp;&nbsp;代理银行102&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="001"> &nbsp;&nbsp;人行001&nbsp;&nbsp;</option>
	  </select>
      <div class="input-group-addon">接收机构：</div>
      <select style="high:150;font-weight:bold;width:200px;" name="decOrgType"  id="decOrgType" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="102"> &nbsp;&nbsp;代理银行102&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="011"> &nbsp;&nbsp;财政011&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="001"> &nbsp;&nbsp;人行001&nbsp;&nbsp;</option>
	  </select>  
    </div>
	<br/>
	<input class="btn btn-success" type="submit" value="调用接口">

	</form>
	   
 </div>
</body>
</html>