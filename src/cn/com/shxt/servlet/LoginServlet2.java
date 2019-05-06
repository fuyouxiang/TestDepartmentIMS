package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;


public class LoginServlet2 extends HttpServlet {


	private static final long serialVersionUID = -5661463449353904524L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		
		//接收表单数据
		System.out.println(time+"手机尝试登录操作");
		request.setCharacterEncoding("UTF-8");	
		String name = request.getParameter("userName");

		//String password = request.getParameter("password");
		String password2 =MD5Helper.MD5(request.getParameter("password"));
		System.out.println(time+"用户名"+name);
		System.out.println(time+"密码"+password2);
		
		
		DBUtils dbutil = new DBUtils();		

		String  sql=" SELECT u_id,u_name,u_password FROM sys_user WHERE u_name='"+name+"'  and u_password='"+password2+"' ";	

	    int flag = dbutil.update(sql);

		
		
	    String info ;
	    String name1 ;
	    if(flag > 0){
	    	   	
	    	name1 = name;
	    	request.setAttribute("name1",name1);
	    	//request.setAttribute("name1",name1);
	    	System.out.println(time+name1);
		    
	    	//创建姓名的session
		    HttpSession session = request.getSession();
		    session.setAttribute("username",name);
	    	
			//response.sendRedirect("index.jsp");
			request.getRequestDispatcher("index_iphone.jsp").forward(request, response);
			return;
		}else{
			info ="对不起,用户名或密码错误";
			request.setAttribute("info", info);
			request.getRequestDispatcher("LoginError.jsp").forward(request, response);
		}
	    
	 }  
	
		}
			
	
	
	


