<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
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
      excelFile += "<head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head>";
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

  //开始测试的返回结果
  var errori ='<%=request.getParameter("StartAnswer")%>';
  if(errori=='yes'){
   alert("测试任务已开始！");
   window.location.href="<%=path%>/selectBanBenServlet";
  }else if(errori=='no'){
   alert("测试任务启动失败，请联系管理员！");
   window.location.href="<%=path%>/selectBanBenServlet";
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
        	 form.submit();
         }
     }
</script>

<body onload="valiButt()">
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">

<form action="<%=path %>/selectVersionServlet"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>
     
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="45" background="images/nav04.gif">
            
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
		    <tr>
		      
			 <%
			 
			 SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			 String time=df.format(new Date());// new Date()为获取当前系统时间
			 %>
			   <td width="1000" align="left" >
			    <button onclick="XiangQing()">操作日志</button>
			    <button href = "javascript:void(0)" onclick = "document.getElementById('startTest').style.display='block';document.getElementById('startTest').style.display='block'">开始测试</button>
			    	<div style="font-size:18px;font-weight:bold;" id="startTest" class="white_content">
			    		<form  method="post"  id="StartBBTestForm">
        					【测试人】：<input  type="text" name="D_TUSER"><br/><br/>
        					【开始测试时间】：<input type="text" name="TIME" value="<%=time %>" readonly="readonly"><br/><br/>
        					<button style="display: block;" onclick='StartTest()'>提交</button>
        				</form>
						<button onclick = "document.getElementById('startTest').style.display='none';document.getElementById('startTest').style.display='none'">关闭</button>
					</div>

			    <button href = "javascript:void(0)" onclick = "document.getElementById('returnTest').style.display='block';document.getElementById('fade').style.display='block'">驳回</button>
			    	<div style="font-size:18px;font-weight:bold;" id="returnTest" class="white_content">
			    		<form  method="post"  id="StartBBTestForm">
        					【测试人】：<input  type="text" name="D_TUSER"><br/><br/>
        					【开始测试时间】：<input type="text" name="TIME" value="<%=time %>" readonly="readonly"><br/><br/>
        					<button style="display: block;" onclick='StartTest()'>提交</button>
        				</form>
						<button onclick = "document.getElementById('returnTest').style.display='none';document.getElementById('fade').style.display='none'">关闭</button>
					</div>
					
			    <button onclick="XiangQing()">通过</button>

			  
           
            </td>
			  <td align="right"><input style="font-size:15px;font-weight:bold;width:80px" size="12" type="button" value="显示全部" onclick="window.location.href='<%=path %>/'"></td>
		    </tr>
		
          </table></td>
        </tr>
    </table> 

          <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" id="tableAll">

              <tr>
                <td height="40" class="font42">
				<table id = "testList" width="100%" height="100px" border="2" cellpadding="0" cellspacing="1" bgcolor="#EEEEEE" class="newfont03">
				 <tr class="CTitle" >
                    	<td id="div_title" height="28" colspan="11" align="center" style="font-size:14px">版本测试汇总</td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!--  <td height="40" class="bor_1"><input name='isBuy'  type="checkbox"  id="all"  onclick="checkAll(this.checked)"/></td>-->
                    <td  style="font-size:13px;font-weight:bold"></td>
                    <td  style="font-size:13px;font-weight:bold">编号</td>
                    <td  style="font-size:13px;font-weight:bold">部门</td>
                    <td  style="font-size:13px;font-weight:bold">开发</td>
                    <td  style="font-size:13px;font-weight:bold">提交日期</td>
                    <td  style="font-size:13px;font-weight:bold">微服务</td>
                    <td  style="font-size:13px;font-weight:bold">版本号 </td>
                    <td  style="font-size:13px;font-weight:bold">测试人</td>
                    <td  style="font-size:13px;font-weight:bold">NG次数</td>
                    <td  style="font-size:13px;font-weight:bold">状态</td>
                    <td  style="font-size:13px;font-weight:bold">操作</td>
                    <!--  <td style="font-size:15px;font-weight:bold">费用支出部门</td>-->
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
                            	   
                            	   String state = stuMap.get("D_STATE");
                            	   
                            	  if(state.equals("0")){
                            		  state ="待测试";
                            	  }else if(state.equals("1")){
                            		  state ="正在测试";
                            	  }else if(state.equals("2")){
                            		  state ="被退回";
                            	  }else if(state.equals("3")){
                            		  state ="测试通过";
                            	  }else{
                            		  state ="未知";
                            	  }  
                            	  
                          %>
                          <tr align="center" style="">
                          	<!--  <td style="font-size:15px" height="28" class="bor_2"><input name='isBuy' type='checkbox' value='<%=i+1 %>'  /></td>-->
                          	<td  width=50 class="bor_2">
                          	<input type="checkbox" value="<%=stuMap.get("D_ID") %>" name="checkboxBtn"/><br />
                          	</td>
                          	<td  width=50 class="bor_2" style="font-size:13px;text-align:center;font-weight:bold;height:2px;line-height:38px;"> <%=i+1 %> </td>
                            <td  width=200 class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_BUMEN") %></td>
                            <td  width=100 class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_KAIFA") %></td>
                            <td  width=100 class="bor_2" style="font-size:13px;text-align:center;"><%=stuMap.get("D_DATE") %></td>
                            <td  width=150 class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("D_WEINAME") %></td>
                            <td  width=150 class="bor_2" style="font-size:11px;text-align:center;font-weight:bold"> <%=stuMap.get("D_VERSION") %></td>
                            <td  width=100 class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("D_TUSER") %></td>
                            <td  width=80 class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=stuMap.get("D_NG") %></td>
                            <td  width=100 class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><%=state %></td>
                            <td  width=100 class="bor_2" style="font-size:13px;text-align:center;font-weight:bold"><button href = "javascript:void(0)" onclick = "document.getElementById('light<%=i+1 %>').style.display='block';document.getElementById('fade').style.display='block'">详情</button>
        					<div id="light<%=i+1 %>" style="font-size:14px;text-align:left;" class="white_content">
        					【部门】：<%=stuMap.get("D_BUMEN") %><br/>
        					【开发】：<%=stuMap.get("D_KAIFA") %><br/>
        					【提交日期】：<%=stuMap.get("D_DATE") %><br/>
        					【微服务】：<%=stuMap.get("D_WEINAME") %><br/>
        					【版本号】：<%=stuMap.get("D_VERSION") %><br/>
        					【版本内容】：<%=stuMap.get("D_CONTENT") %><br/>
        				          【测试通过标准】：<%=stuMap.get("D_BIAOZHUN") %><br/>
        				          【状态】：<%=state %><br/>
        					【重新提交路径】：<%=stuMap.get("D_SUBURL") %><br/>
        					<br/>
							<button href = "javascript:void(0)" onclick = "document.getElementById('light<%=i+1 %>').style.display='none';document.getElementById('fade').style.display='none'">关闭</button></div>
							</td>                            
				
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
