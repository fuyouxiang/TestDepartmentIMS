package cn.com.shxt.utils;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.github.qcloudsms.SmsMultiSender;
import com.github.qcloudsms.SmsMultiSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;
import com.sun.jmx.snmp.Timestamp;

import cn.com.shxt.servlet.DateTime;


public class CopyOfSendSms  extends HttpServlet {

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
		System.out.println("开始发送短信：——————————————————————");	
		
		
		String phoneNumberOld= request.getParameter("tele");//所有原始电话号码，带着86
		
		
		// 短信应用 SDK AppID
		int appid = 1400009099; // SDK AppID 以1400开头
		// 短信应用 SDK AppKey
		String appkey = "9ff91d87c2cd7cd0ea762f141975d1df37481d48700d70ac37470aefc60f9bad";
		// 需要发送短信的手机号码
		String[] phoneNumbers = {"21212313123", "12345678902", "12345678903"};
		// 短信模板 ID，需要在短信应用中申请
		int templateId = 7839; // NOTE: 这里的模板 ID`7839`只是示例，真实的模板 ID 需要在短信控制台中申请
		// 签名
		String smsSign = "腾讯云"; // NOTE: 签名参数使用的是`签名内容`，而不是`签名ID`。这里的签名"腾讯云"只是示例，真实的签名需要在短信控制台申请
		
		try {
			  String[] params = {"5678"};
			  SmsMultiSender msender = new SmsMultiSender(appid, appkey);
			  SmsMultiSenderResult result =  msender.sendWithParam("86", phoneNumbers,
			      templateId, params, smsSign, "", "");
			  System.out.println(result);
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
		//时间戳，直接调用DateTime.java中的方法
		String time= DateTime.showtime();
		request.setCharacterEncoding("UTF-8");
		System.out.println("开始发送短信：——————————————————————");	
		
		
		String phoneNumberOld= request.getParameter("tele");//所有原始电话号码，带着86
        
        String sToFind = "N";
        int num = new SendSms().countStr(phoneNumberOld,sToFind);
        System.out.println("共找到" + num + "个" + sToFind);//电话号码的个数

        String phoneNumberNew = null;
		for(int i=0;i<num;i++){
			String EveryphoneNumber = "&PhoneNumberSet."+i+"=+86";
			phoneNumberNew= phoneNumberOld.replaceFirst("N86",EveryphoneNumber);
			phoneNumberOld=phoneNumberNew;
			System.out.println(time+"短信群发组装中："+phoneNumberNew);//电话号码字符串
		}

		String phoneNumber=phoneNumberNew;
		System.out.println(time+"要发送的电话号码："+phoneNumber);//电话号码字符串

		String Msg= request.getParameter("Msg");
		Msg = new String(Msg.getBytes("ISO8859-1"),"UTF-8");
		System.out.println(time+"短信内容："+Msg);
		
		
		SendSms sendSms = new SendSms();
		
		try {
			sendSms.SendSmsAll(phoneNumber, Msg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		
	}
	
	
	public void SendSmsAll(String phoneNumber,String Msg) throws Exception{
		
		//接口地址
        String url_str = "https://sms.tencentcloudapi.com/?";
        //公共参数，本接口取值：SendSms
        String  Action= "Action=SendSms";
        //公共参数，本接口取值：2019-07-11
        String  Version= "&Version=2019-07-11";
        //PhoneNumberSet.N，下发手机号码，采用 e.164 标准，+[国家或地区码][手机号] ，示例如：+8613711112222， 其中前面有一个+号 ，86为国家码，13711112222为手机号，最多不要超过200个手机号。
        String  PhoneNumberSet= phoneNumber;
        //模板 ID，必须填写已审核通过的模板 ID。模板ID可登录 短信控制台 查看。
        String  TemplateID= "&TemplateID=1234";
        //短信SdkAppid在 短信控制台 添加应用后生成的实际SdkAppid，示例如1400006666。
        String  SmsSdkAppid= "&SmsSdkAppid=1400006666";
        //短信签名内容，使用 UTF-8 编码，必须填写已审核通过的签名，签名信息可登录 短信控制台 查看。
        String  Sign= "&Sign=腾讯云";
        //TemplateParamSet.N	模板参数，若无模板参数，则设置为空。
        String TemplateParamSet= "&TemplateParamSet.0="+Msg;
        //当前 UNIX 时间戳，可记录发起 API 请求的时间。例如 1529223702。注意：如果与服务器时间相差超过5分钟，会引起签名过期错误。
        long timeStampSec = System.currentTimeMillis()/1000;
        String timestamp = "&Timestamp="+String.format("%010d", timeStampSec);
        //随机正整数，与 Timestamp 联合起来，用于防止重放攻击。
        String Nonce="&Nonce=123";
        //在云API密钥上申请的标识身份的 SecretId，一个 SecretId 对应唯一的 SecretKey ，而 SecretKey 会用来生成请求签名 Signature。
        String SecretId="&SecretId=AKIDe5KJ3XMnX3c2IOesHRbbT6TbUDhyGoUN";
        
        String SecretKey="nU6TKwMaZIm3B4nHaeU6Ynob9QRChwvh";
        
        String SendSms_url = url_str + Action + Version + PhoneNumberSet + TemplateID + SmsSdkAppid + Sign + TemplateParamSet + timestamp + Nonce + SecretId;
        System.out.println("开始调用腾讯云短信发送接口："+SendSms_url);
        URL url = new URL(SendSms_url);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.connect();
 
        String ResponseMessage = connection.getResponseMessage();
        System.out.println("接口返回信息"+ResponseMessage);
        InputStream is = connection.getInputStream();
        byte[] response = new byte[is.available()];
        is.read(response);
        is.close();
        if (response == null || response.length == 0) {
            throw new Exception("认证无效，找不到此次认证的会话信息！");
        }
        String userId = new String(response, "UTF-8");
        System.out.println(userId);	
	}
	
    /**
     * @param str 原字符串
     * @param sToFind 需要查找的字符串
     * @return 返回在原字符串中sToFind出现的次数
     */
	public int countStr(String str,String sToFind) {
        int num = 0;
        while (str.contains(sToFind)) {
            str = str.substring(str.indexOf(sToFind) + sToFind.length());
            num ++;
        }
        return num;
    }
	
	public void SendSmsSDK() throws Exception{
	
	}

}


