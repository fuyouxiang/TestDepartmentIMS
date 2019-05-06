package cn.com.shxt.service.bean;


import java.util.Map;



import cn.com.shxt.model.Sys_user;
import cn.com.shxt.utils.DBUtils;
import cn.com.shxt.utils.MD5Helper;


public class UserServiceBean {
	DBUtils db = new DBUtils();
	String sql;
	/**
	 * 修改一个用户
	 * @param user
	 * @return
	 */
	public int updateUser(Sys_user user){
		sql = "update sys_user set u_password = '"+user.getU_password()+"',u_name = '"+user.getU_name()+"',u_state = '"+user.getU_state()+"' where  u_id = "+user.getU_id()+"";
		System.out.println(sql);
		return db.update(sql);
		
	}
	/**
	 * 删除一个用户
	 * @param id
	 * @return
	 */
	public int deleteUser(Sys_user user){
		sql = "delete from sys_user where u_id = '"+user.getU_id()+"' ";
		return db.update(sql);
		
	}
	/**
	 * 查询1个用户的Id
	 * @param id
	 * @return
	 */
	public Sys_user selectOneStudent(int id){
		Sys_user user = new Sys_user();
		sql = "select * from sys_user where u_id = "+ id;
		Map<String,Object> map =db.query1(sql).get(0);
		
		user.setU_id(Integer.parseInt(map.get("U_ID").toString()));
		user.setU_name(map.get("U_NAME").toString());
		user.setU_state(map.get("U_STATE").toString());
		user.setU_role(map.get("U_ROLE").toString());
		user.setXinren(map.get("XINREN").toString());
		user.setXiangmu(map.get("XIANGMU").toString());
		user.setYongli(map.get("YONGLI").toString());
		user.setFenxiang(map.get("FENXIANG").toString());
		return user;
		
	}
	/**
	 * 查询1个用户的name
	 * @param id
	 * @return
	 */
	public Sys_user selectOneStudentName(String name){
		Sys_user user = new Sys_user();
		sql = "select * from sys_user where u_name = '" + name + "'";
		Map<String,Object> map =db.query1(sql).get(0);
		
		user.setU_id(Integer.parseInt(map.get("U_ID").toString()));
		user.setU_name(map.get("U_NAME").toString());
		user.setU_password(map.get("U_PASSWORD").toString());
		user.setU_state(map.get("U_STATE").toString());
		return user;
		
	}
	/**
	 * 修改1个用户的密码
	 * @param id
	 * @return
	 */
	public Sys_user updateOnePassword(String name,String password){
		Sys_user user = new Sys_user();
		sql = "select * from sys_user where u_name = '" + name + "' and u_password = '" + password + "'";
		Map<String,Object> map =db.query1(sql).get(0);
		
		user.setU_id(Integer.parseInt(map.get("U_ID").toString()));
		user.setU_name(map.get("U_NAME").toString());
		user.setU_password(map.get("U_PASSWORD").toString());
		user.setU_state(map.get("U_STATE").toString());
		return user;
		
	}
}
