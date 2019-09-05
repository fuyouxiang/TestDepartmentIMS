package cn.com.shxt.servlet;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.ping;



public class selectOtherUrlServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
		String time=df.format(new Date());// new Date()为获取当前系统时间//时间戳，直接调用DateTime.java中的方法
		System.out.println("**************************************");
		System.out.println(timelog+"工作台加载————————");
		
		
		System.out.println(timelog+"查询url列表servlet");
		String sql = "select (select count(*) from SYS_URL WHERE URL_STATE ='启用' AND IS_OPEN='1') as URL_COUNT,URL_ID,URL_NAME,URL_ADDRESS,URL_CREATER,URL_DATE,ATTACH_NAME,ATTACH_PATH from SYS_URL WHERE URL_STATE ='启用' AND IS_OPEN='1' order by URL_NAME,replace(URL_DATE,'-','') desc";
	
	
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
     
     
		request.getRequestDispatcher("CZCloudUrl.jsp").forward(request, response);
	}

	
	


}
