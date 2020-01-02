package cn.com.shxt.servlet;

import java.io.IOException;





import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectOvertimeServlet2 extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入加班条件查询servlet------------------------------");
	
		//年度
		//String YEAR =request.getParameter("YEAR");
		//System.out.println(time+"年度："+YEAR);
		//月份
		String MONTH =request.getParameter("MONTH");
		System.out.println(time+"月份："+MONTH);
		String NAME1 =request.getParameter("NAME");
		String NAME=new String(NAME1.getBytes("ISO8859-1"),"UTF-8");
		System.out.println(time+"姓名："+NAME);
		
		String sql = null;
		if(NAME.length()>=1&&MONTH.length()<1){	
			System.out.println("姓名不为空，月份为空");
			sql = "select o_id,o_name,o_date,o_time,o_hold1,o_month from sys_overtime where  o_name like '%"+NAME+"%' order by o_date desc";
		}else if(NAME.length()<1&&MONTH.length()>=1){
			System.out.println("姓名为空，月份不为空");
			sql = "select o_id,o_name,o_date,o_time,o_hold1,o_month from sys_overtime where  o_month='"+MONTH+"' order by o_date desc";
		}else if(NAME.length()>=1&&MONTH.length()>=1){
			System.out.println("姓名不为空，月份不为空");
			sql = "select o_id,o_name,o_date,o_time,o_hold1,o_month from sys_overtime where  o_month='"+MONTH+"' and  o_name like '%"+NAME+"%' order by o_date desc";
		}else if(NAME.length()<1&&MONTH.length()<1){
			System.out.println("姓名为空，月份为空");
			sql = "select o_id,o_name,o_date,o_time,o_hold1,o_month from sys_overtime order by o_date desc";
		}else{
			String info ;
			info ="加班查询失败，请检查输入的查询条件或联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);
		}

		
		
		System.out.println(time+"加班条件查询sql："+sql);
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		//往jsp页面传值
		request.getSession().setAttribute("NAME", NAME);
		request.getSession().setAttribute("MONTH", MONTH);
		//request.getSession().setAttribute("YEAR", YEAR);
		request.getRequestDispatcher("over_time/listovertime2.jsp").forward(request, response);
	}



}
