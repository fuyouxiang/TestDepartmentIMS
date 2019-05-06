package cn.com.shxt.servlet;

import java.io.IOException;





import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectItemFileLevelServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询项目文档文件夹列表servlet==========================");
		HttpSession session = request.getSession();
	    String name=(String) session.getAttribute("username");
	    String sql2 = "select * from SYS_USER where U_NAME='"+name+"' and XIANGMU='1'";
		System.out.println("查询用户是否有权限访问："+sql2);
		DBUtils dbutil = new DBUtils();
	    int flag = dbutil.update(sql2);
	    if(flag>0){
	    System.out.println("用户有权限访问！");
		String sql = "SELECT FILE_CATALOG,COUNT(*) FROM SYS_ATTACH_FILE  WHERE APPID='002' GROUP BY FILE_CATALOG";


		
		String nowPage = request.getParameter("currentPage");
		PageBean pageBean = dbutil.queryByPage(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher("youzhishi/ItemFileLevel_Phone.jsp").forward(request, response);
	    }else{
	    	System.out.println("用户无权限访问！");
	    	response.setContentType("text/html; charset=UTF-8");
	    	response.getWriter().println("<script>alert('您没有该模块的访问权限！！！');window.location.href='index_youzhishi.jsp';</script>");
	    	
	    }
	}



}
