package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;

public class AddUserServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"添加用户servlet--------------------------");
		request.setCharacterEncoding("UTF-8");
		//String U_ID = request.getParameter("u_id");
		String USERNAME = request.getParameter("u_name");
		//String PASSWORD = request.getParameter("u_password");
		String STATE = request.getParameter("u_state");
		String ROLE = request.getParameter("u_role");
		String PASSWORD2 =MD5Helper.MD5(request.getParameter("u_password"));
		String EMAIL =request.getParameter("email");
		String PHONE =request.getParameter("phone");
		
		String XINREN = request.getParameter("xinren");
		String XIANGMU = request.getParameter("xiangmu");
		String YONGLI = request.getParameter("yongli");
		String FENXIANG = request.getParameter("fenxiang");
		
		System.out.println(ROLE);
		Calendar date = Calendar.getInstance();
	    String SetYear = String.valueOf(date.get(Calendar.YEAR));
		
	     if(ROLE.equals("普通")||ROLE.equals("管理员")){
	    	 System.out.println("新增用户为普通或管理员");
	 		DBUtils dbutil =new DBUtils();
			String sql = "insert into sys_user (u_name,u_password,u_state,u_role,xinren,xiangmu,yongli,fenxiang,email,phone) values " +
					"('" + USERNAME + "','" + PASSWORD2 + "','" + STATE + "','" + ROLE + "','" + XINREN + "','" + XIANGMU + "','" + YONGLI + "','" + FENXIANG + "','" + EMAIL + "','" + PHONE + "')";
			
			//人员资源统计表
			String sql2 ="insert into sys_person(p_name,p_overtime,p_evection,p_leave,p_year) values"+"('" + USERNAME + "','0','0','0','" + SetYear + "')";
			//测试情况统计表
			String sql3 ="insert into sys_test(T_NAME,T_CASE,T_DOCUMENT,T_BUG,T_YEAR) values"+"('" + USERNAME + "','0','0','0','" + SetYear + "')";
			
			System.out.println(sql);
			System.out.println(sql2);
			System.out.println(sql3);
			
			int flag = dbutil.update(sql);
			int flag2 = dbutil.update(sql2);
			int flag3 = dbutil.update(sql3);
			
			String info ;
			
			if(flag > 0 && flag2 > 0 && flag3 > 0){
				info ="恭喜你!!成功添加用户";
				request.setAttribute("info", info);
			}else{
				info ="不好意思,添加用户失败";
				request.setAttribute("info", info);
			}
			request.getRequestDispatcher("Sys.jsp").forward(request, response); 
			
	     }else if(ROLE.equals("文档")){
	    	 System.out.println("文档");
	  		DBUtils dbutil =new DBUtils();
			String sql = "insert into sys_user (u_name,u_password,u_state,u_role,xinren,xiangmu,yongli,fenxiang) values " +
					"('" + USERNAME + "','" + PASSWORD2 + "','" + STATE + "','" + ROLE + "','" + XINREN + "','" + XIANGMU + "','" + YONGLI + "','" + FENXIANG + "')";
	 			System.out.println(sql); 			
	 			int flag = dbutil.update(sql);

	 			
	 			String info ;
	 			
	 			if(flag > 0){
	 				info ="恭喜你!!成功添加用户";
	 				request.setAttribute("info", info);
	 			}else{
	 				info ="不好意思,添加用户失败";
	 				request.setAttribute("info", info);
	 			}
	 			request.getRequestDispatcher("Sys.jsp").forward(request, response); 
	     }

		
	}
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
