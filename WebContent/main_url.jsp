<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.ping" pageEncoding="gb2312"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
PageBean pageBean2=(PageBean)request.getAttribute("pageBean2");
PageBean pageBean3=(PageBean)request.getAttribute("pageBean3");
PageBean pageBean4=(PageBean)request.getAttribute("pageBean4");
//System.out.println(pageBean.toString()) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="工作台" />
<title>人力资源管理平台</title>
<link type="text/css" rel="stylesheet" href="css/css_url.css" />
</head>
<% String username = (String)session.getAttribute("username"); %>
<script type="text/javascript" src="js/bootstrap.js"></script>





<script language="javascript">

function shuaxinUrl(){
	window.location.href="<%=path %>/selectAllUrlServlet";
}


/*
 * 在使用setInterval方法时，每一次启动都需要对setInterval方法返回的值做一个判断，判断是否是空值，若不是空值，则要停止定时器并将值设为空，再重新启动，
 * 如果不进行判断并赋值，有可能会造成计时器循环调用，在同等的时间内同时执行调用的代码，并会随着代码的运行时间增加而增加，导致功能无法实现，
 * 甚至占用过多资源而卡死奔溃。因此在每一次使用setInterval方法时，都需要进行一次判断。
 */
var interval = null;//计时器
if(interval!=null){//判断计时器是否为空
	clearInterval(interval);
interval=null;
}
//重复执行某个方法 60秒*5
interval = setInterval(shuaxinUrl,60000*5);

		
</script>  















<body>

<!-- 滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:550px;">

<div class="container">
  <!--
  
    <div class="currmenu">
      <ul class="rig_nav">
        <li class="rig_seleli"><a href="#">当前</a><span> x </span></li>
        <li><a href="#">个人中心</a></li>
        <li><a href="#">绩效管理</a></li>
        <li><a href="#">绩效计划制定</a></li>
      </ul>
    </div>
    
     -->
    <div class="adtip">
      <div class="tip">
                           <%
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean4.getResList();
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
                            	   String DAIBAN=stuMap.get("DAIBAN");
                            	   if(DAIBAN.equals("1")){
                            		   DAIBAN="今天没有代办事项(^.^) ！";
                            	   } else if(DAIBAN.equals("0")){
                            		  DAIBAN="您有 1 条代办事项，今天的工作日报还未完成！";
                            	   }

                          %>
        <p class="goom"><%=username%>，&nbsp;&nbsp;<b><%=DAIBAN%></b></p>

                          <%     
                               }
                           }
                        
                          }
                        %>
        
        <!-- 
        <p>您目前有<span>0</span>条待办，<span>0</span>条考勤异常，<span>0</span>条通知！</p>
         -->
      </div>

      <div class="adv">
                     <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean3.getResList();
                        	  int m=0;
							 Map<String, String>  stuMap= resList.get(m);                           	   

                        	
                          %>
                <p><b><span>&nbsp;●&nbsp;<%=stuMap.get("JI_TITLE") %></span></b></p>
                                          <%     
   
                               }
                        	  
                        %>
        

        </div>

        
    </div>
    <div class="rig_link">
      <ul>
        <li><a href="<%=path %>/selectVersionServlet"><img src="images/img_01.jpg" alt="" title="工作情况"></a></li>
        <li><a href="<%=path %>/selectOvertimeServlet"><img src="images/img_04.jpg" alt="" title="加班情况"></a></li>
        <li><a href="<%=path %>/selectEvectionServlet"><img src="images/img_02.jpg" alt="" title="出差情况"></a></li>
        <li><a href="<%=path %>/selectLeaveServlet"><img src="images/img_03.jpg" alt="" title="请假情况"></a></li>
      </ul>
    </div>
        <div class="rig_lm03">
    
   		
      <div class="title"><img src="images/listicon.jpg" class="icon" style="padding-top:13px;">
        <h2>服务列表</h2>
      </div>
<%

%>
      <div class="detail">
        <div class="inner03">
          <div id="tabCot_product" class="zhutitab">
            <div class="tabContainer">
              <ul class="tabHead" id="tabCot_product-li-currentBtn-">
                    
                     <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean.getResList();
                        	  int m=0;
							 Map<String, String>  stuMap= resList.get(m);                           	   

                        	
                          %>
                <li class="currentBtn"><a href="javascript:start();" title="服务列表" rel="1">服务列表</a><span class="red_numb"><%=stuMap.get("URL_COUNT") %></span></li>
                                          <%     
   
                               }
                        	  
                        %>

                <!-- 
                <li ><a href="<%=path %>/selectAllUrlServlet" title="6系列服务列表" rel="2">6系列服务列表</a><span class="grey_numb"></span></li>
                <li ><a href="javascript:void(0)" title="第三方服务列表" rel="3">第三方服务列表</a><span class="red_numb"></span></li>
                 -->
              </ul>

              <p class="shent">     
     <form action="<%=path%>/AddUrlServlet" method="post" id=formId name="formname">&nbsp;&nbsp;
              服务名称：<input name="URL_NAME" id="URL_NAME" class="text" style="width:150px" type="text" />
              服务地址：<input name="URL_ADDRESS" id="URL_ADDRESS" class="text" style="width:250px" type="text" />
              创建人：<input name="URL_CREATER" id="URL_CREATER" class="text" style="width:100px" type="text"/>
     <input type="submit"  value="新增" />　
    </form>
    <!-- 
                <input style="width:30px;" type="text" value="10">
                <img src="images/sz.jpg" class="icon" style="">--></p>
              <div class="clear"></div>
              
            </div>
            <div id="tabCot_product_1" class="tabCot" >
              <table class="tabindex" width="100%" border="0" cellpadding="0" cellspacing="0">
              
                <tr>
                  <th width="5%" bgcolor="#f8f8f8" scope="col"><div align="center" style="font-size:15px;text-align:center;font-weight:bold">编号</div></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><div align="center" style="font-size:15px;text-align:center;font-weight:bold">运行状态</div></th>
                  <th width="25%" bgcolor="#f8f8f8" scope="col"><div align="center" style="font-size:15px;text-align:center;font-weight:bold">URL地址</div></th>
                  <th width="15%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">服务名称</span><span class="xila">&or;</span></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">创建时间</span><span class="xila">&or;</span></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">创建人</span><span class="xila">&or;</span></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">服务状态</span><span class="xila">&or;</span></th>
                  <th width="15%" bgcolor="#f8f8f8" scope="col" style="font-size:15px;text-align:left;font-weight:bold">操作</th>
                </tr>
      
                     <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean.getResList();
                        	 
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                          		//
                          		boolean STATE= false;
                          		ping pi= new ping();
                          		
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
                            	   String URL_ADDRESS=stuMap.get("URL_ADDRESS");
                            	   String src = null;
                                   try {
                                   	STATE=pi.ping(URL_ADDRESS);
                           			System.out.println(STATE);
                                	} catch (Exception e) {
                           			// TODO Auto-generated catch block
                           			e.printStackTrace();
                           		   }
                                   
                                   if(STATE==true){
                                	   src = "greencol";
                                   }else{
                                	   src = "yccol";
                                   }


                        	
                          %>
                <tr>
                  <td bgcolor="#FFFFFF"><div align="center"><%=i+1 %></div></td>
                  <td style="font-size:15px;text-align:center;font-weight:bold;" class="<%=src %>" bgcolor="#FFFFFF"><div align="center"><%=STATE %></div></td>
                  <td style="font-size:15px;text-align:center;font-weight:bold" bgcolor="#FFFFFF"><div align="center"><a href="<%=stuMap.get("URL_ADDRESS") %>" target="_blank"><b><%=URL_ADDRESS%></b></a></div></td>
                  <td bgcolor="#FFFFFF" class="datacol"><%=stuMap.get("URL_NAME") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_DATE") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_CREATER") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_STATE") %></td>
                  <td  bgcolor="#FFFFFF"><a class="datacol" href="<%=path %>/UpdateUrlServlet?caozuo=stop&urlid=<%=stuMap.get("URL_ID") %>">停用</a>&nbsp;&nbsp;<a class="datacol" href="<%=path %>/UpdateUrlServlet?caozuo=start&urlid=<%=stuMap.get("URL_ID") %>">启用</a>&nbsp;&nbsp;<a href="<%=path %>/UpdateUrlServlet?caozuo=delete&urlid=<%=stuMap.get("URL_ID") %>" style="color:black">删除</a></td>
                </tr>
 
  		
                          <%     
   
                               }
                           }
                        %>

                        <%  
                        
                        
                          }
                   
                        
                        %>

                         
              </table>
              <!-- 
              <div class="fanye">
                <div class="yem">
                  <ul>
                    <li><a href="#">First</a></li>
                    <li><a href="#">&lt;</a></li>
                    <li class="sellify"><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">&gt;</a></li>
                    <li><a href="#">Last</a></li>
                  </ul>
                </div>
              </div>
            </div>
            <div id="tabCot_product_2" class="tabCot"  style="display: none;"> 2222222222 </div>
            <div id="tabCot_product_3" class="tabCot"  style="display: none;"> 3333333333 </div>
            <script language="JavaScript" type="text/javascript" src="js/tab.js"></script>  -->
          </div>
        </div>
      </div>
    </div>
    
    
    
    <div class="rig_lm01">
      <div class="title"><img src="images/listicon.jpg" class="icon" style="padding-top:13px;">
        <h2>通知</h2>
                          <%
                        	
                          if(pageBean2!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean2.getResList();
                        	  int n=1;
							 Map<String, String>  stuMap= resList.get(n);                           	   
                          %>   
        <span class="red_numb"><%=stuMap.get("GON_COUNT") %></span>
                                                  <%     
   
                               }
                        	  
                        %>
                        </div>
      <div class="detail">
      
                           <%
                        	
                          if(pageBean2!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean2.getResList();
                        	 
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                          		//
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
                            	   String GON_DATE=stuMap.get("GON_DATE");
                            	   String Month = GON_DATE.substring(5, 7);
                            	   String DAY = GON_DATE.substring(8, 10);
                            	   
                          %>
        <div class="dat01"> <span class="datti"><span><%=DAY %></span> <br />
          <span class="jan"><%=Month %>月</span></span> <span class="sqdeta"><img src="images/bs_04.jpg"><%=stuMap.get("GON_TITLE") %></span>
          <p class="linkbut"><a href="#">查看</a></p>
        </div>
                                  <%     
   
                               }
                           }
                        %>

                        <%  
                        
                        
                          }
                   
                        
                        %>
           <!--       
        <div class="dat02"> <span class="datti"><span>20</span> <br />
          <span class="jan">jan</span></span> <span class="sqdeta"><img src="images/bs_04.jpg"> 您提交的请假申请未审批通过</span>
          <p class="linkbut"><a href="#">查看</a><a href="#">知道了</a></p>
        </div>  -->      
      </div>
    </div>
    
    <!-- 
    <div class="rig_lm02">
      <div class="title"><img src="images/listicon.jpg" class="icon" style="padding-top:13px;">
        <h2>服务运行情况</h2>
      </div>
      <div class="detail">
        <div class="det_inner">
          <div class="jd"><img src="images/jd.jpg" alt="" title=""></div>
          <div class="bs">
            <p><img src="images/bs_01.jpg" alt="" title=""> 运行正常</p>
            <p><img src="images/bs_02.jpg" alt="" title=""> 运行异常</p>
          </div>
          <div class="scordeti">
            <ul>
              <li>
                <p class="ywc">12</p>
                <h3>服务运行中</h3>
              </li>
              <li>
                <p class="wwc">1</p>
                <h3>服务运行警告</h3>
              </li>
              <li>
                <p class="ycd">2</p>
                <h3>服务运行异常</h3>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
 -->
  </div>
</div>
<div class="footer"></div>
</body>
</html>