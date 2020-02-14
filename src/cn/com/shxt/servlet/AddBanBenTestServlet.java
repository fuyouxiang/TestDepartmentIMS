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

import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.SendEmail;

public class AddBanBenTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"版本测试提交单申请————————");
		request.setCharacterEncoding("UTF-8");
		String BumenAndBoss = request.getParameter("bumen");
		String [] strs = BumenAndBoss.split("[;]");
		String Bumen = strs[0];
		String Boss = strs[1];
		String BossEmail = strs[2];
		System.out.println("部门："+Bumen);
		System.out.println("开发总监："+Boss);
		System.out.println("开发总监邮箱："+BossEmail);
		String kaifa = request.getParameter("kaifa");
		System.out.println("开发："+kaifa);
		String k_email = request.getParameter("k_email");
		System.out.println("开发邮箱："+k_email);
		String date = request.getParameter("date");
		System.out.println("日期："+date);
		String weiServer = request.getParameter("weiServer");
		System.out.println("微服务："+weiServer);
		String banbenNo = request.getParameter("banbenNo");
		System.out.println("版本号："+banbenNo);
		String content = request.getParameter("content");
		System.out.println("版本构造内容："+content);		
		String biaozhun = request.getParameter("biaozhun");
		System.out.println("标准："+biaozhun);
		String D_TYPE = "版本测试";
		System.out.println("测试类型："+D_TYPE);

		DBUtils dbutil =new DBUtils();
		String sql = "insert into SYS_TEST_SQ (D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_TYPE,D_WEINAME,D_VERSION) values " +
				"('" + Bumen + "','" + Boss + "','" + BossEmail + "','" + kaifa + "','" + date + "','" + content + "','" + biaozhun + "','" + k_email + "','" + D_TYPE + "','" + weiServer + "','" + banbenNo + "')";		
		
		int flag = dbutil.update(sql);

		System.out.println(time+"添加单元测试申请："+sql);	

		/*
		try {
			SendEmail sendEmail = new SendEmail();
			String EmailAddress =";zhanglhd@yonyou.com;yuanff@yonyou.com;xiaofen1@yonyou.com;"+BossEmail+";"+k_email;
			String Msgtitle = kaifa+"申请版本测试！";
			String Msg = "【微服务名】："+weiServer+"；"+"【版本号】："+banbenNo+"；"+"【版本构造内容】："+content+"；"+"【测试标准】："+biaozhun+"；"+"【提交日期】："+date+"；";
			sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
		}catch(Exception e){
			request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
		}*/
	
		if(flag > 0 ){
			request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=yes").forward(request, response);
		}else{
			request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
		}

		
	}

}