package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;  
import java.util.List;   

import org.apache.commons.fileupload.FileItem;  
import org.apache.commons.fileupload.FileUploadException;  
import org.apache.commons.fileupload.disk.DiskFileItemFactory;  
import org.apache.commons.fileupload.servlet.ServletFileUpload; 

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

import cn.com.shxt.utils.DBUtils;

public class UploadServlet3 extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292614L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}
	
	/*
	 * 文件上传时，需在表单form中添加属性ENCTYPE="multipart/form-data"
	 * （意思是：设置表单的MIME编码。默认情况，这个编码格式是application/x-www-form-urlencoded，不能用于文件上传。只有使用了 multipart/form-data，才能完整的传递文件数据）。
	 * 但是，设置ENCTYPE="multipart/form-data"后，servlet中除了file类型表单能获取到，其他value通过request.getParameter()方法获得的值为null。
	 * 
	 * 解决办法：
	 * 使用jspSmartUpload组件实现上传。
	 * */
	 private   ServletConfig   config;  
	  final   public   ServletConfig   getServletConfig()   {  
		     return   config;  
		   }  
		   public   void   init(ServletConfig   config)   throws   ServletException   {  
		     super.init(config);  
		     this.config   =   config;  
		   }  
		   
		   
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//解决当FORM的ENCTYPE="multipart/form-data" 时request.getParameter()获取不到值的问题
		   SmartUpload smartupload = new SmartUpload();
		   smartupload.initialize(config, request, response);
		   smartupload.setMaxFileSize(2000000000L);//每个上传文件最大2MB;
		   try {
			smartupload.upload();
		} catch (SmartUploadException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		   
		
	       String time= DateTime.showtime(); //时间戳，直接调用DateTime.java中的方法
	       
	       System.out.println("进入servlet，开始上传文件——————————————");
	       
	       request.setCharacterEncoding("UTF-8");  //设置编码 
	       String ATTACH_NAME = smartupload .getRequest().getParameter("ATTACH_NAME");	//文件名称       
	       System.out.println("文件名称 "+ATTACH_NAME);
	       String ATTACH_TYPE = smartupload .getRequest().getParameter("ATTACH_TYPE");//文件类型
	       System.out.println("文件类型 "+ATTACH_TYPE);
	       String APPID = smartupload .getRequest().getParameter("APPID");//子系统
	       System.out.println("子系统"+APPID);
	       String ITEM_TYPE = smartupload .getRequest().getParameter("ITEM_TYPE");//查询标识
	       System.out.println("查询标识 "+ITEM_TYPE);
	       String REMARK = smartupload .getRequest().getParameter("REMARK");//备注
	       System.out.println("备注 "+REMARK);
	       String CREATE_TIME = time;//创建时间
	       System.out.println("创建时间 "+CREATE_TIME);
	       
	       
	       
	       
	       
	       
	          
	        //获得磁盘文件条目工厂  
	        DiskFileItemFactory factory = new DiskFileItemFactory();  
	        //获取文件需要上传到的路径  
	        if(APPID.equals("001")){

		        
		        String path = "D:/uploadfile/001/";
		        System.out.println("上传路径"+path);
		        String ATTACH_PATH=path+ATTACH_NAME+"."+ATTACH_TYPE;//文件路径
		        System.out.println("文件路径"+ATTACH_PATH);
	         
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
		                    //索引到最后一个反斜杠  
		                    int start = value.lastIndexOf("\\");  
		                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，  
		                    String filename = value.substring(start+1);  	                      
		                    request.setAttribute(name, filename);  	                      
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
		        
		        
		        DBUtils dbutil =new DBUtils();
				String sql = "insert into sys_attach_file (ATTACH_PATH,ATTACH_NAME,ATTACH_TYPE,APPID,ITEM_TYPE,REMARK,CREATE_TIME) values " +
						"('" + ATTACH_PATH + "','" + ATTACH_NAME + "','" + ATTACH_TYPE + "','" + APPID + "','" + ITEM_TYPE + "','" + REMARK + "','" + CREATE_TIME + "')";
				int flag = dbutil.update(sql);
				String info ;
				if(flag > 0){
					info ="恭喜你!!上传文件成功！";
					request.setAttribute("info", info);
				}else{
					info ="不好意思,上传文件失败！";
					request.setAttribute("info", info);
				}
		        request.getRequestDispatcher("Sys.jsp").forward(request, response); 
	    }
	        
	        
	        
	        
	        
	        
	        else if(APPID.equals("002")){ 
     	
	        String path = "D:/uploadfile/002/";	        
         
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
	                    //索引到最后一个反斜杠  
	                    int start = value.lastIndexOf("\\");  
	                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，  
	                    String filename = value.substring(start+1);  	                      
	                    request.setAttribute(name, filename);  	                      
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
	        
	        
	        DBUtils dbutil =new DBUtils();
	        String ATTACH_PATH=path+ATTACH_NAME+"."+ATTACH_TYPE;//文件路径
			String sql = "insert into sys_attach_file (ATTACH_PATH,ATTACH_NAME,ATTACH_TYPE,APPID,ITEM_TYPE,REMARK,CREATE_TIME) values " +
					"('" + ATTACH_PATH + "','" + ATTACH_NAME + "','" + ATTACH_TYPE + "','" + APPID + "','" + ITEM_TYPE + "','" + REMARK + "','" + CREATE_TIME + "')";
			int flag = dbutil.update(sql);
			String info ;
			if(flag > 0){
				info ="恭喜你!!上传文件成功！";
				request.setAttribute("info", info);
			}else{
				info ="不好意思,上传文件失败！";
				request.setAttribute("info", info);
			}
	        request.getRequestDispatcher("Sys.jsp").forward(request, response); 
}
	        
	        
	        
	        else if(APPID.equals("003")){ 
	        	 
	         	
		        String path = "D:/uploadfile/002/";	        
	         
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
		                    //索引到最后一个反斜杠  
		                    int start = value.lastIndexOf("\\");  
		                    //截取 上传文件的 字符串名字，加1是 去掉反斜杠，  
		                    String filename = value.substring(start+1);  	                      
		                    request.setAttribute(name, filename);  	                      
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
		        
		        
		        DBUtils dbutil =new DBUtils();
		        String ATTACH_PATH=path+ATTACH_NAME+"."+ATTACH_TYPE;//文件路径
				String sql = "insert into sys_attach_file (ATTACH_PATH,ATTACH_NAME,ATTACH_TYPE,APPID,ITEM_TYPE,REMARK,CREATE_TIME) values " +
						"('" + ATTACH_PATH + "','" + ATTACH_NAME + "','" + ATTACH_TYPE + "','" + APPID + "','" + ITEM_TYPE + "','" + REMARK + "','" + CREATE_TIME + "')";
				int flag = dbutil.update(sql);
				String info ;
				if(flag > 0){
					info ="恭喜你!!上传文件成功！";
					request.setAttribute("info", info);
				}else{
					info ="不好意思,上传文件失败！";
					request.setAttribute("info", info);
				}
		        request.getRequestDispatcher("Sys.jsp").forward(request, response); 

	        }
	        
	        
	        
	        
	        
	        
		}
}
