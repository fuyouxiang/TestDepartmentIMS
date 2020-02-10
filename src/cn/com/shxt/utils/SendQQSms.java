package cn.com.shxt.utils;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import com.github.qcloudsms.SmsMultiSender;
import com.github.qcloudsms.SmsMultiSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;

import cn.com.shxt.servlet.DateTime;



public class SendQQSms  extends HttpServlet {

	private static final long serialVersionUID = 7892767001231292612L;


	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
		     
	}


	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String time= DateTime.showtime();
		System.out.println("使用腾讯云开始发送短信：——————————————————————");	
		
		
		String phoneNumberOld= request.getParameter("tele");//所有原始电话号码，带着；
	    //把收件人字符串中的；换成，   .substring(1)是为了去掉最前面的，
	    String phoneNumber = phoneNumberOld.replace(";", ",").substring(1);
	    System.out.println("收件人确认："+phoneNumber);
		
		String Msg= request.getParameter("Msg");
		Msg = new String(Msg.getBytes("ISO8859-1"),"UTF-8");
		System.out.println(time+"短信内容："+Msg);

		
		// 需要发送短信的手机号码
		String[] phoneNumbers = {"15097007498"};
		
		/**
	     * 腾讯云短信,100条一个月
	     * 方法说明
	     *
	     * @param phone
	     * @return void
	     * @Discription:扩展说明
	     * @throws HTTPException  http status exception
	     * @throws IOException    network problem
	     * 	@param type 短信类型，0 为普通短信，1 营销短信,需要和刚才页面上提交的短信正文下的类型一致
			@param nationCode 国家码，如 86 为中国
			@param phoneNumber 不带国家码的手机号
			@param msg 信息内容，必须与申请的模板格式一致，否则将返回错误，{1}占位符可在代码中用实际需要发送的值替换
			@param extend 扩展码，可填空
			@param ext 服务端原样返回的参数，可填空
	     */

		// 短信应用 SDK AppID
		int appId = 1400305338; // SDK AppID 以1400开头
		// 短信应用 SDK AppKey
		String appKey = "51ef70b316cfacc37695558d97724b0c";

        // 短信模板ID，需要在短信应用中申请
        //NOTE: 这里的模板ID`7839`只是一个示例，真实的模板ID需要在短信控制台中申请
        int templateId = 148464;

        // 签名
        // NOTE: 这里的签名"腾讯云"只是一个示例，真实的签名需要在短信控制台中申请，另外签名参数使用的是`签名内容`，而不是`签名ID`
        String smsSign = "财政云测试部";
        
        
        
        
        try {
        	  String[] params = {"5678"};
        	  SmsMultiSender msender = new SmsMultiSender(appId, appKey);
        	  //SmsMultiSenderResult result =  msender.sendWithParam("86", phoneNumbers,templateId, params, smsSign, "", ""); 
        	  SmsMultiSenderResult result =  msender.send(0, "86", phoneNumbers, Msg, "", "");
        	  System.out.println(result);
              if (result.result != 0) {
          		String info ="短信发送失败！请联系管理员查看后台日志。";
          		request.setAttribute("info", info);
          		request.getRequestDispatcher("Sys.jsp").forward(request, response);
  			} else{
  		 		String info ="短信发送完成！";
  		 		request.setAttribute("info", info);
  		 		request.getRequestDispatcher("Sys.jsp").forward(request, response);
  			}
        	} catch (HTTPException e) {
        	  // HTTP 响应码错误
        	  e.printStackTrace();
        	} catch (JSONException e) {
        	  // JSON 解析错误
        	  e.printStackTrace();
        	} catch (IOException e) {
        	  // 网络 IO 错误
        	  e.printStackTrace();
        	}

        /*
        SmsSingleSender sSender = new SmsSingleSender(appId, appKey);
        try {
        //第一个参数0表示普通短信,1表示营销短信
        SmsSingleSenderResult result = sSender.send(0, "86",
        		phoneNumbers,
        		Msg, "", "");

        if (result.result != 0) {
        		String info ="邮件发送失败！请联系管理员查看后台日志。";
        		request.setAttribute("info", info);
        		request.getRequestDispatcher("Sys.jsp").forward(request, response);
				throw new Exception("send phone validateCode is error" + result.errMsg);

			} else{
		 		String info ="邮件发送完成！";
		 		request.setAttribute("info", info);
		 		request.getRequestDispatcher("Sys.jsp").forward(request, response);
			}
        }catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/
        }
		
	}


