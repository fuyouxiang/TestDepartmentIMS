package cn.com.shxt.servlet;

import java.io.IOException;







import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class updateFileLevelServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		DBUtils dbutil =new DBUtils();
		
	       request.setCharacterEncoding("UTF-8");  //设置编码 
	       System.out.println("查询要修改文件的信息：");
	       String ATTACH_NAME2 = request.getParameter("ATTACH_NAME");	//文件名称       
	       //String ATTACH_NAME=new String(ATTACH_NAME2.getBytes("ISO8859-1"),"UTF-8");
	       System.out.println("文件名称 "+ATTACH_NAME2);
	       String APPID = request.getParameter("APPID");//子系统
	       System.out.println("子系统"+APPID);
	       String FILE_CATALOG = request.getParameter("FILE_CATALOG");//子系统
	       System.out.println("文件夹"+FILE_CATALOG);
	       
	       
		
		
		
		//根据appid查询所有的二级目录
		String sql1 = "SELECT DISTINCT FILE_CATALOG  FROM SYS_ATTACH_FILE   where APPID='"+APPID+"'";
		
		request.setAttribute("ATTACH_NAME", ATTACH_NAME2);
		request.setAttribute("APPID", APPID);
		request.setAttribute("FILE_CATALOG", FILE_CATALOG);
		String nowPage = request.getParameter("currentPage");
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
		request.setAttribute("pageBean", pageBean);
		
		
        //request.getRequestDispatcher("Sys.jsp").forward(request, response); 
        request.getRequestDispatcher("youzhishi/updateFileLevel.jsp").forward(request, response);
	}



}
