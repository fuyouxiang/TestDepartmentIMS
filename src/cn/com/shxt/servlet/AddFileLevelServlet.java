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

public class AddFileLevelServlet extends HttpServlet {
	

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


			       request.setCharacterEncoding("UTF-8");  //设置编码 
			       String ATTACH_NAME = request.getParameter("ATTACH_NAME");	//文件名称       
			       System.out.println("文件名称 "+ATTACH_NAME);
			       String APPID = request.getParameter("APPID");//子系统
			       System.out.println("一级目录"+APPID);
			       
			       String radio = request.getParameter("radio");
			       System.out.println("radio"+radio);
			       String FILE_CATALOG_choose = request.getParameter("FILE_CATALOG_choose");
			       String FILE_CATALOG_input = request.getParameter("FILE_CATALOG_input");
			       String FILE_CATALOG;
			       
			       if(radio.equals("1")){
			    	   System.out.println("用户选择二级目录");
			    	   FILE_CATALOG=FILE_CATALOG_choose;
			       }else{
			    	   System.out.println("用户手工录入二级目录");
			    	   FILE_CATALOG=FILE_CATALOG_input;
			       }
			       System.out.println("二级目录"+FILE_CATALOG);
			       
			       if(FILE_CATALOG==""||FILE_CATALOG.length()<2){
			    	   System.out.println("二级目录入为空");
			    	   FILE_CATALOG="未分类";
			       }
			       System.out.println("判断后的二级目录："+FILE_CATALOG);
			    	   DBUtils dbutil =new DBUtils();
						String sql = "update SYS_ATTACH_FILE set FILE_CATALOG='"+FILE_CATALOG+"' where ATTACH_NAME='"+ATTACH_NAME+"'";
						int flag = dbutil.update(sql);
						String info;
						if(flag > 0){
							info ="上传文件成功！";
							request.setAttribute("info", info);
						}else{
							info ="上传文件出现异常！";
							request.setAttribute("info", info);
						}
						request.getRequestDispatcher("Sys.jsp").forward(request, response); 


			       
		       

	    }
	        
	
	
}
