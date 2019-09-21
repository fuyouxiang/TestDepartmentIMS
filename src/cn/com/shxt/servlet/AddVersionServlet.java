package cn.com.shxt.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class AddVersionServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"添加日报");
		request.setCharacterEncoding("UTF-8");
		String V_MONTH = request.getParameter("V_MONTH");
		String V_DATE = request.getParameter("V_DATE");
		//String V_WEEK = request.getParameter("V_WEEK");
		String V_NAME = request.getParameter("V_NAME");
		String V_BASICS = request.getParameter("V_BASICS");
		String V_WORK = request.getParameter("V_WORK");
		String V_TIME = request.getParameter("V_TIME");
		String V_TYPE = request.getParameter("V_TYPE");
		String V_BUG = request.getParameter("V_BUG");
		String V_DOCUMENT = request.getParameter("V_DOCUMENT");
		String V_CASE = request.getParameter("V_CASE");

		
		//自动判断星期几
		Calendar c = Calendar.getInstance();// 获得一个日历的实例
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
		c.setTime(sdf.parse(V_DATE));
		} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		int V_WEEK =c.get(Calendar.DAY_OF_WEEK);
		if(V_WEEK==1){//国际上一周的第一天是星期日
			V_WEEK=7;
		}else{
			V_WEEK=V_WEEK-1;
		}
		System.out.println("V_WEEK:"+V_WEEK);
		
		
		
		
		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));

		//to_date('2016-03-27', 'yyyy-mm-dd')         to_date('" + v_enddate + "','yyyy-mm-dd')
		DBUtils dbutil =new DBUtils();
		String sql = "insert into SYS_VERSION (V_MONTH,V_DATE,V_WEEK,V_NAME,V_BASICS,V_WORK,V_TIME,V_TYPE,V_BUG,V_DOCUMENT,V_CASE) values " +
				"('" + V_MONTH + "','" + V_DATE + "','" + V_WEEK + "','" + V_NAME + "','" + V_BASICS + "','" + V_WORK + "','" + V_TIME + "','" + V_TYPE + "','" + V_BUG + "','" + V_DOCUMENT + "','" + V_CASE + "')";
		
		//测试情况统计表记录数
		//String sql2 = "update sys_test set t_case=t_case+"+"'" + V_CASE + "'"+",t_document=t_document+"+"'" + V_DOCUMENT + "'"+",t_bug=t_bug+"+"'" + V_BUG + "'"+" where t_name="+"'" + V_NAME + "' and t_year='" + SetYear + "'";	

		
		
		int flag = dbutil.update(sql);
		//int flag2 = dbutil.update(sql2);

		System.out.println(time+"添加日报："+sql);
		//System.out.println(time+"修改测试情况统计表sql:"+sql2);//查看sql

		String info ;
		
		if(flag > 0 ){
			info ="工作日报保存成功！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("User/addversion.jsp?answer=yes").forward(request, response);
		}else{
			info ="工作日报保存失败！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("User/addversion.jsp?answer=no").forward(request, response);
		}

		
	}
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
