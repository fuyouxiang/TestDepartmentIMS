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

public class AddUrlServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292614L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}
	

		   
		   
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	       System.out.println("进入新增URLservlet，开始在数据库插入URL数据——————————————");

			       request.setCharacterEncoding("UTF-8");  //设置编码 
			       String URL_NAME = request.getParameter("URL_NAME");	//服务名称  
			       System.out.println("服务名称   "+URL_NAME);
			       String URL_ADDRESS =request.getParameter("URL_ADDRESS");//服务地址
			       System.out.println("服务地址 "+URL_ADDRESS);
			       String URL_CREATER = request.getParameter("URL_CREATER");//创建人
			       System.out.println("创建人"+URL_CREATER);
				   SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
				   String time=df.format(new Date());// new Date()为获取当前系统时间//时间戳，直接调用DateTime.java中的方法
			       String URL_DATE = time;//创建时间
			       System.out.println("创建时间 "+URL_DATE);
			       String URL_STATE = "启用";//状态
			       System.out.println("状态 "+URL_STATE);

		        
		        DBUtils dbutil =new DBUtils();
				String sql = "insert into sys_url (URL_NAME,URL_ADDRESS,URL_CREATER,URL_DATE,URL_STATE) values " +
						"('" + URL_NAME + "','" + URL_ADDRESS + "','" + URL_CREATER + "','" + URL_DATE + "','" + URL_STATE + "')";
				int flag = dbutil.update(sql);
				
		        //request.getRequestDispatcher("Sys.jsp").forward(request, response); 
		        //request.getRequestDispatcher("<script>alert('服务添加成功！');location.href='<%=path %>/selectAllUrlServlet'</script>").forward(request, response);
	
		        response.setContentType("text/html; charset=UTF-8");
		    	 if(flag>0){
		    	response.getWriter().println("<script>alert('服务添加成功！');window.location.href='selectAllUrlServlet';</script>");
		    	 }else{
		        response.getWriter().println("<script>alert('服务添加异常，请联系管理员！');window.location.href='selectAllUrlServlet';</script>");
		    	 }    
	
	
	}
	        
	
	
}
