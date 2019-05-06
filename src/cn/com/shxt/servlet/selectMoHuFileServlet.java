package cn.com.shxt.servlet;

import java.io.IOException;




import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectMoHuFileServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292613L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"模糊查询文件servlet===============");
		
		request.setCharacterEncoding("UTF-8");  //设置编码 
	    String FILE_CATALOG1 = request.getParameter("FILE_CATALOG");	//文件夹
	    System.out.println("未转码："+FILE_CATALOG1);
	    String FILE_CATALOG=new String(FILE_CATALOG1.getBytes("iso8859-1"),"utf-8");
	    System.out.println("转码后："+FILE_CATALOG);
	    String CHA_NAME = request.getParameter("CHA_NAME");	//搜索内容       
	    System.out.println("搜索内容 :"+CHA_NAME);
	    String CHA_APPID = request.getParameter("CHA_APPID");	//子系统    
	    System.out.println("子系统 :"+CHA_APPID);

		

		String sql = "select ATTACH_ID,ATTACH_NAME,ITEM_TYPE,ATTACH_TYPE,REMARK,CREATE_TIME,APPID,ATTACH_PATH,TC_RESULT from SYS_ATTACH_FILE where APPID = '"+CHA_APPID+"' and (ATTACH_NAME like '%"+CHA_NAME+"%' or ITEM_TYPE like '%"+CHA_NAME+"%' or REMARK like '%"+CHA_NAME+"%' or ATTACH_TYPE like '%"+CHA_NAME+"%' or TC_RESULT like '%"+CHA_NAME+"%')  and FILE_CATALOG='"+FILE_CATALOG+"' order by CREATE_TIME desc";

		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("FILE_CATALOG", FILE_CATALOG);
		
		if(CHA_APPID.equals("001")){
			request.getRequestDispatcher("youzhishi/NewPerson_Phone.jsp").forward(request, response);
		}else if(CHA_APPID.equals("002")){
			request.getRequestDispatcher("youzhishi/ItemFile_Phone.jsp").forward(request, response);
		}else if(CHA_APPID.equals("003")){
			request.getRequestDispatcher("youzhishi/TestCase_Phone.jsp").forward(request, response);
		}else if(CHA_APPID.equals("004")){
			request.getRequestDispatcher("youzhishi/NewShare_Phone.jsp").forward(request, response);
		}else{
			String info ="搜索输入错误，子系统 :"+CHA_APPID+"搜索内容 :"+CHA_NAME;
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response); 
		}
		
	}



}
