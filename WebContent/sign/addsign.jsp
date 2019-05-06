<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
%>
<%
response.setHeader("refresh","600");
 %>
<% String username = (String)session.getAttribute("username"); %>

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
	font-size: 19px;
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
option{
color: red;
color: blue;
}
html { overflow-x: auto; overflow-y: auto; border:0;} 
-->
</style>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/JavaScript">
	/**
	获取当前日期
	*/
 function getDateTime(){
		 var dateTime=new Date();
		 //年份
		 var  fullYear= dateTime.getFullYear();
		 //月份
		 var month=dateTime.getMonth();
		 //日期
		 var day= dateTime.getDate() ;
		var hours=dateTime.getHours();
		var minutes=dateTime.getMinutes();
		 var secondes=dateTime.getSeconds();
		 
		 document.getElementById("showDateTimeId").innerHTML=fullYear+"年"+(month+1)+"月"+day+"日"+"  "+hours+":"+minutes+":"+secondes;
}
   window.onload=function (){
       //每隔1s钟执行numadd()函数
        setInterval("getDateTime()",1000);
	   
	   //1s钟之后执行numadd()函数，仅能执行一次
	   //setTimeout("getDateTime()",5000);    
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
			  		//alert('测试');   
			    	var formObj=document.getElementById("formId");
			    	//var s_host = document.getElementById('s_host').value;        
					//var s_sign = document.getElementById('s_sign').value;
					
					var s_host=document.MyPageForm.s_host.value;
					var s_sign=document.MyPageForm.s_sign.value;

					//校验支持人不能为空
		 			if(s_host == '') {        
		 				alert('请填写主持人名称!');      
		 				return false;    
		 			}
		 			
		 			else if(s_sign == '未知') {        
		 				alert('员工的签到状态未填写完整!');      
		 				return false;    
		 			}

					if(checkForm()){
				  		return true;
				  		
					}else{
						alert("无法提交 请核对信息");
						return false;
					}
			   
			  	}
</script>
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
		
		</script>
<!-- 获取当前日期 -->
<%
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
 String date= format.format(new Date());
%>
<body onload="valiButt()">

<form action="<%=path%>/AddSignServlet2"  name="MyPageForm" method="post"  id =formId id ="pageForm" onsubmit="return submitMyForm()">

	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />

<!-- jsp页面右侧滚动条 -->
<!--<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:500px;">   -->
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>      
          <td height="62" background="images/nav04.gif">           
		   <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" height="70">
		    <tr>	      
			  <td width="21"><img src="images/ico07.gif" width="18" height="15" /></td>
			  
			  <!-- 顶部蓝色框内的td -->
			  <td width="538" align="center" style="font-size:15px">
			    <strong>主持人:</strong>
				<input name="s_host" id="s_host" style="width:120px" type="text" size="40"  maxlength="5" value="<%=username%>"/>           
            </td>
			  <td width="538" align="center" style="font-size:15px">
			    <strong>日期:</strong>			    
				<input  name="s_date" style="width:120px" type="text" size="40"  maxlength="15" value="<%=date%>"/>           
            </td>
            <TD width="538" align="center" style="font-size:15px">
            <!-- 提交按钮 -->
			<input type="submit"  value="保存" style="font-size:15px;font-weight:bold"/>　			
			</TD>
          </table></td>
        </tr>
       
          <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="40" class="font42">
				<table width="100%" border="2" cellpadding="4" cellspacing="1" bgcolor="#EEEEEE" class="newfont03" >
				 <tr class="CTitle" >
                    	<td height="22" colspan="4" align="center" style="font-size:19px"><b>签到表</b></td>
                  </tr>
                  <tr bgcolor="#EEEEEE" align="center">
                  <!-- <td height="40" class="bor_1"><input type="checkbox" /></td> -->
                    <td style="font-size:15px"><b>用户编号</b></td>
                    <td style="font-size:15px"><b>在职人员</b></td>
                    <td style="font-size:15px"><b>签到</b></td>
                    <td style="font-size:15px"><b>备注</b></td>
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
                            	   System.out.print(i);
                            	   
                          %>
                          <tr align="center">
                          	<!-- <td style="font-size:15px" height="28" class="bor_2"><input type="checkbox" /></td>   -->                         
                             <td  class="bor_2">
                             <!--  
                             <select style="high:150" name="s_id">                                
					    	<option style="font-size:15px;color:blue" readOnly="true" value="<%=stuMap.get("U_ID") %>"> &nbsp;&nbsp;<%=stuMap.get("U_ID") %>&nbsp;&nbsp;</option>    
                             -->
                             <input readOnly="true" style="font-size:10px;text-align:center;font-weight:bold" name="s_id" value="<%=i+1 %>"/>
                             </td>
                             
                             <td  class="bor_2">
                             <!--
                             <select style="high:150" name="s_name">                                
					    	<option style="font-size:15px;color:blue" readOnly="true" value="<%=stuMap.get("U_NAME") %>"> &nbsp;&nbsp;<%=stuMap.get("U_NAME") %> &nbsp;&nbsp;</option>    
                             -->
                                <input readOnly="true" style="font-size:14px;text-align:center;font-weight:bold" name="s_name" value="<%=stuMap.get("U_NAME") %>"/>
                             </td>
                             
                            <td style="font-size:15px" class="bor_2">					    
                            <select style="high:150;font-weight:bold;color:blue" name="s_sign"  id="s_sign" required="required">
                            <option style="font-size:15px;color:blue" value=""> &nbsp;&nbsp; &nbsp;&nbsp;</option>                                
					    	<option style="font-size:15px;color:blue" value="在岗"> &nbsp;&nbsp;在岗 &nbsp;&nbsp;</option>    
							<option style="font-size:15px;color:blue" value="出差"> &nbsp;&nbsp;出差&nbsp;&nbsp;</option>
							<option style="font-size:15px;color:red" value="迟到"> &nbsp;&nbsp;迟到&nbsp;&nbsp;</option>
							<option style="font-size:15px;color:red" value="请假"> &nbsp;&nbsp;请假&nbsp;&nbsp;</option>
							<option style="font-size:15px;color:red" value="旷工"> &nbsp;&nbsp;旷工&nbsp;&nbsp;</option>    
					        </select>
					     </td>
                            <td style="font-size:15px" class="bor_2"><input name="s_remark" class="" style="width:100px" type="text" size="500"  maxlength="500" value="无"/></td>
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

</table>   

</table> 

 </form>
  </body>
</html>
