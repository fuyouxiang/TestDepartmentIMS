package cn.com.shxt.servlet;

import java.io.IOException;




import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectTestCaseCheckLogServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
	    request.setCharacterEncoding("UTF-8");  //设置编码 
	    System.out.println("查询要修改文件的信息：");
	    String ATTACH_ID = request.getParameter("ATTACH_ID");	//文件名称       
	    //String ATTACH_NAME=new String(ATTACH_NAME2.getBytes("GB2312"),"UTF-8");
	    System.out.println("文件名称 "+ATTACH_ID);
		
		System.out.println(time+"查询测试用例评审日志selectTestCaseCheckLogServlet");
		String sql = "select ATTACH_NAME,CREATE_TIME,TC_CREATER,TC_CHECK_TIME,TC_CHECKER,TC_RESULT from SYS_ATTACH_FILE_LOG where ATTACH_ID='"+ATTACH_ID+"' order by TC_CHECK_TIME";

		
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		
		
		
		
		request.getRequestDispatcher("youzhishi/TestCaseCheckLog.jsp").forward(request, response);
	}



}
