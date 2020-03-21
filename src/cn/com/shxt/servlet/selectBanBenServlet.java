package cn.com.shxt.servlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.model.PageBean;
import cn.com.shxt.utils.DBUtils;

public class selectBanBenServlet extends HttpServlet {
	

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		     this.doPost(request, response);
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		
		request.setCharacterEncoding("UTF-8");
		
		//查询条件：部门
		String selBumen = request.getParameter("selBumen");
		String selBumenSQL;
		//专门给部门-微服务 查询条件过滤用
		String selBumenSQL2;
		if(selBumen== null || selBumen.length()==0 || selBumen.equals("全部")) {
			selBumenSQL=" AND 1=1 ";
			selBumenSQL2=" AND 1=1 ";
			//发送查询条件默认值
			request.setAttribute("selBumen", "");
		}else {
			selBumenSQL=" AND D_BUMEN='"+selBumen+"' ";
			selBumenSQL2=" AND B_NAME='"+selBumen+"' ";
			//发送查询条件默认值
			request.setAttribute("selBumen", selBumen);
		}
		System.out.println(time+"查询条件：部门:"+selBumenSQL);
		
		//查询条件：微服务
		String selWeifw = request.getParameter("selWeifw");
		String selWeifwSQL;
		if(selWeifw== null || selWeifw.length()==0 || selWeifw.equals("全部")) {
			selWeifwSQL=" AND 1=1 ";
			//发送查询条件默认值
			request.setAttribute("selWeifw", "");
		}else {
			selWeifwSQL=" AND D_WEINAME='"+selWeifw+"' ";
			//发送查询条件默认值
			request.setAttribute("selWeifw", selWeifw);
		}
		System.out.println(time+"查询条件：微服务:"+selWeifwSQL);
		
		//查询条件：版本号(模糊查询)
		String selVersion = request.getParameter("selVersion");
		String selVersionSQL;
		if(selVersion== null || selVersion.length()==0 || selVersion.equals("全部")) {
			selVersionSQL=" AND 1=1 ";
			request.setAttribute("selVersion", "");
		}else {
			selVersionSQL=" AND D_VERSION like '%"+selVersion+"%' ";
			request.setAttribute("selVersion", selVersion);
		}
		System.out.println(time+"查询条件：版本号(模糊查询):"+selVersionSQL);
		
		//查询条件：月份
		String selMonth = request.getParameter("selMonth");
		String selMonthSQL;
		Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
		if(selMonth== null || selMonth.length()==0 || selMonth.equals("全部")) {
			selMonthSQL=" AND 1=1 ";
			request.setAttribute("selMonth", "");
		}else {
			selMonthSQL=" AND D_DATE like '"+year+"-"+selMonth+"-%' ";
			request.setAttribute("selMonth", selMonth);
		}
		System.out.println(time+"查询条件：月份:"+selMonthSQL);
		
		//查询条件：状态
		String selState = request.getParameter("selState");
		String selStateSQL;
		if(selState== null || selState.length()==0 || selState.equals("全部")) {
			selStateSQL=" AND 1=1 ";
			request.setAttribute("selState", "");
		}else {
			selStateSQL=" AND D_STATE = '"+selState+"' ";
			request.setAttribute("selState", selState);
		}
		System.out.println(time+"查询条件：状态:"+selStateSQL);
		
		//排序条件
		String OrderSQL=" order by D_DATE desc";
		
		String sql = "select D_ID,D_BUMEN,D_KBOSS,D_KBOSSEMAIL,D_KAIFA,D_DATE,D_CONTENT,D_BIAOZHUN,D_KEMAIL,D_NG,D_TUSER,D_WEINAME,D_VERSION,D_STATE,D_SUBURL,D_WIKI from SYS_TEST_SQ where D_TYPE='版本测试'"
		+selBumenSQL+selWeifwSQL+selVersionSQL+selMonthSQL+selStateSQL+OrderSQL;
		System.out.println(time+"总查询SQL:"+sql);
		
		String nowPage = request.getParameter("currentPage");
		DBUtils dbutil = new DBUtils();
		PageBean pageBean = dbutil.queryByPage2(nowPage, sql);
		request.setAttribute("pageBean", pageBean);
		
		//部门查询条件
		String sql2 = "select B_NAME from SYS_BUMEN where B_NAME != '产品测试部'";
		PageBean pageBean2 = dbutil.queryByPage2(nowPage, sql2);
		request.setAttribute("pageBean2", pageBean2);

		//版本号查询条件
		String sql3 = "select W_NAME from SYS_WEINAME where length(B_NAME)>1 " + selBumenSQL2 ;
		PageBean pageBean3 = dbutil.queryByPage2(nowPage, sql3);
		request.setAttribute("pageBean3", pageBean3);

		
		request.getRequestDispatcher("User/selectBanBen.jsp").forward(request, response);
	}



}
