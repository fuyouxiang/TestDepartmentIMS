package cn.com.shxt.servlet;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectAllFileLevelServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询文件列表servlet");
		String sql = "SELECT DISTINCT APPID,FILE_CATALOG  FROM SYS_ATTACH_FILE  ORDER BY APPID";

		
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		
		
		
		
		request.getRequestDispatcher("youzhishi/AllFileLevel.jsp").forward(request, response);
	}



}
