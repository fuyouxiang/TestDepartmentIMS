package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;  
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;   
import java.util.Properties;
import java.util.ResourceBundle;

import org.apache.commons.fileupload.FileItem;  
import org.apache.commons.fileupload.FileUploadException;  
import org.apache.commons.fileupload.disk.DiskFileItemFactory;  
import org.apache.commons.fileupload.servlet.ServletFileUpload; 

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class UploadUrlFileServlet extends HttpServlet {
	

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
		

			String weblogic_path = this.getClass().getClassLoader().getResource("/").getPath();
			System.out.println("——————测试———————查询当前服务路径:"+weblogic_path);
			String fileDirPath = request.getSession().getServletContext().getRealPath("/");
			System.out.println("——————测试———————查询当前服务路径2:"+fileDirPath);
			String fileDirPath2 =request.getSession().getServletContext().getResource("/").getFile();
			System.out.println("——————测试———————查询当前服务路径3:"+fileDirPath2);
			SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
			String time=df.format(new Date());// new Date()为获取当前系统时间
		
	       System.out.println("===============进入上传servlet，开始上传文件===============");
	       
	    	String URL_ID = request.getParameter("URL_ID");
	    	System.out.println("URL_ID:"+URL_ID);
	       
	       request.setCharacterEncoding("utf-8");

	        //获得磁盘文件条目工厂  
	        DiskFileItemFactory factory = new DiskFileItemFactory();  
	        //获取文件需要上传到的路径  
			//读取上传地址配置文件
			ResourceBundle resource = uploadAddress();

			 String path =resource.getString("uploadAddress");
		     //String path = "D:/uploadfile/";
		     System.out.println("上传路径："+path);
		     File file=new File(path);
		     if(!file.isDirectory()){
		    	 file.mkdirs();
		    	 System.out.println("没有检测到上传路径，自动创建路径："+path);
		     }

	         
		        //如果没以下两行设置的话，上传大的 文件 会占用 很多内存，  
		        //设置暂时存放的 存储室 , 这个存储室，可以和 最终存储文件 的目录不同  
		        /** 
		         * 原理 它是先存到 暂时存储室，然后在真正写到 对应目录的硬盘上，  
		         * 按理来说 当上传一个文件时，其实是上传了两份，第一个是以 .tem 格式的  
		         * 然后再将其真正写到 对应目录的硬盘上 
		         */  
		        factory.setRepository(new File(path));  
		        //设置 缓存的大小，当上传文件的容量超过该缓存时，直接放到 暂时存储室  
		        factory.setSizeThreshold(1024*1024) ;  
		          
		        //高水平的API文件上传处理  
		        ServletFileUpload upload = new ServletFileUpload(factory);  
		          	          
		        try {  
		            //可以上传多个文件  
		            List<FileItem> list = (List<FileItem>)upload.parseRequest(request);                
		            for(FileItem item : list)  
		            {  
		                //获取表单的属性名字  
		                String name = item.getFieldName();  	                  
		                //如果获取的 表单信息是普通的 文本 信息  
		                if(item.isFormField())  
		                {                     
		                    //获取用户具体输入的字符串 ，名字起得挺好，因为表单提交过来的是 字符串类型的  
		                    String value = item.getString() ;                        
		                    request.setAttribute(name, value);  
		                }  
		                //对传入的非 简单的字符串进行处理 ，比如说二进制的 图片，电影这些  
		                else  
		                {  
		                    /** 
		                     * 以下三步，主要获取 上传文件的名字 
		                     */  
		                    //获取路径名  
		                    String value = item.getName() ;
		                    /*
		                    //索引到最后一个反斜杠  
		                    int start = value.lastIndexOf("\\");  
		                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，  
		                    String filename1 = value.substring(start+1);
		                    */
		                    
		                    int dian=value.lastIndexOf(".");
		                    String Type=value.substring(dian+1);
		                	
		                    int gang=value.lastIndexOf("\\");
		                	String Name1=value.substring(gang+1);//斜杠后面的所有字符输出
		                	String Name=Name1.substring(0,Name1.lastIndexOf("."));

		                	String filename=Name+"_"+time+"."+Type;
		                	System.out.println("上传的文件名:"+filename);
		                    

		                	request.setAttribute("name", filename);
		                	request.setAttribute("URL_ID", URL_ID); 
		                    //真正写到磁盘上  
		                    //它抛出的异常 用exception 捕捉  	                      
		                    //item.write( new File(path,filename) );//第三方提供的  	                      
		                    //手动写的  
		                    OutputStream out = new FileOutputStream(new File(path,filename));  	                      
		                    InputStream in = item.getInputStream() ;  	                      
		                    int length = 0 ;  
		                    byte [] buf = new byte[1024] ;  	                      
		                    System.out.println("获取上传文件的总共的容量："+item.getSize());  	  
		                    // in.read(buf) 每次读到的数据存放在   buf 数组中  
		                    while( (length = in.read(buf) ) != -1)  
		                    {  
		                        //在   buf 数组中 取出数据 写到 （输出流）磁盘上  
		                        out.write(buf, 0, length);
		                        request.setAttribute("info", "文件已经上传成功！");
		                        
		                    }  	                      
		                    in.close();  
		                    out.close();  
		                     
		                   
		                }  
		            }  	              	              	              
		        } catch (FileUploadException e) {  
		            // TODO Auto-generated catch block  
		            e.printStackTrace();  
		        }  
		        catch (Exception e) {  
		            // TODO Auto-generated catch block  
		              
		            //e.printStackTrace();  
		        }
		        

		        request.getRequestDispatcher("guanliyuan/updateUrlFile.jsp").forward(request, response); 
	    }
	        
	
	
}
