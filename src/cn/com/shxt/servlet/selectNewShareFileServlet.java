package cn.com.shxt.servlet;

import java.io.IOException;






import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectNewShareFileServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询知识分享文件列表servlet==============");
		HttpSession session = request.getSession();
	    String name=(String) session.getAttribute("username");
		String sql2 = "select * from SYS_USER where U_NAME='"+name+"' and FENXIANG='1'";
		System.out.println("查询用户是否有权限访问："+sql2);
		DBUtils dbutil = new DBUtils();
	    int flag = dbutil.update(sql2);
	    if(flag>0){
	    System.out.println("用户有权限访问！");
	    String FILE_CATALOG1 = request.getParameter("FILE_CATALOG");	//文件夹
	    System.out.println("未转码："+FILE_CATALOG1);
	    String FILE_CATALOG=new String(FILE_CATALOG1.getBytes("iso8859-1"),"utf-8");
	    System.out.println("转码后："+FILE_CATALOG);
		String sql = "select ATTACH_ID,ATTACH_NAME,ITEM_TYPE,ATTACH_TYPE,REMARK,CREATE_TIME,APPID,ATTACH_PATH from SYS_ATTACH_FILE where APPID='004' and FILE_CATALOG='"+FILE_CATALOG+"' order by CREATE_TIME desc";
		/*int iRows = 5;
		int nowPage = 1;
		String nextPage = (String)request.getParameter("nextPage");
		if(nextPage!=null && !"".equals(nextPage)){
			nowPage = Integer.parseInt(nextPage);
		}
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage(nowPage, sql, iRows);*/

		
		String nowPage = request.getParameter("currentPage");
		PageBean pageBean = dbutil.queryByPage(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("FILE_CATALOG", FILE_CATALOG);
		request.getRequestDispatcher("youzhishi/NewShare_Phone.jsp").forward(request, response);
	    }else{
	    	System.out.println("用户无权限访问！");
	    	response.setContentType("text/html; charset=UTF-8");
	    	response.getWriter().println("<script>alert('您没有该模块的访问权限！！！');window.location.href='index_youzhishi.jsp';</script>");
	    	
	    	//response.sendRedirect("index_youzhishi.jsp");
	    	
	    }
	}



}
