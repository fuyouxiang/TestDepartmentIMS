package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectPersonServlet extends HttpServlet {
	

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
	

		//姓名
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
			//String sql1 = "select count(DISTINCT v_date),t_id,t_name,t_case,t_document,t_bug,t_year from sys_test where t_year='"+YEAR+"' order by t_name ";
			String sql1 = "select p_name,p_year,sum(p_overtime),sum(p_evection),sum(p_leave) from sys_person where p_name like '%"+NAME+"%'  group by p_name,p_year";
			System.out.println(time+"姓名不为空、月份为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH+"月");
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listperson2.jsp").forward(request, response);
		}else if(NAME1.length()>=2&&MONTH.trim()!=("")){
			//姓名、月份都不为空
			String sql1 = "select p_name,p_year,sum(p_overtime),sum(p_evection),sum(p_leave) from sys_person where p_name like '%"+NAME+"%' and p_month='"+MONTH+"' group by p_name,p_year";
			System.out.println(time+"姓名、月份都不为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH+"月");
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listperson2.jsp").forward(request, response);
		}else if(NAME1.length()<2&&MONTH.trim()!=("")){
			//姓名为空、月份不为空
			String sql1 = "select p_name,p_year,sum(p_overtime),sum(p_evection),sum(p_leave) from sys_person where p_month='"+MONTH+"' group by p_name,p_year";
			System.out.println(time+"姓名为空、月份不为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH+"月");
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listperson2.jsp").forward(request, response);
		}else{
			//姓名、月份都为空
			String sql1 = "select p_name,p_year,sum(p_overtime),sum(p_evection),sum(p_leave) from sys_person  group by p_name,p_year";
			System.out.println(time+"姓名、月份都为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH+"月");
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listperson2.jsp").forward(request, response);
		}
		
		
		
		
		/*
		if(name1.trim().equals("")&&YEAR.trim()!=("")&&MONTH.trim().equals("")){
			
			String sql1 = "select p_id,p_name,p_overtime,p_evection,p_leave,p_year from sys_person where p_year='"+YEAR+"' order by p_name" ;
			System.out.println(time+"个人资源统计sql："+sql1);
			
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", name);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listperson.jsp").forward(request, response);
		}
		else{String sql = "select a.*,b.*,c.*,d.*,f.*,g.* from " +
			"(select NVL(sum(o.o_time),0) from sys_overtime o where o.o_name = '"+name+"' and o.o_date like '"+YEAR+"%') a," +
			"(select NVL(sum(e.e_worktime),0) from sys_evection e where e.e_name = '"+name+"' and e.e_startdate like '"+YEAR+"%') b," +
			"(select NVL(sum(l.l_time),0) from sys_leave l where l.l_name = '"+name+"' and l.l_date like '"+YEAR+"%') c,"+
			"(select NVL(sum(o1.o_time),0) from sys_overtime o1 where o1.o_name = '"+name+"' and o1.o_date like '"+YEAR+"%' and o1.o_month='"+MONTH+"') d," +
			"(select NVL(sum(e1.e_worktime),0) from sys_evection e1 where e1.e_name = '"+name+"' and e1.e_startdate like '"+YEAR+"%' and e1.e_month='"+MONTH+"') f," +
			"(select NVL(sum(l1.l_time),0) from sys_leave l1 where l1.l_name = '"+name+"' and l1.l_date like '"+YEAR+"%' and l1.l_month='"+MONTH+"') g";
	
	System.out.println(time+"个人资源统计查询sql："+sql);
	String nowPage = request.getParameter("currentPage");
	DBUtils dbutil = new DBUtils();
	PageBean pageBean = dbutil.queryByPage(nowPage, sql);
	request.setAttribute("pageBean", pageBean);
	request.getSession().setAttribute("NAME", name);//往jsp页面传值
	request.getSession().setAttribute("MONTH", MONTH);
	request.getSession().setAttribute("YEAR", YEAR);
	request.getRequestDispatcher("resource/listperson2.jsp").forward(request, response);}
		*/
	}



}
