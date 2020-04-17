<%@ page language="java" import="java.util.*,cn.com.shxt.model.PageBean,java.io.*,cn.com.shxt.utils.Ping,java.util.concurrent.Executor,java.util.concurrent.Executors" pageEncoding="UTF-8"  %>
<% 
String username =null;
username = (String)session.getAttribute("username"); 
String userrole =null;
userrole = (String)session.getAttribute("userrole");
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>主框架</title>
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="stylesheet" type="text/css" href="css/frame.css">
</head>
<script type="text/javascript">

var shouye=
    {
        icon:'icon-sk001',
        id:'001',
        title:'首页工作台',
        path:'selectAllUrlServlet',
        target:'right',
        level:1,
        children:[]
    };
var tongzhi=
{
        id:'002',
        icon:'icon-sk003',
        title:'通知发布',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0021',level:2,icon:'',title:'系统首页通知',path:'guanliyuan/UpdateNotice.jsp',target:'right',children:[]},
            {id:'0022',level:2,icon:'',title:'邮件通知',path:'selectUserEmailServlet',target:'right',children:[]},
            {id:'0023',level:2,icon:'',title:'短信通知',path:'selectUserPhoneNumberServlet',target:'right',children:[]}
        ]
};
var caizhengyun=
{
        id:'003',
        icon:'icon-sk004',
        title:'财政云服务',
        path:'selectOtherUrlServlet',
        target:'_blank',
        level:1,
        children:[]
    };
    
var zaohui=
{
        id:'004',
        icon:'icon-sk005',
        title:'站立会',
        path:'',
        target:'right',
        level:1,
        children:[            
        	{id:'0041',level:2,icon:'',title:'站立会签到',path:'AddSignServlet',target:'right',children:[]},
            {id:'0042',level:2,icon:'',title:'签到列表查询',path:'selectSignServlet',target:'right',children:[]}
        ]
    }; 

var ribao=
{
        id:'005',
        icon:'icon-sk007',
        title:'工作日报',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0051',level:2,icon:'',title:'工作日报添加',path:'User/addversion.jsp',target:'right',children:[]},
            {id:'0052',level:2,icon:'',title:'工作日报查询',path:'selectVersionServlet',target:'right',children:[]}
        ]
};

var jiabanchuchai=
{
        id:'006',
        icon:'icon-sk007',
        title:'加班+出差',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0061',level:2,icon:'',title:'加班情况添加',path:'over_time/addovertime.jsp',target:'right',children:[]},
            {id:'0062',level:2,icon:'',title:'加班情况查询',path:'selectOvertimeServlet',target:'right',children:[]},
            {id:'0063',level:2,icon:'',title:'出差情况添加',path:'evection/addevection.jsp',target:'right',children:[]},
            {id:'0064',level:2,icon:'',title:'出差情况查询',path:'selectEvectionServlet',target:'right',children:[]}
            ]
};

var qingjia=
{
        id:'007',
        icon:'icon-sk007',
        title:'请假管理',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0071',level:2,icon:'',title:'请假情况添加',path:'leave/addleave.jsp',target:'right',children:[]},
            {id:'0072',level:2,icon:'',title:'请假情况查询',path:'selectLeaveServlet',target:'right',children:[]}
            ]
};

var ziyuan=
{
        id:'008',
        icon:'icon-sk002',
        title:'资源情况汇总',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0081',level:2,icon:'',title:'测试情况统计',path:'selectTestServlet',target:'right',children:[]},
            {id:'0082',level:2,icon:'',title:'个人情况统计',path:'selectPersonServlet2',target:'right',children:[]}
            ]
};

var testshenqing=
{
        id:'009',
        icon:'icon-sk002',
        title:'测试申请汇总',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'091',level:2,icon:'',title:'测试申请',path:'TestApplicationServlet',target:'_blank',children:[]},
            {id:'092',level:2,icon:'',title:'版本测试汇总',path:'selectBanBenServlet?type=1',target:'right',children:[]},
            {id:'093',level:2,icon:'',title:'单元测试汇总',path:'AddDanYuanTestServlet?type=2',target:'right',children:[]},
            {id:'094',level:2,icon:'',title:'微服务管理(beta)',path:'UpdateWeiFuWuServlet?type=select',target:'right',children:[]}
            ]
};

var yonghu=
{
        id:'010',
        icon:'icon-sk006',
        title:'用户管理',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0101',level:2,icon:'',title:'用户添加',path:'guanliyuan/adduser.jsp',target:'right',children:[]},
            {id:'0102',level:2,icon:'',title:'测试部用户',path:'selectUserServlet',target:'right',children:[]},
            {id:'0103',level:2,icon:'',title:'文档用户',path:'selectFileUserServlet',target:'right',children:[]}
            ]
};
var wendang=
{
        id:'011',
        icon:'icon-sk006',
        title:'文档管理',
        path:'',
        target:'right',
        level:1,
        children:[
            {id:'0111',level:2,icon:'',title:'文件上传',path:'youzhishi/upload.jsp',target:'right',children:[]},
            {id:'0112',level:2,icon:'',title:'全部文档',path:'selectAllFileServlet',target:'right',children:[]},
            {id:'0113',level:2,icon:'',title:'测试用例评审',path:'selectTestCaseCheckServlet',target:'right',children:[]}
            ]
};


var data =[];
if('<%=userrole%>'=='管理员'){
	data = [shouye,tongzhi,caizhengyun,zaohui,ribao,jiabanchuchai,qingjia,ziyuan,testshenqing,yonghu,wendang];
}else if('<%=userrole%>'=='普通'){
	data = [shouye,tongzhi,caizhengyun,zaohui,ribao,jiabanchuchai,ziyuan,testshenqing,wendang];
}else if('<%=userrole%>'=='绩效'){
	data = [shouye];
}else{
	
}

</script>
<body>
    <div class="main">
		<!--左侧菜单-->
        <div class="left">
            <div class="logo">
                <span> <%=username%>&nbsp;&nbsp;&nbsp; </span>
                <i class="toggle-menu-icon icon-sk054" onclick="leftMenuToggleEvent(event)"></i>
            </div>
            <ul class="menu first"></ul>
        </div>
    </div>
<script src="js/jquery-1.8.1.min.js"></script>
<script src="js/DIVembed.js"></script>
<script src="js/underscore.js"></script>
<script src="js/mousewheel.js"></script>
<script src="js/frame.js"></script>
</body>
</html>