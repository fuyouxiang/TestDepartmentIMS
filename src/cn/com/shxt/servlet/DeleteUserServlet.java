package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = -1313170890068030737L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		String U_ID = request.getParameter("id");
		String NAME = request.getParameter("name");
		String P_NAME=new String(NAME.getBytes("ISO8859-1"),"UTF-8");
		
		System.out.println(time+"正在删除用户资料...用户ID为："+U_ID);
		String sql = "delete from sys_user where U_ID =" + U_ID;
		System.out.println(time+sql);
		
		System.out.println(time+"正在删除用户人员资源数据...用户NAME为："+P_NAME);
		String sql2 = "delete from sys_person where P_NAME=" + "'"+P_NAME+"'";
		System.out.println(time+sql2);
		
		System.out.println(time+"正在删除用户工作资源数据...用户NAME为："+P_NAME);
		String sql3 = "delete from sys_test where T_NAME=" + "'"+P_NAME+"'";
		System.out.println(time+sql3);
		
		DBUtils dbutil = new DBUtils();
		int flag = dbutil.update(sql);
		int flag2 = dbutil.update(sql2);
		int flag3 = dbutil.update(sql3);
		String info ;
		if(flag > 0 && flag2 > 0 && flag3 > 0){
			info ="恭喜你!!成功删除用户";
			request.setAttribute("info", info);
		}else{
			info ="不好意思,删除用户失败";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	 }
		
}



