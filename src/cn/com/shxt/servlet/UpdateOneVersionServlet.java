package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import cn.com.shxt.model.Sys_Version;
import cn.com.shxt.utils.DBUtils;



public class UpdateOneVersionServlet extends HttpServlet {

	
	
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		request.setCharacterEncoding("UTF-8");	
		String V_ID = request.getParameter("V_ID");
		String V_MONTH = request.getParameter("V_MONTH");
		String V_DATE = request.getParameter("V_DATE");
		String V_WEEK = request.getParameter("V_WEEK");
		String V_NAME = request.getParameter("V_NAME");
		String V_BASICS = request.getParameter("V_BASICS");
		String V_WORK = request.getParameter("V_WORK");
		String V_TIME = request.getParameter("V_TIME");
		String V_TYPE = request.getParameter("V_TYPE");
		String V_BUG = request.getParameter("V_BUG");
		String V_DOCUMENT = request.getParameter("V_DOCUMENT");
		String V_CASE = request.getParameter("V_CASE");

		
		//获取原本的BUG、用例、文档数量
		DBUtils db = new DBUtils();
		String sql;
		Sys_Version version = new Sys_Version();
		sql = "select * from sys_version where v_id = "+ V_ID +" ";
		Map<String,Object> map =db.query1(sql).get(0);
		version.setV_bug(map.get("V_BUG").toString());
		version.setV_case(map.get("V_CASE").toString());
		version.setV_document(map.get("V_DOCUMENT").toString());
		String old_bug=version.getV_bug();
		String old_case=version.getV_case();
		String old_document=version.getV_document();
		
		//测试新的和原来的对比
		System.out.println(time+"测试中文编码"+V_NAME);
		System.out.println(time+"老的BUG数量："+old_bug);
		System.out.println(time+"新的BUG数量："+V_BUG);
		System.out.println(time+"老的用例数量："+old_case);
		System.out.println(time+"新的用例数量："+V_CASE);
		System.out.println(time+"老的文档数量："+old_document);
		System.out.println(time+"新的文档数量："+V_DOCUMENT);
		

		//String NAME=new String(name.getBytes("ISO8859-1"),"UTF-8");

		 Calendar date = Calendar.getInstance();
	     String SetYear = String.valueOf(date.get(Calendar.YEAR));
		
		/*
		System.out.println(time+"先干掉之前的三种统计数量......");
		String sql2 = "update sys_test set t_case=t_case-"+"'" + old_case + "'"+",t_document=t_document-"+"'" + old_document + "'"+",t_bug=t_bug-"+"'" + old_bug + "'"+" where t_name="+"'" + V_NAME + "' and t_year='" + SetYear + "'";	
		int flag2 = db.update(sql2);
		
		System.out.println(time+"在测试情况表增加新的三种统计数量......");
		String sql3 = "update sys_test set t_case=t_case+"+"'" + V_CASE + "'"+",t_document=t_document+"+"'" + V_DOCUMENT + "'"+",t_bug=t_bug+"+"'" + V_BUG + "'"+" where t_name="+"'" + V_NAME + "' and t_year='" + SetYear + "'";	
		int flag3 = db.update(sql3);
		*/
		System.out.println(time+"更新工作情况表......");
		String sql4 = "update sys_version set v_type="+"'" + V_TYPE + "'"+",V_BUG="+"'" + V_BUG + "'"+",V_CASE="+"'" + V_CASE + "'"+",V_TIME="+"'" + V_TIME + "'"+",V_MONTH="+"'" + V_MONTH + "'"+",V_DATE="+"'" + V_DATE + "'"+",V_WEEK="+"'" + V_WEEK + "'"+",V_BASICS="+"'" + V_BASICS + "'"+",V_WORK="+"'" + V_WORK + "'"+",V_DOCUMENT="+"'" + V_DOCUMENT + "'"+" where V_ID="+"'" + V_ID + "'";	
		//String sql = "select V_ID,V_MONTH,substr(V_DATE,9,2),V_WEEK,V_NAME,V_BASICS,V_WORK,V_TIME,V_TYPE,V_BUG,V_DOCUMENT,V_CASE from SYS_VERSION order by V_ID desc";
		System.out.println(sql4);
		int flag4 = db.update(sql4);
		
		
		
		//
		//int flag2 = dbutil.update(sql2);
		
		String info ;
		if(flag4 > 0){
			info ="修改成功!";
			request.setAttribute("info", info);
		}else{
			info ="修改失败，请联系管理员！";
			request.setAttribute("info", info);
		}
		request.getRequestDispatcher("Sys.jsp").forward(request, response);
	}

	

}
