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
<script type="text/JavaScript" src="<%=path %>/My97DatePicker/WdatePicker.js">
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
					if(checkForm()){
				  		return true;
				  		
					}else{
						alert("无法提交 请核对信息");
						return false;
					}
			   
			  	}
		</script>



<body onload="valiButt()">
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">
<form action="<%=path %>/selectSignServlet"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>

     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		   
		    <tr>		      
			  
			  
			  <td width="538"  align="left" style="font-size:15px">
			  <form action="selectSignServlet2" name="MyPageForm" method="post"  id =formId id ="pageForm" onsubmit="return submitMyForm()">
						
						<img src="images/ico07.gif" width="18" height="15" />						
						<!-- <b>查询方式：</b> -->
						日期:<input style="width:120px" name="start_date" type="text" size="12" class="Wdate" onFocus="WdatePicker({lang:'zh-cn'})"/>
						至<input name="end_date" type="text" size="12" class="Wdate" onFocus="WdatePicker({lang:'zh-cn'})"/> 	 
						
						姓名:<input style="width:120px" name="S_NAME" type="text" size="12"/>
						
						<input type="submit" value="查询" style="font-size:15px;font-weight:bold"/>
						
			  
			  </form>
           </td>
            <td align="right"><input style="font-size:15px;font-weight:bold;width:80px" size="12" type="button" value="分页显示" onclick="window.location.href='<%=path %>/selectSignServlet'"></td>
			  <td width="144" align="right"><button style="font-size:15px;font-weight:bold;width:100px"  onclick="javascript:exportToExcel('testList','');">导出全部</button></td>	
		    </tr>
		
          </table></td>
        </tr>
    </table>
   
       
          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <td height="40" class="font42">
				<table id = "testList" width="100%" border="2" cellpadding="4" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td id="div_title" height="22" colspan="7" align="center" style="font-size:19px"><b>签到表汇总</b></td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!--  <td height="40" class="bor_1"><input type="checkbox"/></td>-->
                    <td style="font-size:15px"><b>编号</b></td>
                    <td style="font-size:15px"><b>员工姓名</b></td>
                    <td style="font-size:15px"><b>签到日期</b></td>
                    <td style="font-size:15px"><b>签到状态</b></td>
                    <td style="font-size:15px"><b>备注</b></td>
                    <td style="font-size:15px"><b>主持人</b></td>
                    <td style="font-size:15px"><b>操作</b></td>
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
                          	<!--  <td style="font-size:15px" height="28" class="bor_2"><input type="checkbox" value=<%=i+1 %>/></td>-->
                          	<td class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
                            <td class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("S_NAME") %></td>
                            <td class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("TO_CHAR(S_DATE,'YYYY-MM-DD')") %></td>
                            <td class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("S_SIGN") %></td>
                            <td class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("S_REMARK") %></td>
                            <td class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("S_HOST") %></td>

							<td class="bor_2 bor_4" style="font-size:13px;text-align:center;font-weight:bold"> 
							<!-- <a href = "<%=path %>/updateOneUser?name=<%=stuMap.get("U_NAME") %>">修改</a>-->
							<!-- 把真正的唯一ID隐藏 -->
							<input type="hidden" name="S_ID" value="<%=stuMap.get("S_ID") %>"/>
							<!--<span><img  src="<%=path %>/images/del.gif" width="16" height="16" onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteSignServlet?id=<%=stuMap.get("S_ID") %>'}"/>删除</span>-->
							<button onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteSignServlet?id=<%=stuMap.get("S_ID") %>'}">删除</button>
							</td>
                        </tr>
                        		
                          <%     
              
                               }
                        	  
                           }
                        %>
                         
	      
	      
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
