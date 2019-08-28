package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class UpdateNoticeServlet extends HttpServlet {


	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"修改公告servlet------------------------------");
		
		request.setCharacterEncoding("UTF-8");	
		String JI_TITLE = request.getParameter("JI_TITLE");
		String J1 = request.getParameter("J1");
		String J2 = request.getParameter("J2");
		String J3 = request.getParameter("J3");
		String J4 = request.getParameter("J4");
		
		String sql1 ="insert into SYS_JITANG (JI_TITLE,J1,J2,J3,J4) values"+"('"+JI_TITLE+"','"+J1+"','"+J2+"','"+J3+"','"+J4+"')";
		System.out.println(time+"修改公告sql："+sql1);
		
		DBUtils db = new DBUtils();
		int flag = db.update(sql1);
		String info;
		if(flag > 0 ){
			info ="恭喜你!!发布通知成功";
			request.setAttribute("info", info);
		}else{
			info ="不好意思,发布通知失败";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);
	}


}
