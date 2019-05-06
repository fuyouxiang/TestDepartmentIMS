package cn.com.shxt.servlet;

import java.io.IOException;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;







import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class AddFileServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292614L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}
	
	//读取上传地址配置文件
	public ResourceBundle uploadAddress(){
		
		Properties prop = new Properties();
		//装载Properties配置文件
		ResourceBundle resource = ResourceBundle.getBundle("uploadAddress");
		return resource;
	}
		   
		   
		   
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	       System.out.println("进入新增文档servlet，开始在数据库插入文档数据——————————————");
	       
	        //获取文件需要上传到的路径  
			
	       	//读取上传地址配置文件
			ResourceBundle resource = uploadAddress();

			 String path =resource.getString("uploadAddress");
		     //String path = "D:/uploadfile/";
		     System.out.println("上传路径："+path);


			       request.setCharacterEncoding("UTF-8");  //设置编码 
			       String ATTACH_NAME = request.getParameter("ATTACH_NAME");	//文件名称       
			       System.out.println("文件名称 "+ATTACH_NAME);
			       String ATTACH_TYPE =request.getParameter("ATTACH_TYPE");//文件类型
			       System.out.println("文件类型 "+ATTACH_TYPE);
			       String APPID = request.getParameter("APPID");//子系统
			       System.out.println("子系统"+APPID);
			       String ITEM_TYPE = request.getParameter("ITEM_TYPE");//查询标识
			       System.out.println("查询标识 "+ITEM_TYPE);
			       String REMARK = request.getParameter("REMARK");//备注
			       System.out.println("备注 "+REMARK);
				   SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				   String time=df.format(new Date());// new Date()为获取当前系统时间//时间戳，直接调用DateTime.java中的方法
			       String CREATE_TIME = time;//创建时间
			       System.out.println("创建时间 "+CREATE_TIME);
			       String ATTACH_PATH=path+ATTACH_NAME;//文件路径
			       System.out.println("文件路径"+ATTACH_PATH);
		        
		        DBUtils dbutil =new DBUtils();
				String sql = "insert into sys_attach_file (ATTACH_PATH,ATTACH_NAME,ATTACH_TYPE,APPID,ITEM_TYPE,REMARK,CREATE_TIME) values " +
						"('" + ATTACH_PATH + "','" + ATTACH_NAME + "','" + ATTACH_TYPE + "','" + APPID + "','" + ITEM_TYPE + "','" + REMARK + "','" + CREATE_TIME + "')";
				int flag = dbutil.update(sql);
				
				
				//根据appid查询所有的二级目录
				String sql1 = "SELECT DISTINCT FILE_CATALOG  FROM SYS_ATTACH_FILE   where APPID='"+APPID+"'";
				
				request.setAttribute("ATTACH_NAME", ATTACH_NAME);
				request.setAttribute("APPID", APPID);
				String nowPage = request.getParameter("currentPage");
				PageBean pageBean = dbutil.queryByPage2(nowPage, sql1);
				request.setAttribute("pageBean", pageBean);
				
				
		        //request.getRequestDispatcher("Sys.jsp").forward(request, response); 
		        request.getRequestDispatcher("youzhishi/addFileLevel.jsp").forward(request, response);
	    }
	        
	
	
}
