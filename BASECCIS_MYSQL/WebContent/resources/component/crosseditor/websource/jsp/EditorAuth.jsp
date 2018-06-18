<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*"%>
<%@page import ="java.net.*"%>
<%@page import="java.util.regex.PatternSyntaxException"%>
<%	String ce_domain = ""; String ce_exp = ""; %>
<%@include file="EditorInformation.jsp"%>
<%@include file="Util.jsp"%>
<%@include file="SecurityTool.jsp"%>
<%
	String check_uri = "http://crosseditor.namo.co.kr/application/CELicenseCheck.php";
	String authHostInfo = "";
	String conkey = detectXSSEx(request.getParameter("connection"));
	
	if(conkey != null && conkey.equals("ServerGr")){
		authHostInfo = InetAddress.getLocalHost().getHostAddress();
	}
	else {
		authHostInfo =  request.getHeader("host");
	}
	
	check_uri += "?editordomain=" + authHostInfo;
	check_uri += "&serial=" + ce_serial;
	check_uri += "&editorkey=" + ce_editorkey;
	String editorkey = request.getParameter("editorkey");	
	String conval = ce_domain + "|" + ce_use + "|" + ce_exp + "|" + authHostInfo;

	if (editorkey != "" && editorkey != null){
		if (editorkey.equals("ProductInfo")){
			String returnParam = ce_company + "|";
			returnParam += ce_use + "|";
			returnParam += ce_serial + "|";
			returnParam += ce_lkt;
			out.println(detectXSSEx(returnParam));
		}else{
			if (createEncodeEditorKey(ce_editorkey).equals(editorkey)){
				out.println("SUCCESS");
			}else{
				out.println("NULL");
			}
		}
	}else{
		conval = ce_domain + "|" + ce_exp + "|" + authHostInfo + "|" + createEncodeEditorKey(ce_editorkey);
		out.println(conval);
	}

%>