<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*"%>
<%@page import="java.util.regex.PatternSyntaxException"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.*"%>
<%@include file="SecurityTool.jsp"%>
<%
	try {
		String userDomain = URLDecoder.decode(detectXSSEx(request.getParameter("userdomain")), "UTF-8");
		String funcname = URLDecoder.decode(detectXSSEx(request.getParameter("funcname")), "UTF-8");
		String param = detectXSSEx(request.getParameter("param"));
		param = param.replace("%", "<namo-percent>");
		param = URLDecoder.decode(param, "UTF-8");
		param = param.replace("<namo-percent>", "%");
		param = param.replace("&#39;","'");
		param = param.replace("&lt;","<");
		param = param.replace("&gt;",">");

		String returnValue = "<scr" + "ipt language='javascript' type='text/javascript'>" + userDomain + "parent.window." + funcname + "(" + param + ");</scr" + "ipt>";
		response.getWriter().println(returnValue);
	}catch (UnsupportedEncodingException e1) {
		response.getWriter().println("UTF-8 not supported");
	}catch (IOException e2) {
        response.getWriter().println("IO exception occured!");
    }catch (Exception e) {
		response.getWriter().println("An internal exception occured!");
	}
	
	return;
%>