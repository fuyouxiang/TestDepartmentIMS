package cn.com.shxt.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

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

public class AddDanYuanTestServlet extends HttpServlet {

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
		
		//获取用户名称和角色
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
		System.out.println("从session中获取用户名："+username);

		
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
		
		String type = request.getParameter("type");//调用方法类型
		System.out.println("调用方法类型："+type);
		DBUtils dbutil =new DBUtils();
		
		
//=================================1单位测试新增方法=================================
		if(type.equals("1")) {
		System.out.println(timelog+"单元测试提交单申请————————");
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
		String kaifa = new String((request.getParameter("kaifa")).getBytes("iso8859-1"),"utf-8");
		System.out.println("开发："+kaifa);
		String k_email = new String((request.getParameter("k_email")).getBytes("iso8859-1"),"utf-8");
		System.out.println("开发邮箱："+k_email);
		String date = new String((request.getParameter("date")).getBytes("iso8859-1"),"utf-8");
		System.out.println("日期："+date);
		String dyName = new String((request.getParameter("dyName")).getBytes("iso8859-1"),"utf-8");
		System.out.println("单元测试名称："+dyName);
		String content = new String((request.getParameter("content")).getBytes("iso8859-1"),"utf-8");
		System.out.println("内容："+content);
		String biaozhun = new String((request.getParameter("biaozhun")).getBytes("iso8859-1"),"utf-8");
		System.out.println("标准："+biaozhun);
		String wiki = filename;
		System.out.println("附件名字："+wiki);
		String D_TYPE = "单元测试";
		System.out.println("测试类型："+D_TYPE);

		String sql = "insert into SYS_TEST_SQ (D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_TYPE,D_VERSION,D_WIKI) values " +
				"('" + Bumen + "','" + Boss + "','" + BossEmail + "','" + kaifa + "','" + date + "','" + content + "','" + biaozhun + "','" + k_email + "','" + D_TYPE + "','" + dyName + "','" + wiki + "')";		
		
		int flag = dbutil.update(sql);
		System.out.println(timelog+"添加单元测试申请："+sql);	
		
		String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ((select d_id from SYS_TEST_SQ  where D_DATE='" + date + "'),'" + kaifa + "','" + date + "','提交申请', '【内容】:"+content+"【标准】:"+biaozhun+"【附件名称】:"+wiki+"')";
		int flag2 = dbutil.update(sql2);
		System.out.println(timelog+"添加日志："+sql2);
		
		
		try {
			String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
			String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
			String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
			String Msgtitle = kaifa+"申请单元测试！";
			String Msg = "【单元名称】："+dyName+"<br>"+"【测试内容】："+content+"<br>"+"【测试标准】："+biaozhun+"<br>"+"【提交日期】："+date+"<br>"+"【附件名称】:"+wiki+";";
			SendEmail sendEmail = new SendEmail();
			sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
		}catch(Exception e){
			request.getRequestDispatcher("TestFormSubmit_danyuan.jsp?answer=no").forward(request, response);
		}
		if(flag > 0 ){
			request.getRequestDispatcher("TestFormSubmit_danyuan.jsp?answer=yes").forward(request, response);
		}else{
			request.getRequestDispatcher("TestFormSubmit_danyuan.jsp?answer=no").forward(request, response);
		}
		}
//=================================1结束=================================		

		
//=================================2单元测试查询=================================
		else if(type.equals("2")){
			System.out.println(timelog+"单元测试菜单查询————————");
			
			//查询条件：部门
			String selBumen = request.getParameter("selBumen");
			String selBumenSQL;
			if(selBumen== null || selBumen.length()==0 || selBumen.equals("全部")) {
				selBumenSQL=" AND 1=1 ";
				//发送查询条件默认值
				request.setAttribute("selBumen", "");
			}else {
				selBumenSQL=" AND D_BUMEN='"+selBumen+"' ";
				//发送查询条件默认值
				request.setAttribute("selBumen", selBumen);
			}
			System.out.println(timelog+"查询条件：部门:"+selBumenSQL);
			
			
			//查询条件：单元测试名称(模糊查询)
			String selVersion = request.getParameter("selVersion");
			String selVersionSQL;
			if(selVersion== null || selVersion.length()==0 || selVersion.equals("全部")) {
				selVersionSQL=" AND 1=1 ";
				request.setAttribute("selVersion", "");
			}else {
				selVersionSQL=" AND D_VERSION like '%"+selVersion+"%' ";
				request.setAttribute("selVersion", selVersion);
			}
			System.out.println(timelog+"查询条件：单元测试名称(模糊查询):"+selVersionSQL);
			
			//查询条件：月份
			String selMonth = request.getParameter("selMonth");
			String selMonthSQL;
			Calendar cal = Calendar.getInstance();
	        int year = cal.get(Calendar.YEAR);
			if(selMonth== null || selMonth.length()==0 || selMonth.equals("全部")) {
				selMonthSQL=" AND 1=1 ";
				request.setAttribute("selMonth", "");
			}else {
				selMonthSQL=" AND D_DATE like '"+year+"-"+selMonth+"-%' ";
				request.setAttribute("selMonth", selMonth);
			}
			System.out.println(timelog+"查询条件：月份:"+selMonthSQL);
			
			//查询条件：状态
			String selState = request.getParameter("selState");
			String selStateSQL;
			if(selState== null || selState.length()==0 || selState.equals("全部")) {
				selStateSQL=" AND 1=1 ";
				request.setAttribute("selState", "");
			}else {
				selStateSQL=" AND D_STATE = '"+selState+"' ";
				request.setAttribute("selState", selState);
			}
			System.out.println(timelog+"查询条件：状态:"+selStateSQL);
			
			//排序条件
			String OrderSQL=" order by D_DATE desc";
			
			String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL,D_WIKI,D_REASON_FILE from SYS_TEST_SQ where D_TYPE='单元测试'"
					+selBumenSQL+selVersionSQL+selMonthSQL+selStateSQL+OrderSQL;
					System.out.println(timelog+"总查询SQL:"+sql);
			
			String nowPage = request.getParameter("currentPage");
			System.out.println(time+"当前页数:"+nowPage);
			PageBean pageBean = dbutil.queryByPage3(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			System.out.println(time+"总页数:"+pageBean);
			
			//部门查询条件
			String sql2 = "select B_NAME from SYS_BUMEN where B_NAME != '产品测试部'";
			PageBean pageBean2 = dbutil.queryByPage2(nowPage, sql2);
			request.setAttribute("pageBean2", pageBean2);
			System.out.println(timelog+"部门查询:"+sql2);
			
			
			//查询通过率
			String sql3 = "select \r\n" + 
					"distinct (select count(1) from sys_test_sq where D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NGALL,\r\n" + 
					"(select count(1) from sys_test_sq where d_ng=0 and D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NG1,\r\n" + 
					"(select count(1) from sys_test_sq where d_ng=1 and D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NG2,\r\n" + 
					"(select count(1) from sys_test_sq where d_ng>=2 and D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NG3\r\n" + 
					"from sys_test_sq";
			PageBean pageBean3 = dbutil.queryByPage2(nowPage, sql3);
			request.setAttribute("pageBean3", pageBean3);
			System.out.println(timelog+"查询通过率:"+sql3);
			
			request.getRequestDispatcher("User/selectDanYuan.jsp").forward(request, response);
		
		}
//=================================2结束=================================		

//=================================3单元测试开始=================================
		else if(type.equals("3")) {
			System.out.println(timelog+"测试人员已接单，开始测试————————");
			String D_TUSER = request.getParameter("D_TUSER");
			System.out.println("测试人："+D_TUSER);
			String TIME = request.getParameter("TIME");
			System.out.println("开始时间："+TIME);
			String D_ID = request.getParameter("D_ID");
			System.out.println("单元ID："+D_ID);

			
			String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='1' where D_ID='"+ D_ID +"'";		
			int flag = dbutil.update(sql);
			System.out.println(timelog+"修改该测试任务的测试人："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','开始测试', '无')";
			int flag2 = dbutil.update(sql2);
			System.out.println(timelog+"添加日志："+sql2);
			
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='AddDanYuanTestServlet?type=2';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='AddDanYuanTestServlet?type=2';</script>");
		    }   

		}
//=================================3结束=================================	
		
		
		
//=================================4单元测试驳回=================================
		else if(type.equals("4")) {
			System.out.println(timelog+"测试人员驳回该单元测试————————");
			String D_TUSER = new String((request.getParameter("D_TUSER")).getBytes("iso8859-1"),"utf-8");
			System.out.println("测试人："+D_TUSER);
			String TIME = new String((request.getParameter("TIME")).getBytes("iso8859-1"),"utf-8");
			System.out.println("驳回时间："+TIME);
			String D_ID = request.getParameter("D_ID");
			System.out.println("单元ID："+D_ID);
			String REASON = new String((request.getParameter("REASON")).getBytes("iso8859-1"),"utf-8");
			System.out.println("驳回原因："+REASON);		
			String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";   
			String D_SUBURL =serviceRoot+"ResubmitDYTestServlet?D_ID="+D_ID;
			System.out.println("重新提交路径："+D_SUBURL);
			
			System.out.println("附件名："+filename);
			
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
			if(!OldTester.equals(D_TUSER)) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('抱歉，您不是该版本的测试负责人！不允许进行该操作。');window.location.href='selectBanBenServlet?type=1';</script>");
			}else {

				
				//修改单元测试主表
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
					String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
					String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
					
					String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
					String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
					
					String UserSql="select * from sys_user where U_NAME='"+ username +"' ";
					String userEMAIL = dbutil.queryString(UserSql,"EMAIL");
					if(userEMAIL==null) {
						userEMAIL= "fuyx1@yonyou.com";
					}
					System.out.println("操作人邮箱："+userEMAIL);	
					
					String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email+";"+userEMAIL;
					System.out.println(timelog+"邮件地址："+EmailAddress);
					String Msgtitle = D_KAIFA+"申请的单元测试未通过！";
					System.out.println(timelog+"邮件标题："+Msgtitle);
					String Msg = "【单元测试名称】："+banbenNo+"<br>"+"【驳回人】："+D_TUSER+"<br>"+"【驳回时间】："+TIME+"<br>"+"【驳回原因】："+REASON+"<br>"+"【测试结果附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+filename+"<br>"+"【重新提交地址】："+D_SUBURL+"；";
					System.out.println(timelog+"邮件内容："+Msg);
					SendEmail sendEmail = new SendEmail();
					sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
				}catch(Exception e){
					request.getRequestDispatcher("AddDanYuanTestServlet?type=2").forward(request, response);
				}
				
				response.setContentType("text/html; charset=UTF-8");
			    if(flag>0){
			    response.getWriter().println("<script>alert('操作成功！');window.location.href='AddDanYuanTestServlet?type=2';</script>");
			    }else{
			    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='AddDanYuanTestServlet?type=2';</script>");
			    }   
			}

		}
//=================================4结束=================================

		
//=================================5单元测试通过=================================
		else if(type.equals("5")) {
			System.out.println(timelog+"单元测试通过————————");
			request.setCharacterEncoding("UTF-8");
			String D_TUSER = new String((request.getParameter("D_TUSER")).getBytes("iso8859-1"),"utf-8");
			System.out.println("测试人："+D_TUSER);
			String TIME = new String((request.getParameter("TIME")).getBytes("iso8859-1"),"utf-8");
			System.out.println("通过时间："+TIME);
			String D_ID = request.getParameter("D_ID");
			System.out.println("单元ID："+D_ID);
			String REASON = new String((request.getParameter("REASON")).getBytes("iso8859-1"),"utf-8");
			System.out.println("备注："+REASON);	
			
			System.out.println("附件名："+filename);
			
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
			if(!OldTester.equals(D_TUSER)) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('抱歉，您不是该版本的测试负责人！不允许进行该操作。');window.location.href='selectBanBenServlet?type=1';</script>");
			}else {
				//修改版本测试主表
				String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='3',D_REASON_FILE='"+ filename +"' where D_ID='"+ D_ID +"'";		
				int flag = dbutil.update(sql);
				System.out.println(timelog+"测试结束修改数据状态："+sql);	

				//添加日志
				String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','测试通过', '【结果：】"+REASON+"【附件：】"+filename+"')";
				String sql3 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','测试结束', '" + REASON + "')";
				int flag2 = dbutil.update(sql2);
				if(flag2>0) {
					dbutil.update(sql3);
				}
				System.out.println(timelog+"添加日志："+sql2);
				System.out.println(timelog+"添加日志："+sql3);	
				
				String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/"; 

				//发送邮件
				try {
					String emailSql="select * from SYS_TEST_SQ where D_ID='" + D_ID + "'";
					String BossEmail = dbutil.queryString(emailSql,"D_KBOSSEMAIL");
					String k_email = dbutil.queryString(emailSql,"D_KEMAIL");
					String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
					String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
					
					String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
					String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
					
					String UserSql="select * from sys_user where U_NAME='"+ username +"' ";
					String userEMAIL = dbutil.queryString(UserSql,"EMAIL");
					if(userEMAIL==null) {
						userEMAIL= "fuyx1@yonyou.com";
					}
					System.out.println("操作人邮箱："+userEMAIL);	
					
					String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email+";"+userEMAIL;
					System.out.println(timelog+"邮件地址："+EmailAddress);
					String Msgtitle = D_KAIFA+"申请的"+banbenNo+"单元测试结束，测试通过！";
					System.out.println(timelog+"邮件标题："+Msgtitle);
					String Msg = "【单元测试名称】："+banbenNo+"<br>"+"【申请人】："+D_KAIFA+"<br>"+"【测试人】："+D_TUSER+"<br>"+"【通过时间】："+TIME+"<br>"+"【测试结果附件】："+serviceRoot+"youzhishi/DownloadPDF.jsp?ATTACH_NAME="+filename+"<br>"+"【备注/遗留】："+REASON+"；";
					System.out.println(timelog+"邮件内容："+Msg);
					SendEmail sendEmail = new SendEmail();
					sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
				}catch(Exception e){
					request.getRequestDispatcher("AddDanYuanTestServlet?type=2").forward(request, response);
				}
				
				response.setContentType("text/html; charset=UTF-8");
			    if(flag>0){
			    response.getWriter().println("<script>alert('操作成功！');window.location.href='AddDanYuanTestServlet?type=2';</script>");
			    }else{
			    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='AddDanYuanTestServlet?type=2';</script>");
			    }   
			}

		}		
//=================================5结束=================================	

//=================================6重新提交测试单=================================
		else if(type.equals("6")) {
			
			System.out.println(timelog+"重新提交测试单————————");
			String d_id = new String((request.getParameter("d_id")).getBytes("iso8859-1"),"utf-8");
			System.out.println("d_id："+d_id);
			String date = new String((request.getParameter("date")).getBytes("iso8859-1"),"utf-8");
			System.out.println("日期："+date);
			String content = new String((request.getParameter("content")).getBytes("iso8859-1"),"utf-8");
			System.out.println("版本构造内容："+content);		
			String biaozhun = new String((request.getParameter("biaozhun")).getBytes("iso8859-1"),"utf-8");
			System.out.println("标准："+biaozhun);
			String kaifa = new String((request.getParameter("kaifa")).getBytes("iso8859-1"),"utf-8");
			System.out.println("开发："+kaifa);
			String dyName = new String((request.getParameter("dyName")).getBytes("iso8859-1"),"utf-8");
			System.out.println("单元测试名称："+dyName);
			String k_email = new String((request.getParameter("k_email")).getBytes("iso8859-1"),"utf-8");
			System.out.println("开发邮箱："+k_email);
			String BossEmail = new String((request.getParameter("BossEmail")).getBytes("iso8859-1"),"utf-8");
			System.out.println("开发总监邮箱："+BossEmail);
			String NGnumber = new String((request.getParameter("NGnumber")).getBytes("iso8859-1"),"utf-8");
			System.out.println("NG次数："+NGnumber);
			String wiki = filename;
			String wikiSql =" ";
			System.out.println("附件名字："+wiki);
			if(wiki.equals("无")) {
				wikiSql =" ";
			}else {
				wikiSql=",D_WIKI='"+wiki+"'";
			}

			
			String sql = "update SYS_TEST_SQ set D_CONTENT ='"+ content +"',D_BIAOZHUN ='"+ biaozhun +"',D_STATE='0'"+wikiSql+" where D_ID='"+ d_id +"'";		
			int flag = dbutil.update(sql);
			System.out.println(timelog+"修改完成后重新提交申请单："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + d_id + "','" + kaifa + "','" + date + "','重新提交', '【内容】:"+content+"【标准】:"+biaozhun+"+【附件名称】:"+wiki+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(timelog+"添加日志："+sql2);
			
				
			
			try {
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				String Msgtitle = kaifa+"第"+NGnumber+"轮单元测试申请！";
				String Msg = "【单元测试名称】："+dyName+"<br>"+"【测试内容】："+content+"<br>"+"【测试标准】："+biaozhun+"<br>"+"【提交日期】："+date+"<br>"+"【附件名称】:"+wiki+";";
				SendEmail sendEmail = new SendEmail();
				sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("User/ResubmitBBTest.jsp?StartAnswer=no").forward(request, response);
			}
			if(flag > 0){
				request.getRequestDispatcher("User/ResubmitDYTest.jsp?StartAnswer=yes").forward(request, response);
			}else{
				request.getRequestDispatcher("User/ResubmitDYTest.jsp?StartAnswer=no").forward(request, response);
			}
		}
		
		//=================================7单元测试查询（对外）=================================
				else if(type.equals("7")){
					System.out.println(timelog+"单元测试菜单查询（对外）————————");
					
					//查询条件：部门
					String selBumen = request.getParameter("selBumen");
					String selBumenSQL;
					if(selBumen== null || selBumen.length()==0 || selBumen.equals("全部")) {
						selBumenSQL=" AND 1=1 ";
						//发送查询条件默认值
						request.setAttribute("selBumen", "");
					}else {
						selBumenSQL=" AND D_BUMEN='"+selBumen+"' ";
						//发送查询条件默认值
						request.setAttribute("selBumen", selBumen);
					}
					System.out.println(timelog+"查询条件：部门:"+selBumenSQL);
					
					
					//查询条件：单元测试名称(模糊查询)
					String selVersion = request.getParameter("selVersion");
					String selVersionSQL;
					if(selVersion== null || selVersion.length()==0 || selVersion.equals("全部")) {
						selVersionSQL=" AND 1=1 ";
						request.setAttribute("selVersion", "");
					}else {
						selVersionSQL=" AND D_VERSION like '%"+selVersion+"%' ";
						request.setAttribute("selVersion", selVersion);
					}
					System.out.println(timelog+"查询条件：单元测试名称(模糊查询):"+selVersionSQL);
					
					//查询条件：月份
					String selMonth = request.getParameter("selMonth");
					String selMonthSQL;
					Calendar cal = Calendar.getInstance();
			        int year = cal.get(Calendar.YEAR);
					if(selMonth== null || selMonth.length()==0 || selMonth.equals("全部")) {
						selMonthSQL=" AND 1=1 ";
						request.setAttribute("selMonth", "");
					}else {
						selMonthSQL=" AND D_DATE like '"+year+"-"+selMonth+"-%' ";
						request.setAttribute("selMonth", selMonth);
					}
					System.out.println(timelog+"查询条件：月份:"+selMonthSQL);
					
					//查询条件：状态
					String selState = request.getParameter("selState");
					String selStateSQL;
					if(selState== null || selState.length()==0 || selState.equals("全部")) {
						selStateSQL=" AND 1=1 ";
						request.setAttribute("selState", "");
					}else {
						selStateSQL=" AND D_STATE = '"+selState+"' ";
						request.setAttribute("selState", selState);
					}
					System.out.println(timelog+"查询条件：状态:"+selStateSQL);
					
					//排序条件
					String OrderSQL=" order by D_DATE desc";
					
					//只查询前100
					String rownumSQL=" and rownum<=100";
					
					String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL,D_WIKI from SYS_TEST_SQ where D_TYPE='单元测试'"
							+selBumenSQL+selVersionSQL+selMonthSQL+selStateSQL+rownumSQL+OrderSQL;
							System.out.println(timelog+"总查询SQL:"+sql);
					
					String nowPage = request.getParameter("currentPage");		
					PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
					request.setAttribute("pageBean", pageBean);
					
					//部门查询条件
					String sql2 = "select B_NAME from SYS_BUMEN where B_NAME != '产品测试部'";
					PageBean pageBean2 = dbutil.queryByPage2(nowPage, sql2);
					request.setAttribute("pageBean2", pageBean2);
					System.out.println(timelog+"部门查询:"+sql2);
					
					
					//查询通过率
					String sql3 = "select \r\n" + 
							"distinct (select count(1) from sys_test_sq where D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NGALL,\r\n" + 
							"(select count(1) from sys_test_sq where d_ng=0 and D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NG1,\r\n" + 
							"(select count(1) from sys_test_sq where d_ng=1 and D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NG2,\r\n" + 
							"(select count(1) from sys_test_sq where d_ng>=2 and D_TYPE='单元测试' and d_state='3' "+selBumenSQL+selVersionSQL+selMonthSQL+") as NG3\r\n" + 
							"from sys_test_sq";
					PageBean pageBean3 = dbutil.queryByPage2(nowPage, sql3);
					request.setAttribute("pageBean3", pageBean3);
					System.out.println(timelog+"查询通过率:"+sql3);
					
					request.getRequestDispatcher("User/selectDanYuanForOut.jsp").forward(request, response);
				
				}
		//=================================2结束=================================	
		else {
			String info ="系统出现异常，请联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);		
		}
	}

}
