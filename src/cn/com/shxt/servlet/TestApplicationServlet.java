package cn.com.shxt.servlet;


import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;



public class TestApplicationServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();

		
		System.out.println(timelog+"版本测试申请单接口——————————");
		
		
		String OldBumenAndBoss = request.getParameter("bumen");
		System.out.println("部门(未转码)："+OldBumenAndBoss);

		String sql= "select B_NAME from SYS_BUMEN where B_NAME != '产品测试部'";
		System.out.println(timelog+"查询所有部门："+sql);
	
		String sql2;
		String BumenAndBoss = null;
		if(OldBumenAndBoss!=null) {
			BumenAndBoss = new String(OldBumenAndBoss.getBytes("ISO-8859-1"),"UTF-8");
			System.out.println("部门："+BumenAndBoss);
			String [] strs = BumenAndBoss.split("[;]");
			String Bumen = strs[0];
			sql2 = "select W_NAME from SYS_WEINAME where B_NAME in ('其他','"+Bumen+"') order by w_name";
		}else{
			BumenAndBoss="请选择部门";
			sql2 = "select W_NAME from SYS_WEINAME order by w_name desc";
		}
		
		System.out.println(timelog+"查询所有微服务："+sql2);
	
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();		
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		PageBean pageBean2 = dbutil.queryByPage2(nowPage, sql2);
		request.setAttribute("pageBean2", pageBean2);
		request.setAttribute("newbumen", BumenAndBoss);

			


		/*ip测试
 	    boolean STATE= false;
		ping pi= new ping();
        String ipAddress = "https://www.baidu.com/";
     
        try {
     	    STATE=pi.ping(ipAddress);
			System.out.println("2"+STATE);
  	    } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        System.out.println("3"+STATE);
     */
     
     
		request.getRequestDispatcher("TestFormSubmit_banben.jsp").forward(request, response);
	}

	
	


}
