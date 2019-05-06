package cn.com.shxt.service.bean;


import java.util.Map;



import cn.com.shxt.model.Sys_Version;
import cn.com.shxt.utils.DBUtils;

public class VersionServiceBean {
	DBUtils db = new DBUtils();
	String sql;
	/**
	 * 修改一个版本
	 * @param user
	 * @return
	 */
	public int updateVersion(Sys_Version version){
		//sql = "update SYS_VERSION set v_product = '"+version.getV_product()+"',v_type = '"+version.getV_type()+"',v_cersionno = '"+version.getV_cersionno()+"',v_build = '"+version.getV_build()+"',v_releasedate = '"+version.getV_releasedate()+"' ,v_startdate = '"+version.getV_startdate()+"',v_enddate = '"+version.getV_enddate()+"',v_name = '"+version.getV_name()+"',v_bug = '"+version.getV_bug()+"',v_case = '"+version.getV_case()+"',v_document = '"+version.getV_document()+"',v_re_result = '"+version.getV_re_result()+"',v_reason = '"+version.getV_reason()+"',v_testresult = '"+version.getV_testresult()+"',v_testtime = '"+version.getV_testtime()+"' where  v_id = "+version.getV_id()+"";
		System.out.println(sql);
		return db.update(sql);
		
	}
	/**
	 * 删除一个用户
	 * @param id
	 * @return
	 
	public int deleteUser(Sys_user user){
		sql = "delete from sys_user where u_id = '"+user.getU_id()+"' ";
		return db.update(sql);
		
	}
	*/
	/**
	 * 查询1个用户的Id
	 * @param id
	 * @return
	 */
	public Sys_Version selectOneVersion(int id){
		
		Sys_Version version = new Sys_Version();
		System.out.println("BeanID："+id);
		sql = "select * from sys_version where v_id = "+ id +" ";
		Map<String,Object> map =db.query1(sql).get(0);

		version.setV_id(Integer.parseInt(map.get("V_ID").toString()));
		version.setV_type(map.get("V_TYPE").toString());
		version.setV_name(map.get("V_NAME").toString());
		version.setV_bug(map.get("V_BUG").toString());
		version.setV_case(map.get("V_CASE").toString());
		version.setV_time(map.get("V_TIME").toString());
		version.setV_month(map.get("V_MONTH").toString());
		version.setV_date(map.get("V_DATE").toString());
		version.setV_week(map.get("V_WEEK").toString());
		version.setV_basics(map.get("V_BASICS").toString());
		version.setV_work(map.get("V_WORK").toString());
		version.setV_document(map.get("V_DOCUMENT").toString());

		
		/**version.setV_product(map.get("v_product").toString());
		version.setV_type(map.get("v_type").toString());
		version.setV_cersionno(map.get("v_cersionno").toString());
		version.setV_build(map.get("v_build").toString());
		version.setV_releasedate(map.get("v_releasedate").toString());
		version.setV_releasedate(map.get("v_startdate").toString());
		version.setV_enddate(map.get("v_enddate").toString());
		version.setV_name(map.get("v_name").toString());
		version.setV_bug(Float.parseFloat(map.get("v_bug").toString()));
		version.setV_case(Float.parseFloat(map.get("v_case").toString()));
		version.setV_document(Float.parseFloat(map.get("v_document").toString()));
		version.setV_re_result(map.get("v_re_result").toString());
		version.setV_reason(map.get("v_reason").toString());
		version.setV_testresult(map.get("v_testresult").toString());
		version.setV_testtime(Float.parseFloat(map.get("v_testtime").toString()));
		System.out.println("Bean数据测试：");*/
		return version;
		
	}
	/**
	 * 查询1个用户的name
	 * @param id
	 * @return
	 
	public Sys_user selectOneStudent(String name){
		Sys_user user = new Sys_user();
		sql = "select * from sys_user where u_name = "+ name +" ";
		Map<String,Object> map =db.query1(sql).get(0);
		
		user.setU_id(Integer.parseInt(map.get("U_ID").toString()));
		user.setU_name(map.get("U_NAME").toString());
		user.setU_password(map.get("U_PASSWORD").toString());
		return user;
		
	}*/
}
