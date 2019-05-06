package cn.com.shxt.servlet;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.model.Sys_user;
import cn.com.shxt.utils.DBUtils;

public class selectUrlServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		DBUtils dbutil = new DBUtils();
		
		String url=dbutil.getUrl();
		
		System.out.println("------------------"+url);

		request.setAttribute("url", url);
		request.getRequestDispatcher("console.jsp").forward(request, response);
	}



}
