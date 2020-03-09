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
		
		
		//单位测试新增方法
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
		
		String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ((select d_id from SYS_TEST_SQ  where D_DATE='" + date + "'),'" + kaifa + "','" + date + "','提交申请', '','提交申请', '"+"【内容】:"+content+"【标准】:"+biaozhun+"')')";
		int flag2 = dbutil.update(sql2);
		System.out.println(time+"添加日志："+sql2);
		
		
		try {
			String TestBossSql="select * from  SYS_BUMEN where B_NAME='产品测试部'";
			String TestBossEmail = dbutil.queryString(TestBossSql,"EMAIL");
			String EmailAddress =";"+TestBossEmail+";"+BossEmail+";"+k_email;
			String Msgtitle = kaifa+"申请单元测试！";
			String Msg = "【测试内容】："+content+"；"+"【测试标准】："+biaozhun+"；"+"【提交日期】："+date+"；";
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
		
		//单元测试查询
		else if(type.equals("2")){
			System.out.println(time+"单元测试菜单查询————————");
			String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_VERSION,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_STATE,D_SUBURL from SYS_TEST_SQ where D_TYPE='单元测试' order by D_DATE desc";
			
			String nowPage = request.getParameter("currentPage");
			DBUtils dbutil = new DBUtils();
			
			PageBean pageBean = dbutil.queryByPage(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			
			request.getRequestDispatcher("User/selectDanYuan.jsp").forward(request, response);
		
		}
		else {
			String info ="系统出现异常，请联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);		
		}
	}

}
