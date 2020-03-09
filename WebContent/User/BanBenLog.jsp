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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no">
<title>版本测试操作日志</title>
<style type="text/css">
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
  padding: 7px 26px 9px 29px;
  text-decoration: none;
}
</style>
<link rel="stylesheet" href="css/flowChart.css" />
</head>
<script type="text/javascript">
//操作记录 
function Return(){
   window.location.href="javascript:history.go(-1)";
 }
</script>
<body>
<!-- 右侧滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">
<br/>
<button onclick="Return()">返回主菜单</button>
<!--事件时间轴-->
<div class="flowChart">
	<!--左侧轴-->
	<div class="flowChart-left">
		<!--虚线-->
		<div class="dashed"></div>
	</div>
	<!--右侧内容-->
	<div class="flowChart-right">
	
<%
                        	
    if(pageBean!=null){
    //本页的结果集
    List<Map<String, String>>  resList=  pageBean.getResList();
    //System.out.print(resList);
    if(resList!=null && resList.size()>0){
    //传递学生信息
                          		
    for(int i=0;i<resList.size();i++){
    Map<String, String>  stuMap= resList.get(i);
                            	   
    String buzhou = stuMap.get("T_CAOZUO");//左侧步骤圆圈
    String buzhouColor=null;//左侧步骤圆圈颜色
    String buzhouImg=null;//左侧步骤圆圈图片
    if(buzhou.equals("提交申请")){
    	buzhou="提交";
    	buzhouColor="check check-prime";
    	buzhouImg="kaifa.jpg";
    }else if(buzhou.equals("重新提交")){
    	buzhou="提交";
    	buzhouColor="check check-prime";
    	buzhouImg="kaifa.jpg";
    }
    else if(buzhou.equals("开始测试")){
    	buzhou="测试";
    	buzhouColor="check check-warning";
    	buzhouImg="ceshi.jpg";
    }else if(buzhou.equals("驳回")){
    	buzhou="驳回";
    	buzhouColor="check check-danger";
    	buzhouImg="ceshi.jpg";
    }else if(buzhou.equals("测试通过")){
    	buzhou="通过";
    	buzhouColor="check check-success";
    	buzhouImg="ceshi.jpg";
    }else if(buzhou.equals("测试结束")){
    	buzhou="结束";
    	buzhouColor="check";
    	buzhouImg="ceshi.jpg";
    }
 
%>		
		<!--一个节点-->
		<div class="oneNode">
			<!--左侧小球-->
			<div class="<%=buzhouColor %>">
				<%=buzhou %>
			</div>
			<div class="tag-boder">
				<div class="tag">
				</div>
			</div>
			<!--右侧内容-->
			<div class="NodeDetail">
				<!--上-->
				<div class="NodeDetail-title">
					<!--头像-->
					<img src="img/<%=buzhouImg %>" />
					<!--内容-->
					<div class="details">
						<h4>操作人：<%=stuMap.get("T_PEOPLE") %></h4>
						<p>时间：<%=stuMap.get("T_TIME") %></p>
					</div>
				</div>
				<!--
				<div class="NodeDetail-content">
					<span class="badge"><%=stuMap.get("T_CAOZUO") %></span>
				</div>
				<br/>-->
				<!--中-->
				<div class="NodeDetail-content">
					<span class="badge">备注:</span>&nbsp;&nbsp;<%=stuMap.get("T_BEIZHU") %>

				</div>
			</div>
		</div>		
<%     
  	}
	}
}
 %>
	</div>
</div>
</div>
</body>
</html>
