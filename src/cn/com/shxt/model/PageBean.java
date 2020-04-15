package cn.com.shxt.model;

import java.util.List;
import java.util.Map;

public class PageBean {
	// 当前页数
	private int nowPage = 1;
	// 每页显示记录条数
	private int iRows = 10;
	private int iRows2 = 4000;
	private int iRows3 = 20;
	// 总记录条数
	private int totalRows;
	// 总页数 计算得到
	private int pages;
	// 分页查询的结果集
	private List<Map<String, String>> resList;
	// SQL语句
	private String sql;

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getiRows() {
		return iRows;
	}

	public void setiRows(int iRows) {
		this.iRows = iRows;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totaRows) {
		this.totalRows = totaRows;
	}

	public int getPages() {
		return pages;
	}

	public void setPages(int count) {
		this.pages = count % iRows == 0 ? count / iRows : count / iRows + 1;
	}

	public List<Map<String, String>> getResList() {
		return resList;
	}

	public void setResList(List<Map<String, String>> resList) {
		this.resList = resList;
	}

	public String getSql() {
		return sql;
	}

	public void setSql(String sql) {
		this.sql = "select * from (select rownum r,t.* from(" + sql
				+ ")t where rownum <=" + nowPage * iRows + ")t1 where t1.r >="
				+ ((nowPage - 1) * iRows + 1) + "";
	}
	
	public void setSql2(String sql) {
		this.sql = "select * from (select rownum r,t.* from(" + sql
				+ ")t where rownum <=" + nowPage * iRows2 + ")t1 where t1.r >="
				+ ((nowPage - 1) * iRows2 + 1) + "";
	}

	public void setSql3(String sql) {
		this.sql = "select * from (select rownum r,t.* from(" + sql
				+ ")t where rownum <=" + nowPage * iRows3 + ")t1 where t1.r >="
				+ ((nowPage - 1) * iRows3 + 1) + "";
	}
}
