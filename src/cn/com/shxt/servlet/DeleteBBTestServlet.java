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

public class DeleteBBTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();
		
		System.out.println(timelog+"进行删除操作————————");
		request.setCharacterEncoding("UTF-8");


		String D_ID = request.getParameter("D_ID");
		System.out.println("版本ID："+D_ID);

		DBUtils dbutil =new DBUtils();
		
		//获取用户名称和角色
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
		System.out.println("从session中获取用户名："+username);
		String userrole =null;
		userrole = (String)session.getAttribute("userrole");
		System.out.println("从session中获取用户角色："+userrole);
		String UserCenter = (String)session.getAttribute("UserCenter");
		System.out.println("从session中获取用户所属中心："+UserCenter);
		
		//状态修改人与原测试负责人做对比判断
		if(userrole==null) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('抱歉，session已失效！请重新登录');window.location.href='login.jsp';</script>");
		}else if(!userrole.equals("管理员")) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().println("<script>alert('抱歉，您不是系统管理员角色！不允许进行该操作。');window.location.href='selectBanBenServlet?type=1';</script>");
			
		}
		else {
			
			try {
			//发送邮件
			String emailSql="select * from SYS_TEST_SQ where D_ID='" + D_ID + "'";
			String weiServer = dbutil.queryString(emailSql,"D_WEINAME");
			String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
			String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
			String D_TUSER = dbutil.queryString(emailSql,"D_TUSER");
			String D_TYPE = dbutil.queryString(emailSql,"D_TYPE");
			
			String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
			String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
			String EmailAddress =";"+TestBossEmail;
			System.out.println(timelog+"邮件地址："+EmailAddress);
			
			String Msgtitle = "";
			if(D_TYPE.equals("版本测试")) {
				Msgtitle = username+"对"+weiServer+"微服务"+banbenNo+"版本"+"进行了删除操作，请知晓！";	
			}else {
				Msgtitle = username+"对"+banbenNo+"单元测试"+"进行了删除操作，请知晓！";	
			}
			System.out.println(timelog+"邮件标题："+Msgtitle);
			String Msg = "【微服务名】："+weiServer+"<br>"+"【版本号】："+banbenNo+"<br>"+"【申请人】："+D_KAIFA+"<br>"+"【测试人】："+D_TUSER;
			System.out.println(timelog+"邮件内容："+Msg);
			
			//删除版本测试主表
			String sql = "delete SYS_TEST_SQ where D_ID='"+ D_ID +"'";
			//删除版本测试日志表
			String sql2 = "delete sys_testsq_log where D_ID='"+ D_ID +"'";	
			int flag = dbutil.update(sql);
			int flag2 = dbutil.update(sql2);
			System.out.println(timelog+"删除版本测试主表："+sql);	
			System.out.println(timelog+"删除版本测试日志表"+sql2);
			
			//response.sendRedirect("selectBanBenServlet");
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0&&flag2>0){
			SendEmail sendEmail = new SendEmail();
			sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }   
		    

			
			} catch (SQLException e1) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().println("<script>alert('邮件发送异常，请联系管理员！');window.location.href='selectBanBenServlet?type=1';</script>");
			}
			

			
		}

	}

}
