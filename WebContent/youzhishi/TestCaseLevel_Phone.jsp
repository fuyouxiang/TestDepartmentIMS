<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1,  user-scalable=no">
		<meta http-equiv="pragma" content="no-cache">
	 	<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	
		<link rel="stylesheet" href="css/base.css">
		<link rel="stylesheet" href="css/style3.css" media="screen" type="text/css" />
		<script type="text/javascript" src="js/jquery-1.10.2.min.js" ></script>
		<script type="text/javascript" src="js/TouchSlide.1.1.js" ></script>
		<script type="text/javascript" src="js/sui.nav.js" ></script>
<title>测试用例文件夹</title>
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
			
			function TypeImages() {
			var type=document.getElementsByName("isBuy") ;   
			}
		</script>		
		
		
<body>
<form action="<%=path %>/selectTestCaseLevelServlet"  name="MyPageForm" method="post"  id="pageForm" >
	    <input  type="hidden" name="currentPage" id="currentPage" value="<%=pageBean.getNowPage()%>"/>
	    <input type="hidden" id="nextPageId"  name="nextPage" value="1" />
    </form>
		<div class="top_dingw">
			<div class="top_bg" id="top_bg">
				<div class="top_main">
					<div class="top_logo">
						<a href='index_youzhishi.jsp'><img src="images/logo_youzhishi.png"></a>
					</div>
					<div class="top_search">
				</div>
				<div style="clear: both;"></div>
			</div>
        </div>


		<!--banner 图 star-->
		<div class="banner">
		</div>


		<!--banner 图 end-->
		<!--新闻列表 star-->
		<div class="shadow">
			<div class="zy_news">
				<ul>
				  <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean.getResList();
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                          		//传递学生信息
                          		
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
 
              %>
				
		            <li>
		                <a href="<%=path %>/selectTestCaseFileServlet?FILE_CATALOG=<%=stuMap.get("FILE_CATALOG") %>">
		                    <img src="images/tubiao/filebox.jpg">
		                    <dl>
		                        <dt><%=stuMap.get("FILE_CATALOG") %></dt>
		                        <dd>文件数量：<%=stuMap.get("COUNT(*)") %></dd>
		                        <dd></dd>
		                        <dd></dd>
		                        <span></span>
		                    </dl>
		                </a>
		            </li>

                        		
 						 <%  
                          }
                          
                          } 
                        
                        %>
                    <li>
					<dl>
						<dt>
						<input type="button" value="首页" id="fp" onclick="goPage(this)" />
						<input type="button" value="上一页" id="bp" onclick="goPage(this)" />
						第<%=pageBean.getNowPage()%>页/共<%=pageBean.getPages()%>页
						<input type="button" value="下一页" id="gp" onclick="goPage(this)" />
						<input type="button" value="尾页" id="lp" onclick="goPage(this)" />
						</dt>
					</dl>
				</li>
                        <%  
                          }
                          
                          
                        
                        %>


		        </ul>    
			</div>
        </div>
		<!--新闻列表  end-->

	</body>
</body>
</html>