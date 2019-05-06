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
    
    <title>新人必读</title>
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
		</script>
<body onload="valiButt()">
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">
<form action="<%=path %>/selectNewShareFileServlet"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="62" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		      
			  <td width="538">
        	 	<a href="index_youzhishi.jsp">
   				 <button class="button2">返回首页</button>
				</a>
            </td>
            <td style="font-size:13px;">
            <form action="<%=path %>/selectMoHuFileServlet" name="MyPageForm2" method="post"  id =formId2 id ="pageForm2">
            		关键词模糊查询：<input style="width:150px" id="CHA_NAME" name="CHA_NAME" type="text" size="15"/>
            		<input type="hidden" id="CHA_APPID" name="CHA_APPID" value="004"type="text"/>
            		<input class="button" type="submit" value="查询" style="font-size:15px;font-weight:bold"/>	
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
                    	<td id="div_title" height="22" colspan="8" align="center" style="font-size:16px">文档列表</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!-- <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td> -->
                    <td style="font-size:15px;font-weight:bold">编号</td>
                    <td style="font-size:15px;font-weight:bold">附件名称</td>
                    <td style="font-size:15px;font-weight:bold">附件类型</td>
                    <td style="font-size:15px;font-weight:bold">关键词</td>
                    <td style="font-size:15px;font-weight:bold">附件说明</td>
                    <td style="font-size:15px;font-weight:bold">分类</td>
                    <td style="font-size:15px;font-weight:bold">创建时间</td>
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
                             	  String shortName="《"+shortName1.substring(0,gang)+"》"; 
                          %>
                          <tr align="center">
                          	<!-- <td style="font-size:15px" height="28" class="bor_2"><input name='isBuy' type='checkbox' value='<%=i+1 %>'  /></td>-->
                          	<td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"> <%=i+1 %> </td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=shortName %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("ATTACH_TYPE") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("ITEM_TYPE") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("REMARK") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("APPID") %></td>
                            <td class="bor_2" style="font-size:15px;text-align:center;font-weight:bold"><%=stuMap.get("CREATE_TIME") %></td>
							<td class="bor_2 bor_4" style="font-size:15px;text-align:center;font-weight:bold"> 

							 
							 <!-- <a href="youzhishi/ShowPDF.jsp?ATTACH_PATH=<%=stuMap.get("ATTACH_PATH") %>" target="_blank">预览</a> -->
							 <a href="youzhishi/ShowPDF.jsp?ATTACH_PATH=<%=stuMap.get("ATTACH_PATH") %>" target="_blank">预览</a>
							<a href="youzhishi/DownloadPDF.jsp?ATTACH_PATH=<%=stuMap.get("ATTACH_PATH") %>&ATTACH_NAME=<%=stuMap.get("ATTACH_NAME") %>&ATTACH_TYPE=<%=stuMap.get("ATTACH_TYPE") %>" target="_blank">下载</a>
							<%--<span><img  src="<%=path %>/images/del.gif" width="16" height="16" onclick = "if(window.confirm('您确定要删除吗？')){window.location.href='DeleteUserServlet?id=<%=stuMap.get("U_ID") %>&name=<%=stuMap.get("U_NAME") %>'}"/>删除</span>--%></td>
                        </tr>
                        		
                          <%     
              
                               }
                        	  
                           }
                        %>
                           
	            <tr>
					<th colspan="8">
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
