package cn.com.shxt.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.OutPrintLogs;
import cn.com.shxt.utils.SendEmail;

public class selectBBLogServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//构造方法，所有System.out全部写入到logs
		OutPrintLogs o = new OutPrintLogs();
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询测试版本的操作记录————————");
		request.setCharacterEncoding("UTF-8");
		String D_ID = request.getParameter("D_ID");
		System.out.println("申请单ID："+D_ID);

		DBUtils dbutil =new DBUtils();
		
		String sql = "select D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU from SYS_TESTSQ_LOG where D_ID='"+ D_ID +"' order by T_ID desc";		
		System.out.println(time+"查询申请单ID："+sql);	
		
		String nowPage = request.getParameter("currentPage");
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);

		request.getRequestDispatcher("User/BanBenLog.jsp").forward(request, response);	
		
	}

}
