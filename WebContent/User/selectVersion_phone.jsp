<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'listrenwu.jsp' starting page</title>
    <style type="text/css">
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" type="text/css" href="styles.css">
		<!-- 适配手机端 -->
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no;"> 
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">


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
.button {
	font-family: "宋体";
	font-size: 14px;
	height: 37px;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 
-->
</style>
<link href="css/css.css" rel="stylesheet" type="text/css" />

<link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript"> 
var idTmr = ""; 
function killExcelProcess(appExcel_){ 
appExcel_.Quit(); 
appExcel_ = null; 
idTmr = window.setInterval("Cleanup();",1); 
} 

//导出到excel，参数tableid为JSP页面需要导出的table的id，需要更改IE的安全设置，ActiveX都打开，如果还是不能使用，再服务端运行“regsvr32 scrrun.dll” 
function exportToExcel(tableid,notitleandsearch){ 
try { 
clipboardData.setData('Text',''); 
var appExcel = new ActiveXObject("Excel.Application"); 

killExcelProcess(appExcel); 
appExcel.workbooks.add; 

//标题 
if (notitleandsearch==null||notitleandsearch==false){ 
var elTable = document.getElementById('div_title'); 
var oRangeRef = document.body.createTextRange(); 
oRangeRef.moveToElementText(elTable); 
oRangeRef.execCommand( "Copy" ); 
appExcel.ActiveSheet.Cells(1,3).select(); 
appExcel.ActiveSheet.Paste(); 

clipboardData.setData('Text',''); 
appExcel.ActiveSheet.Cells(2,1).select(); 
appExcel.ActiveSheet.Paste(); 
} 

var elTable1 = document.getElementById(tableid); 
var oRangeRef1 = document.body.createTextRange(); 
oRangeRef1.moveToElementText(elTable1); 
oRangeRef1.execCommand( "Copy" ); 

appExcel.WorkSheets(1).Activate; 
if (notitleandsearch==null||notitleandsearch==false){ 
appExcel.ActiveSheet.Cells(1,1).select(); 
}else{ 
appExcel.ActiveSheet.Cells(1,1).select(); 
} 
appExcel.WorkSheets(1).Activate; 
appExcel.ActiveSheet.Paste(); 
appExcel.Visible = true; 

} catch(e) { 
alert("请使用IE浏览器，并正Internet选项——安全——自定义级别设置 中，将ActiveX全都设为启用！"); 
return false; 
} 
clipboardData.setData('text',''); 
} 
</script>
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
		</script>



<body onload="valiButt()">
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">
<form action="<%=path %>/selectVersionServlet_Phone"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>  
       
          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">

              <tr>
                <td height="40" class="font42">
				<table id = "testList" width="100%" border="2" cellpadding="0" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td id="div_title" height="32" colspan="13" align="center" style="font-size:16px">工作情况表</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!--  <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td>-->
                    <td  style="font-size:15px;font-weight:bold">编号</td>
                    <td  style="font-size:15px;font-weight:bold">月份</td>
                    <td  style="font-size:15px;font-weight:bold">日期</td>
                    <td  style="font-size:15px;font-weight:bold">星期</td>
                    <td  style="font-size:15px;font-weight:bold">基础工作</td>
                    <td  style="font-size:15px;font-weight:bold">工作内容 </td>
                    <td  style="font-size:15px;font-weight:bold">工作类型</td>
                    <td  style="font-size:15px;font-weight:bold">测试人员</td>
                    <td  style="font-size:15px;font-weight:bold">BUG产出</td>
                    <td  style="font-size:15px;font-weight:bold">文档编辑</td>
                    <td  style="font-size:15px;font-weight:bold">用例产出</td>
                    <td  style="font-size:15px;font-weight:bold">工时</td>
                    <!--  <td style="font-size:15px;font-weight:bold">费用支出部门</td>-->
                    <td style="font-size:15px;font-weight:bold">操作</td>
                  </tr>
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
                            	  
                          %>

                          <tr align="center">
                          	<!--  <td style="font-size:15px" height="28" class="bor_2"><input name='isBuy' type='checkbox' value='<%=i+1 %>'  /></td>-->
                          	<td  class="bor_2" style="font-size:15px;text-align:center;font-weight:bold;height:2px;line-height:38px;"> <%=i+1 %> </td>
                            <td  width=50 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_MONTH") %>月</td>
                            <td  width=50 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("SUBSTR(V_DATE,9,2)") %></td>
                            <td  width=50 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_WEEK") %></td>
                            <td  width=250 class="bor_2" style="font-size:15px;text-align:center;"><%=stuMap.get("V_BASICS") %></td>
                            <td  width=6450 class="bor_2" style="font-size:15px;text-align:center;"> <%=stuMap.get("V_WORK") %></td>
                            <!--  <textarea rows=2 cols=27px class="text" style="font-size:15px;text-align:center;" readonly="readonly"><%=stuMap.get("V_WORK") %></textarea>-->
                            <td  width=100 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_TYPE") %></td>
                            <td   width=80 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_NAME") %></td>
                            <td  width=60 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_BUG") %></td>
                            <td  width=60 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_DOCUMENT") %></td>
                            <td  width=60 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_CASE") %></td>
                            <td  width=60 class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("V_TIME") %> H</td>
                            
							<td  width=120 class="bor_2 bor_4" style="font-size:15px;text-align:center;font-weight:bold"> 
							

							<button onClick="location.href='<%=path %>/updateOneVersion_Phone?id=<%=stuMap.get("V_ID") %>'">修改</button>
							<button onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteVersionServlet_Phone?id=<%=stuMap.get("V_ID") %>&name=<%=stuMap.get("V_NAME") %>&bug=<%=stuMap.get("V_BUG") %>&document=<%=stuMap.get("V_DOCUMENT") %>&case1=<%=stuMap.get("V_CASE") %>'}">删除</button></td>

                        </tr>
                        		
                          <%     
              
                               }
                        	  
                           }
                        %>
                         
                     <tr>
					<th colspan="13">
						<input type="button" value="首页" id="fp" onclick="goPage(this)" />
						<input type="button" value="上一页" id="bp" onclick="goPage(this)" />
						第<%=pageBean.getNowPage()%>页/共<%=pageBean.getPages()%>页
						<input type="button" value="下一页" id="gp" onclick="goPage(this)" />
						<input type="button" value="尾页" id="lp" onclick="goPage(this)" />
					</th>
				</tr>
	      
	      
	      
                        <%  
                          }
                   
                        
                        %>
                         
                    </tbody>

      </table></td>
  </tr>
</table>
</div>
  </body>
</html>
