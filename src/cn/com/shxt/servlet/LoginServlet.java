package cn.com.shxt.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;








import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;


public class LoginServlet extends HttpServlet {

	public  static String year;
	
	private static final long serialVersionUID = -5661463449353904524L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		//时间戳
		//Date d = new Date();
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		
		//接收表单数据
		System.out.println(time+"PC尝试登录操作");
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("userName");
		//String password = request.getParameter("password");
		String password2 =MD5Helper.MD5(request.getParameter("password"));
		String set_year = request.getParameter("set_year");
		String WebType = request.getParameter("WebType");
		LoginServlet.year=set_year;

		
		System.out.println(time+"用户名："+name);
		System.out.println(time+"密码："+password2);
		System.out.println(time+"年度："+set_year);
		System.out.println(time+"浏览器类型："+WebType);
		
		
		
		DBUtils dbutil = new DBUtils();	
		
		String selUserSql="SELECT * FROM SYS_USER WHERE U_NAME='"+name+"' and U_PASSWORD='"+password2+"' ";
		String UserRole=null;
		String UserCenter=null;
		try {
			UserRole = dbutil.queryString(selUserSql,"U_ROLE");
			UserCenter = dbutil.queryString(selUserSql,"U_CENTER");
		} catch (SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		/*
		//普通
		String  sql=" SELECT u_id,u_name,u_password FROM sys_user WHERE u_name='"+name+"'  and u_password='"+password2+"' and u_role='普通'";	
	    int flag = dbutil.update(sql);
		//管理员
		String  sql2=" SELECT u_id,u_name,u_password FROM sys_user WHERE u_name='"+name+"'  and u_password='"+password2+"' and u_role='管理员'";	
	    int flag2 = dbutil.update(sql2);
	    //文档
		String  sql3=" SELECT u_id,u_name,u_password FROM sys_user WHERE u_name='"+name+"'  and u_password='"+password2+"' and u_role='文档'";	
	    int flag3 = dbutil.update(sql3);
		 */
	    
		
		//更简单的办法：UserServiceBean和updateOneUser，有获取其中一个字段的方法，直接拿来做判断，时间关系不改了，能用就行。
	    

	    if(UserRole.equals("普通")){
	    	System.out.println("该用户为普通用户！");
	    	
	    	String name1 = name;
	    	request.setAttribute("name1",name1);
	    	
		    
	    	//创建姓名的session
		    HttpSession session = request.getSession();
		    session.setAttribute("username",name);
		    session.setAttribute("userrole",UserRole);
		    session.setAttribute("UserCenter",UserCenter);
		    

		    
			//response.sendRedirect("index.jsp");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			return;
		}else if(UserRole.equals("管理员")){
			System.out.println("该用户为管理员用户！");
			
	    	String name1 = name;
	    	request.setAttribute("name1",name1);
		    
	    	//创建姓名的session
		    HttpSession session = request.getSession();
		    session.setAttribute("username",name);
		    session.setAttribute("userrole",UserRole);
		    session.setAttribute("UserCenter",UserCenter);

		    
			//response.sendRedirect("index.jsp");
			request.getRequestDispatcher("index_boss.jsp").forward(request, response);
			return;
		}else if(UserRole.equals("文档")){	
			System.out.println("该用户为文档用户！");
			
	    	String name1 = name;
	    	request.setAttribute("name1",name1);
		    
	    	//创建姓名的session
		    HttpSession session = request.getSession();
		    session.setAttribute("username",name);
		    session.setAttribute("userrole",UserRole);
		    session.setAttribute("UserCenter",UserCenter);

		    
			//response.sendRedirect("index.jsp");
			request.getRequestDispatcher("index_youzhishi.jsp").forward(request, response);
			return;
		}else if(UserRole.equals("绩效")){	
			System.out.println("该用户为绩效用户！");
			
	    	String name1 = name;
	    	request.setAttribute("name1",name1);
		    
	    	//创建姓名的session
		    HttpSession session = request.getSession();
		    session.setAttribute("username",name);
		    session.setAttribute("userrole",UserRole);
		    session.setAttribute("UserCenter",UserCenter);

		    
			//response.sendRedirect("index.jsp");
			request.getRequestDispatcher("index_Jixiao.jsp").forward(request, response);
			return;
		}else{
			String info ="对不起,用户名或密码错误";
			request.setAttribute("info", info);
	    	response.setContentType("text/html; charset=UTF-8");
	    	response.getWriter().println("<script>alert('对不起,用户名或密码错误!');window.location.href='login.jsp';</script>");
	    	
			//request.getRequestDispatcher("LoginError.jsp").forward(request, response);
		}
	    
	 }  
	

		}
			
	
	
	


