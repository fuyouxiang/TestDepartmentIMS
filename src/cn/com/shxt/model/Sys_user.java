package cn.com.shxt.model;

import cn.com.shxt.utils.MD5Helper;

public class Sys_user {
	private int u_id;
	private String u_name;
	private String u_password;
	private String u_state;
	private String u_role;
	private String xinren;
	private String xiangmu;
	private String yongli;
	private String fenxiang;
	
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_name(String u_name) {
		this.u_name = u_name;
	}
	public String getU_name() {
		return u_name;
	}
	public void setU_password(String u_password) {
		this.u_password = u_password;
	}
	public String getU_password() {
		return u_password;
	}
	public void setU_state(String u_state) {
		this.u_state = u_state;
	}
	public String getU_state() {
		return u_state;
	}
	public void setU_role(String u_role) {
		this.u_role = u_role;
	}
	public String getU_role() {
		return u_role;
	}
	public String getXinren() {
		return xinren;
	}
	public void setXinren(String xinren) {
		this.xinren = xinren;
	}
	public String getXiangmu() {
		return xiangmu;
	}
	public void setXiangmu(String xiangmu) {
		this.xiangmu = xiangmu;
	}
	public String getYongli() {
		return yongli;
	}
	public void setYongli(String yongli) {
		this.yongli = yongli;
	}
	public String getFenxiang() {
		return fenxiang;
	}
	public void setFenxiang(String fenxiang) {
		this.fenxiang = fenxiang;
	}
	
}
