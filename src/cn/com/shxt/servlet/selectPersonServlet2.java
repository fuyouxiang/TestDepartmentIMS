package cn.com.shxt.servlet;

import java.io.IOException;


import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectPersonServlet2 extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入个人资源统计查询servlet------------------------------");
		
		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
		
		//String sql1 = "select p_id,p_name,p_overtime,p_evection,p_leave,p_year,p_month from sys_person where p_year='2018' order by p_name ";
		String sql1 = "select p_name,p_year,sum(p_overtime),sum(p_evection),sum(p_leave) from sys_person  group by p_name,p_year";
		System.out.println(time+"个人资源统计sql："+sql1);
		

		
		
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("resource/listperson.jsp").forward(request, response);
	}



}
