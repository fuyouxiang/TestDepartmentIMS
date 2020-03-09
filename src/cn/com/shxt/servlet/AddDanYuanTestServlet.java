package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.SendEmail;

public class AddDanYuanTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		request.setCharacterEncoding("UTF-8");
		String type = request.getParameter("type");//调用方法类型
		System.out.println("调用方法类型："+type);
		
		
//=================================1单位测试新增方法=================================
		if(type.equals("1")) {
		System.out.println(time+"单元测试提交单申请————————");
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
		String dyName = request.getParameter("dyName");
		System.out.println("单元测试名称："+dyName);
		String content = request.getParameter("content");
		System.out.println("内容："+content);
		String biaozhun = request.getParameter("biaozhun");
		System.out.println("标准："+biaozhun);
		String D_TYPE = "单元测试";
		System.out.println("测试类型："+D_TYPE);

		DBUtils dbutil =new DBUtils();
		String sql = "insert into SYS_TEST_SQ (D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_TYPE,D_VERSION) values " +
				"('" + Bumen + "','" + Boss + "','" + BossEmail + "','" + kaifa + "','" + date + "','" + content + "','" + biaozhun + "','" + k_email + "','" + D_TYPE + "','" + dyName + "')";		
		
		int flag = dbutil.update(sql);
		System.out.println(time+"添加单元测试申请："+sql);	
		
		String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ((select d_id from SYS_TEST_SQ  where D_DATE='" + date + "'),'" + kaifa + "','" + date + "','提交申请', '"+"【内容】:"+content+"【标准】:"+biaozhun+"')";
		int flag2 = dbutil.update(sql2);
		System.out.println(time+"添加日志："+sql2);
		
		
		try {
			String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
			String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
			String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
			String Msgtitle = kaifa+"申请单元测试！";
			String Msg = "【单元名称】："+dyName+"；"+"【测试内容】："+content+"；"+"【测试标准】："+biaozhun+"；"+"【提交日期】："+date+"；";
			//SendEmail sendEmail = new SendEmail();
			//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
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
			System.out.println(time+"单元测试菜单查询————————");
			String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL from SYS_TEST_SQ where D_TYPE='单元测试' order by D_DATE desc";
			
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			
			PageBean pageBean = dbutil.queryByPage(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			
			request.getRequestDispatcher("User/selectDanYuan.jsp").forward(request, response);
		
		}
//=================================2结束=================================		

//=================================3单元测试开始=================================
		else if(type.equals("3")) {
			System.out.println(time+"测试人员已接单，开始测试————————");
			String D_TUSER = request.getParameter("D_TUSER");
			System.out.println("测试人："+D_TUSER);
			String TIME = request.getParameter("TIME");
			System.out.println("开始时间："+TIME);
			String D_ID = request.getParameter("D_ID");
			System.out.println("单元ID："+D_ID);

			DBUtils dbutil =new DBUtils();
			
			String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='1' where D_ID='"+ D_ID +"'";		
			int flag = dbutil.update(sql);
			System.out.println(time+"修改该测试任务的测试人："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','开始测试', '无')";
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"添加日志："+sql2);
			
			String sql3 = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL from SYS_TEST_SQ where D_TYPE='单元测试' order by D_DATE desc";
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage(nowPage, sql3);

			if(flag > 0){
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/selectDanYuan.jsp?StartAnswer=yes").forward(request, response);
			}else{
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/selectDanYuan.jsp?StartAnswer=no").forward(request, response);
			}
		}
//=================================3结束=================================	
		
		
		
//=================================4单元测试驳回=================================
		else if(type.equals("4")) {
			System.out.println(time+"测试人员驳回该单元测试————————");
			String D_TUSER = request.getParameter("D_TUSER");
			System.out.println("测试人："+D_TUSER);
			String TIME = request.getParameter("TIME");
			System.out.println("驳回时间："+TIME);
			String D_ID = request.getParameter("D_ID");
			System.out.println("单元ID："+D_ID);
			String REASON = request.getParameter("REASON");
			System.out.println("驳回原因："+REASON);		
			String serviceRoot= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";   
			String D_SUBURL =serviceRoot+"ResubmitDYTestServlet?D_ID="+D_ID;
			System.out.println("重新提交路径："+D_SUBURL);

			DBUtils dbutil =new DBUtils();
			
			//修改单元测试主表
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
				String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
				String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				System.out.println(time+"邮件地址："+EmailAddress);
				String Msgtitle = D_KAIFA+"申请的单元测试未通过！";
				System.out.println(time+"邮件标题："+Msgtitle);
				String Msg = "【单元测试名称】："+banbenNo+"；"+"【驳回人】："+D_TUSER+"；"+"【驳回时间】："+TIME+"；"+"【驳回原因】："+REASON+"；"+"【重新提交地址】："+D_SUBURL+"；";
				System.out.println(time+"邮件内容："+Msg);
				//SendEmail sendEmail = new SendEmail();
				//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("TestFormSubmit_danyuan.jsp?answer=no").forward(request, response);
			}
			
			String sql3 = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL from SYS_TEST_SQ where D_TYPE='单元测试' order by D_DATE desc";
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage(nowPage, sql3);
			
			if(flag > 0){
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/selectDanYuan.jsp?ReturnAnswer=yes").forward(request, response);
			}else{
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/selectDanYuan.jsp?ReturnAnswer=no").forward(request, response);
			}
		}
//=================================4结束=================================

		
//=================================5单元测试通过=================================
		else if(type.equals("5")) {
			System.out.println(time+"单元测试通过————————");
			request.setCharacterEncoding("UTF-8");
			String D_TUSER = request.getParameter("D_TUSER");
			System.out.println("测试人："+D_TUSER);
			String TIME = request.getParameter("TIME");
			System.out.println("通过时间："+TIME);
			String D_ID = request.getParameter("D_ID");
			System.out.println("单元ID："+D_ID);
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
				String banbenNo = dbutil.queryString(emailSql,"D_VERSION");
				String D_KAIFA = dbutil.queryString(emailSql,"D_KAIFA");
				
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				System.out.println(time+"邮件地址："+EmailAddress);
				String Msgtitle = D_KAIFA+"申请的"+banbenNo+"单元测试结束，测试通过！";
				System.out.println(time+"邮件标题："+Msgtitle);
				String Msg = "【单元测试名称】："+banbenNo+"；"+"【申请人】："+D_KAIFA+"；"+"【测试人】："+D_TUSER+"；"+"【通过时间】："+TIME+"；"+"【备注/遗留】："+REASON+"；";
				System.out.println(time+"邮件内容："+Msg);
				//SendEmail sendEmail = new SendEmail();
				//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("TestFormSubmit_banben.jsp?answer=no").forward(request, response);
			}
			
			String sql4 = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL from SYS_TEST_SQ where D_TYPE='单元测试' order by D_DATE desc";
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage(nowPage, sql4);
			
			if(flag > 0){
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/selectDanYuan.jsp?EndAnswer=yes").forward(request, response);
			}else{
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/selectDanYuan.jsp?EndAnswer=no").forward(request, response);
			}
		}		
//=================================5结束=================================	

//=================================6重新提交测试单=================================
		else if(type.equals("6")) {
			System.out.println(time+"重新提交测试单————————");
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
			String banbenNo = request.getParameter("banbenNo");
			System.out.println("单元测试名称："+banbenNo);
			String k_email = request.getParameter("k_email");
			System.out.println("开发邮箱："+k_email);
			String BossEmail = request.getParameter("BossEmail");
			System.out.println("开发总监邮箱："+BossEmail);
			String NGnumber = request.getParameter("NGnumber");
			System.out.println("NG次数："+NGnumber);
			
			DBUtils dbutil =new DBUtils();
			
			String sql = "update SYS_TEST_SQ set D_CONTENT ='"+ content +"',D_BIAOZHUN ='"+ biaozhun +"',D_STATE='0' where D_ID='"+ d_id +"'";		
			int flag = dbutil.update(sql);
			System.out.println(time+"修改完成后重新提交申请单："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + d_id + "','" + kaifa + "','" + date + "','重新提交', '"+"【内容】:"+content+"【标准】:"+biaozhun+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"添加日志："+sql2);
			
			
			String sql3 = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL from SYS_TEST_SQ where D_TYPE='单元测试' order by D_DATE desc";
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage(nowPage, sql3);
			
			
			try {
				String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
				String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
				String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
				String Msgtitle = kaifa+"第"+NGnumber+"轮单元测试申请！";
				String Msg = "【单元测试名称】："+banbenNo+"；"+"【测试内容】："+content+"；"+"【测试标准】："+biaozhun+"；"+"【提交日期】："+date+"；";
				//SendEmail sendEmail = new SendEmail();
				//sendEmail.SendEmailFromQQ(EmailAddress, Msgtitle, Msg);
			}catch(Exception e){
				request.getRequestDispatcher("User/ResubmitBBTest.jsp?StartAnswer=no").forward(request, response);
			}
			
			if(flag > 0){
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/ResubmitDYTest.jsp?StartAnswer=yes").forward(request, response);
			}else{
				request.setAttribute("pageBean", pageBean);
				request.getRequestDispatcher("User/ResubmitDYTest.jsp?StartAnswer=no").forward(request, response);
			}
		}
		else {
			String info ="系统出现异常，请联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);		
		}
	}

}
