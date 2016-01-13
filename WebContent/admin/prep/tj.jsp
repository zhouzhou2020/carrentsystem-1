<%@ page language="java" import="java.util.*"  contentType="text/html;charset=gb2312"%>
<jsp:useBean id="sn" scope="page" class="com.bean.SystemBean" />
<jsp:useBean id="cb" scope="page" class="com.bean.ComBean" />
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String dir=sn.getDir();
%>
<HTML><HEAD><TITLE>后台操作区</TITLE>
<LINK href="<%=basePath %><%=dir %>/images/Admin_Style.css" type=text/css rel=stylesheet>
<LINK href="<%=basePath %><%=dir %>/images/style.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="<%=basePath %><%=dir %>/images/Common.js"></SCRIPT>
<STYLE type=text/css>
BODY {
	MARGIN-LEFT: 0px; BACKGROUND-COLOR: #ffffff
}
.STYLE1 {color: #ECE9D8}
</STYLE>
</HEAD>

<%
String message = (String)request.getAttribute("message");
	if(message == null){
		message = "";
	}
	if (!message.trim().equals("")){
		out.println("<script language='javascript'>");
		out.println("alert('"+message+"');");
		out.println("</script>");
	}
	request.removeAttribute("message");
%>
<%
	String user=(String)session.getAttribute("user");
	if(user==null){
		response.sendRedirect(path+"/error.jsp");
	}
	else{
		
%>
<BODY >
<TABLE  cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align="left" vAlign=top > 
<table width='100%' cellspacing='1' cellpadding='3' bgcolor='#CCCCCC' class="tablewidth">
     <tr class="head"> 
      <td align="center">编号</td>
      <td  align="center">汽车名称</td>
      <td  align="center">租金</td>
      <td  align="center">取车时间</td>
      <td  align="center">取车地点</td>
      <td  align="center">还车时间</td>
      <td  align="center">还车地点</td>
      <td  align="center">租车会员</td>
      <td  align="center">费用信息</td>
      <td  align="center">状态</td>  
    </tr>
    <%cb.setEVERYPAGENUM(12);float fff=0;
			int cou = cb.getMessageCount("select count(*) from zc  ");//得到信息总数			        
			String page1=request.getParameter("page");
			if(page1==null){
				page1="1";
			}
			session.setAttribute("busMessageCount", cou + "");
			session.setAttribute("busPage", page1);
			List pagelist1 = cb.getMessage(Integer.parseInt(page1),"select * from zc  order by id desc",9);
			session.setAttribute("qqq", pagelist1);
			int pageCount = cb.getPageCount(); //得到页数  
			session.setAttribute("busPageCount", pageCount + ""); 
			List pagelist3=(ArrayList)session.getAttribute("qqq"); 
			//List pagelist3=cb.getCom("select * from zc ",9);
    		if(!pagelist3.isEmpty()){
				for(int i=0;i<pagelist3.size();i++){
					List pagelist2 =(ArrayList)pagelist3.get(i);
			%> 
	<tr  class="trA" onMouseOver="this.className='trB'" onMouseOut="this.className='trA'"> 
      <td  align="center" style="border-bottom:1px dotted #ccc;"><%=i+1 %></td>
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=cb.getString("select  cm from qc where id='"+pagelist2.get(1).toString()+"'") %></td>
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=cb.getString("select  zj from qc where id='"+pagelist2.get(1).toString()+"'") %></td>
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=pagelist2.get(2).toString() %></td>
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=pagelist2.get(3).toString() %></td>
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=pagelist2.get(4).toString() %></td>
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=pagelist2.get(5).toString() %></td> 
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;"><%=pagelist2.get(6).toString() %></td>        
      <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;">
	  <% 
	  
	  java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");  
		String data=pagelist2.get(2).toString();
		String data2=pagelist2.get(4).toString();
 
		Date d1=formatter.parse(data);
		Date d2 = formatter.parse(data2); 
		long diff = d2.getTime() - d1.getTime();
		long days = diff / (1000 * 60 * 60 * 24); 
	   float f=98;String str="普通会员，享受9.8折优惠";
	  	int num=cb.getCount("select jf from member where username='"+pagelist2.get(6).toString()+"'");
	  	if(num<5000){str="普通会员，享受9.8折优惠，租车时间"+days+"天 ";f=98;}
	  	else if(num>=5000&&num<12000){str="银卡会员，享受9.8折优惠，租车时间"+days+"天 ";f=98; }
		else if(num>=12000){str="金卡会员，享受9.5折优惠，租车时间"+days+"天 ";f=95; }
		else if(num>=20000){str="白金卡会员，享受9折优惠，租车时间"+days+"天 ";f=90;} 
		float fyzj=(Float.parseFloat(cb.getString("select  zj from qc where id='"+pagelist2.get(1).toString()+"'"))/100)*f*days;
		fff+=fyzj;
	  %>
	  
	  <%=str+"当前费用："+fyzj+"元" %>
	  </td>
	  <td align="center" bgcolor="#FFFFFF"  style="border-bottom:1px dotted #ccc;">


<%if(pagelist2.get(7).toString().equals("已审核")){out.println("已审核");}else{ %>
<a href="<%=basePath %>ComServlet?method=shP&id=<%=pagelist2.get(0).toString()%>&fy=<%=fyzj%>"><%=pagelist2.get(7).toString() %></a><%} %></td>  
     
       
    </tr>
	
<%
	}} 
%>  
<tr  > 
      <td align="center" colspan=10>总计：<%=fff %> 元</td>  
    </tr>
 <tr bgcolor='#FFFFFF'>
	<td colspan='15' align='right'>
	<TABLE width="100%" border=0 align="right" cellPadding=0 cellSpacing=0>
     <TBODY>
     <TR align="right" >
	 <TD >
	 <form action="" method="post" name="form3">	
	 <input type="hidden" name="pageCount" value="<%= session.getAttribute("busPageCount").toString()%>" /><!--//用于给上面javascript传值-->
	 <input type="hidden" name="page" value="<%=session.getAttribute("busPage").toString()%>" /><!--//用于给上面javascript传值-->         
					<a href="#" onClick="gotop()"><img src="<%=basePath %>images/first.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;
		<a href="#" onClick="dopre()"><img src="<%=basePath %>images/pre.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;
		 共<%=session.getAttribute("busMessageCount").toString()%>条记录,共计<%=session.getAttribute("busPageCount").toString()%>页,当前第<%=session.getAttribute("busPage").toString()%>页&nbsp;&nbsp;&nbsp;
		<a href="#" onClick="donext()"><img src="<%=basePath %>images/next.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;
		<a href="#" onClick="golast()"><img src="<%=basePath %>images/last.gif" border="0" /></a>
	 第<input name="busjump" type="text" size="3" />页<a href="#" onClick="bjump()"><img src="<%=basePath %>images/jump.gif" border="0" /></a>&nbsp;&nbsp;&nbsp;
	 </form>
           </TD>
           </TR>
</table>
   </TD>
	</TR>	 
</TABLE>
</BODY>
<%} %>
</HTML>

<script type="text/JavaScript">
	function del()
	{
		pageform.submit(); 
	}
	
	function allch()
	{
		 var check = document.getElementsByName("checkit");
		 for(var i = 0; i < check.length; i++){
			 check[i].checked=document.getElementById("checkall").checked;
		 }
	}
	
	function gotop(){	//返回第一页
		form3.action="<%=basePath%>admin/prep/tj.jsp?page=1";
	    form3.submit();
	}
	
	function golast(){ //返回最后一页
	    if(form3.pageCount.value==0){//如果总页数为0，那么最后一页为1，也就是第一页，而不是第0页
	    form3.action="<%=basePath%>admin/prep/tj.jsp?page=1";
	    form3.submit();
		}else{
		form3.action="<%=basePath%>admin/prep/tj.jsp?page="+form3.pageCount.value;
	    	form3.submit();
		}
	}
	function dopre(){ //上一页
	  var page=parseInt(form3.page.value);
	  if(page<=1){
	    alert("已至第一页");
	  }else{
	    form3.action="<%=basePath%>admin/prep/tj.jsp?page="+(page-1);
	    form3.submit();
	  }
	}
	
	function donext(){//下一页
	  var page=parseInt(form3.page.value);
	  var pageCount=parseInt(form3.pageCount.value);
	  if(page>=pageCount){
	    alert("已至最后一页");
	  }else{
	    form3.action="<%=basePath%>admin/prep/tj.jsp?page="+(page+1);
	    form3.submit();
	  }
	}
	
	function bjump(){
		var pageCount=parseInt(form3.pageCount.value);
	  	if(fIsNumber(form3.busjump.value,"1234567890")!=1 ){
			alert("跳转文本框中只能输入数字!");
			form3.busjump.select();
			form3.busjump.focus();
			return false;
		}
	  	if(form3.busjump.value>pageCount){//如果跳转文本框中输入的页数超过最后一页的数，则跳到最后一页
			if(pageCount==0){	
		
				var url = "<%=basePath%>admin/prep/tj.jsp?page=1";
				form3.action=url;
				form3.submit();
			}
			else{
				var url = "<%=basePath%>admin/prep/tj.jsp?page="+pageCount;
				form3.action=url;
				form3.submit();
			}	
		}
	  	else if(form3.busjump.value<=pageCount){
			var page=parseInt(form3.busjump.value);
			if(page==0){
		    	page=1;//如果你输入的是0，那么就让它等于1
		    	form3.action="<%=basePath%>admin/prep/tj.jsp?page="+page;
		    	form3.submit();
	   		}else{
	      		form3.action="<%=basePath%>admin/prep/tj.jsp?page="+page;
	      		form3.submit();
	   		}
		}	  	
	}
	
	//****判断是否是Number.
	function fIsNumber (sV,sR){
		var sTmp;
		if(sV.length==0){ return (false);}
		for (var i=0; i < sV.length; i++){
			sTmp= sV.substring (i, i+1);
			if (sR.indexOf (sTmp, 0)==-1) {return (false);}
		}
		return (true);
	}
	
	</script>


