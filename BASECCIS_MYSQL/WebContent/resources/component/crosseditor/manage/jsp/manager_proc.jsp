<%@page contentType="text/html;charset=utf-8" %>

<%@include file = "./include/session_check.jsp"%>
<%@include file="manager_util.jsp"%>
<%
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

	if (!ContextPath.equals("") && !ContextPath.equals("/")){
		File tempFileRealDIR = new File(fileRealFolder);
		if(!tempFileRealDIR.exists()){
			if (urlPath.indexOf(ContextPath) != -1){
				String rename_image_temp = urlPath.substring(ContextPath.length());
				fileRealFolder = context.getRealPath(rename_image_temp);
			}
		}
	}
	
	if (fileRealFolder.lastIndexOf(File.separator) != fileRealFolder.length() - 1){
		fileRealFolder = fileRealFolder + File.separator;
	}

	String filenames = xmlUrl(fileRealFolder);
	int count = 0;
	Element root = configXMlLoad(filenames);
	
	String xmlText = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
	String StartTag = root.getNodeName();
	String userAddMenuList [] = detectXSSEx(request.getParameter("UserAddMenu")).split("\\|\\|");

	List parent = childrenList(root);

	xmlText += "<" + StartTag + ">\n";
	for(int i=0;i<parent.size();i++){

		xmlText += "	<" + parent.get(i) + ">\n";
		
		NodeList child = root.getElementsByTagName((String)parent.get(i));
		Node node = child.item(0);
		
		List children = childrenList(node);

		for(int j=0;j<children.size();j++){

			if(children.get(j).equals("AddMenu")){

				if(count == 0){
					for(int k=0; k < userAddMenuList.length;k++){
 						xmlText += "		<" + children.get(j) + ">" + userAddMenuList[k] + "</" + children.get(j) + ">\n";
					}
					count = 1;
				}
				
			}
			else if(detectXSSEx(request.getParameter((String)children.get(j))) == null){	
				xmlText += "		<" + children.get(j) + "></" + children.get(j) + ">\n";
			}
			else{ 
				xmlText += "		<" + children.get(j) + ">" + detectXSSEx(request.getParameter((String)children.get(j))) + "</" + children.get(j) + ">\n";
			}
		}
		xmlText += "	</" + parent.get(i) + ">\n";
	}
	xmlText += "</" + StartTag + ">\n";
	
	String result_sc = "";
	String fileName = " (config/xmls/Config.xml)";
	boolean check =  xmlCreate(xmlText,filenames);
	
	if(check){
		result_sc = "<script type='text/javascript' language='javascript'>alert(pe_bE.pe_pi); window.document.location.href='manager_setting.jsp?Tab=" + detectXSSEx(request.getParameter("Tab")) + "';</script>";
	}
	else{
		result_sc = "<script>alert(pe_bE.pe_lh+'" + fileName + "');  history.back();</script> ";
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