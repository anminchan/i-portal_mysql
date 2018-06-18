<%@page contentType="text/html;charset=utf-8" %>
<%@include file = "./include/session_check.jsp"%>
<%
	session.invalidate();
	response.sendRedirect("../index.html");
%>
