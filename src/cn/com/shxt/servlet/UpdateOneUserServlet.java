package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;



public class UpdateOneUserServlet extends HttpServlet {

	
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		request.setCharacterEncoding("UTF-8");	
		String id = request.getParameter("u_id");
		String name = request.getParameter("u_name");
		String state = request.getParameter("u_state");
		String role = request.getParameter("u_role");
		String xinren = request.getParameter("xinren");
		String xiangmu = request.getParameter("xiangmu");
		String yongli = request.getParameter("yongli");
		String fenxiang = request.getParameter("fenxiang");
		//String password = request.getParameter("u_password");
		//String password2 =MD5Helper.MD5(request.getParameter("u_password"));
		System.out.println(time+id  + name  + state );
//		Sys_user u = new Sys_user();
//		u.setU_id(Integer.parseInt(id));
//		u.setU_name(name);
//		u.setU_password(password2);
//		u.setU_state(state);

		DBUtils dbutil =new DBUtils();
		String sql = "update sys_user set u_name='"+name+"',u_state='"+state+"',u_role='"+role+"',xinren='"+xinren+"',xiangmu='"+xiangmu+"',yongli='"+yongli+"',fenxiang='"+fenxiang+"' where u_id ='"+id+"'";
		
		int flag = dbutil.update(sql);

		
//		UserServiceBean ssb= new UserServiceBean();
//		System.out.println("1");
//		int num = ssb.updateUser(u);
//		System.out.println(num);
		String info ;
		if(flag>0){
			info ="恭喜你!!修改用户成功";
			request.setAttribute("info", info);
		}else{
			info ="不好意思,修改用户失败";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);
	}

	

}
