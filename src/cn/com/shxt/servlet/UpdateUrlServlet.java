package cn.com.shxt.servlet;

import java.io.IOException;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;











import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class UpdateUrlServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292614L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}
	
	//读取上传地址配置文件
	public ResourceBundle uploadAddress(){
		
		Properties prop = new Properties();
		//装载Properties配置文件
		ResourceBundle resource = ResourceBundle.getBundle("uploadAddress");
		return resource;
	}
		   
		   
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
			//时间戳，直接调用DateTime.java中的方法
			String timelog= DateTime.showtime();
	       System.out.println(timelog+"进入修改URLservlet，开始在数据库修改URL数据——————————————");

	       	//读取上传地址配置文件
			ResourceBundle resource = uploadAddress();

			 String path =resource.getString("uploadAddress");
		     //String path = "D:/uploadfile/";
		     System.out.println("上传路径："+path);
		     
		     request.setCharacterEncoding("UTF-8");  //设置编码 
		     String Caozuo = request.getParameter("caozuo");
		     System.out.println("操作名称：" + Caozuo);
		     String URL_ID = request.getParameter("URL_ID");	//操作名称
		     System.out.println("URL_ID："+URL_ID);
		     
			       



				   DBUtils dbutil = new DBUtils();
				    String sql = null;
				    if (Caozuo.equals("stop")) {
				      System.out.println("停用操作——————");
				      sql = "update sys_url set URL_STATE ='停用' where URL_ID='" + URL_ID + "'";
				      System.out.println(sql);
				    }
				    else if (Caozuo.equals("start")) {
				      System.out.println("启用操作——————");
				      sql = "update sys_url set URL_STATE ='启用' where URL_ID='" + URL_ID + "'";
				      System.out.println(sql);
				    }
				    else if (Caozuo.equals("delete")) {
				      System.out.println("删除操作——————");
				      sql = "delete from sys_url where URL_ID='" + URL_ID + "'";
				      System.out.println(sql);
				    } 
				    else if (Caozuo.equals("file")) {
					      System.out.println("修改url附件操作——————");
					      
					       String ATTACH_NAME_TEST = request.getParameter("ATTACH_NAME");	//文件名称     
					       System.out.println("未转码文件名称："+ATTACH_NAME_TEST);
					       String ATTACH_NAME;
					       if (!(java.nio.charset.Charset.forName("GBK").newEncoder().canEncode(ATTACH_NAME_TEST))) {
					    	   System.out.println("判断文件名称为乱码！开始转码————————");
					    	   ATTACH_NAME= new String(ATTACH_NAME_TEST.getBytes("iso8859-1"),"UTF-8");
					       }else{
					    	   System.out.println("判断文件名称不是乱码："+ATTACH_NAME_TEST);
					    	   ATTACH_NAME=ATTACH_NAME_TEST;
					       }
					       System.out.println("最后的文件名称 ："+ATTACH_NAME);

					       String ATTACH_PATH=path+ATTACH_NAME;//文件路径
						   System.out.println("文件路径："+ATTACH_PATH);
						   
						   //tomcat和weblogic好像不一样
					      sql = "update sys_url set ATTACH_NAME ='"+ATTACH_NAME+"',ATTACH_PATH='"+ATTACH_PATH+"' where URL_ID='" + URL_ID + "'";
					      System.out.println(sql);
					    } 
				    else {
				      response.setContentType("text/html; charset=UTF-8");
				      response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='selectAllUrlServlet';</script>");
				    }

			       

			   int flag = dbutil.update(sql);
			   System.out.println(flag);
		        
			   response.setContentType("text/html; charset=UTF-8");
		        if(flag>0){
		    	response.getWriter().println("<script>alert('操作成功！');window.location.href='selectAllUrlServlet';</script>");
		    	 }else{
		        response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='selectAllUrlServlet';</script>");
		    	 }   
		    	/*
				String sql = "insert into sys_url (URL_NAME,URL_ADDRESS,URL_CREATER,URL_DATE,URL_STATE) values " +"('" + URL_NAME + "','" + URL_ADDRESS + "','" + URL_CREATER + "','" + URL_DATE + "','" + URL_STATE + "')";
				int flag = dbutil.update(sql);
				
		        //request.getRequestDispatcher("Sys.jsp").forward(request, response); 
		        //request.getRequestDispatcher("<script>alert('服务添加成功！');location.href='<%=path %>/selectAllUrlServlet'</script>").forward(request, response);


 
	
	*/
	}
	        
	
	
}
