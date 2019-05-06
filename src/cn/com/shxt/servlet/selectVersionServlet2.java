package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectVersionServlet2 extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入日报条件查询servlet------------------------------");
	
		
		//人名
		//request.setCharacterEncoding("UTF-8");
		String NAME1 =request.getParameter("NAME");
		String NAME=new String(NAME1.getBytes("ISO8859-1"),"UTF-8");
		System.out.println(time+"姓名："+NAME);
		//年度
		//String YEAR =request.getParameter("YEAR");
		//System.out.println(time+"年度："+YEAR);
		//月份
		String MONTH =request.getParameter("MONTH");
		System.out.println(time+"月份："+MONTH);
		
		
		
		if(NAME1.length()>=2&&MONTH.trim().equals("")){			
			//姓名不为空、月份为空
			String sql = "select V_ID,V_MONTH,substr(V_DATE,9,2),V_WEEK,V_NAME,V_BASICS,V_WORK,V_TIME,V_TYPE,V_BUG,V_DOCUMENT,V_CASE from SYS_VERSION where V_NAME like '%"+NAME+"%' order by V_DATE desc,V_NAME";
			System.out.println(time+"工作情况条件查询sql："+sql);
			System.out.println(time+"姓名不为空、月份为空");
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("User/selectVersion2.jsp").forward(request, response);
		}else if(NAME1.length()>=2&&MONTH.trim()!=("")){
			//姓名、月份都不为空
			String sql = "select V_ID,V_MONTH,substr(V_DATE,9,2),V_WEEK,V_NAME,V_BASICS,V_WORK,V_TIME,V_TYPE,V_BUG,V_DOCUMENT,V_CASE from SYS_VERSION where   V_MONTH='"+MONTH+"' and V_NAME like '%"+NAME+"%'order by V_DATE desc,V_NAME";			
			System.out.println(time+"工作情况条件查询sql："+sql);
			System.out.println(time+"姓名、月份都不为空");
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("User/selectVersion2.jsp").forward(request, response);
		} else if(NAME1.length()<2&&MONTH.trim()!=("")){
			String sql = "select V_ID,V_MONTH,substr(V_DATE,9,2),V_WEEK,V_NAME,V_BASICS,V_WORK,V_TIME,V_TYPE,V_BUG,V_DOCUMENT,V_CASE from SYS_VERSION where V_MONTH='"+MONTH+"' order by V_DATE desc,V_NAME";
			System.out.println(time+"工作情况条件查询sql："+sql);
			System.out.println(time+"姓名为空、月份不为空");
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("User/selectVersion2.jsp").forward(request, response);
		}else{
			String sql = "select V_ID,V_MONTH,substr(V_DATE,9,2),V_WEEK,V_NAME,V_BASICS,V_WORK,V_TIME,V_TYPE,V_BUG,V_DOCUMENT,V_CASE from SYS_VERSION order by V_DATE desc,V_NAME";
			System.out.println(time+"工作情况条件查询sql："+sql);
			System.out.println(time+"姓名、月份为空");
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("User/selectVersion2.jsp").forward(request, response);
		}
	}



}
