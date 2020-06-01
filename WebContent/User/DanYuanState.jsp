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
   	 	fm.action = fm.action+"&D_ID="+D_ID;
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


    
    
%>	

	<br/>
	<button type="button" class="btn btn-info" onclick="Return()">返回上一页</button>
	<br/><br/>
	<form action="<%=path%>/updateDYStateServlet?type=2" onsubmit="return UpdateState(this)" name="formname" method="post" id=formname  enctype="multipart/form-data">
	<div class="input-group">
      <div class="input-group-addon">原ID：</div>
      <input type="text" name="D_ID" id='D_ID' class="form-control"  value="<%=stuMap.get("D_ID") %>" readonly="readonly" style="width:214px">   
    </div>
    <div class="input-group">
      <div class="input-group-addon">部门：</div>
      <input type="text" name="D_BUMEN" id='D_BUMEN' class="form-control"  value="<%=stuMap.get("D_BUMEN") %>" readonly="readonly" style="width:214px">   
    </div>
    <div class="input-group">
      <div class="input-group-addon">单元测试名称：</div>
      <input type="text" name="D_VERSION" id='D_VERSION' class="form-control"  value="<%=stuMap.get("D_VERSION") %>" readonly="readonly" style="width:200px">   
    </div>
	<br/>
	

	<p class="lead">注意：以下所有附件如果重新上传则会替换，不上传则保持原附件不变。<br/></p>
	<div class="input-group">
      <div class="input-group-addon">构造内容附件：</div>
      <input name="uploadFile1" type="file" class="text" id="uploadFile1" style="display: none;" onchange="change1();">
      <input type="text" class="form-control" id="uploadFile1_temp" placeholder="<%=stuMap.get("D_WIKI") %>" style="width:400px">
      <a class="btn btn-default"  onclick="uploadFile1.click();" role="button">替换附件</a>    
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