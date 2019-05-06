package cn.com.shxt.servlet;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectMouFileServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"查询文件查询servlet===============");
		
		
	    request.setCharacterEncoding("UTF-8");  //设置编码 
	    String CHA_NAME = request.getParameter("CHA_NAME");	//搜索内容       
	    System.out.println("搜索内容 :"+CHA_NAME);
	    String CHA_APPID = request.getParameter("CHA_APPID");	//子系统    
	    System.out.println("子系统 :"+CHA_APPID);
	    
	    String sql;
		if(CHA_APPID.equals("all")){
			sql = "select ATTACH_ID,ATTACH_NAME,ITEM_TYPE,ATTACH_TYPE,REMARK,CREATE_TIME,APPID,ATTACH_PATH from SYS_ATTACH_FILE where  ATTACH_NAME like '%"+CHA_NAME+"%' or ITEM_TYPE like '%"+CHA_NAME+"%' or REMARK like '%"+CHA_NAME+"%' order by CREATE_TIME desc";
		}else{
			sql = "select ATTACH_ID,ATTACH_NAME,ITEM_TYPE,ATTACH_TYPE,REMARK,CREATE_TIME,APPID,ATTACH_PATH from SYS_ATTACH_FILE where APPID ='"+CHA_APPID+"' and (ATTACH_NAME like '%"+CHA_NAME+"%' or ITEM_TYPE like '%"+CHA_NAME+"%' or REMARK like '%"+CHA_NAME+"%' or ATTACH_TYPE like '%"+CHA_NAME+"%') order by CREATE_TIME desc";
		}
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		
		request.getRequestDispatcher("youzhishi/AllFile.jsp").forward(request, response); 
		
		
	}



}
