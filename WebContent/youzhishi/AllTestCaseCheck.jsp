<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*" pageEncoding="UTF-8"%>
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
    
    <title>全部文档</title>
    <style type="text/css">
    
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</style>  
<link href="css/css.css" rel="stylesheet" type="text/css" />
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
			
			function gradeChange(){
				document.getElementById("selectForm").submit();
		       }
		</script>
<body onload="valiButt()">
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		      
			  <td width="1">
			  <!-- 
        	 	<a href="index_youzhishi.jsp">
   				 <button class="button2">前往文档管理系统</button>
				</a>
				 -->
				 <td>

				 </td>
            </td>
            <td style="font-size:13px;">
            <form action="<%=path %>/selectMouTestCaseServlet" name="selectForm" method="post" id ="selectForm">
				<select style="width:150px;height:20px;color:blue;font-weight:bold;font-size:14px;" name="TC_RESULT"  id="TC_RESULT" > 
				<option value="all"> &nbsp;&nbsp;全部 &nbsp;&nbsp;</option>                       
				<option value="未评审" style="color:#000000"> &nbsp;&nbsp;未评审  &nbsp;&nbsp;</option>				     
				<option value="未通过" style="color:#ff0000"> &nbsp;&nbsp;未通过 &nbsp;&nbsp;</option>
				<option value="已通过" style="color:#0006ff"> &nbsp;&nbsp;已通过 &nbsp;&nbsp;</option>
				</select>
            		<input style="width:150px" id="CHA_NAME" name="CHA_NAME" type="text" size="15"/>
            		<input class="button" type="submit" value="快速查询" style="font-size:15px;font-weight:bold"/>	
			  </form>
            </td>

		    </tr>
		
          </table></td>
        </tr>
    </table>
   
       
          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">

              <tr>
                <td height="40" class="font42">
				<table id = "testList" width="100%" border="2" cellpadding="4" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td id="div_title" height="22" colspan="9" align="center" style="font-size:16px">测试用例评审记录</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!-- <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td> -->
                    <td style="font-size:15px;font-weight:bold">编号</td>
                    <td style="font-size:15px;font-weight:bold">用例名称</td>
                    <td style="font-size:15px;font-weight:bold">创建时间</td>
                    <td style="font-size:15px;font-weight:bold">文件夹</td>
                    <td style="font-size:15px;font-weight:bold">用例编写人</td>
                    <td style="font-size:15px;font-weight:bold">用例评审时间</td>
                    <td style="font-size:15px;font-weight:bold">用例评审人</td>
                    <td style="font-size:15px;font-weight:bold">用例评审结果</td>
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
                                	  String shortName1=stuMap.get("ATTACH_NAME");
                                   	  int gang=shortName1.lastIndexOf("_");
                                   		String shortName;
                                   	  if(gang>=0){
                                   		shortName="《"+shortName1.substring(0,gang)+"》"; 
                                   	  }else{
                                   		shortName=shortName1;  
                                   	  }
                                   	  
                            	  
                          %>
                          <tr align="center">
                          	<!-- <td style="font-size:15px" height="28" class="bor_2"><input name='isBuy' type='checkbox' value='<%=i+1 %>'  /></td>-->
                          	<td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=shortName %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("CREATE_TIME") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("FILE_CATALOG") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("TC_CREATER") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("TC_CHECK_TIME") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("TC_CHECKER") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("TC_RESULT") %></td>
							<td class="bor_2 bor_4" style="font-size:15px;text-align:center;font-weight:bold"> 

							 
							 
							 <!--  <a href="youzhishi/ShowPDF.jsp?ATTACH_PATH=<%=stuMap.get("ATTACH_PATH") %>" target="_blank">预览</a>-->
							<a target="_blank" href="<%=path %>/selectTestCaseCheckLogServlet?ATTACH_ID=<%=stuMap.get("ATTACH_ID") %>" >日志</a>
							<a href="<%=path %>/youzhishi/addTestCaseCheck.jsp?ATTACH_ID=<%=stuMap.get("ATTACH_ID") %>&ATTACH_NAME=<%=stuMap.get("ATTACH_NAME") %>&CREATE_TIME=<%=stuMap.get("CREATE_TIME") %>"  target="_blank">评审</a>
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
