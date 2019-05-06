package cn.com.shxt.servlet;

import java.io.IOException;


import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectTestServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入测试情况统计查询servlet------------------------------");
		
		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
		
		//String sql1 = "select t_id,t_name,t_case,t_document,t_bug,t_year from sys_test where t_year='2018' order by t_name ";
		String sql1 ="select count(DISTINCT v_date),v_name,sum(v_time),sum(v_case),sum(v_document),sum(v_bug) from sys_version group by v_name";
		System.out.println(time+"个人资源统计sql："+sql1);
		
		
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("resource/listtest.jsp").forward(request, response);
	}



}
