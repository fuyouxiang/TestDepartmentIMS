<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
%>
<!DOCTYPE>
<html>
<head>
<link href="bootstrap/css/bootstrap.css" rel='stylesheet' type='text/css'/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<style type="text/css">
</style>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>
<script type="text/javascript">
	//提交
	function UpdateState(fm){
		var D_ID = document.formname.D_ID.value;
        var D_ISJXXC=document.formname.D_ISJXXC.value;
        var D_ISYCHJ=document.formname.D_ISYCHJ.value;
        var D_ISYTH2020=document.formname.D_ISYTH2020.value;
        var ISJXPRE=document.formname.ISJXPRE.value;
   	 	fm.action = fm.action+"&D_ID="+D_ID+"&D_ISJXXC="+D_ISJXXC+"&D_ISYCHJ="+D_ISYCHJ+"&D_ISJXPRE="+ISJXPRE+"&D_ISYTH2020="+D_ISYTH2020;
   		return true;
    }
	
	//操作记录 
	function Return(){
	   window.location.href="javascript:history.go(-1)";
	 }
	
	//上传附件
	function change1(){
	    document.getElementById("uploadFile1_temp").value=document.getElementById("uploadFile1").value;
	}
	function change2(){
	    document.getElementById("uploadFile2_temp").value=document.getElementById("uploadFile2").value;
	 }
	function change3(){
	    document.getElementById("uploadFile3_temp").value=document.getElementById("uploadFile3").value;
	 }
	function change4(){
	    document.getElementById("uploadFile4_temp").value=document.getElementById("uploadFile4").value;
	 }
</script>

<body style="margin-left:30px;">

<div style="width:100%;height:95%;overflow: scroll;">
<%
                        	
    if(pageBean!=null){
    //本页的结果集
    List<Map<String, String>>  resList=  pageBean.getResList();
    //System.out.print(resList);
    if(resList!=null && resList.size()>0){
    //传递学生信息
                          		
    for(int i=0;i<resList.size();i++){
    Map<String, String>  stuMap= resList.get(i);
     
    
    //是否发江西
    String D_ISJXXC = stuMap.get("D_ISJXXC");
    if(D_ISJXXC.equals("0")){
  	  D_ISJXXC="否";
    }else if(D_ISJXXC.equals("1")){
  	  D_ISJXXC="是";
    }else{
  	  D_ISJXXC ="未知";
	  }
    
    //是否更新压测环境
    String D_ISYCHJ = stuMap.get("D_ISYCHJ");
    if(D_ISYCHJ.equals("0")){
  	  D_ISYCHJ="未更新";
    }else if(D_ISYCHJ.equals("1")){
  	  D_ISYCHJ="已更新";
    }else{
  	  D_ISYCHJ ="未知";
	  }
    
    //是否更新yth2020环境
    String D_ISYTH2020 = stuMap.get("D_ISYTH2020");
    if(D_ISYTH2020.equals("0")){
    	D_ISYTH2020="未更新";
    }else if(D_ISYTH2020.equals("1")){
    	D_ISYTH2020="已更新";
    }else{
    	D_ISYTH2020 ="未知";
	  }
    
    //是否更新jxpre环境
    String D_ISJXPRE = stuMap.get("D_ISJXPRE");
    if(D_ISJXPRE.equals("0")){
    	D_ISJXPRE="未更新";
    }else if(D_ISJXPRE.equals("1")){
    	D_ISJXPRE="已更新";
    }else{
    	D_ISJXPRE ="未知";
	  }
    
    
%>	

	<br/>
	<button type="button" class="btn btn-info" onclick="Return()">返回上一页</button>
	<br/><br/>
	<form action="<%=path%>/updateBBStateServlet?type=2" onsubmit="return UpdateState(this)" name="formname" method="post" id=formname  enctype="multipart/form-data">
	<div class="input-group">
      <div class="input-group-addon">原ID：</div>
      <input type="text" name="D_ID" id='D_ID' class="form-control"  value="<%=stuMap.get("D_ID") %>" readonly="readonly" style="width:214px">   
    </div>
    <div class="input-group">
      <div class="input-group-addon">部门：</div>
      <input type="text" name="D_BUMEN" id='D_BUMEN' class="form-control"  value="<%=stuMap.get("D_BUMEN") %>" readonly="readonly" style="width:214px">   
    </div>
    <div class="input-group">
      <div class="input-group-addon">服务：</div>
      <input type="text" name="D_WEINAME" id='D_WEINAME' class="form-control"  value="<%=stuMap.get("D_WEINAME") %>" readonly="readonly" style="width:214px">   
    </div>
    <div class="input-group">
      <div class="input-group-addon">版本号：</div>
      <input type="text" name="D_VERSION" id='D_VERSION' class="form-control"  value="<%=stuMap.get("D_VERSION") %>" readonly="readonly" style="width:200px">   
    </div>
	<br/>
	
	<div class="input-group">
		<div class="input-group-addon"><strong>是否发江西：</strong></div>
		<select style="high:150;font-weight:bold;width:80px;background-color:#ffb100;" name="D_ISJXXC"  id="D_ISJXXC" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="<%=stuMap.get("D_ISJXXC") %>"> &nbsp;&nbsp;<%=D_ISJXXC %>&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="1"> &nbsp;&nbsp;是&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="0"> &nbsp;&nbsp;否&nbsp;&nbsp;</option>
		</select>
	</div>
	<br/>
	<div class="input-group">
		<div class="input-group-addon"><strong>是否更新压测环境：</strong></div>
		<select style="high:150;font-weight:bold;width:100px;background-color:#ffb100;" name="D_ISYCHJ"  id="D_ISYCHJ" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="<%=stuMap.get("D_ISYCHJ") %>"> &nbsp;&nbsp;<%=D_ISYCHJ %>&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
		</select>
	</div>
	<br/>
	<div class="input-group">
		<div class="input-group-addon"><strong>是否更新yth2020环境：</strong></div>
		<select style="high:150;font-weight:bold;width:100px;background-color:#ffb100;" name="D_ISYTH2020"  id="D_ISYTH2020" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="<%=stuMap.get("D_ISYTH2020") %>"> &nbsp;&nbsp;<%=D_ISYTH2020 %>&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
		</select>
	</div>
	<br/>
	<div class="input-group">
		<div class="input-group-addon"><strong>是否更新jxpre环境：</strong></div>
		<select style="high:150;font-weight:bold;width:100px;background-color:#ffb100;" name="ISJXPRE"  id="ISJXPRE" class="selectpicker show-tick form-control">
		<option style="font-size:13px;" value="<%=stuMap.get("D_ISJXPRE") %>"> &nbsp;&nbsp;<%=D_ISJXPRE %>&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
		<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
		</select>
	</div>
	<br/>
	<!--  
	是否发江西：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISJXXC"  id="D_ISJXXC">
	<option style="font-size:13px;" value=""> &nbsp;&nbsp;<%=D_ISJXXC %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;是&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;否&nbsp;&nbsp;</option>
	</select><br/> 
	是否更新压测环境：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISYCHJ"  id="D_ISYCHJ" >
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISYCHJ") %>"> &nbsp;&nbsp;<%=D_ISYCHJ %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
	</select><br/>
	是否更新yth2020环境：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISYTH2020"  id="D_ISJXPRE">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISYTH2020") %>"> &nbsp;&nbsp;<%=D_ISYTH2020 %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
	</select><br/>
	是否更新jxpre环境：
	<select style="high:150;font-weight:bold;width:80px" name="ISJXPRE"  id="ISJXPRE">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISJXPRE") %>"> &nbsp;&nbsp;<%=D_ISJXPRE %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
	</select><br/><br/> -->

	<p class="lead">注意：以下所有附件如果重新上传则会替换，不上传则保持原附件不变。<br/></p>
	<div class="input-group">
      <div class="input-group-addon">构造内容附件：</div>
      <input name="uploadFile1" type="file" class="text" id="uploadFile1" style="display: none;" onchange="change1();">
      <input type="text" class="form-control" id="uploadFile1_temp" placeholder="<%=stuMap.get("D_WIKI") %>" style="width:400px">
      <a class="btn btn-default"  onclick="uploadFile1.click();" role="button">替换附件</a>    
    </div>
    <br/>
    <div class="input-group">
      <div class="input-group-addon">SQL脚本附件：</div>
      <input name="uploadFile2" type="file" class="text" id="uploadFile2" style="display: none;" onchange="change2();">
      <input type="text" class="form-control" id="uploadFile2_temp" placeholder="<%=stuMap.get("D_SQL") %>" style="width:400px">
      <a class="btn btn-default"  onclick="uploadFile2.click();" role="button">替换附件</a>    
    </div>
    <br/>
    <div class="input-group">
      <div class="input-group-addon">配置文件附件：</div>
      <input name="uploadFile3" type="file" class="text" id="uploadFile3" style="display: none;" onchange="change3();">
      <input type="text" class="form-control" id="uploadFile3_temp" placeholder="<%=stuMap.get("D_CONFIG") %>" style="width:400px">
      <a class="btn btn-default"  onclick="uploadFile3.click();" role="button">替换附件</a>    
    </div>
    <br/>
    <div class="input-group">
      <div class="input-group-addon">测试结果附件：</div>
      <input name="uploadFile4" type="file" class="text" id="uploadFile4" style="display: none;" onchange="change4();">
      <input type="text" class="form-control" id="uploadFile4_temp" placeholder="<%=stuMap.get("D_REASON_FILE") %>" style="width:400px">
      <a class="btn btn-default"  onclick="uploadFile4.click();" role="button">替换附件</a>    
    </div>
	<br/>
	<input class="btn btn-success" type="submit" value="提交">

	</form>
	   
	<%     
  	}
	}
}
 %>
 </div>
</body>
</html>