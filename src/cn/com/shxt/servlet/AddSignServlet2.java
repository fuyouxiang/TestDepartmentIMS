package cn.com.shxt.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.com.shxt.utils.DBUtils;

public class AddSignServlet2 extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		System.out.println(time+"签到第二步：添加签到记录servlet--------------------------");
		request.setCharacterEncoding("UTF-8");

		String s_host = request.getParameter("s_host");//主持人
		String s_date = request.getParameter("s_date");//签到日期
		//String[] s_id = request.getParameterValues("s_id");//用户序号，无意义
		String[] s_name = request.getParameterValues("s_name");//用户姓名
		String[] s_sign = request.getParameterValues("s_sign");//签到状态
		String[] s_remark = request.getParameterValues("s_remark");//备注
		
		for (int n = 0; n < s_name.length; n++) {
			
			//String id=s_id[n];
			String name=s_name[n];
			String sign=s_sign[n];
			String remark=s_remark[n];
			
			//System.out.println(id);//测试输出ID
			System.out.println(time+"签到人员"+name);//测试输出name
			System.out.println(time+"签到状态"+sign);
			System.out.println(time+"备注"+remark);
			DBUtils dbutil =new DBUtils();
			String sql = "insert into sys_sign (s_name,s_date,s_sign,s_remark,s_host) values " +
			"('" + name + "',to_date('" + s_date + "','yyyy-mm-dd'),'" + sign + "','" + remark + "','" + s_host + "')";
	
			int flag = dbutil.update(sql);
			System.out.println(time+"添加签到记录sql："+sql);//查看sql
			String info ;
			
			if(flag > 0){
				info ="今日签到表已添加完成！";
				request.setAttribute("info", info);
			}else{
				info ="签到表保存失败！";
				request.setAttribute("info", info);
			}
		} 		
		request.getRequestDispatcher("Sys.jsp").forward(request, response);		
}
		

	
	public void init() throws ServletException {
		// Put your code here
	}

}
