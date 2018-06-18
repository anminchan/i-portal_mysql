<%@ page session="false" contentType="text/html" %>
<html>
<meta http-equiv="refresh" content="5;url=mem.jsp">
<body>
<h1>Memory Monitor(GC Version)</h1>
<%= new java.util.Date() %><br><br>

<%
	String localIP = request.getRemoteAddr();
	String strScheme = request.getScheme();
	int strServerPort = request.getServerPort();
	boolean strSecure = request.isSecure();

	String serverIP = java.net.InetAddress.getLocalHost().getHostAddress();
	int i = serverIP.lastIndexOf(".");
	serverIP = serverIP.substring(i+1);

  // System.out.println(java.net.InetAddress.getLocalHost().getHostAddress()+"<br>");
   Runtime rt = Runtime.getRuntime();
   long free = rt.freeMemory();
   long total = rt.totalMemory();
   long max =  rt.maxMemory();
   out.println("ip: xxx.xxx.xxx."+serverIP+"<br><br>");
   out.println("Free  = " + (free/1024/1024) + " MB (" + free + " bytes)<br>");
   out.println("Total = " + (total/1024/1024) + " MB (" + total + " bytes)<br>");
   out.println("Max = " + (max/1024/1024) + " MB (" + max + " bytes)<br>");
   out.println("----------------------------------------------------<br><br>");
   
   //out.println("localIP:"+localIP+"<br>");
   out.println("strScheme:"+strScheme+"<br>");
   out.println("strServerPort:"+strServerPort+"<br>");
   out.println("strSecure:"+strSecure+"<br>");
  
   //System.gc();
   //rt = Runtime.getRuntime();
   //free = rt.freeMemory();
   //total = rt.totalMemory();
   //out.println("Free  = " + (free/1024/1024) + " MB (" + free + " bytes)<br>");
   //out.println("Total = " + (total/1024/1024) + " MB (" + total + " bytes)<br>");
  
%>

<%=application.getServerInfo() %>

Servlet Specification:

<%=application.getMajorVersion()%>.<%= application.getMinorVersion() %>


JSP version:

<%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>

</body></html>