package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
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
		String type = request.getParameter("type");//申请类型：1是第一次新增；2是修改后重新提交
		System.out.println("申请类型："+type);
		
		
		if(type.equals("1")) {
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
			String wiki = request.getParameter("wiki");
			System.out.println("wiki地址："+wiki);
			String D_TYPE = "版本测试";
			System.out.println("测试类型："+D_TYPE);

			DBUtils dbutil =new DBUtils();
			String sql = "insert into SYS_TEST_SQ (D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_TYPE,D_WEINAME,D_VERSION,D_WIKI) values " +
					"('" + Bumen + "','" + Boss + "','" + BossEmail + "','" + kaifa + "','" + date + "','" + content + "','" + biaozhun + "','" + k_email + "','" + D_TYPE + "','" + weiServer + "','" + banbenNo + "','" + wiki + "')";		
			
			int flag = dbutil.update(sql);
			System.out.println(time+"添加版本测试申请："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ((select d_id from SYS_TEST_SQ  where D_DATE='" + date + "'),'" + kaifa + "','" + date + "','提交申请', '"+"【内容】:"+content+"【标准】:"+biaozhun+"【wiki地址】:"+wiki+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"添加日志："+sql2);	

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
			
			
			DBUtils dbutil =new DBUtils();
			
			String sql = "update SYS_TEST_SQ set D_CONTENT ='"+ content +"',D_BIAOZHUN ='"+ biaozhun +"',D_STATE='0',D_WIKI ='"+ wiki +"' where D_ID='"+ d_id +"'";		
			int flag = dbutil.update(sql);
			System.out.println(time+"修改完成后重新提交申请单："+sql);	
			
			String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + d_id + "','" + kaifa + "','" + date + "','重新提交', '"+"【内容】:"+content+"【标准】:"+biaozhun+"【wiki地址】:"+wiki+"')";
			int flag2 = dbutil.update(sql2);
			System.out.println(time+"添加日志："+sql2);
			
			
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
