<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.Ping" pageEncoding="UTF-8"  %>
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
<title>财政云服务列表</title>
<link type="text/css" rel="stylesheet" href="css/css_url.css" />
</head>
<script type="text/javascript" src="js/bootstrap.js"></script>





<script language="javascript">

function shuaxinUrl(){
	window.location.href="<%=path %>/selectOtherUrlServlet";
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
<script type="text/javascript">
    function base64 (content) {
       return window.btoa(unescape(encodeURIComponent(content)));         
    }
    /*
    *@tableId: table的Id
    *@fileName: 要生成excel文件的名字（不包括后缀，可随意填写）
    */
    function tableToExcel(tableID,fileName){
        var table = document.getElementById(tableID);
      var excelContent = table.innerHTML;
      var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>";
      excelFile += "<head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head>";
      excelFile += "<body><table>";
      excelFile += excelContent;
      excelFile += "</table></body>";
      excelFile += "</html>";
      var link = "data:application/vnd.ms-excel;base64," + base64(excelFile);
      var a = document.createElement("a");
      a.download = fileName+".xls";
      a.href = link;
      a.click();
    }
</script>

<body>

<!-- 滚动条 -->
<div style="overflow-x:hidden;overflow-y:auto;width:100%;height:100%;">

<div class="container" >
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

        <div class="rig_lm03">
    
   		
      <div class="title"><img src="images/listicon.jpg" class="icon" style="padding-top:13px;">
        <h2>财政云服务列表</h2>
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
              <button style="font-size:15px;font-weight:bold;width:100px"  onclick="tableToExcel('tableAll','财政云服务列表');">导出Excel</button>
              <!--    
     <form action="<%=path%>/AddUrlServlet" method="post" id=formId name="formname">&nbsp;&nbsp;
              服务名称：<input name="URL_NAME" id="URL_NAME" class="text" style="width:150px" type="text" />
              服务地址：<input name="URL_ADDRESS" id="URL_ADDRESS" class="text" style="width:250px" type="text" />
              创建人：<input name="URL_CREATER" id="URL_CREATER" class="text" style="width:100px" type="text"/>
     <input type="submit"  value="新增" />　
    </form>
     -->  
    <!-- 
                <input style="width:30px;" type="text" value="10">
                <img src="images/sz.jpg" class="icon" style="">--></p>
              <div class="clear"></div>
              
            </div>
            <div id="tabCot_product_1" class="tabCot" >
              <table class="tabindex" width="100%" height="100%"border="0" cellpadding="0" cellspacing="0" id="tableAll">
              
                <tr>
                  <th width="5%" bgcolor="#f8f8f8" scope="col"><div align="center" style="font-size:15px;text-align:center;font-weight:bold">编号</div></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><div align="center" style="font-size:15px;text-align:center;font-weight:bold">运行状态</div></th>
                  <th width="25%" bgcolor="#f8f8f8" scope="col"><div align="center" style="font-size:15px;text-align:center;font-weight:bold">URL地址</div></th>
                  <th width="15%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">服务名称</span></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">创建时间</span></th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">创建人</span></th>
                  <th width="15%" bgcolor="#f8f8f8" scope="col"><span class="titlab" style="font-size:15px;text-align:center;font-weight:bold">附件</span>&nbsp;(点击下载)</th>
                  <th width="10%" bgcolor="#f8f8f8" scope="col" style="font-size:15px;text-align:left;font-weight:bold">操作</th>
                </tr>
      
                     <%
                        	
                          if(pageBean!=null){
                        	  //本页的结果集
                        	 List<Map<String, String>>  resList=  pageBean.getResList();
                        	 
                        	 //System.out.print(resList);
                          if(resList!=null && resList.size()>0){
                          		//
                          		boolean STATE= false;
                          		Ping pi= new Ping();
                          		
                               for(int i=0;i<resList.size();i++){
                            	   Map<String, String>  stuMap= resList.get(i);
                            	   
                            	   String URL_ADDRESS=stuMap.get("URL_ADDRESS");
                            	   String src = null;
                                   try {
                                	System.out.println("——————————————————————");
                                	System.out.println("ping路径："+URL_ADDRESS);
                                   	STATE=pi.ping(URL_ADDRESS);
                           			System.out.println("是否能连通："+STATE);
                                	} catch (Exception e) {
                           			// TODO Auto-generated catch block
                           			e.printStackTrace();
                           		   }

                                   if(STATE==true){
                                	   src = "greencol";
                                   }else{
                                	   src = "yccol";
                                   }

                                	String shortName1=stuMap.get("ATTACH_NAME");
                                   	System.out.println("未缩写文件名："+shortName1);
                                   	String shortName;
                                   	if(shortName1==null||shortName1.length() <= 0){
                                   		shortName="无";
                                   		System.out.println("缩写后的文件名："+shortName); 
                                   	}else{
                                       	int gang=shortName1.lastIndexOf("_");
                                       	shortName=shortName1.substring(0,gang);
                                       	String houzhui=shortName1.substring(shortName1.lastIndexOf(".")+1,shortName1.length());
                                       	shortName=shortName+"."+houzhui;
                                       	System.out.println("缩写后的文件名："+shortName);  
                                    }

                        	
                          %>
                <tr>
                  <td bgcolor="#FFFFFF"><div align="center"><%=i+1 %></div></td>
                  <td style="font-size:15px;text-align:center;font-weight:bold;" class="<%=src %>" bgcolor="#FFFFFF"><div align="center"><%=STATE %></div></td>
                  <td style="font-size:15px;text-align:center;font-weight:bold" bgcolor="#FFFFFF"><div align="center"><a href="<%=stuMap.get("URL_ADDRESS") %>" target="_blank"><b><%=URL_ADDRESS%></b></a></div></td>
                  <td bgcolor="#FFFFFF" class="datacol"><a href="<%=stuMap.get("URL_ADDRESS") %>" target="_blank" style="color:#1D79C7;"><%=stuMap.get("URL_NAME") %></a></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_DATE") %></td>
                  <td bgcolor="#FFFFFF"><%=stuMap.get("URL_CREATER") %></td>
                  <td bgcolor="#FFFFFF"><a href="youzhishi/DownloadPDF.jsp?ATTACH_PATH=<%=stuMap.get("ATTACH_PATH") %>&ATTACH_NAME=<%=stuMap.get("ATTACH_NAME") %>" target="_blank" style="color:#1D79C7;"><%=shortName %></a></td>
                  <td  bgcolor="#FFFFFF"><a class="datacol" onclick = "window.confirm('对不起，您暂无此操作权限。如需上传附件请联系测试部。')">附件上传</a>&nbsp;&nbsp;<a onclick = "window.confirm('对不起，您暂无此操作权限。如需删除请联系测试部。')" style="color:red;">删除</a></td>
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

  </div>
</div>
</div>
<div class="footer"></div>
</body>
</html>