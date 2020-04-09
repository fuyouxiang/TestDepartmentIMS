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

public class updateBBStateServlet extends HttpServlet {

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
		
		if(type.equals("1")) {
			
			System.out.println(time+"查询要修改的版本测试————————");
			String D_ID = request.getParameter("D_ID");
			System.out.println("申请单ID："+D_ID);
			DBUtils dbutil =new DBUtils();
			String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_WEINAME,D_VERSION,D_STATE,D_SUBURL,D_WIKI,D_ISSQL,D_ISJXXC,D_ISYCHJ,D_ISJXPRE,D_ISYTH2020 from SYS_TEST_SQ where  D_ID='"+ D_ID +"' ";		
			System.out.println(time+"查询申请单ID："+sql);	
			
			String nowPage = request.getParameter("currentPage");
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);

			request.getRequestDispatcher("User/BanBenState.jsp").forward(request, response);	
			
			
		}else if(type.equals("2")) {
			System.out.println(time+"修改版本测试————————");
			String D_ID = request.getParameter("D_ID");
			System.out.println("申请单ID："+D_ID);
			String D_ISSQL = request.getParameter("D_ISSQL");
			System.out.println("是否带脚本：："+D_ISSQL);
			String D_ISJXXC = request.getParameter("D_ISJXXC");
			System.out.println("是否发江西：："+D_ISJXXC);
			String D_ISYCHJ = request.getParameter("D_ISYCHJ");
			System.out.println("是否更新压测环境："+D_ISYCHJ);
			String D_ISJXPRE = request.getParameter("D_ISJXPRE");
			System.out.println("是否更新jxpre环境：："+D_ISJXPRE);
			String D_ISYTH2020 = request.getParameter("D_ISYTH2020");
			System.out.println("是否更新yth2020环境：："+D_ISYTH2020);

			DBUtils dbutil =new DBUtils();
			String sql = "update SYS_TEST_SQ SET D_ISSQL='"+ D_ISSQL +"',D_ISJXXC='"+ D_ISJXXC +"',D_ISYCHJ='"+ D_ISYCHJ +"',D_ISJXPRE='"+ D_ISJXPRE +"',D_ISYTH2020='"+ D_ISYTH2020 +"' where D_ID='"+ D_ID +"' ";		
			System.out.println(time+"修改版本测试状态："+sql);	
			
			int flag = dbutil.update(sql);
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='selectBanBenServlet?type=1';</script>");
		    }   
			
			
		}else {
			String info ="系统出现异常，请联系管理员！";
			request.setAttribute("info", info);
			request.getRequestDispatcher("Sys.jsp").forward(request, response);		
		}
		

		
	}

}
