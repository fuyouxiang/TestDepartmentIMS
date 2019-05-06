package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.utils.DBUtils;

public class DeleteVersionServlet extends HttpServlet {
	private static final long serialVersionUID = -1313170890068030737L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		String V_ID = request.getParameter("id");
		String name = request.getParameter("name");
		String NAME=new String(name.getBytes("ISO8859-1"),"UTF-8");
		String document = request.getParameter("document");
		String bug = request.getParameter("bug");
		String case1 = request.getParameter("case1");
		System.out.println(time+"日报ID"+V_ID);
		String sql = "delete from SYS_VERSION where V_ID =" + V_ID;
		
		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
	     
		//人员资源统计表记录数减1
		System.out.println(time+"正在修改测试情况统计表信息...NAME为："+NAME);
		String sql2 = "update sys_test set t_case=t_case-"+"'" + case1 + "'"+",t_document=t_document-"+"'" + document + "'"+",t_bug=t_bug-"+"'" + bug + "'"+" where t_name="+"'" + NAME + "' and t_year='" + SetYear + "'";	
		System.out.println(sql2);
		System.out.println(time+"修改完成！");
		
		DBUtils dbutil = new DBUtils();
		int flag = dbutil.update(sql);
		int flag2 = dbutil.update(sql2);

		String info ;
		if(flag > 0 && flag2 > 0){
			info ="工作日报删除成功！测试情况统计表修改成功！";
			request.setAttribute("info", info);
		}else if(flag > 0 && flag2 == 0){
			info ="工作日报删除成功！测试情况统计表修改成功！";
			request.setAttribute("info", info);
		}else if(flag == 0 && flag2 > 0){
			info ="工作日报删除失败！测试情况统计表修改成功！";
			request.setAttribute("info", info);
		}else{
			info ="工作日报删除失败！测试情况统计表修改失败！";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	 }
		
}



