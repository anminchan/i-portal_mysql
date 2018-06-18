<%@page contentType="text/html;charset=utf-8" %>
<%@include file = "./include/session_check.jsp"%>
<%@include file="manager_util.jsp"%>

<%
	String encrypt = encrypt("SHA1", request.getParameter("passwd"));
	String fileName = " (manageInfo.jsp)";
	String result_sc = "";
	String fileRealFolder = "";

	String ContextPath = request.getContextPath();
	String urlPath = rootFolderPath(request.getRequestURI());

	ServletContext context = getServletConfig().getServletContext();

	fileRealFolder = context.getRealPath(urlPath);

	//2013.08.26 [2.0.5.23] mwhong tomcat8.0 에서 getRealPath가 null을 리턴하여 수정
	if(fileRealFolder == null && urlPath != null && ContextPath != null){
		fileRealFolder = context.getRealPath(urlPath.substring(ContextPath.length()));
	}

	if (ContextPath != null && !ContextPath.equals("") && !ContextPath.equals("/")){
		File tempFileRealDIR = new File(fileRealFolder);
		if(!tempFileRealDIR.exists()){
			if (urlPath != null && urlPath.indexOf(ContextPath) != -1){
				String rename_image_temp = urlPath.substring(ContextPath.length());
				fileRealFolder = context.getRealPath(rename_image_temp);
			}
		}
	}
	
	if (fileRealFolder.lastIndexOf(File.separator) != fileRealFolder.length() - 1){
		fileRealFolder = fileRealFolder + File.separator;
	}

	String manageInfoStr = manageInFo_text(fileRealFolder);

	String u_pass = manageInfoStr.substring(manageInfoStr.indexOf(";"));
	u_pass = u_pass.substring(u_pass.indexOf("\"") + 1, u_pass.lastIndexOf("\""));

	if(encrypt.equals(u_pass))
	{
			//encrypt = encrypt("SHA1", request.getParameter("newPasswd").replaceAll(" ",""));
			encrypt = encrypt("SHA1", request.getParameter("newPasswd"));

			String filenames = fileRealFolder + "manageInfo.jsp";
			String xmlText = "<%\n";
			xmlText += "	String u_id =\"" + request.getParameter("u_id") + "\";\n";
			xmlText += "	String u_pass =\"" + encrypt + "\";\n";
			xmlText += "%" + ">";
			
			boolean check =  xmlCreate(xmlText,filenames);
			if(check)
			{
				session.invalidate(); 
				result_sc = "<script>alert(pe_bE.pe_pi); window.document.location.href='../index.html';</script>";
			}
			else
			{
				result_sc = "<script>alert(pe_bE.pe_lh + '" + fileName + "');  history.back();</script> ";
			}
	}
	else{
		result_sc = "<script>alert(pe_bE.pe_oZ);location.href='account_setting.jsp';</script>";
	}

%>

<html>
<head>
	<script type="text/javascript" src="../manage_common.js"></script>
	<script type="text/javascript" src="../../js/namo_cengine.js"></script>
</head>
<body>

<% 
	out.println(result_sc);
%>
</body>
</html>