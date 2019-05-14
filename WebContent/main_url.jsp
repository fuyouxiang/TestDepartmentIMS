<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="gb2312"%>
<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.ping"  %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
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




<body>

<!-- 滚动条 -->
<div style="overflow-x:hidden;overflow-y:scroll;width:100%;height:700px;">
<% String username = (String)session.getAttribute("username"); %>
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
        <p class="goom">早上好，<%=username%>！</p>
        <p>您目前有<span>0</span>条待办，<span>0</span>条考勤异常，<span>0</span>条通知！</p>
      </div>
      <div class="adv">
        <p>我也不知道这里显示个啥</p>
        <span> x </span> </div>
    </div>
    <div class="rig_link">
      <ul>
        <li><a href="#"><img src="images/img_01.jpg" alt="" title="新增"></a></li>
        <li><a href="#"><img src="images/img_03.jpg" alt="" title="修改"></a></li>
        <li><a href="#"><img src="images/img_02.jpg" alt="" title="停用"></a></li>
        <li><a href="#"><img src="images/img_04.jpg" alt="" title="刷新"></a></li>
      </ul>
    </div>
    <div class="rig_lm01">
      <div class="title"><img src="images/listicon.jpg" class="icon" style="padding-top:13px;">
        <h2>通知</h2>
        <span class="red_numb">2</span></div>
      <div class="detail">
        <div class="dat01"> <span class="datti"><span>20</span> <br />
          <span class="jan">jan</span></span> <span class="sqdeta"><img src="images/bs_03.jpg"> 您想王晓磊提交的换班申请已经通过，交换班次时间为2014-02-09  09:00-18:00，请按时上班！</span>
          <p class="linkbut"><a href="#">查看</a><a href="#">知道了</a></p>
        </div>
        <div class="dat02"> <span class="datti"><span>20</span> <br />
          <span class="jan">jan</span></span> <span class="sqdeta"><img src="images/bs_04.jpg"> 您提交的请假申请未审批通过</span>
          <p class="linkbut"><a href="#">查看</a><a href="#">知道了</a></p>
        </div>
      </div>
    </div>
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
                <li class="currentBtn"><a href="<%=path %>/selectAllUrlServlet" title="服务列表" rel="1">服务列表</a><span class="grey_numb"></span></li>
                <!-- 
                <li ><a href="<%=path %>/selectAllUrlServlet" title="6系列服务列表" rel="2">6系列服务列表</a><span class="red_numb"></span></li>
                <li ><a href="javascript:void(0)" title="第三方服务列表" rel="3">第三方服务列表</a><span class="red_numb"></span></li>
                 -->
              </ul>
              <p class="shent"><span>Show entries: </span>
                <input style="width:30px;" type="text" value="10">
                <img src="images/sz.jpg" class="icon" style=""></p>
              <div class="clear"></div>
            </div>
            <div id="tabCot_product_1" class="tabCot" >
              <table class="tabindex" width="100%" border="0" cellpadding="0" cellspacing="0">
              
                <tr>
                  <th width="15%" bgcolor="#f8f8f8" scope="col"><span class="center">运行状态</span><span class="xila">&or;</span></th>
                  <th width="16%" bgcolor="#f8f8f8" scope="col"><div align="center">URL地址</div></th>
                  <th width="14%" bgcolor="#f8f8f8" scope="col"><span class="titlab">服务名称</span><span class="xila">&or;</span></th>
                  <th width="15%" bgcolor="#f8f8f8" scope="col"><span class="titlab">创建时间</span><span class="xila">&or;</span></th>
                  <th width="14%" bgcolor="#f8f8f8" scope="col"><span class="titlab">创建人</span><span class="xila">&or;</span></th>
                  <th width="7%" bgcolor="#f8f8f8" scope="col"><span class="titlab">启用状态</span><span class="xila">&or;</span></th>
                  <th width="19%" bgcolor="#f8f8f8" scope="col">操作</th>
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
                                   try {
                                   	STATE=pi.ping(URL_ADDRESS);
                           			System.out.println(STATE);
                                	} catch (Exception e) {
                           			// TODO Auto-generated catch block
                           			e.printStackTrace();
                           		   }
                            	   

                        	
                          %>
                <tr>
                  <td class="yccol" bgcolor="#FFFFFF"><div align="center"><%=STATE %></div></td>
                  <td bgcolor="#FFFFFF"><div align="center"><a href="<%=stuMap.get("URL_ADDRESS") %>" target="_blank"><b><%=URL_ADDRESS%></b></a></div></td>
                  <td class="datacol" bgcolor="#FFFFFF"><%=stuMap.get("URL_NAME") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_DATE") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_CREATER") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_STATE") %></td>
                  <td class="czcol" bgcolor="#FFFFFF"><a href="#">刷新</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">查看</a></td>
                </tr>
 
  		
                          <%     
   
                               }
                        	  
                           }
                        %>

                        <%  
                          }
                   
                        
                        %>

                         
              </table>
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
            <script language="JavaScript" type="text/javascript" src="js/tab.js"></script> 
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<div class="footer"></div>
</body>
</html>