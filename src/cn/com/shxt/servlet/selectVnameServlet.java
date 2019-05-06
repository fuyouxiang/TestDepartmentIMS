package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectVnameServlet extends HttpServlet {


	private static final long serialVersionUID = 1L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		//String V_NAME = request.getParameter("V_NAME");
		String V_NAME=new String(request.getParameter("V_NAME").getBytes("ISO-8859-1"),"GB2312");
		System.out.println(time+V_NAME);
		String sql = "select V_ID,V_PRODUCT,V_TYPE,V_CERSIONNO,V_BUILD,V_RELEASEDATE,V_STARTDATE,V_ENDDATE,V_NAME,V_BUG,V_CASE,V_DOCUMENT,V_RE_RESULT,V_REASON,V_TESTRESULT,V_TESTTIME from SYS_VERSION where V_NAME = "+"'"+V_NAME+"'"+" order by V_ID" ;
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("User/selectVersion.jsp").forward(request, response);
	}



}
