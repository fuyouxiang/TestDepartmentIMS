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
	}

}
