package cn.com.shxt.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.SendEmail;

public class EndBBTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"该版本测试通过————————");
		request.setCharacterEncoding("UTF-8");
		String D_TUSER = request.getParameter("D_TUSER");
		System.out.println("测试人："+D_TUSER);
		String TIME = request.getParameter("TIME");
		System.out.println("通过时间："+TIME);
		String D_ID = request.getParameter("D_ID");
		System.out.println("版本ID："+D_ID);
		String REASON = request.getParameter("REASON");
		System.out.println("备注："+REASON);		

		DBUtils dbutil =new DBUtils();
		
		//修改版本测试主表
		String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='3' where D_ID='"+ D_ID +"'";		
		int flag = dbutil.update(sql);
		System.out.println(time+"测试结束修改数据状态："+sql);	

		//添加日志
		String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','测试通过', '" + REASON + "')";
		String sql3 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','测试结束', '" + REASON + "')";
		int flag2 = dbutil.update(sql2);
		if(flag2>0) {
			dbutil.update(sql3);
		}
		System.out.println(time+"添加日志："+sql2);
		System.out.println(time+"添加日志："+sql3);	

		//发送邮件
		try {
			String emailSql="select * from SYS_TEST_SQ where D_ID='" + D_ID + "'";
			String BossEmail = dbutil.queryString(emailSql,"D_KBOSSEMAIL");
			String k_email = dbutil.queryString(emailSql,"D_KEMAIL");
			String weiServer = dbutil.queryString(emailSql,"D_WEINAME");
			String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
			String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
			String D_WIKI = dbutil.queryString(emailSql,"D_WIKI");
			
			String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
			String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
			
			String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
			System.out.println(time+"邮件地址："+EmailAddress);
			String Msgtitle = D_KAIFA+"申请的"+banbenNo+"版本测试结束，测试通过！";
			System.out.println(time+"邮件标题："+Msgtitle);
			String Msg = "【微服务名】："+weiServer+"；"+"【版本号】："+banbenNo+"；"+"【申请人】："+D_KAIFA+"；"+"【测试人】："+D_TUSER+"；"+"【通过时间】："+TIME+"；"+"【备注/遗留】："+REASON+"；"+"【附件名称】："+D_WIKI+"；";
			System.out.println(time+"邮件内容："+Msg);
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
