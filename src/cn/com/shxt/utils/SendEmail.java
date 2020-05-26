package cn.com.shxt.utils;


import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Date;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.mail.util.MailSSLSocketFactory;

import cn.com.shxt.servlet.DateTime;
import net.sf.json.JSONObject;


public class SendEmail  extends HttpServlet {

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		     
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("调用发送QQ邮件接口：——————————————————————");	
		
		//时间戳，直接调用DateTime.java中的方法
		String timelog= DateTime.showtime();

		request.setCharacterEncoding("UTF-8");
		
		//接收json字符串
		InputStreamReader reader=new InputStreamReader(request.getInputStream(),"UTF-8");
		char [] buff=new char[1024];
		int length=0;
		String str = null;
		while((length=reader.read(buff))!=-1){
		     str=new String(buff,0,length);
		     System.out.println(timelog+"接收到的json串为："+str);
		}
		/*
		 * 示例：
		 * 
	{
    "Msgtitle": "中文1",
    "Msg": "中文2",
	"EmailAddress": "中文3"
	}
		 * */

		
		//json里有key和数组
		JSONObject jsonobj=JSONObject.fromObject(str);//将字符串转化成json对象 
		
		String Msgtitle=(String) jsonobj.get("Msgtitle");
		System.out.println("邮件标题："+Msgtitle);
		String Msg=(String) jsonobj.get("Msg");
		System.out.println("邮件内容："+Msg);
		String EmailAddress=(String) jsonobj.get("EmailAddress");
		System.out.println("邮件地址："+EmailAddress);
		
		
		/*使用key的方式问号传值
		 * 
		 * 		
		String Msgtitle= request.getParameter("Msgtitle");//信息标题
		Msgtitle = new String(Msgtitle.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件标题："+Msgtitle);
		
		String Msg= request.getParameter("Msg");//信息内容
		Msg = new String(Msg.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件内容："+Msg);
		
		String EmailAddressStirng= request.getParameter("EmailAddress");//收件人
		EmailAddressStirng = new String(EmailAddressStirng.getBytes("ISO8859-1"),"UTF-8");
		System.out.println("邮件地址："+EmailAddressStirng);
		
		 * 
		 * */

		
		SendEmail s = new SendEmail();
   	    //s.SendEmailFromQQ(EmailAddressStirng, Msgtitle, Msg);
		
   	   
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
	
	public void SendEmailFromQQ(String EmailAddress,String Msgtitle,String Msg){
		
	    ResourceBundle resource = ResourceBundle.getBundle("email");
	    System.out.println("读取电子邮件配置文件：email.properties");
	    String EmailType = resource.getString("EmailType");
	    System.out.println("邮箱类型：" + EmailType );
	    String SendEmailAddress = resource.getString("SendEmailAddress");
	    System.out.println("电子邮件服务端：" + SendEmailAddress);
	    String ShouQuanMa = resource.getString("ShouQuanMa");
	    System.out.println("授权码：" + ShouQuanMa );

	    System.out.println("邮箱地址：" + EmailAddress );
	    System.out.println("邮件标题：" + Msgtitle );
	    System.out.println("邮件内容：" + Msg );
	    
	    Properties properties = new Properties();
	    properties.setProperty("mail.transport.protocol", "smtp");
	    
	    
	    if(EmailType.equals("163")) {
			 System.out.println("调用163邮箱发送接口：————————————————");
			 
			 properties.put("mail.smtp.host", "smtp.163.com");

	    }else {
			 System.out.println("调用QQ邮箱发送接口：————————————————");
			 
			 properties.put("mail.smtp.host", "smtp.qq.com");
			   
	    }

		    properties.put("mail.smtp.auth", "true");
		    properties.put("mail.smtp.ssl.enable", "true");
			 // SSL加密
			 MailSSLSocketFactory sf = null;
			    try {
					sf = new MailSSLSocketFactory();
			} catch (GeneralSecurityException e1) {
					// TODO 自动生成的 catch 块
					e1.printStackTrace();
			}
			  // 设置信任所有的主机
			  sf.setTrustAllHosts(true);
			  properties.put("mail.smtp.ssl.socketFactory", sf);


		    

	        //设置自定义发件人昵称  
	        String nick="";  
	        try {  
	            nick=javax.mail.internet.MimeUtility.encodeText("财政云产品测试部");  
	        } catch (UnsupportedEncodingException e) {  
	            e.printStackTrace();  
	        }  
	        
		    Session session = Session.getDefaultInstance(properties);
		    session.setDebug(true);

		    Message message = new MimeMessage(session);

		    try {
		      try {
				message.setFrom(new InternetAddress(SendEmailAddress,"财政云测试部","UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}

		      message.setSubject(Msgtitle);

		      
				//message.setText(Msg);
				message.setContent(Msg, "text/html;charset=UTF-8");

		      Transport transport = session.getTransport();

		      transport.connect(SendEmailAddress, ShouQuanMa);

		      //把收件人字符串中的；换成，   .substring(1)是为了去掉最前面的，
		      String to = EmailAddress.replace(";", ",").substring(1);
		      //to="fuyouxiang1994@163.com";
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
							System.out.println("收件人遍历："+addressesTo[i]);
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
	
	public void SendEmailFromYonYou( String EmailAddress,String Msgtitle,String Msg) throws Exception{
		
		System.out.println("调用用友邮箱发送接口：————————————————");
		
	    // 发件人的 邮箱 和 密码（替换为自己的邮箱和密码）
	    // PS: 某些邮箱服务器为了增加邮箱本身密码的安全性，给 SMTP 客户端设置了独立密码（有的邮箱称为“授权码”）, 
	    //     对于开启了独立密码的邮箱, 这里的邮箱密码必需使用这个独立密码（授权码）。
	    String myEmailAccount = "fuyx1@yonyou.com";
	    String myEmailPassword = "fyx112358";
	    System.out.println("发件人："+myEmailAccount);
	    

	    // 发件人邮箱的 SMTP 服务器地址, 必须准确, 不同邮件服务器地址不同, 一般(只是一般, 绝非绝对)格式为: smtp.xxx.com
	    // 网易163邮箱的 SMTP 服务器地址为: smtp.163.com    腾讯: smtp.qq.com
	    String myEmailSMTPHost = "smtp.example.com";

	    // 收件人邮箱（替换为自己知道的有效邮箱）
	    String receiveMailAccount = "415912873@qq.com";
	    System.out.println("收件人："+receiveMailAccount);

	    // 1. 创建参数配置, 用于连接邮件服务器的参数配置
	     Properties props = new Properties();                    // 参数配置
	     props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
	     props.setProperty("mail.smtp.host", myEmailSMTPHost);   // 发件人的邮箱的 SMTP 服务器地址
	     props.setProperty("mail.smtp.auth", "true");            // 需要请求认证

	        // PS: 某些邮箱服务器要求 SMTP 连接需要使用 SSL 安全认证 (为了提高安全性, 邮箱支持SSL连接, 也可以自己开启),
	        //     如果无法连接邮件服务器, 仔细查看控制台打印的 log, 如果有有类似 “连接失败, 要求 SSL 安全连接” 等错误,
	        //     打开下面 /* ... */ 之间的注释代码, 开启 SSL 安全连接。
	        
	            // SMTP 服务器的端口 (非 SSL 连接的端口一般默认为 25, 可以不添加, 如果开启了 SSL 连接,
	            //                  需要改为对应邮箱的 SMTP 服务器的端口, 具体可查看对应邮箱服务的帮助,
	            //                  QQ邮箱的SMTP(SLL)端口为465或587, 其他邮箱自行去查看)
	            final String smtpPort = "995";
	            props.setProperty("mail.smtp.port", smtpPort);
	            props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	            props.setProperty("mail.smtp.socketFactory.fallback", "false");
	            props.setProperty("mail.smtp.socketFactory.port", smtpPort);
	         

	        // 2. 根据配置创建会话对象, 用于和邮件服务器交互
	        Session session = Session.getDefaultInstance(props);
	        session.setDebug(true);                                 // 设置为debug模式, 可以查看详细的发送 log

	        // 1. 创建一封邮件
	        MimeMessage message = new MimeMessage(session);

	        // 2. From: 发件人（昵称有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改昵称）
	        message.setFrom(new InternetAddress(myEmailAccount, "白小纯", "UTF-8"));

	        // 3. To: 收件人（可以增加多个收件人、抄送、密送）
	        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMailAccount, "XX用户", "UTF-8"));

	        // 4. Subject: 邮件主题（标题有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改标题）
	        message.setSubject(Msgtitle, "UTF-8");

	        // 5. Content: 邮件正文（可以使用html标签）（内容有广告嫌疑，避免被邮件服务器误认为是滥发广告以至返回失败，请修改发送内容）
	        message.setContent(Msg, "text/html;charset=UTF-8");

	        // 6. 设置发件时间
	        message.setSentDate(new Date());

	        // 7. 保存设置
	        message.saveChanges();

	        // 4. 根据 Session 获取邮件传输对象
	        Transport transport = session.getTransport();

	        // 5. 使用 邮箱账号 和 密码 连接邮件服务器, 这里认证的邮箱必须与 message 中的发件人邮箱一致, 否则报错
	        // 
	        //    PS_01: 成败的判断关键在此一句, 如果连接服务器失败, 都会在控制台输出相应失败原因的 log,
	        //           仔细查看失败原因, 有些邮箱服务器会返回错误码或查看错误类型的链接, 根据给出的错误
	        //           类型到对应邮件服务器的帮助网站上查看具体失败原因。
	        //
	        //    PS_02: 连接失败的原因通常为以下几点, 仔细检查代码:
	        //           (1) 邮箱没有开启 SMTP 服务;
	        //           (2) 邮箱密码错误, 例如某些邮箱开启了独立密码;
	        //           (3) 邮箱服务器要求必须要使用 SSL 安全连接;
	        //           (4) 请求过于频繁或其他原因, 被邮件服务器拒绝服务;
	        //           (5) 如果以上几点都确定无误, 到邮件服务器网站查找帮助。
	        //
	        //    PS_03: 仔细看log, 认真看log, 看懂log, 错误原因都在log已说明。
	        transport.connect(myEmailAccount, myEmailPassword);

	        // 6. 发送邮件, 发到所有的收件地址, message.getAllRecipients() 获取到的是在创建邮件对象时添加的所有收件人, 抄送人, 密送人
	        transport.sendMessage(message, message.getAllRecipients());
	        System.out.println("发送完成！");

	        // 7. 关闭连接
	        transport.close();
	}
	
	public void SendEmailFrom163(String EmailAddress,String Msgtitle,String Msg){
		
		   System.out.println("调用163邮箱发送接口：————————————————");
		   
		   
		    Properties properties = new Properties();
		    properties.setProperty("mail.transport.protocol", "smtp");

		    properties.put("mail.smtp.host", "smtp.163.com");
		    properties.put("mail.smtp.auth", "true");
		    properties.put("mail.smtp.ssl.enable", "true");
		    // SSL加密
		    MailSSLSocketFactory sf = null;
		    try {
				sf = new MailSSLSocketFactory();
			} catch (GeneralSecurityException e1) {
				// TODO 自动生成的 catch 块
				e1.printStackTrace();
			}
		    // 设置信任所有的主机
		    sf.setTrustAllHosts(true);
		    properties.put("mail.smtp.ssl.socketFactory", sf);


		    ResourceBundle resource = ResourceBundle.getBundle("email");
		    System.out.println("读取电子邮件配置文件：email.properties");
		    String SendEmailAddress = resource.getString("SendEmailAddress");
		    System.out.println("电子邮件服务端：" + SendEmailAddress);
		    String ShouQuanMa = resource.getString("ShouQuanMa");
		    System.out.println("授权码：" + ShouQuanMa );
		    System.out.println("邮箱地址：" + EmailAddress );
		    System.out.println("邮件标题：" + Msgtitle );
		    System.out.println("邮件内容：" + Msg );
		    

	        //设置自定义发件人昵称  
	        String nick="";  
	        try {  
	            nick=javax.mail.internet.MimeUtility.encodeText("财政云产品测试部");  
	        } catch (UnsupportedEncodingException e) {  
	            e.printStackTrace();  
	        }  
	        
		    Session session = Session.getDefaultInstance(properties);
		    session.setDebug(true);

		    Message message = new MimeMessage(session);

		    try {
		      try {
				message.setFrom(new InternetAddress(SendEmailAddress,"财政云测试部","UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}

		      message.setSubject(Msgtitle);

		      
				//message.setText(Msg);
				message.setContent(Msg, "text/html;charset=UTF-8");

		      Transport transport = session.getTransport();

		      transport.connect(SendEmailAddress, ShouQuanMa);

		      //把收件人字符串中的；换成，   .substring(1)是为了去掉最前面的，
		      String to = EmailAddress.replace(";", ",").substring(1);
		      System.out.println("收件人确认："+to);
		      to="fuyx1@yonyou.com,fuyouxiang1994@163.com";
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
		    