package cn.com.shxt.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

/**
 * Servlet implementation class UpdateWeiFuWuServlet
 */
public class UpdateWeiFuWuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateWeiFuWuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();
		request.setCharacterEncoding("UTF-8");
		DBUtils dbutil =new DBUtils();
		
		String type = request.getParameter("type");//申请类型：1是第一次新增；2是修改后重新提交
		System.out.println("调用参数："+type);
		
		System.out.println(timelog+"===============微服务管理=============");
		
		if(type.equals("select")) {
			System.out.println(timelog+"微服务名称查询————————");
			
			String sql = "select W_NAME,B_NAME from sys_weiname order by B_NAME";
			System.out.println(timelog+"微服务查询SQL:"+sql);
			
			String sql2 = "select B_NAME from SYS_BUMEN";
			System.out.println(timelog+"部门查询SQL:"+sql);
			
			String nowPage = request.getParameter("currentPage");
			
			PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
			request.setAttribute("pageBean", pageBean);
			
			PageBean pageBean2 = dbutil.queryByPage2(nowPage, sql2);
			request.setAttribute("pageBean2", pageBean2);

			request.getRequestDispatcher("guanliyuan/WeiFuWu.jsp").forward(request, response);
		}
		
		else if (type.equals("add")){
			
			System.out.println(timelog+"微服务添加————————");
			
			String W_NAME = request.getParameter("W_NAME");//微服务名称
			System.out.println(timelog+"微服务名称:"+W_NAME);
			String B_NAME = request.getParameter("B_NAME");//部门名称
			System.out.println(timelog+"部门名称:"+B_NAME);
			
			String sql = "insert into sys_weiname (W_NAME,B_NAME) values "+"('" + W_NAME + "','" + B_NAME + "')";
			System.out.println(timelog+"新增SQL:"+sql);
			
			int flag = dbutil.update(sql);
			System.out.println(timelog+"新增SQL结果:"+flag);
			
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='UpdateWeiFuWuServlet?type=select';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='UpdateWeiFuWuServlet?type=select';</script>");
		    }
			
		}
		
		else if (type.equals("delete")){
			
			System.out.println(timelog+"微服务删除————————");
			
			String W_NAME = new String((request.getParameter("W_NAME")).getBytes("ISO8859-1"),"UTF-8");//微服务名称
			System.out.println(timelog+"微服务名称:"+W_NAME);
			String B_NAME = new String((request.getParameter("B_NAME")).getBytes("ISO8859-1"),"UTF-8");//部门名称
			System.out.println(timelog+"部门名称:"+B_NAME);
			
			String sql = "delete from sys_weiname where W_NAME='"+W_NAME+"' and B_NAME='"+B_NAME+"'";
			System.out.println(timelog+"删除SQL:"+sql);
			
			int flag = dbutil.update(sql);
			System.out.println(timelog+"删除SQL结果:"+flag);
			
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='UpdateWeiFuWuServlet?type=select';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='UpdateWeiFuWuServlet?type=select';</script>");
		    }

		}
		else if (type.equals("update")){
			String oldW_NAME = new String((request.getParameter("oldW_NAME")).getBytes("ISO8859-1"),"UTF-8");//微服务名称
			System.out.println(timelog+"旧微服务名称:"+oldW_NAME);
			String oldB_NAME = new String((request.getParameter("oldB_NAME")).getBytes("ISO8859-1"),"UTF-8");//部门名称
			System.out.println(timelog+"旧部门名称:"+oldB_NAME);
			
			String W_NAME = request.getParameter("W_NAME");//微服务名称
			System.out.println(timelog+"微服务名称:"+W_NAME);
			String B_NAME = request.getParameter("B_NAME");//部门名称
			System.out.println(timelog+"部门名称:"+B_NAME);
			
			String sql = "update sys_weiname set W_NAME='"+W_NAME+"',B_NAME='"+B_NAME+"' where W_NAME='"+oldW_NAME+"' and B_NAME='"+oldB_NAME+"'" ;
			System.out.println(timelog+"修改SQL:"+sql);
			
			int flag = dbutil.update(sql);
			System.out.println(timelog+"修改SQL结果:"+flag);
			
			response.setContentType("text/html; charset=UTF-8");
		    if(flag>0){
		    response.getWriter().println("<script>alert('操作成功！');window.location.href='UpdateWeiFuWuServlet?type=select';</script>");
		    }else{
		    response.getWriter().println("<script>alert('操作异常，请联系管理员！');window.location.href='UpdateWeiFuWuServlet?type=select';</script>");
		    }
			
		}
		else {
			
		}
	}

}
