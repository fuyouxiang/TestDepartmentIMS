package cn.com.shxt.servlet;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTime {
    public static String showtime(){ 
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time="【"+sdf.format(d)+"】";
		return time;
    } 
}
