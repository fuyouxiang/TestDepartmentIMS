package cn.com.shxt.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.SendEmail;

public class ReturnBBTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	//读取上传地址配置文件
	public ResourceBundle uploadAddress(){
		
		Properties prop = new Properties();
		//装载Properties配置文件
		ResourceBundle resource = ResourceBundle.getBundle("uploadAddress");
		return resource;
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();
		
		System.out.println(timelog+"测试人员驳回该版本————————");
		request.setCharacterEncoding("UTF-8");
		
		/**********************************************************************************************************************/
	       System.out.println(timelog+"===============进入上传servlet，开始上传文件===============");
	       //定义总文件名
	       String filename="";
	       SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式
			String time=df.format(new Date());// new Date()为获取当前系统时间
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
		                    if(value.length()<1) {
		                    	value="无";
			         	       	//定义文件名
	 		         	        String filenamePart=value;
			                	System.out.println("上传的文件名:"+filenamePart);
			                	filename=filenamePart;
		                    }else {
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
			         	       	//定义文件名
	 		         	        String filenamePart=Name+"_"+time+"."+Type;
			                	System.out.println("上传的文件名:"+filenamePart);
			                	filename=filenamePart;
			                    
			                    //真正写到磁盘上  
			                    //它抛出的异常 用exception 捕捉  	                      
			                    //item.write( new File(path,filename) );//第三方提供的  	                      
			                    //手动写的  
			                    OutputStream out = new FileOutputStream(new File(path,filenamePart));  	                      
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
			                    System.out.println("文件上传成功！");
			                    in.close();  
			                    out.close();  
		                    }
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
		System.out.println(timelog+"===============上传文件over===============");      
/**********************************************************************************************************************/	
		
		String D_TUSER = new String((request.getParameter("D_TUSER")).getBytes("iso8859-1"),"utf-8");
		System.out.println("测试人："+D_TUSER);
		String TIME = new String((request.getParameter("TIME")).getBytes("iso8859-1"),"utf-8");
		System.out.println("驳回时间："+TIME);
		String D_ID = request.getParameter("D_ID");
		System.out.println("版本ID："+D_ID);
		String REASON = new String((request.getParameter("REASON")).getBytes("iso8859-1"),"utf-8");
		System.out.println("驳回原因："+REASON);		
		String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";   
		String D_SUBURL =serviceRoot+"ResubmitBBTestServlet?D_ID="+D_ID;
		System.out.println("重新提交路径："+D_SUBURL);
		
		System.out.println("附件名："+filename);

		DBUtils dbutil =new DBUtils();
		
		//获取原测试版本的负责人
		String TesterSql="select * from SYS_TEST_SQ where D_ID='" + D_ID + "'";
		String OldTester = null;
		try {
			OldTester = dbutil.queryString(TesterSql,"D_TUSER");
		} catch (SQLException e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		}
		//状态修改人与原测试负责人做对比判断
		if(!OldTester.equals(D_TUSER)||OldTester==null) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('抱歉，您不是该版本的测试负责人！不允许进行该操作。');window.location.href='selectBanBenServlet?type=1';</script>");
		}else {
			
			//修改版本测试主表
			String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='2',D_SUBURL ='"+ D_SUBURL +"',D_NG=D_NG+1,D_REASON_FILE='"+ filename +"' where D_ID='"+ D_ID +"'";		
			int flag = dbutil.update(sql);
			System.out.println(timelog+"修改数据状态，填写重新提交地址："+sql);	

			//添加日志
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','驳回', '【结果：】"+REASON+"【附件：】"+filename+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(timelog+"添加日志："+sql2);	

			//发送邮件
			try {
				String emailSql="select * from SYS_TEST_SQ where D_ID='" + D_ID + "'";
				String BossEmail = dbutil.queryString(emailSql,"D_KBOSSEMAIL");
				String k_email = dbutil.queryString(emailSql,"D_KEMAIL");
				String weiServer = dbutil.queryString(emailSql,"D_WEINAME");
				String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
				String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				System.out.println(timelog+"邮件地址："+EmailAddress);
				String Msgtitle = D_KAIFA+"申请的"+banbenNo+"版本测试未通过！";
				System.out.println(timelog+"邮件标题："+Msgtitle);
				String Msg = "【微服务名】："+weiServer+"<br>"+"【版本号】："+banbenNo+"<br>"+"【测试人】："+D_TUSER+"<br>"+"【驳回时间】："+TIME+"<br>"+"【NG原因】："+REASON+"<br>"+"【测试结果附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+filename+"<br>"+"【重新申请地址】："+D_SUBURL+"；";
				System.out.println(timelog+"邮件内容："+Msg);
				SendEmail sendEmail = new SendEmail();
				sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
			}
			
			//response.sendRedirect("selectBanBenServlet");
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }   

		}

	}

}
