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
<form action="<%=path %>/selectTestServlet2"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		    <td width="538"  align="center" style="font-size:15px">
			  <form action="selectPersonServlet2" name="MyPageForm" method="post"  id =formId id ="pageForm" onsubmit="return submitMyForm()">
						
						<img src="images/ico07.gif" width="18" height="15" />						
						<!--<b>查询：</b>  -->
						员工姓名：<input style="width:100px" name="NAME" type="text" size="12"/>
						年度：
<% 
    Calendar calendar=Calendar.getInstance(); 
    int year=calendar.get(Calendar.YEAR); 
 %> 
						<select style="high:150;font-weight:bold;" name="YEAR"  id="YEAR">
					     <option style="font-size:13px;" value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
					     <option style="font-size:13px;" value="<%=year %>"> &nbsp;&nbsp;<%=year %>&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="<%=year-1 %>"> &nbsp;&nbsp;<%=year-1 %>&nbsp;&nbsp;</option>
					     </select>
					            月份：
						<select style="high:150;font-weight:bold;" name="MONTH"  id="MONTH">
					     <option style="font-size:13px;" value=""> &nbsp;&nbsp;&nbsp;&nbsp;</option>                                
					     <option style="font-size:13px;" value="1"> &nbsp;&nbsp;一月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="2"> &nbsp;&nbsp;二月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="3"> &nbsp;&nbsp;三月&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="4"> &nbsp;&nbsp;四月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="5"> &nbsp;&nbsp;五月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="6"> &nbsp;&nbsp;六月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="7"> &nbsp;&nbsp;七月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="8"> &nbsp;&nbsp;八月&nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="9"> &nbsp;&nbsp;九月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="10"> &nbsp;&nbsp;十月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="11"> &nbsp;&nbsp;十一月 &nbsp;&nbsp;</option>
					     <option style="font-size:13px;" value="12"> &nbsp;&nbsp;十二月 &nbsp;&nbsp;</option>
					     </select>
						<input type="submit" value="查询" style="font-size:15px;font-weight:bold"/>
						
			  </form>
			  </td>
           
            
			   <td width="144" align="left"></td>	
		    </tr>
		
          </table></td>
        </tr>
    </table>
   
       
          <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          	 <tr>
               <td height="20">
	              </td>
          	 </tr>
              <tr>
                <td height="40" class="font42">
				<table width="100%" border="2" cellpadding="4" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td height="22" colspan="11" align="center" style="font-size:16px">加班情况表</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td>
                    <td style="font-size:15px;font-weight:bold">编号</td>
                    <td style="font-size:15px;font-weight:bold">姓名</td>
                    <td style="font-size:15px;font-weight:bold">月份</td>
                    <td style="font-size:15px;font-weight:bold"><%=session.getAttribute("YEAR") %>年总用例产出</td>
                    <td style="font-size:15px;font-weight:bold"><%=session.getAttribute("MONTH") %>月加班天数</td>
                    <td style="font-size:15px;font-weight:bold"><%=session.getAttribute("YEAR") %>年总文档产出</td>
                    <td style="font-size:15px;font-weight:bold"><%=session.getAttribute("MONTH") %>月文档产出</td>
                    <td style="font-size:15px;font-weight:bold"<%=session.getAttribute("YEAR") %>>年总BUG产出</td>
                    <td style="font-size:15px;font-weight:bold"><%=session.getAttribute("MONTH") %>月BUG产出</td>
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
                          	<td style="font-size:15px" height="28" class="bor_2"><input name='isBuy' type='checkbox' value='<%=i+1 %>'  /></td>
                          	<td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
                          	<td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=session.getAttribute("NAME") %></td>
                          	<td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=session.getAttribute("MONTH") %>月</td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("NVL(SUM(O.V_CASE),0)")%></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("NVL(SUM(O1.V_CASE),0)")%></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("NVL(SUM(E.V_DOCUMENT),0)")%></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("NVL(SUM(E1.V_DOCUMENT),0)")%></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("NVL(SUM(L.V_BUG),0)")%></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("NVL(SUM(L1.V_BUG),0)")%></td>
                        </tr>
                        		
                          <%     
              
                               }
                        	  
                           }
                        %>
                         
                     <tr>
					<th colspan="11">
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
