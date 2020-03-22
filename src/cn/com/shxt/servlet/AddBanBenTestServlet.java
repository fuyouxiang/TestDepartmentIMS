package cn.com.shxt.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

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

public class AddBanBenTestServlet extends HttpServlet {

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
		
		
		
			System.out.println(timelog+"版本测试提交单申请————————");
			request.setCharacterEncoding("UTF-8");
		
/**********************************************************************************************************************/
	       System.out.println(timelog+"===============进入上传servlet，开始上传文件===============");
	       //定义文件名
	       String filename="无";
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

		                	filename=Name+"_"+time+"."+Type;
		                	System.out.println("上传的文件名:"+filename);
		                    
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
		                    System.out.println("文件上传成功！");
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
		System.out.println(timelog+"===============上传文件over===============");      
/**********************************************************************************************************************/	
		
		
		
		String type = request.getParameter("type");//申请类型：1是第一次新增；2是修改后重新提交
		System.out.println("申请类型："+type);
		
		DBUtils dbutil =new DBUtils();
		
		if(type.equals("1")) {
  
			//因为是文号传值，所以中文需要转码
			String Bumen =new String((request.getParameter("bumen")).getBytes("iso8859-1"),"utf-8");	
			String KaifaBossSql="select B_NAME,B_USER,PHONE,EMAIL from SYS_BUMEN where B_NAME='"+Bumen+"'";
			String Boss = null;
			String BossEmail = null;
			try {
				Boss = dbutil.queryString(KaifaBossSql,"B_USER");
				BossEmail = dbutil.queryString(KaifaBossSql,"EMAIL");
			} catch (SQLException e1) {
				// TODO 自动生成的 catch 块
				e1.printStackTrace();
			}
			System.out.println("部门："+Bumen);
			System.out.println("开发总监："+Boss);
			System.out.println("开发总监邮箱："+BossEmail);
			String kaifa =new String((request.getParameter("kaifa")).getBytes("iso8859-1"),"utf-8");
			System.out.println("开发："+kaifa);
			String k_email = new String((request.getParameter("k_email")).getBytes("iso8859-1"),"utf-8");
			System.out.println("开发邮箱："+k_email);	        
			String date = new String((request.getParameter("date")).getBytes("iso8859-1"),"utf-8");
			System.out.println("日期："+date);
			String weiServer = new String((request.getParameter("weiServer")).getBytes("iso8859-1"),"utf-8");
			System.out.println("微服务："+weiServer);
			String banbenNo = new String((request.getParameter("banbenNo")).getBytes("iso8859-1"),"utf-8");
			System.out.println("版本号："+banbenNo);
			String content = new String((request.getParameter("content")).getBytes("iso8859-1"),"utf-8");
			System.out.println("版本构造内容："+content);		
			String biaozhun = new String((request.getParameter("biaozhun")).getBytes("iso8859-1"),"utf-8");
			System.out.println("标准："+biaozhun);
			String wiki = filename;
			System.out.println("附件名字："+wiki);
			String D_ISSQL="0";
			if(wiki.equals("无")) {
				D_ISSQL="0";
			}else {
				D_ISSQL="1";
			}
			System.out.println("是否有附件："+D_ISSQL);
			String D_TYPE = "版本测试";
			System.out.println("测试类型："+D_TYPE);

			String sql = "insert into SYS_TEST_SQ (D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_TYPE,D_WEINAME,D_VERSION,D_WIKI,D_ISSQL) values " +
					"('" + Bumen + "','" + Boss + "','" + BossEmail + "','" + kaifa + "','" + date + "','" + content + "','" + biaozhun + "','" + k_email + "','" + D_TYPE + "','" + weiServer + "','" + banbenNo + "','" + wiki + "','" + D_ISSQL + "')";		
			
			int flag = dbutil.update(sql);
			System.out.println(timelog+"添加版本测试申请："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ((select d_id from SYS_TEST_SQ  where D_DATE='" + date + "'),'" + kaifa + "','" + date + "','提交申请', '"+"【内容】:"+content+"【标准】:"+biaozhun+"【wiki地址】:"+wiki+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(timelog+"添加日志："+sql2);	

			try {
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				String Msgtitle = kaifa+"申请版本测试！";
				String Msg = "【微服务名】："+weiServer+"；"+"【版本号】："+banbenNo+"；"+"【版本构造内容】："+content+"；"+"【测试标准】："+biaozhun+"；"+"【提交日期】："+date+"；"+"【wiki地址】："+wiki+"；";
				//SendEmail sendEmail = new SendEmail();
				//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
			}
		
			if(flag > 0 ){
				request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=yes").forward(request, response);
			}else{
				request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
			}
		}
		
		
		
		else if(type.equals("2")){
			String d_id = request.getParameter("d_id");
			System.out.println("d_id："+d_id);
			String date = request.getParameter("date");
			System.out.println("日期："+date);
			String content = request.getParameter("content");
			System.out.println("版本构造内容："+content);		
			String biaozhun = request.getParameter("biaozhun");
			System.out.println("标准："+biaozhun);
			String kaifa = request.getParameter("kaifa");
			System.out.println("开发："+kaifa);
			String weiServer = request.getParameter("weiServer");
			System.out.println("微服务："+weiServer);
			String banbenNo = request.getParameter("banbenNo");
			System.out.println("版本号："+banbenNo);
			String k_email = request.getParameter("k_email");
			System.out.println("开发邮箱："+k_email);
			String BossEmail = request.getParameter("BossEmail");
			System.out.println("开发总监邮箱："+BossEmail);
			String NGnumber = request.getParameter("NGnumber");
			System.out.println("NG次数："+NGnumber);
			String wiki = request.getParameter("wiki");
			System.out.println("wiki地址："+wiki);
			
			

			
			String sql = "update SYS_TEST_SQ set D_CONTENT ='"+ content +"',D_BIAOZHUN ='"+ biaozhun +"',D_STATE='0',D_WIKI ='"+ wiki +"' where D_ID='"+ d_id +"'";		
			int flag = dbutil.update(sql);
			System.out.println(timelog+"修改完成后重新提交申请单："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + d_id + "','" + kaifa + "','" + date + "','重新提交', '"+"【内容】:"+content+"【标准】:"+biaozhun+"【wiki地址】:"+wiki+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(timelog+"添加日志："+sql2);
			
			
			String sql3 = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_WEINAME,D_VERSION,D_STATE,D_SUBURL,D_WIKI from SYS_TEST_SQ where D_ID='"+d_id+"'";
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql3);
			
			
			try {
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				String Msgtitle = kaifa+"第"+NGnumber+"轮版本测试申请！";
				String Msg = "【微服务名】："+weiServer+"；"+"【版本号】："+banbenNo+"；"+"【版本构造内容】："+content+"；"+"【测试标准】："+biaozhun+"；"+"【提交日期】："+date+"；"+"【wiki地址】："+wiki+"；";
				//SendEmail sendEmail = new SendEmail();
				//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("User/ResubmitBBTest.jsp?StartAnswer=no").forward(request, response);
			}
			
			if(flag > 0){
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/ResubmitBBTest.jsp?StartAnswer=yes").forward(request, response);
			}else{
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/ResubmitBBTest.jsp?StartAnswer=no").forward(request, response);
			}
		}
		
		else {
			String info ="系统出现异常，请联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);		
		}


		
	}

}
