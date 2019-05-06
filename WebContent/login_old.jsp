<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
    <meta http-equiv="Content-Type" content="text/html; charset=${encoding}">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="icon" href="img/logo.png"/>
    <title>财政产品中心测试部</title>
    <link href="css/bootstrap.css" rel="stylesheet">

    <!--[if lt IE 9]>
  <script src="js/html5shiv.min.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
    <style>
        html,body {
            height: 100%;
        }
        .box {
            /*filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6699FF', endColorstr='#6699FF'); /!*  IE *!/*/
            /*background-image:linear-gradient(bottom, #6699FF 0%, #6699FF 100%);*/
            /*background-image:-o-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);*/
            /*background-image:-moz-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);*/
            /*background-image:-webkit-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);*/
            /*background-image:-ms-linear-gradient(bottom, #6699FF 0%, #6699FF 100%);*/
            background-image:url("img/bg-login.png");
            background-repeat: no-repeat;
            background-size: 100%;
            margin: 0 auto;
            position: relative;
            width: 100%;
            height: 100%;
            
            background-size: cover;
		  	-webkit-background-size: cover;
 		 	-o-background-size: cover;
 		 	
        }
        .login-box {
            width: 100%;
            max-width:500px;
            height: 400px;
            position: absolute;
            top: 50%;
            margin-top: -200px;
            /*设置负值，为要定位子盒子的一半高度*/

        }
        @media screen and (min-width:500px){
            .login-box {
                left: 50%;
                /*设置负值，为要定位子盒子的一半宽度*/
                margin-left: -250px;
            }
        }

        .form {
            width: 100%;
            max-width:500px;
            height: 275px;
            margin: 25px auto 0px auto;
            padding-top: 25px;
        }
        .login-content {
            height: 320px;
            width: 100%;
            max-width:500px;
            background-color: rgba(255, 250, 2550, .6);
            float: left;
        }


        .input-group {
            margin: 0px 0px 30px 0px !important;
        }
        .form-control,
        .input-group {
            height: 40px;
        }

        .form-group {
            margin-bottom: 0px !important;
        }
        .login-title {
            padding: 20px 10px;
            background-color: rgba(0, 0, 0, .6);
        }
        .login-title h1 {
            margin-top: 10px !important;
        }
        .login-title small {
            color: #fff;
        }

        .link p {
            line-height: 20px;
            margin-top: 30px;
        }
        .btn-sm {
            padding: 8px 24px !important;
            font-size: 16px !important;
        }
        .text-white{
            color: white;
        }
    </style>
      	<script type="text/javascript">
   function submitOn(){
      var userName= document.getElementById("userName").value; 
      var pass= document.getElementById("password").value; 
      //alert(issubmit); 
      if(userName==""){
        alert("请输入用户名！"); 
        return false;
      }
	 if(pass==""){
       alert("请输入密码！");  
        return false;
      }
      //alert(issubmit);
      //return  issubmit; 
      } 
  /*
     验证码 错误信息
 */
function errLogin() {
	var messg = '<%=message%>'; 
	if (messg != 'null') {
		alert(messg);
	}
  }
   	</script>
</head>
<body>
<div class="box">
    <br/>
    <!--  <h1 style="color:red;font-size:35px;font-family:'微软雅黑'" class="text-center text-white"><span  class="glyphicon glyphicon-leaf"></span>&nbsp;&nbsp;&nbsp;用&nbsp;友&nbsp;政&nbsp;务</h1>-->
    <div class="login-box">
        <div class="login-title text-center">
            <h1><small>财政产品中心——测试部</small></h1>
        </div>
        <div class="login-content ">
            <div class="form">
                <form method="post" onsubmit="return submitOn()" name="myForm">
                    <div class="form-group">
                        <div class="col-xs-12  ">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                                <input type="text" id="userName" name="userName" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12  ">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                                <input type="text" id="password" name="password" class="form-control" >
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="col-xs-12  ">
                            <div class="input-group">
                                <span class="input-group-addon">
<% 
    Calendar calendar=Calendar.getInstance(); 
    int year=calendar.get(Calendar.YEAR); 
 %> 
 								
                                <select style="high:400;font-weight:bold;width: 92px;height: 28px;font-size:16px;" name="set_year"  id="set_year">                              
					     <option value="<%=year %>"> &nbsp;&nbsp;<%=year %> &nbsp;&nbsp;</option>
					     <option value="<%=year-1 %>"> &nbsp;&nbsp;<%=year-1 %> &nbsp;&nbsp;</option>
					     </select>
					     </span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group form-actions">
                    <table align=center>
					<tr>
					<td>
					<input name="Submit2" type="button" class="btn btn-sm btn-info" value="登&nbsp;录" onclick="myForm.action='LoginServlet';myForm.submit()">
					</td>
					<!--<td style="width:100px;"></td>
					 暂时屏蔽手机版 
					<td>
					<input name="Submit2" type="button" class="btn btn-sm btn-info" value="手机登录" onclick="myForm.action='LoginServlet';myForm.submit()">
					</td> -->
					</tr>
					</table>
                         <!-- <div class="col-xs-4 col-xs-offset-4 " style="margin: 0 37%;"> 
                            <a href="index.html" class="btn btn-sm btn-info"><span class="glyphicon glyphicon-off"></span><input name="Submit2" type="submit" value="登陆" /></a>
                            <input name="Submit2" type="submit" value="手机登录"  class="btn btn-sm btn-info"/>
                        </div>-->
                        
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>


<script src="js/jquery-1.11.3.js"></script>
<script src="js/bootstrap.js"></script>
<script>
    /*Bootlint工具用于对页面中的HTML标签以及Bootstrapclass的使用进行检测
    (function () {
        var s = document.createElement("script");
        s.onload = function () {
            bootlint.showLintReportForCurrentDocument([]);
        };
        s.src = "js/bootlint.js";
        document.body.appendChild(s)
    })();*/
</script>
</body>
</html>