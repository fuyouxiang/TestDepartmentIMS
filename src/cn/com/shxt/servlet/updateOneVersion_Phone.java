package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.Sys_Version;
import cn.com.shxt.service.bean.VersionServiceBean;


public class updateOneVersion_Phone extends HttpServlet {

	
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		String id = request.getParameter("id");
		System.out.println(time+"ID"+id);
		VersionServiceBean ss = new VersionServiceBean();
		Sys_Version version = ss.selectOneVersion(Integer.parseInt(id));
		request.setAttribute("version", version);
		request.getRequestDispatcher("/User/updateVersion_phone.jsp").forward(request, response);
		System.out.println(time+"修改第一次跳转");
	}


}
