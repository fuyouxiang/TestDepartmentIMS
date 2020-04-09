<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<script type="text/javascript">
	//提交
	function submitUpdate(){
		var ID = document.getElementsByName('D_ID');
        window.location.href="<%=path%>/updateBBStateServlet?type=2&D_ID="+ID;
    }
	
	//操作记录 
	function Return(){
	   window.location.href="javascript:history.go(-1)";
	 }
</script>

<body>
<%
                        	
    if(pageBean!=null){
    //本页的结果集
    List<Map<String, String>>  resList=  pageBean.getResList();
    //System.out.print(resList);
    if(resList!=null && resList.size()>0){
    //传递学生信息
                          		
    for(int i=0;i<resList.size();i++){
    Map<String, String>  stuMap= resList.get(i);
     
    //是否带脚本
    String D_ISSQL= stuMap.get("D_ISSQL");
    if(D_ISSQL.equals("0")){
  	  D_ISSQL="否";
    }else if(D_ISSQL.equals("1")){
  	  D_ISSQL="是";
    }else{
  	  D_ISSQL ="未知";
	  }
    
    //是否发江西
    String D_ISJXXC = stuMap.get("D_ISJXXC");
    if(D_ISJXXC.equals("0")){
  	  D_ISJXXC="否";
    }else if(D_ISJXXC.equals("1")){
  	  D_ISJXXC="是";
    }else{
  	  D_ISJXXC ="未知";
	  }
    
    //是否更新压测环境
    String D_ISYCHJ = stuMap.get("D_ISYCHJ");
    if(D_ISYCHJ.equals("0")){
  	  D_ISYCHJ="未更新";
    }else if(D_ISYCHJ.equals("1")){
  	  D_ISYCHJ="已更新";
    }else{
  	  D_ISYCHJ ="未知";
	  }
    
    //是否更新yth2020环境
    String D_ISYTH2020 = stuMap.get("D_ISYTH2020");
    if(D_ISYTH2020.equals("0")){
    	D_ISYTH2020="未更新";
    }else if(D_ISYTH2020.equals("1")){
    	D_ISYTH2020="已更新";
    }else{
    	D_ISYTH2020 ="未知";
	  }
    
    //是否更新jxpre环境
    String D_ISJXPRE = stuMap.get("D_ISJXPRE");
    if(D_ISJXPRE.equals("0")){
  	  D_ISJXPRE="未更新";
    }else if(D_ISJXPRE.equals("1")){
  	  D_ISJXPRE="已更新";
    }else{
  	  D_ISJXPRE ="未知";
	  }
    
    
%>	
	<button onclick="Return()">返回主菜单</button>
	<form action="<%=path%>/updateBBStateServlet?type=2&D_ID=<%=stuMap.get("D_ID") %>" name="formname" method="post" id =formId >
	ID：<input style="width:100px" name="D_ID" id='D_ID' type="text" size="12" value="<%=stuMap.get("D_ID") %>" readonly="readonly"/><br/>	
	部门：<input style="width:100px" name="D_BUMEN" id='D_BUMEN' type="text" size="12" value="<%=stuMap.get("D_BUMEN") %>" readonly="readonly"/><br/>
	微服务：<input style="width:100px" name="D_WEINAME" id='D_WEINAME' type="text" size="12" value="<%=stuMap.get("D_WEINAME") %>" readonly="readonly"/><br/>
	版本号：<input style="width:100px" name="D_VERSION" id='D_VERSION' type="text" size="12" value="<%=stuMap.get("D_VERSION") %>" readonly="readonly"/><br/>
	是否带脚本：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISSQL"  id="D_ISSQL">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISSQL") %>"> &nbsp;&nbsp;<%=D_ISSQL %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;是&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;否&nbsp;&nbsp;</option>
	</select><br/>
	是否发江西：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISJXXC"  id="D_ISJXXC">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISJXXC") %>"> &nbsp;&nbsp;<%=D_ISJXXC %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;是&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;否&nbsp;&nbsp;</option>
	</select><br/>  
	是否更新压测环境：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISYCHJ"  id="D_ISYCHJ">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISYCHJ") %>"> &nbsp;&nbsp;<%=D_ISYCHJ %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
	</select><br/>
	是否更新yth2020环境：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISYTH2020"  id="D_ISJXPRE">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISYTH2020") %>"> &nbsp;&nbsp;<%=D_ISYTH2020 %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
	</select><br/>
	是否更新jxpre环境：
	<select style="high:150;font-weight:bold;width:80px" name="D_ISJXPRE"  id="D_ISJXPRE">
	<option style="font-size:13px;" value="<%=stuMap.get("D_ISJXPRE") %>"> &nbsp;&nbsp;<%=D_ISJXPRE %> &nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="1"> &nbsp;&nbsp;已更新&nbsp;&nbsp;</option>
	<option style="font-size:13px;" value="0"> &nbsp;&nbsp;未更新&nbsp;&nbsp;</option>
	</select><br/>
	<input type="submit" value="提交" >
	</form>   
	<%     
  	}
	}
}
 %>
</body>
</html>