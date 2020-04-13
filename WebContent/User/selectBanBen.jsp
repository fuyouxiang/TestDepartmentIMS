<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.SimpleDateFormat,java.util.Calendar,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
PageBean pageBean2=(PageBean)request.getAttribute("pageBean2");
PageBean pageBean3=(PageBean)request.getAttribute("pageBean3");

//获取用户名称和角色
String username = (String)session.getAttribute("username");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>版本测试汇总</title>
    <style type="text/css">
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
		<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
	-->

<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.tabfont01 {	
	font-family: "宋体";
	font-size: 9px;
	color: #555555;
	height:2px;
	text-decoration: none;
	text-align: center;
}
.font051 {font-family: "宋体";
	font-size: 12px;
	color: #333333;
	height:2px;
	text-decoration: none;
	line-height: 10px;
}
.font201 {font-family: "宋体";
	font-size: 12px;
	color: #FF0000;
	height:2px;
	text-decoration: none;
}
form {
    display: block;
    margin-top: 0.5em;
    margin-block-end: 0.5em;
}
button {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: 微软雅黑;
  color: #ffffff;
  font-size: 14px;
  padding: 2px 8px 4px 11px;
  text-decoration: none;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 
-->

 .black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%; 
            height: 100%; 
            background-color: black; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=88); 
        } 
        .white_content { 
            display: none; 
            position: absolute; 
            top: 25%; 
            left: 25%; 
            width: 55%; 
            height: 55%; 
            padding: 20px; 
            border: 10px solid orange; 
            background-color: white; 
            z-index:1002; 
            overflow: auto; 
        }

</style>


<link href="css/css.css" rel="stylesheet" type="text/css" />

<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript" src="./js/jquery-1.11.3.js"></script>
<script type="text/javascript">
		function valiButt() {
					if(<%=pageBean.getNowPage()%> == 1) {
						document.getElementById("fp").disabled = true;
						document.getElementById("bp").disabled = true;
					} 
				
					 if(<%=pageBean.getNowPage()%> == <%=pageBean.getPages()%>) {
						document.getElementById("lp").disabled = true;
						document.getElementById("gp").disabled = true;
					
						}
					 }
		
	
		function goPage(butt) {
			var currentPage = document.getElementById("currentPage");
			var pageForm = document.getElementById("pageForm");
			
			switch(butt.id) {
				case "fp":
					currentPage.value = 1;
					break;
				case "bp":
					currentPage.value = Number(currentPage.value) - 1;
					break;
				case "gp":
					currentPage.value = Number(currentPage.value) + 1;
					//alert(currentPage.value);
					break;
				case "lp":
					currentPage.value = <%=pageBean.getPages()%>;
					break;
			}
			pageForm.submit();
		}

			//checkbox全选和反选
			function checkAll(checked){    
				//根据名字获取所有checkbox控件   
				var allCheckBoxs=document.getElementsByName("isBuy") ;   
		  		//循环设置控件为选中状态   
				for (var i=0;i<allCheckBoxs.length ;i++){       
					if(allCheckBoxs[i].type=="checkbox"){              
					allCheckBoxs[i].checked=checked;       
					}    
				}  
			}
			
			 /*
			  *统一设置所有条目的
			  */
			  function setItemCheckBox(flag) {
			    $(":checkbox[name=checkboxBtn]").prop("checked",flag);
			  }
			  $(function () {
			    //点击全选
			    $("#selectAll").click(function(){
			      //1.获取全选的状态
			      var flag = this.checked;//获取全选的状态
			      if(flag){
			        $(this).prop("checked", true);
			      }else{
			        $(this).prop("checked", false);
			      }
			      //var flag = $(":checkbox[name=selectAll]").attr("checked");//jquery-1.5.1的用法
			      //2.让所有条目的复选框与全选的状态同步
			      //alert(flag);
			      setItemCheckBox(flag);
			    });
			    //给所有复选框添加事件
			    $(":checkbox[name=checkboxBtn]").click(function(){
			      var flagV = this.checked;
			      if(flagV){
			        $(this).prop("checked", true);
			      }else{
			        $(this).prop("checked", false);
			      }
			      //获取所有复选框的个数
			      var len = $(":checkbox[name=checkboxBtn]").length;
			      //alert("复选框个数："+len);
			      //获取所有被选中的复选框的个数
			      var checked_len = $(":checkbox[name=checkboxBtn]:checked").length;
			      if(checked_len>1){
			    	  alert("只能选中一条数据进行处理！");
			    	  return false;
			      }else{
				      if(len == checked_len){
					        //alert("全选中了");
					        $("#selectAll").prop("checked",true);
					      } else if(checked_len == 0) {
					        $("#selectAll").prop("checked",false);
					      } else {
					        $("#selectAll").prop("checked",false);
					      }
			      }
			      

			    });
			  });
		</script>

<script type="text/javascript">

    function base64 (content) {
       return window.btoa(unescape(encodeURIComponent(content)));         
    }
    /*
    *@tableId: table的Id
    *@fileName: 要生成excel文件的名字（不包括后缀，可随意填写）
    */
    function tableToExcel(tableID,fileName){
        var table = document.getElementById(tableID);
      var excelContent = table.innerHTML;
      var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>";
      excelFile += "<head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>版本测试汇总</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head>";
      excelFile += "<body><table>";
      excelFile += excelContent;
      excelFile += "</table></body>";
      excelFile += "</html>";
      var link = "data:application/vnd.ms-excel;base64," + base64(excelFile);
      var a = document.createElement("a");
      a.download = fileName+".xls";
      a.href = link;
      a.click();
    }
    
    
    //操作记录
    function BBLog(){
        var checkbox = document.getElementsByName('checkboxBtn');
        var value = new Array();
        for(var i = 0; i < checkbox.length; i++){
        	if(checkbox[i].checked)
        		value.push(checkbox[i].value);
        } 
         var ID =value.toString();
         if(ID == "" || ID == null || ID == undefined){
        	 alert("请勾选一条数据！"); 
         }else{
        	 window.location.href="<%=path %>/selectBBLogServlet?D_ID="+ID;
         }
     }    
    
    //状态修改
    function BBState(){
        var checkbox = document.getElementsByName('checkboxBtn');
        var value = new Array();
        for(var i = 0; i < checkbox.length; i++){
        	if(checkbox[i].checked)
        		value.push(checkbox[i].value);
        } 
         var ID =value.toString();
         if(ID == "" || ID == null || ID == undefined){
        	 alert("请勾选一条数据！"); 
         }else{
        	 window.location.href="<%=path %>/updateBBStateServlet?type=1&D_ID="+ID;
         }
     }  

    //开始测试
    function StartTest(){
        var checkbox = document.getElementsByName('checkboxBtn');
        var form= document.getElementById("StartBBTestForm");
        var value = new Array();
        for(var i = 0; i < checkbox.length; i++){
        	if(checkbox[i].checked)
        		value.push(checkbox[i].value);
        } 
         var ID =value.toString();
         if(ID == "" || ID == null || ID == undefined){
        	 alert("请勾选一条数据！"); 
         }else{
        	 //alert("该条数据的ID为"+ID); 
        	 
        	 form.action="<%=path %>/StartBBTestServlet?D_ID="+ID;
        	 //alert(form.action);
        	 document.getElementById("startTestButton").onclick();
        	 //等待提示
        	 showWaiting();
        	 form.submit();
     		 $(document).ready(parent.closeWaiting());
         }
     }

    //开始测试的返回结果
    var errori ='<%=request.getParameter("StartAnswer")%>';
    if(errori=='yes'){
     alert("测试任务已开始！");
     window.location.href="<%=path%>/selectBanBenServlet?type=1";
    }else if(errori=='no'){
     alert("测试任务启动失败，请联系管理员！");
     window.location.href="<%=path%>/selectBanBenServlet?type=1";
    }
    
    //驳回操作
    function ReturnTest(fm){
        var D_TUSER=document.returnBBTestForm.D_TUSER.value;
        var TIME=document.returnBBTestForm.TIME.value;
        var REASON=document.returnBBTestForm.REASON.value;
        var checkbox = document.getElementsByName('checkboxBtn');       
        var value = new Array();
        for(var i = 0; i < checkbox.length; i++){
        	if(checkbox[i].checked)
        		value.push(checkbox[i].value);
        } 
         var ID =value.toString();
         if(ID == "" || ID == null || ID == undefined){
        	 alert("请勾选一条数据！"); 
         }else{
        	 document.getElementById("returnTestButton").click()
        	 //等待提示
        	 showWaiting();
        	 fm.action = fm.action + "D_ID="+ID+"&D_TUSER="+D_TUSER+"&TIME="+TIME+"&REASON="+REASON;
        	 return true;
         }
     }
    
    //驳回操作的返回结果
    var errori ='<%=request.getParameter("ReturnAnswer")%>';
    if(errori=='yes'){
     alert("驳回操作完成，已邮件通知开发人员！为保证沟通的及时性，建议同时通过其他方式通知开发。");
     window.location.href="<%=path%>/selectBanBenServlet?type=1";
    }else if(errori=='no'){
     alert("驳回操作失败，请联系管理员！");
     window.location.href="<%=path%>/selectBanBenServlet?type=1";
    }    

    //测试通过
    function EndTest(fm){
        var D_TUSER=document.endBBTestForm.D_TUSER.value;
        var TIME=document.endBBTestForm.TIME.value;
        var REASON=document.endBBTestForm.REASON.value;
        var checkbox = document.getElementsByName('checkboxBtn');
        var value = new Array();
        for(var i = 0; i < checkbox.length; i++){
        	if(checkbox[i].checked)
        		value.push(checkbox[i].value);
        } 
         var ID =value.toString();
         if(ID == "" || ID == null || ID == undefined){
        	 alert("请勾选一条数据！"); 
         }else{
        	 document.getElementById("endTestButton").click()
        	 //等待提示
        	 showWaiting();
        	 fm.action = fm.action + "D_ID="+ID+"&D_TUSER="+D_TUSER+"&TIME="+TIME+"&REASON="+REASON;
        	 return true;
         }
     }
    
    //测试通过的返回结果
    var errori ='<%=request.getParameter("EndAnswer")%>';
    if(errori=='yes'){
     alert("此版本已测试通过！测试结束。");
     window.location.href="<%=path%>/selectBanBenServlet?type=1";
    }else if(errori=='no'){
     alert("操作失败，请联系管理员！");
     window.location.href="<%=path%>/selectBanBenServlet?type=1";
    } 
    
	//查询提交
	function submitSelect(){
        //等待提示
        showWaiting();
        window.location.href="<%=path%>/selectBanBenServlet?type=1";
        $(document).ready(parent.closeWaiting());
    }

	//选择部门时触发查询提交
	function submitSelBumen(){
		var form = document.getElementById("submitSelectFrom");
		//等待提示
        showWaiting();
		form.submit();//form表单提交
		$(document).ready(parent.closeWaiting());
    }
	
	//重置查询条件后查询
	function resetSelect(){
		var form = document.getElementById("submitSelectFrom").reset();
		//等待提示
		submitSelect();
    }
	
	
</script>

		
		
<body onload="valiButt()">


<form action="<%=path %>/selectBanBenServlet?type=1"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>
     
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="45" background="images/nav04.gif">
            
		   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		      
			 <%
			 
			 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			 String time=df.format(new Date());// new Date()为获取当前系统时间
			 String ExcelName = "版本测试汇总"+time;
			 %>
			   <td width="40%" align="left" >
			    <button onclick="BBLog()">操作日志</button>
			    <button onclick="BBState()">修改</button>
			    <button href = "javascript:void(0)" onclick = "document.getElementById('startTest').style.display='block'">开始测试</button>
			    	<div style="font-size:18px;font-weight:bold;" id="startTest" class="white_content">
			    		<form  method="post"  id="StartBBTestForm">
        					【测试人】：<input  type="text" name="D_TUSER" style="background-color:#e8e8e8" readonly value="<%=username%>"><br/><br/>
        					【开始测试时间】：<input type="text" name="TIME" style="background-color:#e8e8e8" value="<%=time %>" readonly="readonly"><br/><br/>
        					<button style="display: block;" onclick='StartTest()'>提交</button>
        				</form>
						<button onclick = "document.getElementById('startTest').style.display='none'" id="startTestButton">关闭</button>
					</div>

			    <button href = "javascript:void(0)" onclick = "document.getElementById('returnTest').style.display='block'" style="color:#ffe000">不通过</button>
			    	<div style="font-size:18px;font-weight:bold;" id="returnTest" class="white_content">
			    		<form  action="<%=path %>/ReturnBBTestServlet?" onsubmit="return ReturnTest(this)"method="post"  name="returnBBTestForm" id="returnBBTestForm" enctype="multipart/form-data">
        					【 测 试 人】：<input  type="text" name="D_TUSER" style="background-color:#e8e8e8" readonly value="<%=username%>"><br/><br/>
        					【NG时间】：<input type="text" name="TIME" style="background-color:#e8e8e8" value="<%=time %>" readonly="readonly"><br/><br/>
        					【NG原因】：<textarea type="text" name="REASON" required="required" style="margin: 0px; width: 356px; height: 131px;"></textarea><br/><br/>
        					【测试结果附件】：<input name="file" type="file" class="text"><br/><br/>
        					<input type="submit" value="提交" style="background:#3498db;background-image:linear-gradient(to bottom, #3498db, #2980b9);font-family:微软雅黑;color:#ffffff;padding:2px 8px 4px 11px;text-decoration:none;border-radius:28px;font-size:14px">
        				</form>
						<button onclick = "document.getElementById('returnTest').style.display='none'" id="returnTestButton">关闭</button>
					</div>
					
			    <button href = "javascript:void(0)" onclick = "document.getElementById('endTest').style.display='block'" style="color:#00ff5a">通过</button>
			    	<div style="font-size:18px;font-weight:bold;" id="endTest" class="white_content">
			    		<form  action="<%=path %>/EndBBTestServlet?" onsubmit="return EndTest(this)" method="post"  name="endBBTestForm" id="endBBTestForm" enctype="multipart/form-data">
        					【 测 试 人】：<input  type="text" name="D_TUSER" style="background-color:#e8e8e8" readonly value="<%=username%>"><br/><br/>
        					【通过时间】：<input type="text" name="TIME" style="background-color:#e8e8e8" value="<%=time %>" readonly="readonly"><br/><br/>
        					【备注/遗留】：<textarea type="text" name="REASON" required="required" style="margin: 0px; width: 356px; height: 131px;"></textarea><br/><br/>
        					【测试结果附件】：<input name="file" type="file" class="text"><br/><br/>
        					<input type="submit" value="提交" style="background:#3498db;background-image:linear-gradient(to bottom, #3498db, #2980b9);font-family:微软雅黑;color:#ffffff;padding:2px 8px 4px 11px;text-decoration:none;border-radius:28px;font-size:14px">
        				</form>
						<button onclick = "document.getElementById('endTest').style.display='none'" id="endTestButton">关闭</button>
					</div>
			   <button href = "javascript:void(0)"  onclick="tableToExcel('tableAll','<%=ExcelName %>');">导出</button>
			  
           
            </td>
			  <!-- <td align="right"><input style="font-size:15px;font-weight:bold;width:80px" size="12" type="button" value="显示全部" onclick="window.location.href='<%=path %>/'"></td>  -->
		    </tr>
		
          </table></td>
          
          <!-- 高级查询区域 -->
          <td height="45" background="images/nav04.gif" style="width:60%;" align="right">
			 <form name="MyPageForm" method="post"  id="submitSelectFrom"  onsubmit="submitSelect()">
						部门：
					<select name="selBumen" style="width:231px" onchange="submitSelBumen()">
					<option id="MRbumen"></option>
					<option>全部</option>
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
						微服务：
					<select name="selWeifw" style="width:170px">
					<option id="MRwei"></option>
					<option>全部</option>
					<%
                      if(pageBean3!=null){
                       List<Map<String, String>>  resList=  pageBean3.getResList();
                       if(resList!=null && resList.size()>0){                          		
                          for(int i=0;i<resList.size();i++){
                          Map<String, String>  stuMap= resList.get(i);	  
                          %>    
					<option  value="<%=stuMap.get("W_NAME") %>"><%=stuMap.get("W_NAME") %></option>
					<%     
                          }                        	  
                       }
                      }
                        %>
					</select><br>
						月份：
						<select style="high:150;font-weight:bold;width:80px" name="selMonth"  id="selMonth">
						 <option id="MRmonth"></option>
						 <option style="font-size:13px;"value="全部"> &nbsp;&nbsp;全部 &nbsp;&nbsp;</option>                          
					     <option style="font-size:13px;" value="01"> &nbsp;&nbsp;一月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="02"> &nbsp;&nbsp;二月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="03"> &nbsp;&nbsp;三月&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="04"> &nbsp;&nbsp;四月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="05"> &nbsp;&nbsp;五月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="06"> &nbsp;&nbsp;六月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="07"> &nbsp;&nbsp;七月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="08"> &nbsp;&nbsp;八月&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="09"> &nbsp;&nbsp;九月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="10"> &nbsp;&nbsp;十月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="11"> &nbsp;&nbsp;十一月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="12"> &nbsp;&nbsp;十二月 &nbsp;&nbsp;</option>
					     </select>
					            版本号：<input style="width:100px" name="selVersion" id='MRversion' type="text" size="12"/>
					            状态：
					     <select style="high:150;font-weight:bold;width:80px" name="selState"  id="selState">
						 <option id="MRstate"></option>
						 <option style="font-size:13px;"value="全部"> &nbsp;&nbsp;全部 &nbsp;&nbsp;</option>                              
					     <option style="font-size:13px;" value="0"> &nbsp;&nbsp;待测试 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="1"> &nbsp;&nbsp;正在测试 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="2"> &nbsp;&nbsp;NG&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="3"> &nbsp;&nbsp;OK&nbsp;&nbsp;</option>
					     </select>      
						<input type="submit" value="查询" style="font-size:15px;font-weight:bold"/>
						<input type="button" value="重置" style="font-size:15px;font-weight:bold" onclick="resetSelect()"/>
			 </form>
		</td>
		<td height="45" background="images/nav04.gif" style="width:1%;"></td>
        </tr>
        
    </table> 
<!-- 右侧滚动条 -->
<div style="width:100%;height:85%;overflow: scroll;">
          <table width="3500px" border="0" align="left" cellpadding="0" cellspacing="0" id="tableAll">

              <tr>
                <td height="40" class="font42">
				<table id = "testList" width="3500px" height="100px" border="2" cellpadding="0" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tbody>
				 <tr class="CTitle" >
                    	<td id="div_title" height="28" colspan="24" align="center" style="font-size:16px">版 本 测 试 汇 总</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center"  style="line-height:22px;height:22px;">
                  <!--  <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td>-->
                    <td  style="font-size:15px;font-weight:bold"></td>
                    <td  style="font-size:15px;font-weight:bold">编号</td>
                    <td  style="font-size:15px;font-weight:bold">部门</td>
                    <td  style="font-size:15px;font-weight:bold">微服务</td>
                    <td  style="font-size:15px;font-weight:bold">版本号</td>                   
                    <td  style="font-size:15px;font-weight:bold">月份</td>
                    <td  style="font-size:15px;font-weight:bold">日期 </td>
                    <td  style="font-size:15px;font-weight:bold">状态</td>
                    <td  style="font-size:15px;font-weight:bold">紧急程度</td>                    
                    <td  style="font-size:15px;font-weight:bold">带脚本</td>
                    <td  style="font-size:15px;font-weight:bold">带配置</td>
                    <td  style="font-size:15px;font-weight:bold">发江西</td>
                    <td  style="font-size:15px;font-weight:bold">压测环境</td>
                    <td  style="font-size:15px;font-weight:bold">yth2020</td>
                    <td  style="font-size:15px;font-weight:bold">jxpre更新</td>
                    <td  style="font-size:15px;font-weight:bold">研发人</td>
                    <td  style="font-size:15px;font-weight:bold">测试人</td>
                    <td  style="font-size:15px;font-weight:bold">提交日期</td>
                    <td  style="font-size:15px;font-weight:bold">版本内容</td>
                    <td  style="font-size:15px;font-weight:bold">测试通过标准</td>
                    <td  style="font-size:15px;font-weight:bold">构造内容附件</td>
                    <td  style="font-size:15px;font-weight:bold">SQL脚本附件</td>
                    <td  style="font-size:15px;font-weight:bold">配置文件附件</td>
                    <td  style="font-size:15px;font-weight:bold">测试结果附件</td>
                    <!--  <td style="font-size:15px;font-weight:bold">费用支出部门</td>-->
                  </tr>
                  </tbody>

				  <tbody>

                        <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean.getResList();
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                          		//传递学生信息
                          		
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
                            	   
                            	   String state = stuMap.get("D_STATE");
                            	   int lunci = Integer.parseInt(stuMap.get("D_NG"))+1;
                            	   String Color= null;
                            	   
                            	  if(state.equals("0")){
                            		  state ="待测试";
                            		  Color ="black";
                            	  }else if(state.equals("1")){
                            		  state ="正在测试";
                            		  Color ="blue";
                            	  }else if(state.equals("2")){
                            		  state ="NG";
                            		  Color ="red";
                            	  }else if(state.equals("3")){
                            		  state ="OK";
                            		  Color ="green";
                            	  }else{
                            		  state ="未知";
                            	  }
                            	  
                            	  String Olddate = stuMap.get("D_DATE");
                            	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            	  Date date = sdf.parse(Olddate);
                                  Calendar calendar = Calendar.getInstance();
                                  calendar.setTime(date);
                                  int month=calendar.get(Calendar.MONTH)+1;
                                  int day=calendar.get(Calendar.DAY_OF_MONTH);
                                  String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
                                  
                                  //是否带脚本
                                  String D_ISSQL = stuMap.get("D_ISSQL");
                                  if(D_ISSQL.equals("0")){
                                	  D_ISSQL="否";
                                  }else if(D_ISSQL.equals("1")){
                                	  D_ISSQL="是";
                                  }else{
                                	  D_ISSQL ="未知";
                            	  }
                                  //是否有配置文件
                                  String D_ISCONFIG = stuMap.get("D_ISCONFIG");
                                  if(D_ISCONFIG.equals("0")){
                                	  D_ISCONFIG="否";
                                  }else if(D_ISCONFIG.equals("1")){
                                	  D_ISCONFIG="是";
                                  }else{
                                	  D_ISCONFIG ="未知";
                            	  }
                                  //是否发江西
                                  String D_ISJXXC = stuMap.get("D_ISJXXC");
                                  if(D_ISJXXC.equals("0")){
                                	  D_ISJXXC="";
                                  }else if(D_ISJXXC.equals("1")){
                                	  D_ISJXXC="已发";
                                  }else{
                                	  D_ISJXXC ="未知";
                            	  }
                                  //是否更新压测环境
                                  String D_ISYCHJ = stuMap.get("D_ISYCHJ");
                                  if(D_ISYCHJ.equals("0")){
                                	  D_ISYCHJ="";
                                  }else if(D_ISYCHJ.equals("1")){
                                	  D_ISYCHJ="已更新";
                                  }else{
                                	  D_ISYCHJ ="未知";
                            	  }
                                  //是否更新yth2020环境
                                  String D_ISYTH2020 = stuMap.get("D_ISYTH2020");
                                  if(D_ISYTH2020.equals("0")){
                                	  D_ISYTH2020="";
                                  }else if(D_ISYTH2020.equals("1")){
                                	  D_ISYTH2020="已更新";
                                  }else{
                                	  D_ISYTH2020 ="未知";
                            	  }
                                  //是否更新jxpre环境
                                  String D_ISJXPRE = stuMap.get("D_ISJXPRE");
                                  if(D_ISJXPRE.equals("0")){
                                	  D_ISJXPRE="";
                                  }else if(D_ISJXPRE.equals("1")){
                                	  D_ISJXPRE="已更新";
                                  }else{
                                	  D_ISJXPRE ="未知";
                            	  }
                                  //是否紧急
                                  String D_JINJI = stuMap.get("D_JINJI");
                                  if(D_JINJI.equals("1")){
                                	  D_JINJI="紧急";
                                  }else{
                                	  D_JINJI ="非紧急";
                            	  }
                          %>

                          <tr align="center" style="line-height:20px;height:20px;">
                          	<!--  <td style="font-size:15px" height="28" class="bor_2"><input name='isBuy' type='checkbox' value='<%=i+1 %>'  /></td>-->
                          	<td  width=50px class="bor_2">
                          	<input type="checkbox" value="<%=stuMap.get("D_ID") %>" name="checkboxBtn"/><br />
                          	</td>
                          	<td  width=50px class="bor_2" style="font-size:13px;text-align:center;font-weight:bold;height:2px;line-height:30px;"> <%=i+1 %> </td>
                            <td  width=170px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_BUMEN") %></td>
                            <td  width=170px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_WEINAME") %></td>
                            <td  width=200px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_VERSION") %></td>
                            <td  width=80px class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=month %></td>
                            <td  width=80px class="bor_2" style="font-size:11px;text-align:center;font-weight:bold"><%=day %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><font color="<%=Color %>"><%=state %></font></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_JINJI %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_ISSQL %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_ISCONFIG %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_ISJXXC %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_ISYCHJ %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_ISYTH2020 %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=D_ISJXPRE %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_KAIFA") %></td>
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_TUSER") %></td>
                            <td  width=200px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_DATE") %></td>
   							<td  width=600px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_CONTENT") %></td>
   							<td  width=400px class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_BIAOZHUN") %></td>
   							<td  width=200px class="bor_2" style="font-size:13px;text-align:center;">
   							<a href="<%=serviceRoot %>youzhishi/DownloadPDF.jsp?ATTACH_NAME=<%=stuMap.get("D_WIKI") %>" target="_blank">
   							<%=stuMap.get("D_WIKI") %>
   							</a>
   							</td>
   							<td  width=200px class="bor_2" style="font-size:13px;text-align:center;">
   							<a href="<%=serviceRoot %>youzhishi/DownloadPDF.jsp?ATTACH_NAME=<%=stuMap.get("D_SQL") %>" target="_blank">
   							<%=stuMap.get("D_SQL") %>
   							</a>
   							</td>
   							<td  width=200px class="bor_2" style="font-size:13px;text-align:center;">
   							<a href="<%=serviceRoot %>youzhishi/DownloadPDF.jsp?ATTACH_NAME=<%=stuMap.get("D_CONFIG") %>" target="_blank">
   							<%=stuMap.get("D_CONFIG") %>
   							</a>
   							</td>
   							<td  width=200px class="bor_2" style="font-size:13px;text-align:center;">
   							<a href="<%=serviceRoot %>youzhishi/DownloadPDF.jsp?ATTACH_NAME=<%=stuMap.get("D_REASON_FILE") %>" target="_blank">
   							<%=stuMap.get("D_REASON_FILE") %>
   							</a>
   							</td>
   							<!-- 
                            <td  width=100px class="bor_2" style="font-size:13px;text-align:center;font-weight:bold">
                            <button href = "javascript:void(0)" onclick = "document.getElementById('light<%=i+1 %>').style.display='block';document.getElementById('fade').style.display='block'">详情</button>
                            <div id="light<%=i+1 %>" style="font-size:14px;text-align:left;" class="white_content">
        					【部门】：<%=stuMap.get("D_BUMEN") %><br/>
        					【开发】：<%=stuMap.get("D_KAIFA") %><br/>
        					【提交日期】：<%=stuMap.get("D_DATE") %><br/>
        					【微服务】：<%=stuMap.get("D_WEINAME") %><br/>
        					【版本号】：<%=stuMap.get("D_VERSION") %><br/>
        					【版本内容】：<%=stuMap.get("D_CONTENT") %><br/>
        				          【测试通过标准】：<%=stuMap.get("D_BIAOZHUN") %><br/>
        				          【wiki地址】：<a href="<%=stuMap.get("D_WIKI") %>" target="_blank"><%=stuMap.get("D_WIKI") %></a><br/>
        				          【状态】：<%=state %><br/>    
        					【重新提交路径】：<a href="<%=stuMap.get("D_SUBURL") %>" target="_blank"><%=stuMap.get("D_SUBURL") %></a><br/>
        					<br/>  
							<button href = "javascript:void(0)" onclick = "document.getElementById('light<%=i+1 %>').style.display='none';document.getElementById('fade').style.display='none'">关闭</button>
							</div>
                            </td>
 							-->
                        </tr>
                          <%     
              
                               }
                        	  
                           } 
                          }
                   
                        
                        %>
                         
                    </tbody>

      </table></td>
  </tr>
</table>
</div>
  </body>
<script language="javascript">
var selBumen ='<%=request.getAttribute("selBumen")%>';
document.getElementById('MRbumen').innerHTML = selBumen;
var selWeifw ='<%=request.getAttribute("selWeifw")%>';
document.getElementById('MRwei').innerHTML = selWeifw;
var selMonth ='<%=request.getAttribute("selMonth")%>';
document.getElementById('MRmonth').innerHTML = selMonth;
var selVersion ='<%=request.getAttribute("selVersion")%>';
document.getElementById('MRversion').innerHTML = selVersion;
var selState ='<%=request.getAttribute("selState")%>';
document.getElementById('MRstate').innerHTML = selState;

//关闭等待窗口
  function closeWaiting() {
      var bgDiv = document.getElementById("bgDiv");
      var msgDiv = document.getElementById("msgDiv");
      //移除背景遮罩层div
      if(bgDiv != null){
          document.body.removeChild(bgDiv);
      }
      //移除中间信息提示层div    
      if(msgDiv != null){
          document.body.removeChild(msgDiv);
      }
  }
  //显示等待窗口
  function showWaiting() {
      var msgw, msgh, bordercolor;
      msgw = 300; //提示窗口的宽度 
      msgh = 100; //提示窗口的高度 
      bordercolor = "#336699"; //提示窗口的边框颜色 
      titlecolor = "#99CCFF"; //提示窗口的标题颜色 

      var sWidth, sHeight;
      sWidth = document.body.clientWidth;
      sHeight = document.body.clientHeight;

      //背景遮罩层div
      var bgObj = document.createElement("div");
      bgObj.setAttribute('id', 'bgDiv');
      bgObj.style.position = "absolute";
      bgObj.style.top = "0px";
      bgObj.style.background = "#888";
      bgObj.style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
      bgObj.style.opacity = "0.6";
      bgObj.style.left = "0px";
      bgObj.style.width = sWidth + "px";
      bgObj.style.height = sHeight + "px";
      document.body.appendChild(bgObj);
      
      //信息提示层div
      var msgObj = document.createElement("div");
      msgObj.setAttribute("id", "msgDiv");
      msgObj.setAttribute("align", "center");
      msgObj.style.position = "absolute";
      msgObj.style.background = "white";
      msgObj.style.font = "12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
      msgObj.style.border = "1px solid " + bordercolor;
      msgObj.style.width = msgw + "px";
      msgObj.style.height = msgh + "px";
      msgObj.style.top = (document.documentElement.scrollTop + (sHeight - msgh) / 2) + "px";
      msgObj.style.left = (sWidth - msgw) / 2 + "px";
      document.body.appendChild(msgObj);
      
      //标题栏
      var title = document.createElement("h4");
      title.setAttribute("id", "msgTitle");
      title.setAttribute("align", "left");
      title.style.margin = "0px";
      title.style.padding = "3px";
      title.style.background = bordercolor;
      title.style.filter = "progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
      title.style.opacity = "0.75";
      title.style.border = "1px solid " + bordercolor;
      title.style.height = "14px";
      title.style.font = "12px Verdana, Geneva, Arial, Helvetica, sans-serif";
      title.style.color = "white";
      title.innerHTML = "正在加载中，请稍候......";
      document.getElementById("msgDiv").appendChild(title);
      
      //中间等待图标
      var img = document.createElement("img");
      img.style.margin = "10px 0px 10px 0px";
      img.style.width = "48px";
      img.style.height = "48px";
      img.setAttribute("src", "./img/waiting.gif");
      document.getElementById("msgDiv").appendChild(img);
  }
</script>
</html>
