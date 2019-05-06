package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectSignServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询签到表");
		//String sql = "select s_name,to_char(s_date,'yyyy-mm-dd'),s_sign,s_remark,s_host from sys_sign";
		String sql = "select s_id,s_name,to_char(s_date,'yyyy-mm-dd'),s_sign,s_remark,s_host from sys_sign order by s_date desc";
		/*int iRows = 5;
		int nowPage = 1;
		String nextPage = (String)request.getParameter("nextPage");
		if(nextPage!=null && !"".equals(nextPage)){
			nowPage = Integer.parseInt(nextPage);
		}
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage(nowPage, sql, iRows);*/

		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("sign/listsign.jsp").forward(request, response);
	}



}
