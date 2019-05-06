package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class DeleteSignServlet extends HttpServlet {
	private static final long serialVersionUID = -1313170890068030737L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		String S_ID = request.getParameter("id");
		System.out.println(time+"正在删除签到记录...ID为："+S_ID);
		String sql = "delete from sys_sign where S_ID =" + S_ID;
		DBUtils dbutil = new DBUtils();
		int flag2 = dbutil.update(sql);
		String info ;
		if(flag2 > 0){
			info ="成功签到记录！";
			request.setAttribute("info", info);
		}else{
			info ="删除签到记录失败！";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	 }
		
}



