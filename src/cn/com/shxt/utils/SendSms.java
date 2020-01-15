package cn.com.shxt.utils;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import cn.com.shxt.servlet.DateTime;



public class SendSms  extends HttpServlet {

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		     
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String time= DateTime.showtime();
		System.out.println("使用网建短信通发送短信：——————————————————————");	
		
		
		String phoneNumberOld= request.getParameter("tele");//所有原始电话号码，带着；
	    //把收件人字符串中的；换成，   .substring(1)是为了去掉最前面的，
	    String phoneNumber = phoneNumberOld.replace(";", ",").substring(1);
	    System.out.println("收件人确认："+phoneNumber);
		
		String Msg= request.getParameter("Msg");
		Msg = new String(Msg.getBytes("ISO8859-1"),"UTF-8");
		System.out.println(time+"短信内容："+Msg);
		
		HttpClient client = new HttpClient();
		PostMethod post = new PostMethod("http://gbk.api.smschinese.cn");
		post.addRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=gbk");//在头文件中设置转码
		NameValuePair[] data ={ new NameValuePair("Uid", "fuyouxiang"),//中国网建sms平台注册的用户名
								new NameValuePair("Key", "d41d8cd98f00b204e980"),//中国网建sms平台注册的密码
								new NameValuePair("smsMob",phoneNumber),//接收人手机号
								new NameValuePair("smsText",Msg)};
		post.setRequestBody(data);

		client.executeMethod(post);
		Header[] headers = post.getResponseHeaders();
		int statusCode = post.getStatusCode();
		System.out.println("statusCode:"+statusCode);
		for(Header h : headers)
		{
		System.out.println(h.toString());
		}
		String result = new String(post.getResponseBodyAsString().getBytes("gbk"));
		System.out.println(result); //打印返回消息状态


		post.releaseConnection();
		
 		String info ="邮件发送完成！";
 		request.setAttribute("info", info);

 		request.getRequestDispatcher("Sys.jsp").forward(request, response);
		
	}
	


}


