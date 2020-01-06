package cn.com.shxt.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.com.shxt.model.PageBean;





public class Ping {

		
	public synchronized  boolean ping(String urlStr) throws SQLException {
		
		
		String ConfigName = "isPing";
		String sql ="select * from sys_config where name ='"+ConfigName+"'";
		System.out.println("查询配置开关sql："+sql);
		String ZIDuan = "VALUE";
		DBUtils dbutil =new DBUtils();
		String KaiGuan = dbutil.queryString(sql,ZIDuan);
		System.out.println("配置开关的值为："+KaiGuan);
		if(KaiGuan.equals("0")){
			System.out.println("关闭所有ping方法！全部返回false");
			return false;
		}else{
			System.out.println("所有ping方法正常运行中！");
			int counts = 0;
			while (counts < 1) {
			try {
				URL url = new URL(urlStr);
				HttpURLConnection con = (HttpURLConnection) url.openConnection();
	    		con.setUseCaches(false);
	    		con.setReadTimeout(1500);
	    		con.setConnectTimeout(1500);
				int state = con.getResponseCode();
				System.out.println(counts +"= "+state);
				if (state == 200) {
					System.out.println("URL可用！");
					return true;
				}
				break;
			}catch (Exception ex) {
				counts++;
				System.out.println("URL不可用，连接第"+counts+"次");
				urlStr = null;
				continue;
				}
			}
				return false;
			}
		}

}


