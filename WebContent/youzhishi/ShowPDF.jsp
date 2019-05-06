<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//获取之前得到的分页对象
PageBean pageBean=(PageBean)request.getAttribute("pageBean");
//System.out.println(pageBean.toString()) ;
%>//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%

	//获得ATTACH_PATH 
	String ATTACH_PATH1=request.getParameter("ATTACH_PATH");   
	System.out.print("ATTACH_PATH："+ATTACH_PATH1+"====================");

	String ATTACH_PATH = new String(request.getParameter("ATTACH_PATH").getBytes("iso-8859-1"), "utf-8");
	System.out.print("转码后ATTACH_PATH："+ATTACH_PATH+"====================");

	out.clear();
   out = pageContext.pushBody();
   response.setContentType("application/pdf");
 
   try {
    String strPdfPath = new String(ATTACH_PATH);
    //判断该路径下的文件是否存在
    File file = new File(strPdfPath);
    if (file.exists()) {
     DataOutputStream temps = new DataOutputStream(response
       .getOutputStream());
     DataInputStream in = new DataInputStream(
       new FileInputStream(strPdfPath));
 
     byte[] b = new byte[2048];
     while ((in.read(b)) != -1) {
      temps.write(b);
      temps.flush();
     }
 
     in.close();
     temps.close();
    } else {
     out.print(strPdfPath + "PDF文件不存在!");
    }
 
   } catch (Exception e) {
    out.println(e.getMessage());
   }
%>
<body>

</body>
</html>