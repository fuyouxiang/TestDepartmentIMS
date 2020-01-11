package cn.com.shxt.utils;


import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.shxt.servlet.DateTime;


public class SendEmail  extends HttpServlet {

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		     
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		request.setCharacterEncoding("UTF-8");
		System.out.println("开始发送邮件：——————————————————————");	
		
		String Msgtitle= request.getParameter("Msgtitle");//信息标题
		Msgtitle = new String(Msgtitle.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件标题："+Msgtitle);
		
		String Msg= request.getParameter("Msg");//信息内容
		Msg = new String(Msg.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件内容："+Msg);
		
		String EmailAddressStirng= request.getParameter("EmailAddress");//信息内容
		EmailAddressStirng = new String(EmailAddressStirng.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件地址："+EmailAddressStirng);
		
		String [] EmailAddress=EmailAddressStirng.split(";");
		
         for(int i=1;i<EmailAddress.length;i++){
        	 SendEmail s = new SendEmail();
        	 s.SendEmailFromQQ(EmailAddress[i], Msgtitle, Msg);
         }
         
 		String info ="邮件发送完成！";
 		request.setAttribute("info", info);

 		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	}
	
	public void SendEmailFromQQ( String EmailAddress,String Msgtitle,String Msg){
		
		System.out.println("调用QQ邮箱发送接口：————————————————");
        Properties properties = new Properties();
        properties.put("mail.transport.protocol", "smtp");// 连接协议
        properties.put("mail.smtp.host", "smtp.qq.com");// 主机名
        properties.put("mail.smtp.port", 465);// 端口号
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.ssl.enable", "true");// 设置是否使用ssl安全连接 ---一般都使用
        properties.put("mail.debug", "true");// 设置是否显示debug信息 true 会在控制台显示相关信息
        
        //装载Properties配置文件
      	ResourceBundle resource = ResourceBundle.getBundle("email");
      	System.out.println("读取电子邮件配置文件：email.properties");
      	String SendEmailAddress =resource.getString("SendEmailAddress");
      	System.out.println("电子邮件服务端："+SendEmailAddress);
      	String ShouQuanMa =resource.getString("ShouQuanMa");
      	System.out.println("授权码："+ShouQuanMa);
        
		// 得到回话对象
        Session session = Session.getInstance(properties);
        // 获取邮件对象
        Message message = new MimeMessage(session);
        try {
        // 设置发件人邮箱地址
        message.setFrom(new InternetAddress(SendEmailAddress));
        // 设置邮件标题
        message.setSubject(Msgtitle);
        // 设置邮件内容
        message.setText(Msg);
        // 得到邮差对象
        Transport transport = session.getTransport();
        // 连接自己的邮箱账户
        transport.connect(SendEmailAddress, ShouQuanMa);// 密码为QQ邮箱开通的stmp服务后得到的客户端授权码
        // 设置收件人邮箱地址 
        //message.setRecipients(Message.RecipientType.TO, new InternetAddress[]{new InternetAddress("415912873@qq.com"),new InternetAddress("xxx@qq.com"),new InternetAddress("xxx@qq.com")});
       message.setRecipient(Message.RecipientType.TO, new InternetAddress(EmailAddress));//一个收件人
		System.out.println("开始发送邮件："+EmailAddress);
        // 发送邮件
        transport.sendMessage(message, message.getAllRecipients());
		System.out.println("发送完成！");
        transport.close();
        } catch (Exception e) {
        	e.printStackTrace();
        }
	}
}


