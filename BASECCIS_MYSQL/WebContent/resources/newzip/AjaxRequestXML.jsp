<%@ page language="java" import="java.io.*,java.net.*" 
	contentType="text/xml; charset=utf-8"    
pageEncoding="utf-8"%><%

URL url = new URL(request.getParameter("getUrl"));
URLConnection connection = url.openConnection();
 connection.setDoOutput(true);
 connection.setRequestProperty("CONTENT-TYPE","text/xml"); 
    BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream(),"utf-8"));
    String inputLine;
    String buffer = "";
    System.out.println("ajax1");
    while ((inputLine = in.readLine()) != null){
     	buffer += inputLine.trim();
     	System.out.println("ajax2"+buffer);
    }
    System.out.println("ajax3");
    in.close();
%><%=buffer%>