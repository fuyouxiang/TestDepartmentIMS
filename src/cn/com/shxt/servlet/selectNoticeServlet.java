package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectNoticeServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询公告servlet------------------------------");
		
		 Calendar date = Calendar.getInstance();
		
		String sql1 ="select JI_TITLE,J1,J2,J3,J4 from SYS_JITANG LIMIT 1 ORDER BY JI_ID";
		System.out.println(time+"查询公告sql："+sql1);
		
		
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("guanliyuan/UpdateNotice.jsp").forward(request, response);
	}



}
