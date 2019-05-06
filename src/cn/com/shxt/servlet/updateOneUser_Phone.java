package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Sys_user;
import cn.com.shxt.service.bean.UserServiceBean;;

public class updateOneUser_Phone extends HttpServlet {

	
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		
		String name1 = request.getParameter("name");
		//解决request.getParameter获取中文乱码问题
		String name=new String(name1.getBytes("ISO8859-1"),"UTF-8");	
		System.out.println(time+"正在修改用户资料...用户name为："+name);
		UserServiceBean ss = new UserServiceBean();
		//Sys_user user = ss.selectOneStudentName(name);
		Sys_user user = ss.selectOneStudentName(name);
		request.setAttribute("user", user);
		request.getRequestDispatcher("/guanliyuan/UserUpdate_phone.jsp").forward(request, response);
	}

}
