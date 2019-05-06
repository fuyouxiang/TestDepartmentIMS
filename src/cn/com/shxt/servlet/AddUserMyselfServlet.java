package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;

public class AddUserMyselfServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"用户自己注册文档用户servlet--------------------------");
		request.setCharacterEncoding("UTF-8");
		String USERNAME = request.getParameter("u_name");
		String STATE = "在职";
		String ROLE = "文档";
		String PASSWORD2 =MD5Helper.MD5(request.getParameter("u_password"));
		
		String XINREN = "1";
		String XIANGMU = "1";
		String YONGLI = "1";
		String FENXIANG = "1";
		
		System.out.println(ROLE);
		Calendar date = Calendar.getInstance();
	    String SetYear = String.valueOf(date.get(Calendar.YEAR));
		

	    	
	  		DBUtils dbutil =new DBUtils();
	  		
	  		System.out.println("查询是否有重复用户：---------");
	  		String chongfu = "select * from sys_user where u_name='" + USERNAME + "'";
	  		int chong=dbutil.update(chongfu);
	  		
	  		if(chong > 0){
	  			System.out.println("------------用户名有重复");
	  			response.setContentType("text/html; charset=UTF-8");
		    	response.getWriter().println("<script>alert('用户名重复！请重新填写用户名。');window.location.href='signup.jsp';</script>");

	  		}
	  		else{
	  			System.out.println("------------用户名无重复");
				String sql = "insert into sys_user (u_name,u_password,u_state,u_role,xinren,xiangmu,yongli,fenxiang) values " +
						"('" + USERNAME + "','" + PASSWORD2 + "','" + STATE + "','" + ROLE + "','" + XINREN + "','" + XIANGMU + "','" + YONGLI + "','" + FENXIANG + "')";
		 			System.out.println(sql); 			
		 			int flag = dbutil.update(sql);

		 			
		 			String info ;
		 			
		 			if(flag > 0){
				    	response.setContentType("text/html; charset=UTF-8");
				    	response.getWriter().println("<script>alert('注册成功！请重新登录。');window.location.href='login.jsp';</script>");
		 			}else{
				    	response.setContentType("text/html; charset=UTF-8");
				    	response.getWriter().println("<script>alert('注册失败！请联系管理员。');window.location.href='login.jsp';</script>");
		 			}
	  		}
	  			


	     }
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
