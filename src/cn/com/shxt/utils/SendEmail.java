package cn.com.shxt.utils;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
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
		//request.setCharacterEncoding("UTF-8");
		System.out.println("开始发送邮件：——————————————————————");	
		
		String Msgtitle= request.getParameter("Msgtitle");//信息标题
		Msgtitle = new String(Msgtitle.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件标题："+Msgtitle);
		
		String Msg= request.getParameter("Msg");//信息内容
		Msg = new String(Msg.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件内容："+Msg);
		
		String EmailAddressStirng= request.getParameter("EmailAddress");//收件人
		EmailAddressStirng = new String(EmailAddressStirng.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件地址："+EmailAddressStirng);
		
		SendEmail s = new SendEmail();
   	    s.SendEmailFromQQ(EmailAddressStirng, Msgtitle, Msg);
		
   	   
		/*
		 * 逐条发送，但是会有每天20条邮件的限制，超过20封会要求验证码
		String [] EmailAddress=EmailAddressStirng.split(";");

         for(int i=1;i<EmailAddress.length;i++){
        	 SendEmail s = new SendEmail();
        	 s.SendEmailFromQQ(EmailAddress[i], Msgtitle, Msg);
         }*/
         
 		String info ="邮件发送完成！";
 		request.setAttribute("info", info);

 		request.getRequestDispatcher("Sys.jsp").forward(request, response);

	}
	
	public void SendEmailFromQQ( String EmailAddress,String Msgtitle,String Msg){
		
		   System.out.println("调用QQ邮箱发送接口：————————————————");
		   
		    Properties properties = new Properties();
		    properties.setProperty("mail.transport.protocol", "smtp");

		    properties.put("mail.smtp.host", "smtp.qq.com");
		    properties.put("mail.smtp.port", Integer.valueOf(465));
		    properties.put("mail.smtp.auth", "true");
		    properties.put("mail.smtp.ssl.enable", "true");

		    ResourceBundle resource = ResourceBundle.getBundle("email");
		    System.out.println("读取电子邮件配置文件：email.properties");
		    String SendEmailAddress = resource.getString("SendEmailAddress");
		    System.out.println("电子邮件服务端：" + SendEmailAddress);
		    String ShouQuanMa = resource.getString("ShouQuanMa");
		    System.out.println("授权码：" + ShouQuanMa );

		    Session session = Session.getDefaultInstance(properties);
		    session.setDebug(true);

		    Message message = new MimeMessage(session);

		    try {
		      message.setFrom(new InternetAddress(SendEmailAddress));

		      message.setSubject(Msgtitle);

		      
				message.setText(Msg);
			

		      Transport transport = session.getTransport();

		      transport.connect(SendEmailAddress, ShouQuanMa);

		      //把收件人字符串中的；换成，   .substring(1)是为了去掉最前面的，
		      String to = EmailAddress.replace(";", ",").substring(1);
		      System.out.println("收件人确认："+to);
		      
		      //必须把收件人地址封装成数组
		      InternetAddress[] addressesTo = null;
				if (to != null && to.trim().length() > 0) {
					String[] receiveList = to.split(",");
					int receiveCount = receiveList.length;
					if (receiveCount > 0) {
						addressesTo = new InternetAddress[receiveCount];
						for (int i = 0; i < receiveCount; i++) {
							addressesTo[i] = new InternetAddress(receiveList[i]);
						}

		      //message.setRecipient(Message.RecipientType.TO, new InternetAddress(addressesCc));
			  //封装邮件
		      message.setRecipients(Message.RecipientType.TO,addressesTo);

		      System.out.println("开始发送邮件：" + addressesTo);
		      //邮件群发
		      transport.sendMessage(message, message.getAllRecipients());
		      System.out.println("发送完成！");
		      transport.close();
		    
		  }
		}
		      } catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}		
	}
	

}
		    