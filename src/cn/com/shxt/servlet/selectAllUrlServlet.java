package cn.com.shxt.servlet;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.ping;



public class selectAllUrlServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询url列表servlet");
		String sql = "select (select count(*) from SYS_URL) as URL_COUNT,URL_ID,URL_NAME,URL_ADDRESS,URL_CREATER,URL_DATE,URL_STATE from SYS_URL a order by URL_DATE desc";

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
     
     
		request.getRequestDispatcher("main_url.jsp").forward(request, response);
	}

	
	


}
