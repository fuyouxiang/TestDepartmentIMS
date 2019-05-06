package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class AddLeaveServlet_Phone extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		
		System.out.println(time+"进入添加请假情况servlet---------------------------------");
		request.setCharacterEncoding("UTF-8");

		String l_name = request.getParameter("l_name");//员工姓名
		String l_month = request.getParameter("l_month");//加班月份
		String l_date = request.getParameter("l_date");//加班日期
		String  l_time = request.getParameter("l_time");//加班时间
		

		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
		
	     
			DBUtils dbutil =new DBUtils();
			String sql = "insert into sys_leave (l_name,l_month,l_date,l_time) values " +
					"('" + l_name + "','" + l_month + "','" + l_date + "','" + l_time + "')";
	
			//人员资源统计表记录数加1
			//String sql2 = "update sys_person set p_leave=p_leave+"+"'" + l_time + "'"+" where p_name="+"'" + l_name + "' and p_year='2018'";
			String sql2 = "insert into sys_person(p_name,p_overtime,p_evection,p_leave,p_year,p_month) values('" + l_name + "','0','0','" + l_time + "','" + SetYear + "','" + l_month + "')";
			
			int flag = dbutil.update(sql);
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"添加请假情况sql:"+sql);//查看sql
			System.out.println(time+"修改个人情况统计表sql:"+sql2);//查看sql
			String info ;
			
			if(flag > 0 && flag2 > 0){
				info ="请假情况保存成功！个人情况统计表修改成功！";
				request.setAttribute("info", info);
			}else if(flag > 0 && flag2 == 0){
				info ="请假情况保存成功！个人情况统计表修改失败！";
				request.setAttribute("info", info);
			}else if(flag == 0 && flag2 > 0){
				info ="请假情况保存失败！个人情况统计表修改成功！";
				request.setAttribute("info", info);
			}else{
				info ="请假情况保存失败！个人情况统计表修改失败！";
				request.setAttribute("info", info);
			}
			
		request.getRequestDispatcher("Sys_Phone.jsp").forward(request, response);		
}
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
