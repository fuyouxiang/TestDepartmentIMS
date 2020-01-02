package cn.com.shxt.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;





public class Ping {

		
	public synchronized  boolean ping(String urlStr) {
		
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


