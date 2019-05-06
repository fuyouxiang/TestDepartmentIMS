package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Sys_user;
import cn.com.shxt.service.bean.UserServiceBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;


public class updatePassword_Phone extends HttpServlet {


	private static final long serialVersionUID = -5661463449353904524L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		request.setCharacterEncoding("UTF-8");	
		String name = request.getParameter("u_name");
		String oldpassword = request.getParameter("u_password");
		String newpassword = request.getParameter("u_password2");
		String oldpassword2 =MD5Helper.MD5(request.getParameter("u_password"));
		String newpassword2 =MD5Helper.MD5(request.getParameter("u_password2"));
		
		System.out.println(time+"正在修改密码："+name + oldpassword2+newpassword2);
//		Sys_user u = new Sys_user();
//		u.setU_id(Integer.parseInt(id));
//		u.setU_name(name);
//		u.setU_password(password2);
//		u.setU_state(state);

		DBUtils dbutil =new DBUtils();
		
		String  sql1=" SELECT * FROM sys_user WHERE u_name='"+name+"'  and u_password='"+oldpassword2+"' ";
		System.out.println(time+"正在验证原密码："+sql1);
		int flag1 = dbutil.update(sql1);
		String info ;
		
				
		if(flag1>0){

			String sql2= "update sys_user set u_password='"+newpassword2+"' where u_name='"+name+"'";
			System.out.println(time+"正在修改密码："+sql2);
			int flag2 = dbutil.update(sql2);
			if(flag2>0){
				info ="恭喜你!!修改密码成功";
				request.setAttribute("info", info);
				request.getRequestDispatcher("Sys_Phone.jsp").forward(request, response);
			}else{
				info ="不好意思,修改失败！";
				request.setAttribute("info", info);
				request.getRequestDispatcher("Sys_Phone.jsp").forward(request, response);
			}

			
		}else{
			info ="不好意思,原用户名或密码输入错误！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys_Phone.jsp").forward(request, response);
		}
		
		

	}
	 }  
	
			
	
	
	


