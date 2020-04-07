package cn.com.shxt.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.Properties;
import java.util.ResourceBundle;

public class OutPrintLogs {

    public OutPrintLogs(){ 
    	
    	Properties prop = new Properties();
    	//装载Properties配置文件
    	ResourceBundle resource = ResourceBundle.getBundle("uploadAddress");
    	//读取上传地址配置文件
    	String path =resource.getString("logsAddress");
    	System.out.println("上传路径："+path);
        File file=new File(path);
        if(!file.isDirectory()){
       	 file.mkdirs();
       	 System.out.println("没有检测到日志路径，自动创建路径："+path);
        }
        try {    
              
            PrintStream print=new PrintStream(path+"logs.txt");  //写好输出位置文件；  
            System.setOut(print);    
        } catch (FileNotFoundException e) {    
            e.printStackTrace();    
        }    
    }  
}
