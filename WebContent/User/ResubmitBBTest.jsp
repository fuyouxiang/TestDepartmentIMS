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
<link href="bootstrap/css/bootstrap.css" rel='stylesheet' type='text/css'/>
<link href="css/style5.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Pink Contact Form ,Login Forms,Sign up Forms,Registration Forms,News latter Forms,Elements"./>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<!--webfonts-->
<!--//webfonts-->
</head>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="bootstrap/js/bootstrap.js"></script>

<script language="javascript">

//取出传回来的参数error并与yes比较
var errori ='<%=request.getParameter("StartAnswer")%>';
if(errori=='yes'){
 alert("版本测试申请单重新提交成功！已邮件通知测试经理。");
 window.location.href="<%=path%>/TestApplicationServlet";
}else if(errori=='no'){
 alert("版本测试申请单重新提交失败，请联系管理员！");
 window.location.href="<%=path%>/TestApplicationServlet";
}

//邮箱格式校验
function  submitMyForm(fm){
	var old_id=document.formname.old_id.value;
	var bumen=document.formname.bumen.value;
	var kaifa=document.formname.kaifa.value;
	var k_email=document.formname.k_email.value;
	var date=document.formname.date.value;
	var weiServer=document.formname.weiServer.value;
	var banbenNo=document.formname.banbenNo.value;
	var content=document.formname.content.value;
	var jinji=document.formname.jinji.value;
	var obj = document.getElementsByName("biaozhun");//选择所有name="interest"的对象，返回数组    
	var biaozhun='';//如果这样定义var s;变量s中会默认被赋个null值
	for(var i=0;i<obj.length;i++){
	    if(obj[i].checked) //取到对象数组后，我们来循环检测它是不是被选中
	    biaozhun+=obj[i].value;   //如果选中，将value添加到变量s中    
	}
	if (biaozhun.length<1) {
		alert("请选择通过标准!");
		return false;
    }else if (content.length>600) {
		alert("内容较多时建议将内容写在附件中，然后构造内容填写  “详情请见内容附件。” 即可");
		return false;
    }else{
        //等待提示
        showWaiting();
        fm.action = fm.action + "&bumen="+bumen+"&kaifa="+kaifa+"&k_email="+k_email+"&date="+date+"&weiServer="+weiServer+"&banbenNo="+banbenNo+"&content="+content+"&biaozhun="+biaozhun+"&old_id="+old_id+"&jinji="+jinji;  
        return true;
    }
}

//显示等待窗口
function showWaiting() {
    var msgw, msgh, bordercolor;
    msgw = 300; //提示窗口的宽度 
    msgh = 100; //提示窗口的高度 
    bordercolor = "#336699"; //提示窗口的边框颜色 
    titlecolor = "#99CCFF"; //提示窗口的标题颜色 

    var sWidth, sHeight;
    sWidth = document.body.clientWidth;
    sHeight = document.body.clientHeight;

    //背景遮罩层div
    var bgObj = document.createElement("div");
    bgObj.setAttribute('id', 'bgDiv');
    bgObj.style.position = "absolute";
    bgObj.style.top = "0px";
    bgObj.style.background = "#888";
    bgObj.style.filter = "progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
    bgObj.style.opacity = "0.6";
    bgObj.style.left = "0px";
    bgObj.style.width = sWidth + "px";
    bgObj.style.height = sHeight + "px";
    document.body.appendChild(bgObj);
    
    //信息提示层div
    var msgObj = document.createElement("div");
    msgObj.setAttribute("id", "msgDiv");
    msgObj.setAttribute("align", "center");
    msgObj.style.position = "absolute";
    msgObj.style.background = "white";
    msgObj.style.font = "12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
    msgObj.style.border = "1px solid " + bordercolor;
    msgObj.style.width = msgw + "px";
    msgObj.style.height = msgh + "px";
    msgObj.style.top = (document.documentElement.scrollTop + (sHeight - msgh) / 2) + "px";
    msgObj.style.left = (sWidth - msgw) / 2 + "px";
    document.body.appendChild(msgObj);
    
    //标题栏
    var title = document.createElement("h4");
    title.setAttribute("id", "msgTitle");
    title.setAttribute("align", "left");
    title.style.margin = "0px";
    title.style.padding = "3px";
    title.style.background = bordercolor;
    title.style.filter = "progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
    title.style.opacity = "0.75";
    title.style.border = "1px solid " + bordercolor;
    title.style.height = "14px";
    title.style.font = "12px Verdana, Geneva, Arial, Helvetica, sans-serif";
    title.style.color = "white";
    title.innerHTML = "正在提交中，请稍候......";
    document.getElementById("msgDiv").appendChild(title);
    
    //中间等待图标
    var img = document.createElement("img");
    img.style.margin = "10px 0px 10px 0px";
    img.style.width = "48px";
    img.style.height = "48px";
    img.setAttribute("src", "./img/waiting.gif");
    document.getElementById("msgDiv").appendChild(img);
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
        String D_JINJI=stuMap.get("D_JINJI");
        if(D_JINJI.equals("1")){
        	D_JINJI="紧急";
        }else{
        	D_JINJI="非紧急";
        }
	%>
	<div class="alert alert-danger alert-dismissible" role="alert"  style="width:60%;height:50px;text-align:center;margin:0 auto;">
		<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  		<strong>请注意！</strong>从即日起，新版本提交后需由开发人员进行构建（build），测试人员不再进行构建！
	</div>
	<h1>版本测试重新提交</h1>
	<form action="<%=path%>/AddBanBenTestServlet?type=2" name="formname" method="post" id =formId onsubmit="return submitMyForm(this)" enctype="multipart/form-data">
	<div class="login-01">
			<form>
			
  
				<ul>
				<li class="first">
				<a href="#" class=" icon user" style="text-align: center;color:black;"><br/>所属部门</a>   
					<select name="bumen">
					<option  value="<%=stuMap.get("D_BUMEN") %>"><%=stuMap.get("D_BUMEN") %></option>
					</select>
					<div class="clear"></div>
				</li>
				
				<li class="first">
					<input type="hidden" name="old_id"  value="<%=stuMap.get("D_ID") %>">
					<input type="hidden" name="NGnumber"  value="<%=NG %>">
					<a href="#" class=" icon user" style="text-align: center;color:black;"><br/>开发人员</a><input name="kaifa" type="text" class="text" readonly="readonly" placeholder="开发人员" required="required" value="<%=stuMap.get("D_KAIFA") %>">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email" style="text-align: center;color:black;"><br/>开发邮箱</a><input name="k_email" type="text"  readonly="readonly" class="text" placeholder="开发人员邮箱，用于接收通知邮件"  required="required" value="<%=stuMap.get("D_KEMAIL") %>">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon email"  style="text-align: center;color:black;"><br/>提交日期</a><input name="date" type="text"  readonly="readonly" class="text" value="<%=date%>"  required="required" >
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>微服务</a><input name="weiServer" type="text" readonly="readonly" class="text" placeholder="微服务名称" required="required" value="<%=stuMap.get("D_WEINAME") %>">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>版本号</a><input name="banbenNo" type="text" class="text"  required="required">
					<div class="clear"></div>
				</li>
				<li class="second">
				<a href="#" class=" icon msg"  style="text-align: center;color:black;"><br/>是否紧急</a>
					<select name="jinji">
					<option value="<%=stuMap.get("D_JINJI") %>"><%=D_JINJI %></option>
					<option value="0">非紧急</option>
					<option value="1">紧急（抄送江西现场）</option>
					</select>
				<div class="clear"></div>
				</li>
				<li class="second">
				<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>构造内容</a><textarea name="content" placeholder="版本构造内容" required="required" ><%=stuMap.get("D_CONTENT") %></textarea>
				<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>内容附件</a><input name="file" type="file" class="text">
					<div class="clear"></div>
				</li>
				<li class="second">
					<a href="#" class=" icon email" style="text-align: center;color:black;height: 80px;"><br/>通过标准</a>
					<input name="biaozhun" type="checkbox" class="text" value="主流程测试通过；" style="zoom:150%;"><a style="color: #000000;background: #fff;font-family: 'Microsoft YaHei', serif;">主流程测试通过</a><br/>
					<input name="biaozhun" type="checkbox" class="text" value="符合测试用例中的测试通过标准；" style="zoom:150%;"><a style="color: #000000;background: #fff;font-family: 'Microsoft YaHei', serif;">符合测试用例中的测试通过标准</a><br/>
					<input name="biaozhun" type="checkbox" class="text" value="符合版本构造说明中的测试通过标准；"style="zoom:150%;"><a style="color: #000000;background: #fff;font-family: 'Microsoft YaHei', serif;">符合版本构造说明中的测试通过标准</a><br/>
					<div class="clear"></div>
				</li>
				<!-- 
				<li class="second">
				<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>通过标准</a>
					<select name="biaozhun">
					<option value="<%=stuMap.get("D_BIAOZHUN") %>"><%=stuMap.get("D_BIAOZHUN") %></option>
					<option value="符合测试用例测试通过要求">符合测试用例测试通过要求</option>
					<option value="符合构造说明测试通过要求">符合构造说明测试通过要求</option>
					<option value="主流程测试通过">主流程测试通过</option>
					</select>
				<div class="clear"></div>
				</li> -->
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>SQL脚本</a><input name="file2" type="file" class="text">
					<div class="clear"></div>
				</li>
				<li class="first">
					<a href="#" class=" icon msg" style="text-align: center;color:black;"><br/>配置文件</a><input name="file3" type="file" class="text">
					<div class="clear"></div>
				</li>
			</ul>
			<input type="submit" value="重新提交" >
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