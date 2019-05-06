package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import cn.com.shxt.utils.DBUtils;

public class DeleteFileServlet extends HttpServlet {
	private static final long serialVersionUID = -1313170890068030737L;

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
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		String ATTACH_ID = request.getParameter("ATTACH_ID");
		System.out.println("文件id:"+ATTACH_ID);
		String ATTACH_NAME1 = request.getParameter("ATTACH_NAME");
		System.out.println("未编译文件名:"+ATTACH_NAME1);
		String ATTACH_TYPE = request.getParameter("ATTACH_TYPE");
		System.out.println("文件类型:"+ATTACH_TYPE);
		String ATTACH_NAME=new String(ATTACH_NAME1.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("文件名:"+ATTACH_NAME);
		
		//拼接完整文件名
		String FILE_NAME=ATTACH_NAME;
		System.out.println("完整文件名:"+FILE_NAME);
		
		
        //读取上传地址配置文件
		ResourceBundle resource = uploadAddress();
        String path =resource.getString("uploadAddress");
        System.out.println("文件路径："+path);
		
		System.out.println(time+"正在删除文档资料...文档ID为："+ATTACH_ID);
		String sql = "delete from sys_attach_file where ATTACH_ID =" + ATTACH_ID;
		System.out.println(time+sql);
		
		DBUtils dbutil = new DBUtils();
		int flag = dbutil.update(sql);
		
		String info ;
		if(flag > 0 ){
			info ="恭喜你!!文档删除成功！";
			request.setAttribute("info", info);
		}else{
			info ="不好意思,文档删除失败！";
			request.setAttribute("info", info);
		}
		
		
		 boolean result = false;
	     try{
	          java.io.File file = new java.io.File(path,FILE_NAME);
	           if(file.exists())
	            {
	               file.delete();
	               result = true;
	               System.out.println("文件"+FILE_NAME+"已经删除！");
	            }
	            else
	            {
	            System.out.println("文件"+FILE_NAME+"不存在！");
	            }
	        }
	      catch(Exception ex)
	       {
	        ex.printStackTrace();
	        System.out.println("Delete File is error:"+ex);
	       }
	     
	 
		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	 }
		
}



