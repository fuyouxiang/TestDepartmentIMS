package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class DeleteOvertimeServlet extends HttpServlet {
	private static final long serialVersionUID = -1313170890068030737L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		//request.setCharacterEncoding("UTF-8");
		
		String O_ID = request.getParameter("id");
		String O_TIME = request.getParameter("time");
		String NAME =request.getParameter("name");
		String O_NAME=new String(NAME.getBytes("ISO8859-1"),"UTF-8");
		
		System.out.println(time+"正在删除加班信息...加班ID为："+O_ID);
		String sql = "delete from sys_overtime where O_ID =" + O_ID;
		System.out.println(time+"删除成功！");
		
		
		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
	     
		//人员资源统计表记录数减1
		System.out.println(time+"正在修改个人情况统计表信息...加班NAME为："+O_NAME);
		//String sql2 = "update sys_person set p_overtime=p_overtime-"+"'" + O_TIME + "'"+" where p_name="+"'" + O_NAME + "' and p_year='2018'";
		String sql2 = "delete from sys_person where p_id=(select max(p_id) from sys_person where p_overtime='" + O_TIME + "' and p_name='" + O_NAME + "' )";
		System.out.println(sql2);
		System.out.println(time+"修改成功！");
		
		
		DBUtils dbutil = new DBUtils();
		int flag = dbutil.update(sql);
		int flag2 = dbutil.update(sql2);
		String info ;
		if(flag > 0 && flag2 > 0){
			info ="加班情况删除成功！个人情况统计表修改成功！";
			request.setAttribute("info", info);
		}else if(flag > 0 && flag2 == 0){
			info ="加班情况删除成功！个人情况统计表修改失败！";
			request.setAttribute("info", info);
		}else if(flag == 0 && flag2 > 0){
			info ="加班情况删除失败！个人情况统计表修改成功！";
			request.setAttribute("info", info);
		}else{
			info ="加班情况删除失败！个人情况统计表修改失败！";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	 }
		
}



