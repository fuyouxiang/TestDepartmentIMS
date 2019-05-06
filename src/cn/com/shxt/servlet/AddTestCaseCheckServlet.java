package cn.com.shxt.servlet;

import java.io.IOException;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;









import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class AddTestCaseCheckServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292614L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}
		   
		   
		   
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	       System.out.println("进入测试用例评审servlet，开始在数据库插入文档数据——————————————");
	       
	        //获取文件需要上传到的路径  
			



			       request.setCharacterEncoding("UTF-8");  //设置编码 
			       String ATTACH_ID = request.getParameter("ATTACH_ID");	//文件ID       
			       System.out.println("文件ID "+ATTACH_ID);
			       String ATTACH_NAME = request.getParameter("ATTACH_NAME");	//文件名称       
			       System.out.println("文件名称 "+ATTACH_NAME);
			       String CREATE_TIME =request.getParameter("CREATE_TIME");//用例创建时间
			       System.out.println("用例创建时间 "+CREATE_TIME);
			       String TC_CREATER =request.getParameter("TC_CREATER");//用例创建人CREATE_TIME
			       System.out.println("用例创建人 "+TC_CREATER);
			       String TC_CHECK_TIME = request.getParameter("TC_CHECK_TIME");//用例评审时间
			       System.out.println("用例评审时间"+TC_CHECK_TIME);
			       String TC_CHECKER = request.getParameter("TC_CHECKER");//用例评审人
			       System.out.println("用例评审人 "+TC_CHECKER);
			       String TC_RESULT = request.getParameter("TC_RESULT");//用例评审结果
			       System.out.println("用例评审结果"+TC_RESULT);
			       
		        
		        DBUtils dbutil =new DBUtils();
		        String sql = "update sys_attach_file set TC_CREATER='" + TC_CREATER + "',TC_CHECK_TIME='" + TC_CHECK_TIME + "',TC_CHECKER='" + TC_CHECKER + "',TC_RESULT='" + TC_RESULT + "' where ATTACH_NAME='" + ATTACH_NAME + "'";
		        System.out.println("测试用例评审sql:"+sql);
		        int flag = dbutil.update(sql);
		        
		        
				String sql2 = "insert into sys_attach_file_log (ATTACH_ID,ATTACH_NAME,CREATE_TIME,TC_CREATER,TC_CHECK_TIME,TC_CHECKER,TC_RESULT) values " +
						"('" + ATTACH_ID + "','" + ATTACH_NAME + "','" + CREATE_TIME + "','" + TC_CREATER + "','" + TC_CHECK_TIME + "','" + TC_CHECKER + "','" + TC_RESULT + "')";
				System.out.println("测试用例评审日志sql:"+sql2);
		        int flag2 = dbutil.update(sql2);

		    	response.setContentType("text/html; charset=UTF-8");
		    	 if(flag>0){
		    	response.getWriter().println("<script>alert('本次测试用例评审完成！');window.history.go(-2);</script>");
		    	 }else{
		        response.getWriter().println("<script>alert('系统出现异常，请联系管理员！');window.location.href='index_youzhishi.jsp';</script>");
		    	 }
				
				
	    }
	        
	
	
}
