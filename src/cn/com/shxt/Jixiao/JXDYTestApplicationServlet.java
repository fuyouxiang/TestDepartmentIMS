package cn.com.shxt.Jixiao;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.servlet.DateTime;
import cn.com.shxt.utils.DBUtils;



public class JXDYTestApplicationServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();

		System.out.println(timelog+"绩效单元测试申请单接口——————————");
		
		String sql = "select B_NAME,B_USER,PHONE,EMAIL from SYS_BUMEN where B_CENTER='预算绩效产品部'";
		System.out.println(timelog+"查询所有部门："+sql);
	
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil =new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);

			


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
     
     
		request.getRequestDispatcher("JixiaoTest/TestFormSubmit_danyuan.jsp").forward(request, response);
	}

	
	


}
