package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Sys_user;
import cn.com.shxt.service.bean.UserServiceBean;;

public class updateOneUser extends HttpServlet {

	
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		String id = request.getParameter("id");
		//解决request.getParameter获取中文乱码问题
		//String name=new String(old.getBytes("ISO8859-1"),"UTF-8");	
		System.out.println(time+"正在修改用户资料...用户ID为："+id);
		UserServiceBean ss = new UserServiceBean();
		//Sys_user user = ss.selectOneStudentName(name);
		Sys_user user = ss.selectOneStudent(Integer.parseInt(id));
		request.setAttribute("user", user);
		request.getRequestDispatcher("/guanliyuan/UserUpdate.jsp").forward(request, response);
	}

}
