<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<HEAD> 
<TITLE>导出Excel</TITLE> 
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
appExcel.ActiveSheet.Cells(3,1).select(); 
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
</HEAD>
<BODY> 
<button onclick="javascript:exportToExcel('testList','');">导出</button><br> 

<div id='div_title' > 
<font color='black' size='4'><strong>导出报表</strong></font> 
</div> 
<table id = "testList" bordercolor="#000000" border = "1"> 
<tr> 
<td>序列</td> 
<td>姓名</td> 
<td>数量</td> 
</tr> 
<tr> 
<td>1</td> 
<td>张三1</td> 
<td>2</td> 
</tr> 
<tr> 
<td>2</td> 
<td>张三2</td> 
<td>2</td> 
</tr> 
<tr> 
<td>3</td> 
<td>张三3</td> 
<td>2</td> 
</tr> 
<tr> 
<td>4</td> 
<td>张三4</td> 
<td>2</td> 
</tr> 
<tr> 
<td>5</td> 
<td>张三5</td> 
<td>2</td> 
</tr> 
<tr> 
<td colspan="2">总计：</td> 
<td>10</td> 
</tr> 

</table> 
</BODY>  
</html>