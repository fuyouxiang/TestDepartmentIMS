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

public class ReturnBBTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"测试人员驳回该版本————————");
		request.setCharacterEncoding("UTF-8");
		String D_TUSER = request.getParameter("D_TUSER");
		System.out.println("测试人："+D_TUSER);
		String TIME = request.getParameter("TIME");
		System.out.println("驳回时间："+TIME);
		String D_ID = request.getParameter("D_ID");
		System.out.println("版本ID："+D_ID);
		String REASON = request.getParameter("REASON");
		System.out.println("驳回原因："+REASON);		
		String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";   
		String D_SUBURL =serviceRoot+"ResubmitBBTestServlet?D_ID="+D_ID;
		System.out.println("重新提交路径："+D_SUBURL);

		DBUtils dbutil =new DBUtils();
		
		//修改版本测试主表
		String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='2',D_SUBURL ='"+ D_SUBURL +"',D_NG=D_NG+1 where D_ID='"+ D_ID +"'";		
		int flag = dbutil.update(sql);
		System.out.println(time+"修改数据状态，填写重新提交地址："+sql);	

		//添加日志
		String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','驳回', '" + REASON + "')";
		int flag2 = dbutil.update(sql2);
		System.out.println(time+"添加日志："+sql2);	

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
			System.out.println(time+"邮件地址："+EmailAddress);
			String Msgtitle = D_KAIFA+"申请的版本测试未通过！";
			System.out.println(time+"邮件标题："+Msgtitle);
			String Msg = "【微服务名】："+weiServer+"；"+"【版本号】："+banbenNo+"；"+"【驳回人】："+D_TUSER+"；"+"【驳回时间】："+TIME+"；"+"【驳回原因】："+REASON+"；"+"【重新提交地址】："+D_SUBURL+"；";
			System.out.println(time+"邮件内容："+Msg);
			//SendEmail sendEmail = new SendEmail();
			//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
		}catch(Exception e){
			request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
		}
		
		response.sendRedirect("selectBanBenServlet");

	}

}
