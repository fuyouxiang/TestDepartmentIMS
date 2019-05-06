package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectSignServlet2 extends HttpServlet {


	private static final long serialVersionUID = 3089438135550637937L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"条件查询");
		//按日期及名字查询
		//开始日期
		String start_date =request.getParameter("start_date");
		System.out.println(time+start_date);
		//结束日期
		String end_date =request.getParameter("end_date");
		System.out.println(time+end_date);
		//员工姓名
		String s_name1 = request.getParameter("S_NAME");
		String s_name=new String(s_name1.getBytes("ISO8859-1"),"UTF-8");
		System.out.println(time+s_name);

		

		
		
		//只查日期，姓名为空
		if(start_date.trim()!=("")&&end_date.trim()!=("")&&s_name.trim().equals("")){
			String sql = "select s_id,s_name,to_char(s_date,'yyyy-mm-dd'),s_sign,s_remark,s_host from sys_sign where to_char(s_date,'yyyy-mm-dd') between '"+start_date+"' and '"+end_date+"' order by s_id desc";
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//翻页会刷新，所以转到另一个没有翻页的jsp，靠滚动条
			//往jsp页面传值
			request.getSession().setAttribute("start_date", start_date);
			request.getSession().setAttribute("end_date", end_date);
			request.getSession().setAttribute("s_name", s_name);
			request.getRequestDispatcher("sign/listAllsign2.jsp").forward(request, response);
		}
		
		//只查姓名，日期为空
		else if(start_date.trim().equals("")&&end_date.trim().equals("")&&s_name.trim()!=("")){
			String sql = "select s_id,s_name,to_char(s_date,'yyyy-mm-dd'),s_sign,s_remark,s_host from sys_sign where s_name='"+s_name+"' order by s_id desc";
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//翻页会刷新，所以转到另一个没有翻页的jsp，靠滚动条
			//往jsp页面传值
			request.getSession().setAttribute("start_date", start_date);
			request.getSession().setAttribute("end_date", end_date);
			request.getSession().setAttribute("s_name", s_name);
			request.getRequestDispatcher("sign/listAllsign2.jsp").forward(request, response);
		}
		
		//姓名、日期都查
		//.trim()表示字符串去掉空格，接着与空格进行比较，看是否字符串仍未空。s_name.trim().equals("")
		else if(start_date.trim()!=("")&&end_date.trim()!=("")&&s_name.trim()!=("")){
			String sql = "select s_id,s_name,to_char(s_date,'yyyy-mm-dd'),s_sign,s_remark,s_host from sys_sign where to_char(s_date,'yyyy-mm-dd') between '"+start_date+"' and '"+end_date+"' and s_name='"+s_name+"' order by s_id desc";
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			//翻页会刷新，所以转到另一个没有翻页的jsp，靠滚动条
			//往jsp页面传值
			request.getSession().setAttribute("start_date", start_date);
			request.getSession().setAttribute("end_date", end_date);
			request.getSession().setAttribute("s_name", s_name);
			request.getRequestDispatcher("sign/listAllsign2.jsp").forward(request, response);
		}
	}



}
