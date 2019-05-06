package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class AddEvectionServlet_Phone extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"进入添加出差情况servlet------------------------");
		request.setCharacterEncoding("UTF-8");

		String E_NAME = request.getParameter("E_NAME");//员工姓名
		String E_MONTH = request.getParameter("E_MONTH");//出差月份
		String E_STARTDATE = request.getParameter("E_STARTDATE");//出发时间
		String E_ENDDATE = request.getParameter("E_ENDDATE");//结束时间
		String E_PLACE = request.getParameter("E_PLACE");//出差地点
		String E_REMARK = request.getParameter("E_REMARK");//出差任务
		String E_DEPARTMENT = request.getParameter("E_DEPARTMENT");//费用支出部门


		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
		

			DBUtils dbutil =new DBUtils();
			String sql = "insert into SYS_EVECTION (E_NAME,E_MONTH,E_STARTDATE,E_ENDDATE,E_PLACE,E_REMARK,E_DEPARTMENT,E_WORKTIME) values " +
					"('" + E_NAME + "','" + E_MONTH + "','" + E_STARTDATE + "','" + E_ENDDATE + "','" + E_PLACE + "','" + E_REMARK + "','" + E_DEPARTMENT + "',to_date('" + E_ENDDATE + "','yyyy-mm-dd')-to_date('" + E_STARTDATE + "','yyyy-mm-dd')+1)";
	
			
			//人员资源统计表记录数加1
			//String sql2 = "update sys_person set p_evection=p_evection+"+"(to_date('" + E_ENDDATE + "','yyyy-mm-dd')-to_date('" + E_STARTDATE + "','yyyy-mm-dd')+1)"+" where p_name="+"'" + E_NAME + "' and p_year='2018'";
			String sql2 = "insert into sys_person(p_name,p_overtime,p_evection,p_leave,p_year,p_month) values('" + E_NAME + "','0',to_date('" + E_ENDDATE + "','yyyy-mm-dd')-to_date('" + E_STARTDATE + "','yyyy-mm-dd')+1,'0','" + SetYear + "','" + E_MONTH + "')";
			
			int flag = dbutil.update(sql);
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"出差情况添加sql："+sql);//查看sql
			System.out.println(time+"修改个人情况统计表sql:"+sql2);//查看sql
			String info;
			
			if(flag > 0 && flag2 > 0){
				info ="出差情况保存成功！个人情况统计表修改成功！";
				request.setAttribute("info", info);
			}else if(flag > 0 && flag2 == 0){
				info ="出差情况保存成功！个人情况统计表修改失败！";
				request.setAttribute("info", info);
			}else if(flag == 0 && flag2 > 0){
				info ="出差情况保存失败！个人情况统计表修改成功！";
				request.setAttribute("info", info);
			}else{
				info ="出差情况保存失败！个人情况统计表修改失败！";
				request.setAttribute("info", info);
			}
			
		request.getRequestDispatcher("Sys_Phone.jsp").forward(request, response);		
}
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
