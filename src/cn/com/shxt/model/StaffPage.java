package cn.com.shxt.model;

import java.util.List;
import java.util.Map;

public class StaffPage {

	private int currentpage =1;			//当前页
	private int totalpage ;				//总页数
	private String sql;					//sql语句
	private int pagesize = 3;			//返回值
	private List<Map<String,Object>> list;
	public int getCurrentpage() {
		return currentpage;
	}
	public void setCurrentpage(int currentpage) {
		this.currentpage = currentpage;
	}
	public int getTotalpage() {
		return totalpage;
	}
	public void setTotalpage(int count) {
		this.totalpage = count%pagesize==0? count/pagesize : count/pagesize + 1;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = "select * from (select rownum r,t.*from("+sql+") t where rownum <= "+currentpage*pagesize+" ) t1 where t1.r >= "+((currentpage-1)*pagesize + 1)+" ";
	}
	public int getPagesize() {
		return pagesize;
	}
	public void setPagesize(int pagesize) {
		this.pagesize = pagesize;
	}
	public List<Map<String, Object>> getList() {
		return list;
	}
	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}

}
