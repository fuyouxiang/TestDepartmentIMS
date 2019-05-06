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
		
		 function checkUserName(){   
		 var username=document.getElementById("danwei").value;       
		 var content=document.getElementById("username_prompt");   
		 content.innerHTML="";   
		 if(username!=""){     
		 content.innerHTML="输入的单位正确";     
		 return true;   
		 }   else{     
		 content.innerHTML="单位名称不能为空";     
		 return false;   } 
		 }
		 
		 
		</script>



<body onload="valiButt()">
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">  
<form action="<%=path %>/selectSignServlet2"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		   
		    <tr>		      
			  
			  <td width="538"  align="left" style="font-size:15px">
			  <form action="selectSignServlet2" name="MyPageForm" method="post"  id =formId id ="pageForm" onsubmit="return submitMyForm()">
						
						<img src="images/ico07.gif" width="18" height="15" />						
						<!-- <b>查询方式：</b> -->
						日期:<input style="width:120px" name="start_date" type="text" size="12" class="Wdate" onFocus="WdatePicker({lang:'zh-cn'})" value="<%=session.getAttribute("start_date") %>"/>
						至<input name="end_date" type="text" size="12" class="Wdate" onFocus="WdatePicker({lang:'zh-cn'})" value="<%=session.getAttribute("end_date") %>"/> 	 
						
						姓名：<input style="width:120px" name="S_NAME" type="text" size="12" value="<%=session.getAttribute("s_name") %>"/>
						
						<input type="submit" value="查询" style="font-size:15px;font-weight:bold"/>
						
			  
			  </form>
			</td>
			   <td width="144" align="left"></td>	
		    </tr>
		
          </table></td>
        </tr>
    </table>
   </form>
   
       
          <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          	 <tr>
               <td height="10">
	              </td>
          	 </tr>
              <tr>
                <td height="40" class="font42">
				<table width="100%" border="2" cellpadding="4" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td height="22" colspan="10" align="center" style="font-size:19px"><b>签到表汇总</b></td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <td height="40" class="bor_1"><input type="checkbox" /></td>
                    <td style="font-size:15px"><b>用户编号</b></td>
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
                          	<td style="font-size:15px" height="28" class="bor_2"><input type="checkbox" /></td>
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
							<span><img  src="<%=path %>/images/del.gif" width="16" height="16" onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteSignServlet?id=<%=stuMap.get("S_ID") %>'}"/>删除</span></td>
							
                        </tr>
                        		
                          <%     
              
                               }
                        	  
                           }
                        %>
                    <tr>
					<th colspan="8">
						<input type="button" value="首页" id="fp" onclick="goPage(this)" />
						<input type="button" value="上一页" id="bp" onclick="goPage(this)" />
						<%=pageBean.getNowPage()%>/<%=pageBean.getPages()%>
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
