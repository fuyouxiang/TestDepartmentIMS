package cn.com.shxt.utils;

import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;

public class WebService extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5142015976490528693L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		request.setCharacterEncoding("UTF-8");  //设置编码 
		
    	String endpoint = request.getParameter("endpoint");
        System.out.println("WebService地址： "+endpoint);
        String PointName = request.getParameter("PointName");
        System.out.println("接口名称："+PointName);
        String certid = request.getParameter("certid");
        System.out.println("证书ID："+certid);
        String admDivCode = request.getParameter("admDivCode");
        System.out.println("区划："+admDivCode);
        int stYear = Integer.parseInt(request.getParameter("stYear")); 
        System.out.println("年度："+stYear);
        String vtCode = request.getParameter("vtCode");
        System.out.println("凭证类型："+vtCode);
        
        
        
        if(PointName.equals("signStampByNosAndSend")) {
        	System.out.println("=================signStampByNosAndSend===============");
            String voucher = request.getParameter("voucher");
            System.out.println("凭证原文："+voucher);
            String voucher_no = request.getParameter("voucher_no");
            System.out.println("凭证号："+voucher_no);
            int VoucherFlag = Integer.parseInt(request.getParameter("VoucherFlag")); 
            System.out.println("是否回单："+VoucherFlag);
            String stamp_id = request.getParameter("stamp_id");
            System.out.println("印章ID："+stamp_id);
            String stamp_no = request.getParameter("stamp_no");
            System.out.println("签章位置："+stamp_no);
            String srcOrgType = request.getParameter("srcOrgType");
            System.out.println("发送机构："+srcOrgType);
            String decOrgType = request.getParameter("decOrgType");
            System.out.println("接收机构："+decOrgType);
    		  
            try {  
                //String endpoint = "http://10.10.66.37:8071/realware/services/AsspPBankService?wsdl";

                // 直接引用远程的wsdl文件  
                // 以下都是套路  
                Service service = new Service();  
                Call call = (Call) service.createCall();  
                call.setTargetEndpointAddress(endpoint);
                //String PointName="signStampByNosAndSend";
                call.setOperationName(PointName);// WSDL里面描述的接口名称  
                call.addParameter("certid",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);// 接口的参数 
                call.addParameter("admDivCode",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("stYear",  org.apache.axis.encoding.XMLType.SOAP_INT, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("vtCode",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("voucherMessage",  org.apache.axis.encoding.XMLType.SOAP_BASE64BINARY, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("stamp",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("srcOrgType",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("decOrgType",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_MAP);// 设置返回类型  

                byte[] bytes = voucher.getBytes("GBK");
                //Base64 加密
                String voucherBase64 = Base64.getEncoder().encodeToString(bytes);
                System.out.println("凭证原文Base64加密：" + voucherBase64);


                //报文头尾+加密后的凭证
                String voucherMessageOld = "<?xml version=\"1.0\" encoding=\"GBK\"?>\r\n" + 
                		"<MOF>\r\n" + 
                		"   <VoucherCount>1</VoucherCount>\r\n" + 
                		"   <VoucherBody AdmDivCode=\""+admDivCode+"\" StYear=\""+stYear+"\" VtCode=\""+vtCode+"\" VoucherNo=\""+voucher_no+"\">\r\n" + 
                		"      <VoucherFlag>"+VoucherFlag+"</VoucherFlag>\r\n" + 
                		"      <Return_Reason></Return_Reason>\r\n" + 
                		"      <Attach></Attach>\r\n" + 
                		"      <Voucher>"+voucherBase64
                		+ "</Voucher>\r\n" + 
                		"</VoucherBody>\r\n" + 
                		" </MOF>";
                System.out.println("凭证原文完整：" + voucherMessageOld);
                byte[] voucherMessage = voucherMessageOld.getBytes();
                

                String stamp="<?xml version=\"1.0\" encoding=\"GBK\"?><Root><Stamp No=\""+stamp_no+"\">"+stamp_id+"</Stamp></Root>"; //签章信息
                System.out.println("签章信息：" + stamp);
                

                HashMap<String,Object> map=new HashMap<String,Object>();
                System.out.println("================开始调用================ ");
                map = (HashMap) call.invoke(new Object[] { certid,admDivCode,stYear,vtCode,voucherMessage,stamp,srcOrgType,decOrgType }); 
                String result=map.toString();
                // 给方法传递参数，并且调用方法  
                System.out.println("================调用成功！================ ");
                System.out.println("返回结果： " + result);
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('发送成功！返回结果："+result+"');window.history.go(-1);</script>");
            } catch (Exception e) {
            	System.out.println("调用失败！ ");
                System.err.println(e.toString()); 
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('发送失败！返回结果："+e.toString()+"');window.history.go(-1);</script>");
            }  
        }
        
        
        
        else if(PointName.equals("readVoucher")){
        	System.out.println("=================readVoucher===============");
        	
            int voucherCount = 1;
            System.out.println("凭证数量："+voucherCount);
        	
            try {  
                //String endpoint = "http://10.10.66.37:8071/realware/services/AsspPBankService?wsdl";

                // 直接引用远程的wsdl文件  
                // 以下都是套路  
                Service service = new Service();  
                Call call = (Call) service.createCall();  
                call.setTargetEndpointAddress(endpoint);
                //String PointName="signStampByNosAndSend";
                call.setOperationName(PointName);// WSDL里面描述的接口名称  
                call.addParameter("certid",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);// 接口的参数 
                call.addParameter("admDivCode",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("stYear",  org.apache.axis.encoding.XMLType.SOAP_INT, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("vtCode",  org.apache.axis.encoding.XMLType.SOAP_STRING, javax.xml.rpc.ParameterMode.IN);
                call.addParameter("voucherCount",  org.apache.axis.encoding.XMLType.SOAP_INT, javax.xml.rpc.ParameterMode.IN);
                //call.setReturnType(org.apache.axis.encoding.XMLType.SOAP_BYTE);// 设置返回类型  

                //HashMap<String,Object> map=new HashMap<String,Object>();
                System.out.println("================开始调用================ ");
                byte[] map =  (byte[]) call.invoke(new Object[] { certid,admDivCode,stYear,vtCode,voucherCount}); 
                String result=new String(map);
                // 给方法传递参数，并且调用方法  
                System.out.println("================调用成功！================ ");
                System.out.println("返回结果： " + result);
                response.setContentType("text/html; charset=UTF-8");
				request.setAttribute("info", result);
                request.getRequestDispatcher("User/readVoucher.jsp").forward(request, response);		
            } catch (Exception e) {
            	System.out.println("调用失败！ ");
                System.err.println(e.toString()); 
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('调用失败！返回结果："+e.toString()+"');window.history.go(-1);</script>");
            }  
        }
        
        
        
        else {
        	    response.getWriter().println("<script>alert('调用接口异常！');window.history.go(-1);</script>");
        }

    }  
	
}
