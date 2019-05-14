package cn.com.shxt.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ping {
	
   
    
    public static boolean ping(String ipAddress) {   	
    	try {
    		URL url=new URL(ipAddress);
    		URLConnection conn = (URLConnection)url.openConnection();
    		/*
    		 * JDK 1.5以前的版本，只能通过设置这两个系统属性来控制网络超时。在1.5中，还可以使用HttpURLConnection的父类URLConnection的以下两个方法：
				setConnectTimeout：设置连接主机超时（单位：毫秒）
				setReadTimeout：设置从主机读取数据超时（单位：毫秒）
    		 * */
    		conn.setReadTimeout(2000);
    		conn.setConnectTimeout(2000);

    		String str=conn.getHeaderField(0);
    		System.out.println("1"+str);
    		if (str.indexOf("200")> 0){
    		//网址正常
    		return true;
    		}else{
    		//网址不正常
    		return false;
    		}
    		} catch (Exception ex) {
    		//网址不正常
    		return false;
    		}
   
    }
  

}
