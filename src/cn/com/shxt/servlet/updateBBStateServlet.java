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
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.SendEmail;

public class updateBBStateServlet extends HttpServlet {

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
		request.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");//调用方法类型
		System.out.println("调用方法类型："+type);
		
		//获取用户名称和角色
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
		System.out.println("从session中获取用户名："+username);
		String userrole = (String)session.getAttribute("userrole");
		System.out.println("从session中获取用户角色："+userrole);
		String UserCenter = (String)session.getAttribute("UserCenter");
		System.out.println("从session中获取用户所属中心："+UserCenter);
		
		if(type.equals("1")) {
			
			System.out.println(timelog+"查询要修改的版本测试————————");
			String D_ID = request.getParameter("D_ID");
			System.out.println("申请单ID："+D_ID);
			DBUtils dbutil =new DBUtils();
			String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_WEINAME,D_VERSION,D_STATE,D_SUBURL,D_WIKI,D_ISSQL,D_ISJXXC,D_ISYCHJ,D_ISJXPRE,D_ISYTH2020,D_SQL,D_CONFIG,D_REASON_FILE from SYS_TEST_SQ where  D_ID='"+ D_ID +"' ";		
			System.out.println(timelog+"查询申请单ID："+sql);	
			
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);

			request.getRequestDispatcher("User/BanBenState.jsp").forward(request, response);	
			
			
		}else if(type.equals("2")) {
			
			System.out.println(timelog+"修改版本测试————————");
			
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
				                	filename+=filenamePart+":";
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
				                	filename+=filenamePart+":";
				                    
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
			
			DBUtils dbutil =new DBUtils();
			
			String D_ID = request.getParameter("D_ID");
			System.out.println("申请单ID："+D_ID);
			String D_ISJXXC = new String((request.getParameter("D_ISJXXC")).getBytes("iso8859-1"),"utf-8");
			System.out.println("是否发江西："+D_ISJXXC);
			String D_ISYCHJ = new String((request.getParameter("D_ISYCHJ")).getBytes("iso8859-1"),"utf-8");
			System.out.println("是否更新压测环境："+D_ISYCHJ);
			String D_ISJXPRE = new String((request.getParameter("D_ISJXPRE")).getBytes("iso8859-1"),"utf-8");
			System.out.println("是否更新jxpre环境："+D_ISJXPRE);
			String D_ISYTH2020 = new String((request.getParameter("D_ISYTH2020")).getBytes("iso8859-1"),"utf-8");
			System.out.println("是否更新yth2020环境："+D_ISYTH2020);
			
			//对三个附件名字进行截取
			System.out.println("四个文件名："+filename);
			String[] list=filename.split(":");
			String D_WIKI = list[0];
			System.out.println("内容附件（新获取）："+D_WIKI);
			String D_SQL = list[1];
			System.out.println("SQL附件（新获取）："+D_SQL);
			String D_CONFIG = list[2];
			System.out.println("配置文件附件（新获取）："+D_CONFIG);
			String D_REASON_FILE = list[3];
			System.out.println("测试结果附件（新获取）："+D_REASON_FILE);
			
			//是否有sql文件
			String D_ISSQL="1";
			//是否有配置文件
			String D_ISCONFIG="1";
			
			//查询原数据
			String OldIDSql="select D_WIKI,D_SQL,D_CONFIG,D_REASON_FILE from sys_test_sq where D_ID='"+D_ID+"'";
			try {
			//如果没有上传新附件的话，用原来的附件
			if(D_WIKI.equals("无")){
				D_WIKI = dbutil.queryString(OldIDSql,"D_WIKI");
				System.out.println("内容附件（使用原附件）："+D_WIKI);

			}
			if(D_SQL.equals("无")){
				D_SQL = dbutil.queryString(OldIDSql,"D_SQL");
				System.out.println("SQL附件（使用原附件）："+D_SQL);

			}
			if(D_CONFIG.equals("无")){
				D_CONFIG = dbutil.queryString(OldIDSql,"D_CONFIG");
				System.out.println("配置文件附件（使用原附件）："+D_CONFIG);
			}
			if(D_REASON_FILE.equals("无")){
				D_REASON_FILE = dbutil.queryString(OldIDSql,"D_REASON_FILE");
				System.out.println("测试结果附件（使用原附件）："+D_REASON_FILE);
			}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			if(D_SQL.equals("无")) {
				D_ISSQL="0";
			}
			if(D_CONFIG.equals("无")) {
				D_ISCONFIG="0";
			}

			
			String sql = "update SYS_TEST_SQ SET D_ISJXXC='"+ D_ISJXXC +"',D_ISYCHJ='"+ D_ISYCHJ +"',D_ISJXPRE='"+ D_ISJXPRE +"',D_ISYTH2020='"+ D_ISYTH2020 +"',D_WIKI='"+ D_WIKI +"',D_SQL='"+ D_SQL +"',D_CONFIG='"+ D_CONFIG +"',D_REASON_FILE='"+ D_REASON_FILE +"',D_ISSQL='"+ D_ISSQL +"',D_ISCONFIG='"+ D_ISCONFIG +"' where D_ID='"+ D_ID +"' ";		
			System.out.println(timelog+"修改版本测试状态："+sql);	
			
			int flag = dbutil.update(sql);
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }   
			
			
		}else if(type.equals("3")) {
			
			System.out.println(timelog+"测试通过发送江西————————");
			String D_ID = request.getParameter("D_ID");
			System.out.println("申请单ID："+D_ID);
			DBUtils dbutil =new DBUtils();
			
			//发送邮件
			try {
				String selectBBSql = "select * from SYS_TEST_SQ where  D_ID='"+ D_ID +"' ";
				System.out.println(timelog+"查询申请单ID："+selectBBSql);	
				String BossEmail = dbutil.queryString(selectBBSql,"D_KBOSSEMAIL");//开发总监邮箱
				String k_email = dbutil.queryString(selectBBSql,"D_KEMAIL");//开发邮箱
				String weiServer = dbutil.queryString(selectBBSql,"D_WEINAME");//微服务名
				String banbenNo = dbutil.queryString(selectBBSql,"D_VERSION");//版本号
				String D_KAIFA = dbutil.queryString(selectBBSql,"D_KAIFA");//开发
				String D_TUSER = dbutil.queryString(selectBBSql,"D_TUSER");//测试
				String D_REASON_FILE= dbutil.queryString(selectBBSql,"D_REASON_FILE");//结果附件
				String D_CONFIG= dbutil.queryString(selectBBSql,"D_CONFIG");//配置文件附件
				String D_SQL= dbutil.queryString(selectBBSql,"D_SQL");//SQL脚本附件
				String D_WIKI= dbutil.queryString(selectBBSql,"D_WIKI");//构造内容附件
				String D_CONTENT= dbutil.queryString(selectBBSql,"D_CONTENT");//构造内容附件
				
				
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				System.out.println(timelog+"查询测试部经理："+TestBossSql);	
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");//测试部经理
				System.out.println(timelog+"测试部经理邮箱："+TestBossSql);	
				
				String JinJiBossSql="select B_NAME,B_USER,PHONE,EMAIL from SYS_BUMEN where B_NAME='江西现场'";
				String JinjiBoss = dbutil.queryString(JinJiBossSql,"EMAIL");
				System.out.println("江西收件人："+JinjiBoss);	
				
				String UserSql="select * from sys_user where U_NAME='"+ username +"' ";
				String userEMAIL = dbutil.queryString(UserSql,"EMAIL");
				if(userEMAIL==null) {
					userEMAIL= "fuyx1@yonyou.com";
				}
				System.out.println("操作人邮箱："+userEMAIL);	
				
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email+";"+JinjiBoss+";"+userEMAIL;
				
				System.out.println(timelog+"邮件地址："+EmailAddress);
				String Msgtitle = weiServer+"微服务"+banbenNo+"版本已测试通过！（请现场查收并下载附件）";
				System.out.println(timelog+"邮件标题："+Msgtitle);
				String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 
				String Msg = "【微服务名】："+weiServer+"<br>"+"【版本号】："+banbenNo+"<br>"+"【开发人】："+D_KAIFA+"<br>"+"【测试人】："+D_TUSER+"<br>"+
				"【更新内容】："+D_CONTENT+"<br>"+
				"【测试结果附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+D_REASON_FILE+"<br>"+
				"【构造内容附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+D_WIKI+"<br>"+
				"【SQL附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+D_SQL+"<br>"+
				"【配置文件附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+D_CONFIG+"<br>";
				System.out.println(timelog+"邮件内容："+Msg);
				SendEmail sendEmail = new SendEmail();
				sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('发送失败！请联系管理员。');window.location.href='selectBanBenServlet?type=1';</script>");
			}
			
			String UpdateSql = "update SYS_TEST_SQ SET D_ISJXXC='1' where D_ID='"+ D_ID +"' ";		
			System.out.println(timelog+"修改版本测试状态："+UpdateSql);
			int flag = dbutil.update(UpdateSql);
			
			response.setContentType("text/html; charset=UTF-8");
		    response.getWriter().println("<script>alert('发送成功！');window.location.href='selectBanBenServlet?type=1';</script>");
		}
		else {
			String info ="系统出现异常，请联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);		
		}
		

		
	}

}
