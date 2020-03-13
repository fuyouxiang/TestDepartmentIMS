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

public class StartBBTestServlet extends HttpServlet {

	private static final long serialVersionUID = 8515925025996005949L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"测试人员已接单，开始测试————————");
		request.setCharacterEncoding("UTF-8");
		String D_TUSER = request.getParameter("D_TUSER");
		System.out.println("测试人："+D_TUSER);
		String TIME = request.getParameter("TIME");
		System.out.println("开始时间："+TIME);
		String D_ID = request.getParameter("D_ID");
		System.out.println("版本ID："+D_ID);

		DBUtils dbutil =new DBUtils();
		
		String sql = "update SYS_TEST_SQ set D_TUSER ='"+ D_TUSER +"',D_STATE='1' where D_ID='"+ D_ID +"'";		
		int flag = dbutil.update(sql);
		System.out.println(time+"修改该测试任务的测试人："+sql);	
		
		String sql2 = "insert into SYS_TESTSQ_LOG (D_ID,T_PEOPLE,T_TIME,T_CAOZUO,T_BEIZHU) values ('" + D_ID + "','" + D_TUSER + "','" + TIME + "','开始测试', '无')";
		int flag2 = dbutil.update(sql2);
		System.out.println(time+"添加日志："+sql2);
		
		String sql3 = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_WEINAME,D_VERSION,D_STATE,D_SUBURL,D_WIKI from SYS_TEST_SQ where D_TYPE='版本测试' order by D_DATE desc";
		String nowPage = request.getParameter("currentPage");
		PageBean pageBean = dbutil.queryByPage(nowPage, sql3);

		if(flag > 0){
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("User/selectBanBen.jsp?StartAnswer=yes").forward(request, response);
		}else{
			request.setAttribute("pageBean", pageBean);
			request.getRequestDispatcher("User/selectBanBen.jsp?StartAnswer=no").forward(request, response);
		}

		
	}

}
