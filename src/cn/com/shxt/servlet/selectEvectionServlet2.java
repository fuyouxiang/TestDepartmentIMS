package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectEvectionServlet2 extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入出差条件查询servlet------------------------------");
	
		//年度
		//String YEAR =request.getParameter("YEAR");
		//System.out.println(time+"年度："+YEAR);
		//月份
		String MONTH =request.getParameter("MONTH");
		System.out.println(time+"月份："+MONTH);

		String sql = "select E_ID,E_MONTH,E_STARTDATE,E_ENDDATE,E_PLACE,E_REMARK,E_WORKTIME,E_DEPARTMENT,E_NAME from SYS_EVECTION where E_MONTH='"+MONTH+"' order by E_STARTDATE desc";
		
		System.out.println(time+"出差条件查询sql："+sql);
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		//往jsp页面传值
		request.getSession().setAttribute("MONTH", MONTH);
		//request.getSession().setAttribute("YEAR", YEAR);
		request.getRequestDispatcher("evection/listevection2.jsp").forward(request, response);
	}



}
