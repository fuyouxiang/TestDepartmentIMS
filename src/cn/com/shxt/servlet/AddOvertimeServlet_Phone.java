package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class AddOvertimeServlet_Phone extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入添加加班情况servlet------------------------------------");
		request.setCharacterEncoding("UTF-8");

		String o_name = request.getParameter("o_name");//员工姓名
		String o_date = request.getParameter("o_date");//加班日期
		String o_time = request.getParameter("o_time");//加班时间
		String o_hold1 = request.getParameter("o_hold1");//加班事由
		String o_month = request.getParameter("o_month");//月份
		
		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));

			DBUtils dbutil =new DBUtils();
			String sql = "insert into sys_overtime (o_name,o_date,o_time,o_hold1,o_month) values " +
					"('" + o_name + "','" + o_date + "','" + o_time + "','" + o_hold1 + "','" + o_month + "')";
	
			//人员资源统计表记录数加1
			//String sql2 = "update sys_person set p_overtime=p_overtime+"+"'" + o_time + "'"+" where p_name="+"'" + o_name + "' and p_year='2018'";
			String sql2 = "insert into sys_person(p_name,p_overtime,p_evection,p_leave,p_year,p_month) values('" + o_name + "','" + o_time + "','0','0','" + SetYear + "','" + o_month + "')";
			
			int flag = dbutil.update(sql);
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"添加加班情况sql:"+sql);//查看sql
			System.out.println(time+"修改个人情况统计表sql:"+sql2);//查看sql
			String info ;
			
			if(flag > 0 && flag2 > 0){
				info ="加班情况保存成功！个人情况统计表修改成功！";
				request.setAttribute("info", info);
			}else if(flag > 0 && flag2 == 0){
				info ="加班情况保存成功！个人情况统计表修改失败！";
				request.setAttribute("info", info);
			}else if(flag == 0 && flag2 > 0){
				info ="加班情况保存失败！个人情况统计表修改成功！";
				request.setAttribute("info", info);
			}else{
				info ="加班情况保存失败！个人情况统计表修改失败！";
				request.setAttribute("info", info);
			}
			
		request.getRequestDispatcher("Sys_Phone.jsp").forward(request, response);		
}
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
