<%@page contentType="text/html;charset=utf-8" %>
<%@include file = "manager_util.jsp"%>
<%@include file = "./include/session_check.jsp"%>

<%
	String result_sc = "";
	String result_pop = "";
	String fileRealFolder = "";
	String ContextPath = request.getContextPath();
	String urlPath = rootFolderPath(request.getRequestURI());
	urlPath = urlPath.substring(0, urlPath.indexOf("manage/jsp"));

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
	
	String update_xml_url = fileRealFolder + "update/config/config.xml";
	String before_xml_url = fileRealFolder + "config/xmls/config.xml";
	String resultStrSc = "<script language=\"javascript\">window.document.location.href='manager_setting.jsp';</script>";
	File update_xml = new File(update_xml_url);
	
	if(update_xml.exists()){
		boolean update_check_value = update_check(update_xml_url,before_xml_url);
		if(update_check_value){
			result_pop = "<script language=\"javascript\">alert(pe_bE.pe_yq)</script>";
			String saveCheck = update_xml(update_xml_url,before_xml_url);
			if(saveCheck.equals("sucess")){
				result_sc = resultStrSc;
			}
			else{
				result_sc = "<script language=\"javascript\">alert(pe_bE.pe_oo+ pe_bE.pe_lh );window.document.location.href='manager_setting.jsp';</script>";
			}
		}
		else{
			result_sc = resultStrSc;
		}
	}
	else{
		result_sc = resultStrSc;
	}
%>

<html>
	<head>
		<script type="text/javascript" src="../manage_common.js"></script>
		<script type="text/javascript" language="javascript" src="../../js/namo_cengine.js"></script>
	</head>
	<body>
		<%= result_pop%>
		<%= result_sc%>
	</body>
</html>