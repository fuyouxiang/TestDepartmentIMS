<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();

String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
List<Map<String,String>> RInfoList= (List<Map<String , String>>) request.getAttribute("RList");
%>
  	<% String username = (String)session.getAttribute("username"); %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" type="text/css" href="iphone/static/css/template/reset.css?2014-03-07-1" media="all" />

		<link rel="stylesheet" type="text/css" href="iphone/static/css/template/snower.css?2014-03-07-1" media="all" />

		<link rel="stylesheet" type="text/css" href="iphone/static/css/template/common.css?2014-03-07-1" media="all" />
		
<link rel="stylesheet" type="text/css" href="iphone/static/css/template/home-19.css?2014-03-07-1" media="all" />
		
<link rel="stylesheet" type="text/css" href="iphone/static/css/template/home-menu-2.css?2014-03-07-1" media="all" />

		<script type="text/javascript" src="iphone/static/src/template/maivl.js?2014-03-07-1"></script>

		<script type="text/javascript" src="iphone/static/src/jQuery.js?2014-03-07-1"></script>
		
<script type="text/javascript" src="iphone/static/src/template/swipe.js?2014-03-07-1"></script>
		
<script type="text/javascript" src="iphone/static/src/template/zepto.js?2014-03-07-1"></script>
		
<title>测试部工作管理系统——手机版</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
		<meta content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">        
        <!-- Mobile Devices Support @begin -->
            <meta content="application/xhtml+xml;charset=UTF-8" http-equiv="Content-Type">
            <meta content="no-cache,must-revalidate" http-equiv="Cache-Control">
            <meta content="no-cache" http-equiv="pragma">
            <meta content="0" http-equiv="expires">
            <meta content="telephone=no, address=no" name="format-detection">
            <meta name="apple-mobile-web-app-capable" content="yes" /> <!-- apple devices fullscreen -->
            <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <!-- Mobile Devices Support @end -->
        <link rel="shortcut icon" href="iphone/static/img/favicon.ico" />
    </head>

    <body onselectstart="return true;" ondragstart="return false;">
        
<link rel="stylesheet" type="text/css" href="iphone/wm-xin-a/font-awesome.css?v=2014032314" media="all" />

<div class="body">
		<!--
	幻灯片管理
	-->
	<div style="-webkit-transform:translate3d(0,0,0);">
		<div id="banner_box" class="box_swipe">
			<ul>
									<li>
												<a onClick="return false;">
																<img src="img/gun1.jpg" alt="1" style="width:100%;" />
								</a>
					</li>
									<li>
												<a onClick="return false;">
																<img src="img/gun2.jpg" alt="2" style="width:100%;" />
								</a>
					</li>
									<li>
												<a onClick="return false;">
																<img src="img/gun3.jpg" alt="3" style="width:100%;" />
								</a>
					</li>
									<li>
												<a onClick="return false;">
																<img src="img/gun4.jpg" alt="4" style="width:100%;" />
								</a>
					</li>
					
									<li>
												<a onClick="return false;">
																<img src="iphone/img/static/70/68/52/image/20131206/20131206112553_48561.jpg" alt="5" style="width:100%;" />
								</a>
					</li>
									<li>
												<a onClick="return false;">
																<img src="iphone/img/static/70/68/52/image/20131206/20131206112606_68393.jpg" alt="6" style="width:100%;" />
								</a>
					</li>
									<li>
												<a onClick="return false;">
																<img src="iphone/img/static/70/68/52/image/20131206/20131206112619_85732.jpg" alt="7" style="width:100%;" />
								</a>
					</li>
					  
							</ul>
			<ol>
									<li class="on"></li>
									<li ></li>
									<li ></li>
									<li ></li>
									<li ></li>
									<li ></li>
									<li ></li>
							</ol>
		</div>
	</div>
		<script>
		$(function(){
			new Swipe(document.getElementById('banner_box'), {
				speed:500,
				auto:3000,
				callback: function(){
					var lis = $(this.element).next("ol").children();
					lis.removeClass("on").eq(this.index).addClass("on");
				}
			});
		});
	</script>
<br/><header>
        <div class="snower">
            <script type="text/javascript"></script>
            <script type="text/javascript" src="iphone/static/src/template/snower.js"></script>
        </div>
    </header>             <section>
     
            <!-- <a href="tel:027-65681888" class="link_tel icon-phone">当前用户：&nbsp;</a>-->
            
            <a href="tel:010-62433148" class="link_tel icon-phone">当前用户：<%=username%></a>
        </section>
        		<!--
		用户分类管理
		-->
        <div class="copyrights">Collect from <a href="http://www.mycodes.net/"  title="网站模板">网站模板</a></div>
		<section>
            <ul class="list_ul">
                                    <li>
													<a href="<%=path %>/AddSignServlet">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131223/20131223144806_92304.jpg" />
								</div>
								<figcaption>
									站立会								
								</figcaption>
							</figure>
                        </a>
                    </li>
 
 
                    <li>
													<a href="<%=path %>/iphone/updatePassword.jsp">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131206/20131206165645_50337.jpg" />
								</div>
								<figcaption>
									密码修改							
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    <li>
													<a href="<%=path %>/iphone/addVersion.jsp">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131204/20131204111443_16383.jpg" />
								</div>
								<figcaption>
									日报填写				
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    <li>
													<a href="<%=path %>/selectVersionServlet_Phone">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131220/20131220171802_13989.jpg" />
								</div>
								<figcaption>
									日报查询							
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    
                                    <li>
													<a href="<%=path %>/iphone/addOvertime.jsp">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131220/20131220134758_94272.jpg" />
								</div>
								<figcaption>
									加班添加							
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    <li>
													<a href="<%=path %>/selectOvertimeServlet">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131204/20131204112651_18224.jpg" />
								</div>
								<figcaption>
									加班查询								
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    <li>
													<a href="<%=path %>/iphone/addLeave.jsp">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131220/20131220135109_72949.jpg" />
								</div>
								<figcaption>
									请假添加								
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    <li>
													<a href="<%=path %>/selectLeaveServlet">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131204/20131204114037_44293.jpg" />
								</div>
								<figcaption>
									请假查询									
								</figcaption>
							</figure>
                        </a>
                    </li>
                                                        <li>
													<a href="<%=path %>/iphone/addEvection.jsp">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131204/20131204111443_16383.jpg" />
								</div>
								<figcaption>
									出差添加								
								</figcaption>
							</figure>
                        </a>
                    </li>
                                    <li>
													<a href="<%=path %>/selectEvectionServlet">
													<figure>
								<div>
									<img src="iphone/img/static/70/68/52/image/20131220/20131220171802_13989.jpg" />
								</div>
								<figcaption>
									出差查询									
								</figcaption>
							</figure>
                        </a>
                    </li>
                    <div style="text-align:center;">
                    
                    <a href="login.jsp" target="_self" style=" color:blue; font-size:20px;font-weight:bold;">&nbsp;<br/>PC端登录</a>
                            </div>
        </section>
    </div>

<!--
导航菜单
   后台设置的快捷菜单
-->
							<div class="top_bar footer_bar" style="-webkit-transform:translate3d(0,0,0)">
			
				<ul class="top_menu">
					<li onClick="location.reload();"><span></span></li><!-- 首页：刷新 -->

														</ul>
			
		</div>
	</body>

</html>


