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
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
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
	text-decoration: none;
	text-align: center;
}
.font051 {font-family: "宋体";
	font-size: 12px;
	color: #333333;
	text-decoration: none;
	line-height: 20px;
}
.font201 {font-family: "宋体";
	font-size: 12px;
	color: #FF0000;
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
<script type="text/JavaScript">

</script>
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
alert("请确认IE安全设置，ActiveX都启用！"); 
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
<form action="<%=path %>/selectLeaveServlet"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		      
			  <td width="538" align="left" style="font-size:15px">
			    
			  <form action="<%=path %>/selectLeaveServlet2" name="MyPageForm" method="post"  id =formId id ="pageForm" onsubmit="return submitMyForm()">
						<img src="images/ico07.gif" width="18" height="15" />
						<!-- 
						年度：
<% 
    Calendar calendar=Calendar.getInstance(); 
    int year=calendar.get(Calendar.YEAR); 
 %> 
						<select style="high:150;font-weight:bold;" name="YEAR"  id="YEAR">
						<option style="font-size:13px;" value="<%=year %>"> &nbsp;&nbsp;<%=year %>&nbsp;&nbsp;</option>                            
					     <option style="font-size:13px;" value="<%=year-1 %>"> &nbsp;&nbsp;<%=year-1 %>&nbsp;&nbsp;</option>
					     </select> -->
						月份：
						<select style="high:150;font-weight:bold;" name="MONTH"  id="MONTH">
					     <option style="font-size:13px;" value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
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
						<input type="submit" value="查询" style="font-size:15px;font-weight:bold"/>
			  </form>
			  
           
            </td>
			  <td align="right"><input style="font-size:15px;font-weight:bold;width:80px" size="12" type="button" value="显示全部" onclick="window.location.href='<%=path %>/selectAllLeaveServlet'"></td>
			  <td width="144" align="left"><button style="font-size:15px;font-weight:bold;width:100px"  onclick="javascript:exportToExcel('testList','');">导出当前页</button></td>	
		
		    </tr>
		
          </table></td>
        </tr>
    </table>
   
       
          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">

              <tr>
                <td height="40" class="font42">
				<table id = "testList" width="100%" border="2" cellpadding="4" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td id="div_title" height="22" colspan="6" align="center" style="font-size:16px">请假情况表</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!-- <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td> -->
                    <td style="font-size:15px;font-weight:bold">编号</td>
                    <td style="font-size:15px;font-weight:bold">员工姓名</td>
                    <td style="font-size:15px;font-weight:bold">月份</td>
                    <td style="font-size:15px;font-weight:bold">请假日期</td>
                    <td style="font-size:15px;font-weight:bold">请假天数</td>
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
                          	<td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("L_NAME") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("L_MONTH") %>月</td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("L_DATE") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("L_TIME") %>人/天</td>
							<td class="bor_2 bor_4" style="font-size:15px;text-align:center;font-weight:bold"> 
							<input type="hidden" name="L_ID" value="<%=stuMap.get("L_ID") %>"/>
							<%-- <input name="Submit" type="submit"  value="修改"  onclick = "updateStu(<%=stuMap.get("S_ID") %>"/> --%>  
							<!--<span><img  src="<%=path %>/images/del.gif" width="16" height="16" onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteLeaveServlet?id=<%=stuMap.get("L_ID") %>&name=<%=stuMap.get("L_NAME") %>&time=<%=stuMap.get("L_TIME") %>'}"/>删除</span>-->
							<button onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteLeaveServlet?id=<%=stuMap.get("L_ID") %>&name=<%=stuMap.get("L_NAME") %>&time=<%=stuMap.get("L_TIME") %>'}">删除</button></td>
                        </tr>
                        		
                          <%     
              
                               }
                        	  
                           }
                        %>
                         
                     <tr>
					<th colspan="6">
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
