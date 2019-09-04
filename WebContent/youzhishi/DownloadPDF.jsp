<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,java.net.*" pageEncoding="UTF-8"%> 
<%  
  //关于文件下载时采用文件流输出的方式处理：  
  //加上response.reset()，并且所有的％>后面不要换行，包括最后一个；  
  
  response.reset();//可以加也可以不加  
  response.setContentType("application/x-download");  
  
//application.getRealPath("/main/mvplayer/CapSetup.msi");获取的物理路径  
  
String filedownload1 = request.getParameter("ATTACH_PATH"); 
System.out.println("ATTACH_PATH："+filedownload1+"====================");

String filedownload = new String(request.getParameter("ATTACH_PATH").getBytes("iso-8859-1"), "utf-8");
System.out.println("转码后ATTACH_PATH："+filedownload+"====================");

String test = request.getParameter("ATTACH_NAME");
System.out.println("ATTACH_NAME"+test+"====================");

String filedisplay = new String(request.getParameter("ATTACH_NAME").getBytes("iso-8859-1"), "utf-8");
System.out.println("转码后ATTACH_NAME"+filedisplay+"====================");
 

String filedisplay2 = URLEncoder.encode(filedisplay,"utf-8");
response.addHeader("Content-Disposition","attachment;filename=" + filedisplay2); 

FileInputStream input = new FileInputStream(filedownload);
//修正 Excel在“xxx.xlsx”中发现不可读取的内容。是否恢复此工作薄的内容？如果信任此工作簿的来源，请点击"是"
response.setHeader("Content-Length", String.valueOf(input.getChannel().size()));
System.out.println("hahaha");

  
  java.io.OutputStream outp = null;  
  java.io.FileInputStream in = null;  
  try  
  {  
  outp = response.getOutputStream();  
  in = new FileInputStream(filedownload);  
  
  byte[] b = new byte[1024];  
  int i = 0;  
   
  while((i = in.read(b)) > 0)  
  {  
  outp.write(b, 0, i);  
  }  
  


//    
outp.flush();  
//要加以下两句话，否则会报错  
//java.lang.IllegalStateException: getOutputStream() has already been called for //this response    
out.clear();  
out = pageContext.pushBody();  
}  
  catch(Exception e)  
  {  
  System.out.println("Error!");  
  e.printStackTrace();  
  }  
  finally  
  {  
  if(in != null)  
  {  
  in.close();  
  in = null;  
  }  
//这里不能关闭    
//if(outp != null)  
  //{  
  //outp.close();  
  //outp = null;  
  //}  
  }  
%>  