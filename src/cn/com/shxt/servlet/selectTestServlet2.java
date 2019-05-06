package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectTestServlet2 extends HttpServlet {
	

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
			String sql1 = "select count(DISTINCT v_date),v_name,sum(v_time),sum(v_case),sum(v_document),sum(v_bug) from sys_version where v_name like '%"+NAME+"%' group by v_name";
			System.out.println(time+"姓名不为空、月份为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listtest2.jsp").forward(request, response);
		}else if(NAME1.length()>=2&&MONTH.trim()!=("")){
			//姓名、月份都不为空
			String sql1 = "select count(DISTINCT v_date),v_name,sum(v_time),sum(v_case),sum(v_document),sum(v_bug) from sys_version where v_name like '%"+NAME+"%' and v_month='"+MONTH+"'  group by v_name";
			System.out.println(time+"姓名、月份都不为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listtest2.jsp").forward(request, response);
		}else if(NAME1.length()<2&&MONTH.trim()!=("")){
			//姓名为空、月份不为空
			String sql1 = "select count(DISTINCT v_date),v_name,sum(v_time),sum(v_case),sum(v_document),sum(v_bug) from sys_version where  v_month='"+MONTH+"'  group by v_name";
			System.out.println(time+"姓名为空、月份不为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listtest2.jsp").forward(request, response);
		}else{
			//姓名、月份都为空
			String sql1 = "select count(DISTINCT v_date),v_name,sum(v_time),sum(v_case),sum(v_document),sum(v_bug) from sys_version  group by v_name";
			System.out.println(time+"姓名、月份都为空");
			System.out.println(time+"个人资源统计查询sql："+sql1);
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
			request.setAttribute("pageBean", pageBean);
			request.getSession().setAttribute("NAME", NAME1);//往jsp页面传值
			request.getSession().setAttribute("MONTH", MONTH);
			//request.getSession().setAttribute("YEAR", YEAR);
			request.getRequestDispatcher("resource/listtest2.jsp").forward(request, response);
		}
		/**
		else{
			String sql = "select a.*,b.*,c.*,d.*,f.*,g.* from " +
			"(select NVL(sum(o.v_case),0) from sys_version o where o.v_name = '"+name+"' and o.v_date like '"+YEAR+"%') a," +
			"(select NVL(sum(e.v_document),0) from sys_version e where e.v_name = '"+name+"' and e.v_date like '"+YEAR+"%') b," +
			"(select NVL(sum(l.v_bug),0) from sys_version l where l.v_name = '"+name+"' and l.v_date like '"+YEAR+"%') c,"+
			"(select NVL(sum(o1.v_case),0) from sys_version o1 where o1.v_name = '"+name+"' and o1.v_date like '"+YEAR+"%' and o1.v_month='"+MONTH+"') d," +
			"(select NVL(sum(e1.v_document),0) from sys_version e1 where e1.v_name = '"+name+"' and e1.v_date like '"+YEAR+"%' and e1.v_month='"+MONTH+"') f," +
			"(select NVL(sum(l1.v_bug),0) from sys_version l1 where l1.v_name = '"+name+"' and l1.v_date like '"+YEAR+"%' and l1.v_month='"+MONTH+"') g";
		
	System.out.println("个人资源统计查询sql："+sql);
	String nowPage = request.getParameter("currentPage");
	DBUtils dbutil = new DBUtils();
	PageBean pageBean = dbutil.queryByPage(nowPage, sql);
	request.setAttribute("pageBean", pageBean);
	request.getSession().setAttribute("NAME", name);//往jsp页面传值
	request.getSession().setAttribute("MONTH", MONTH);
	request.getSession().setAttribute("YEAR", YEAR);
	request.getRequestDispatcher("resource/listtest2.jsp").forward(request, response);
		}
		 */
	}



}
