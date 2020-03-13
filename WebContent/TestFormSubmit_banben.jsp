<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.Ping" pageEncoding="UTF-8"  %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
PageBean pageBean2=(PageBean)request.getAttribute("pageBean2");
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>财政云测试申请</title>
<link href="css/style5.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Pink Contact Form ,Login Forms,Sign up Forms,Registration Forms,News latter Forms,Elements"./>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<!--webfonts-->
<!--//webfonts-->
</head>
<script language="javascript">
//取出传回来的参数error并与yes比较
var errori ='<%=request.getParameter("answer")%>';
if(errori=='yes'){
 alert("版本测试申请单提交成功！已邮件通知测试经理。");
 window.location.href="<%=path%>/TestApplicationServlet";
}else if(errori=='no'){
 alert("单元测试申请单提交失败，请联系管理员！");
 window.location.href="<%=path%>/TestApplicationServlet";
}

//邮箱格式校验
	function  submitMyForm(){
		var k_email=document.formname.k_email.value;
		var stop= /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
		if (!stop.test(k_email)) {
			alert("邮箱格式不正确!");
			return false;
	    }else{
	    	return true;
	    }
}

	function submit(){
		alert("111");
		document.a.submit;
		document.b.submit;
		}
</script>
<body>
		<%
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date= format.format(new Date());
		%>
	<div class="top-buttons-agileinfo">
		<a class="active" href="<%=path%>/TestApplicationServlet">版本测试申请</a><a href="<%=path%>/DYTestApplicationServlet" >单元测试申请</a>
	</div>
	<h1>版本测试申请单</h1>
	<form action="<%=path%>/AddBanBenTestServlet?type=1" name="formname" method="post" id =formId onsubmit="return submitMyForm()">
	<div class="login-01">
			<form>
				<ul>
				

				<li class="first">
					<a href="#" class=" icon user" style="text-align: center;color:black;"><br/>所属部门</a>
					<select name="bumen">
					<%
                      if(pageBean!=null){
                       //本页的结果集
                       List<Map<String, String>>  resList=  pageBean.getResList();
                       //System.out.print(resList);
                       if(resList!=null && resList.size()>0){                          		
                          for(int i=0;i<resList.size();i++){
                          Map<String, String>  stuMap= resList.get(i);	  
                          %>    
					<option  value="<%=stuMap.get("B_NAME") %>;<%=stuMap.get("B_USER") %>;<%=stuMap.get("EMAIL") %>"><%=stuMap.get("B_NAME") %></option>
					<%     
                          }                        	  
                       }
                      }
                        %>
					</select>
					<div class="clear"></div>
				</li>
				
				<li class="first">
					<a href="#" class=" icon user" style="text-align: center;color:black;"><br/>开发人员</a><input name="kaifa" type="text" class="text" placeholder="开发人员" required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email" style="text-align: center;color:black;"><br/>开发邮箱</a><input name="k_email" type="text"  class="text" placeholder="开发人员邮箱，用于接收通知邮件"  required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email"  style="text-align: center;color:black;"><br/>提交日期</a><input name="date" type="text"  readonly="readonly" class="text" value="<%=date%>"  required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg"  style="text-align: center;color:black;"><br/>微服务</a>
					<select name="weiServer">
					<%
                      if(pageBean!=null){
                       //本页的结果集
                       List<Map<String, String>>  resList=  pageBean2.getResList();
                       //System.out.print(resList);
                       if(resList!=null && resList.size()>0){                          		
                          for(int i=0;i<resList.size();i++){
                          Map<String, String>  stuMap= resList.get(i);	  
                          %>    
					<option  value="<%=stuMap.get("W_NAME") %>"><%=stuMap.get("W_NAME") %></option>
					<%     
                          }                        	  
                       }
                      }
                        %>
					</select>
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg"  style="text-align: center;color:black;"><br/>版本号</a><input name="banbenNo" type="text" class="text" placeholder="版本号" required="required">
					<div class="clear"></div>
				</li>
				<!-- 
				<li class="first">
					<a href="#" class=" icon phone"></a><input type="text" class="text" value="Phone" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Phone';}" >
					<div class="clear"></div>
				</li> -->
				<li class="second">
				<a href="#" class=" icon msg"  style="text-align: center;color:black;"><br/>构造内容</a><textarea name="content" placeholder="版本构造内容" required="required"></textarea>
				<div class="clear"></div>
				<li class="second">
				<a href="#" class=" icon msg"  style="text-align: center;color:black;"><br/>通过标准</a>
					<select name="biaozhun">
					<option value="符合测试用例测试通过要求">符合测试用例测试通过要求</option>
					<option value="符合构造说明测试通过要求">符合构造说明测试通过要求</option>
					<option value="主流程测试通过">主流程测试通过</option>
					</select>
				<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>附件上传</a><input name="wiki" type="file" class="text" placeholder="Wiki地址">
					<div class="clear"></div>
				</li>
			</ul>
			<input type="submit" value="提交" onclick="submit();">
			<div class="clear"></div>
		</form>
</div>
</form>
	<!--start-copyright-->
   		<div class="copy-right">
   			<div class="wrap">
				<p>财政云产品测试部&nbsp;&copy;2020&nbsp;&nbsp;京ICP备20002763号-1&nbsp;&nbsp;<a target="_blank" href="http://www.yonyougov.vip/">系统首页</a></p>
			</div>
			<div style="width:300px;margin:0 auto; padding:20px 0;">
		 		<a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=11010802030909" style="display:inline-block;text-decoration:none;height:20px;line-height:20px;"><img src="img/beian.png" style="float:left;"/><p style="float:left;height:20px;line-height:20px;margin: 0px 0px 0px 5px; color:#939393;">京公网安备 11010802030909号</p></a>
			</div>
	</div>
	<!--//end-copyright-->
</body>
</html>