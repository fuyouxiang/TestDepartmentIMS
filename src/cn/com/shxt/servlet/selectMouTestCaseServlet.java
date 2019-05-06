package cn.com.shxt.servlet;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectMouTestCaseServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"模糊查询用例评审servlet===============");
		
		
	    request.setCharacterEncoding("UTF-8");  //设置编码 
	    String CHA_NAME = request.getParameter("CHA_NAME");	//搜索内容       
	    System.out.println("搜索内容 :"+CHA_NAME);
	    String TC_RESULT = request.getParameter("TC_RESULT");	//评审结果    
	    System.out.println("评审结果:"+TC_RESULT);
	    
	    String sql;
		if(TC_RESULT.equals("all")){
			sql = "select ATTACH_NAME,FILE_CATALOG,CREATE_TIME,TC_CREATER,TC_CHECK_TIME,TC_CHECKER,TC_RESULT from SYS_ATTACH_FILE where APPID='003' and  (ATTACH_NAME like '%"+CHA_NAME+"%' or FILE_CATALOG like '%"+CHA_NAME+"%' or TC_CREATER like '%"+CHA_NAME+"%' or TC_CHECKER like '%"+CHA_NAME+"%')order by CREATE_TIME desc";
		}else{
			sql = "select ATTACH_NAME,FILE_CATALOG,CREATE_TIME,TC_CREATER,TC_CHECK_TIME,TC_CHECKER,TC_RESULT from SYS_ATTACH_FILE where APPID='003' and  TC_RESULT='"+TC_RESULT+"' and (ATTACH_NAME like '%"+CHA_NAME+"%' or FILE_CATALOG like '%"+CHA_NAME+"%' or TC_CREATER like '%"+CHA_NAME+"%' or TC_CHECKER like '%"+CHA_NAME+"%') order by CREATE_TIME desc";
		}
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		
		request.getRequestDispatcher("youzhishi/AllTestCaseCheck.jsp").forward(request, response); 
		
		
	}



}
