<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.Ping" pageEncoding="UTF-8"  %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
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
var errori ='<%=request.getParameter("StartAnswer")%>';
if(errori=='yes'){
 alert("单元测试申请单重新提交成功！已邮件通知测试经理。");
 window.location.href="<%=path%>/DYTestApplicationServlet";
}else if(errori=='no'){
 alert("单元测试申请单重新提交失败，请联系管理员！");
 window.location.href="<%=path%>/DYTestApplicationServlet";
}

//邮箱格式校验
function  submitMyForm(fm){

	var d_id=document.formname.d_id.value;
	var bumen=document.formname.bumen.value;
	var kaifa=document.formname.kaifa.value;
	var k_email=document.formname.k_email.value;
	var date=document.formname.date.value;
	var dyName=document.formname.dyName.value;
	var content=document.formname.content.value;
	var BossEmail=document.formname.BossEmail.value;
	var NGnumber=document.formname.NGnumber.value;
	var obj = document.getElementsByName("biaozhun");//选择所有name="interest"的对象，返回数组    
	var biaozhun='';//如果这样定义var s;变量s中会默认被赋个null值
	for(var i=0;i<obj.length;i++){
	    if(obj[i].checked) //取到对象数组后，我们来循环检测它是不是被选中
	    biaozhun+=obj[i].value;   //如果选中，将value添加到变量s中    
	}
	
	var stop= /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
	if (!stop.test(k_email)) {
		alert("邮箱格式不正确!");
		return false;
    }else if (bumen=="请选择部门") {
		alert("请选择部门!");
		return false;
    }else if (biaozhun.length<1) {
		alert("请选择通过标准!");
		return false;
    }else{
    	fm.action = fm.action + "&d_id="+d_id+"&bumen="+bumen+"&kaifa="+kaifa+"&k_email="+k_email+"&date="+date+"&dyName="+dyName+"&content="+content+"&biaozhun="+biaozhun+"&BossEmail="+BossEmail+"&NGnumber="+NGnumber;  
    	return true;
    }
}
</script>
<body>
		<%
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String date= format.format(new Date());

        if(pageBean!=null){
        //本页的结果集
        List<Map<String, String>>  resList=  pageBean.getResList();
        //System.out.print(resList);
        if(resList!=null && resList.size()>0){                          		
        for(int i=0;i<resList.size();i++){
        Map<String, String>  stuMap= resList.get(i);	
        int NG=Integer.parseInt(stuMap.get("D_NG"))+1; 
	%>
	<h1>单元测试第<%=NG %>次提交</h1>
	<form action="<%=path%>/AddDanYuanTestServlet?type=6" name="formname" method="post" id =formId onsubmit="return submitMyForm(this)" enctype="multipart/form-data">
	<div class="login-01">
			<form>
				<ul>
				<li class="first">
					<a href="#" class=" icon user" style="text-align: center;color:black;"><br/>所属部门</a>
					<input type="hidden" name="BossEmail"  value="<%=stuMap.get("D_KBOSSEMAIL") %>">
					<input name="bumen" type="text" class="text" readonly="readonly" required="required" value="<%=stuMap.get("D_BUMEN") %>">
					<div class="clear"></div>
				</li>
				
				<li class="first">
					<input type="hidden" name="d_id"  value="<%=stuMap.get("D_ID") %>">
					<input type="hidden" name="NGnumber"  value="<%=stuMap.get("D_NG")%>">
					<a href="#" class=" icon user" style="text-align: center;color:black;"><br/>开发人员</a><input name="kaifa" type="text" class="text" placeholder="开发人员" required="required" value="<%=stuMap.get("D_KAIFA") %>" readonly="readonly">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email" style="text-align: center;color:black;"><br/>开发邮箱</a><input name="k_email" type="text" class="text" placeholder="开发人员邮箱，用于接收通知邮件"  required="required" value="<%=stuMap.get("D_KEMAIL") %>" readonly="readonly">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email" style="text-align: center;color:black;"><br/>提交日期</a><input name="date" type="text"  readonly="readonly" class="text" value="<%=date%>"  required="required">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>单元名称</a><input name="dyName" type="text" class="text" placeholder="单元测试名称" required="required" value="<%=stuMap.get("D_VERSION") %>" readonly="readonly">
					<div class="clear"></div>
				</li>
				<!-- 
				<li class="first">
					<a href="#" class=" icon phone"></a><input type="text" class="text" value="Phone" onFocus="this.value = '';" onBlur="if (this.value == '') {this.value = 'Phone';}" >
					<div class="clear"></div>
				</li> -->
				<li class="second">
				<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>测试内容</a><textarea name="content" placeholder="测试内容" required="required"><%=stuMap.get("D_CONTENT") %></textarea>
				<div class="clear"></div>
				<li class="second">
					<a href="#" class=" icon email" style="text-align: center;color:black;height: 80px;"><br/>通过标准</a>
					<input name="biaozhun" type="checkbox" class="text" value="主流程测试通过；" style="zoom:150%;"><a style="color: #000000;background: #fff;font-family: 'Microsoft YaHei', serif;">主流程测试通过</a><br/>
					<input name="biaozhun" type="checkbox" class="text" value="符合测试用例中的测试通过标准；" style="zoom:150%;"><a style="color: #000000;background: #fff;font-family: 'Microsoft YaHei', serif;">符合测试用例中的测试通过标准</a><br/>
					<input name="biaozhun" type="checkbox" class="text" value="符合版本构造说明中的测试通过标准；"style="zoom:150%;"><a style="color: #000000;background: #fff;font-family: 'Microsoft YaHei', serif;">符合版本构造说明中的测试通过标准</a><br/>
					<div class="clear"></div>
				</li>
				<!--  
				<li class="second">
				<a href="#" class=" icon msg"  style="text-align: center;color:black;"><br/>通过标准</a>
					<select name="biaozhun">
					<option value="<%=stuMap.get("D_BIAOZHUN") %>"><%=stuMap.get("D_BIAOZHUN") %></option>
					<option value="符合测试用例中的测试通过标准">符合测试用例中的测试通过标准</option>
					<option value="符合版本构造说明中的测试通过标准">符合版本构造说明中的测试通过标准</option>
					<option value="主流程测试通过">主流程测试通过</option>
					</select>
				<div class="clear"></div>
				</li>-->
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>附件上传</a><input name="file" type="file" class="text">
					<div class="clear"></div>
				</li>
			</ul>
			<input type="submit" value="第<%=NG %>次提交" >
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
	
					<%     
                   }                        	  
               }
            }
            %>
</body>
</html>