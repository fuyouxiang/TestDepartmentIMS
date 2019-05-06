<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import="java.util.Date"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试用例评审</title>
</head>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>测试用例评审</title>
<style>
body,input,button{font:normal 14px "Microsoft Yahei";margin:0;padding:0}
.odform-tit{font-weight:normal;font-size:25px;color:#595757;line-height:40px;text-align:center;border-bottom:1px solid #c9cacb;margin:0;padding:5% 0}
.odform-tit img{height:40px;vertical-align:middle;margin-right:15px}
.odform{padding:5%}
.input-group{margin-bottom:5%;position:relative}
.input-group label{padding:2% 0;position:absolute;color:#595757}
.input-group input{margin-left:5em;padding:3% 5%;box-sizing:border-box;background:#efeff0;border:0;border-radius:5px;color:#595757;width:75%}
.input-group select{margin-left:5em;padding:3% 5%;box-sizing:border-box;background:#efeff0;border:0;border-radius:5px;color:#595757;width:75%}
.odform button{background:#8ec31f;color:#fff;text-align:center;border:0;border-radius:10px;padding:3%;width:100%;font-size:16px}
.odform .cal{background-image:url(../images/daetixian-cal.png);background-repeat:no-repeat;background-position:95% center;background-size:auto 50%}
.odform .xl{background-image:url(../images/daetixian-xl.png);background-repeat:no-repeat;background-position:95% center;background-size:auto 20%}
</style>
<script type="text/JavaScript" src="<%=path %>/My97DatePicker/WdatePicker.js">
</script><!-- 日期控件 -->
</head>
<body>
<h1 class="odform-tit">测试用例评审</h1>
<%
String ATTACH_NAME = request.getParameter("ATTACH_NAME"); 
ATTACH_NAME = new String(ATTACH_NAME.getBytes("ISO8859-1"), "utf-8");
String shortName1=ATTACH_NAME;
int gang=shortName1.lastIndexOf("_");
String shortName="《"+shortName1.substring(0,gang)+"》";
String CREATE_TIME = request.getParameter("CREATE_TIME"); 
String ATTACH_ID = request.getParameter("ATTACH_ID");
%>
<div class="odform">
	<form action="<%=path %>/AddTestCaseCheckServlet" method="post"  name="myForm">
		<div class="input-group">
			<label for="ATTACH_NAME">用例名称</label>
			<input type="text"  id="shortName" name="shortName" value="<%=shortName%>" readonly="readonly">
			<input type="hidden"  id="ATTACH_NAME" name="ATTACH_NAME" value="<%=ATTACH_NAME%>" readonly="readonly">
			<input type="hidden"  id="ATTACH_ID" name="ATTACH_ID" value="<%=ATTACH_ID%>" readonly="readonly">
		</div>
		<div class="input-group">
			<label for="CREATE_TIME">上传时间</label>
			<input type="text" id="CREATE_TIME" name="CREATE_TIME" value="<%=CREATE_TIME%>" readonly="readonly">
		</div>
		<div class="input-group">
			<label for="TC_CREATER">编写人</label>
			<input type="text" id="TC_CREATER" name="TC_CREATER" placeholder="请输入测试用例编写人" required="required">
		</div>
				<%
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String date= format.format(new Date());
					%>
		<div class="input-group">
			<label for="TC_CHECK_TIME">评审时间</label>
			<input type="text" id="TC_CHECK_TIME" name="TC_CHECK_TIME" value="<%=date%>" onFocus="WdatePicker({lang:'zh-cn'})" autocomplete="off" class="cal">
		</div>
		<div class="input-group">
			<label for="TC_CHECKER">评审人</label>
			<input type="text"  id="TC_CHECKER"name="TC_CHECKER"  placeholder="请输入评审人" required="required">
		</div>
		<div class="input-group">
			<label for="TC_RESULT">评审结果</label>
				<select name="TC_RESULT"  id="TC_RESULT">
					<option style="color:#ff0000" value="未通过">未通过</option>
			    	<option style="color:#0006ff" value="已通过">已通过</option>
				</select>
			<!-- 
			<input type="text" id="khname" list="itemlist" required="required" class="xl">
			<datalist id="itemlist">
			    <option style="color:#03b2eb" value="未通过">未通过</option>
			    <option style="color:#03b2eb" value="已通过">已通过</option>
			</datalist>  -->
		</div>
		<button>评审完成</button>	
		</form>
		&nbsp;
		<button style="background:#03b2eb" onclick="javascript:history.back(-1)">返回</button>

</div>

<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
</div>
</body>
</html>