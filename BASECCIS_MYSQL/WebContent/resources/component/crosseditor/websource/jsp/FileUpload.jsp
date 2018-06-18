<%@page contentType="text/html;charset=utf-8" %>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.regex.PatternSyntaxException"%>
<%@page import="java.net.*"%>
<%@page import="java.awt.*"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.FileUploadBase"%>
<%@include file="Util.jsp"%>
<%@include file="SecurityTool.jsp"%>
<%
	String encType = "utf-8"; 
	
	/*
	if(detectXSSEx(request.getParameter("licenseCheck")) != null){
		if(detectXSSEx(request.getParameter("licenseCheck")).toLowerCase().equals("true")){
			out.println(InetAddress.getLocalHost().getHostAddress());
			return;
		}
	}
	*/
	
	int maxSize = Integer.parseInt(request.getParameter("fileSizeLimit"));
	String defaultUPath = detectXSSEx(request.getParameter("defaultUPath"));
	String imageUPath = detectXSSEx(request.getParameter("fileUPath"));
	String fileUPathHost = "http://" + request.getHeader("host");
	String imagePhysicalPath = "";
%>
<%@include file="ImagePath.jsp"%>
<%
	String fileModify = ""; 
	if ( detectXSSEx(request.getParameter("filemodify")) != null)
		fileModify =  detectXSSEx(request.getParameter("filemodify"));
	
	String fileEditorFlag = "";
	if ( detectXSSEx(request.getParameter("fileEditorFlag")) != null)
		fileEditorFlag =  detectXSSEx(request.getParameter("fileEditorFlag"));
	
	String uploadFileSubDir = "";
	if ( detectXSSEx(request.getParameter("uploadFileSubDir")) != null)
		uploadFileSubDir =  detectXSSEx(request.getParameter("uploadFileSubDir"));
	
	String fileDomain = ""; 
	if ( detectXSSEx(request.getParameter("fileDomain")) != null)
		fileDomain =  detectXSSEx(request.getParameter("fileDomain"));

	String useExternalServer = "";
	if ( detectXSSEx(request.getParameter("useExternalServer")) != null)
		useExternalServer =  detectXSSEx(request.getParameter("useExternalServer"));

	
	String fileTemp = "";
	String scriptValue = "";
	String fileRealPath = "";
	String saveFolder = "";
	String returnParam ="";
	String scriptTag = "";
	String ContextPath = request.getContextPath();
	String ServerName = request.getServerName();
	
	ServletContext context = getServletConfig().getServletContext();

	if (!imageUPath.equals("")) {
		if (imageUPath.length() > 7) {
			if (imageUPath.substring(0, 7).equals("http://")) {
				fileTemp = imageUPath.substring(7);
				imageUPath = fileTemp.substring(fileTemp.indexOf("/"));
				fileUPathHost = "http://" + fileTemp.substring(0, fileTemp.indexOf("/"));
			}
			else if (imageUPath.substring(0, 8).equals("https://")) {
				fileTemp = imageUPath.substring(8);
				imageUPath = fileTemp.substring(fileTemp.indexOf("/"));
				fileUPathHost = "https://" + fileTemp.substring(0, fileTemp.indexOf("/"));
			}
			else if (!imageUPath.substring(0, 1).equals("/")) {
				scriptValue = executeFileScript(response, "invalid_path", "", useExternalServer, fileDomain, fileEditorFlag);
				response.getWriter().println(scriptValue);
				return;
			}
		} else {
			if (!imageUPath.substring(0, 1).equals("/")) {
				scriptValue = executeFileScript(response, "invalid_path", "" , useExternalServer, fileDomain, fileEditorFlag);
				response.getWriter().println(scriptValue);
				return;
			}
		}
	} else {
		if (defaultUPath.length() > 7) {
			if (defaultUPath.substring(0, 7).equals("http://")) {
				fileTemp = defaultUPath.substring(7);
				imageUPath = fileTemp.substring(fileTemp.indexOf("/"));
			}
			else if (defaultUPath.substring(0, 8).equals("https://")) {
				fileTemp = defaultUPath.substring(8);
				imageUPath = fileTemp.substring(fileTemp.indexOf("/"));
			} else if (defaultUPath.substring(0, 1).equals("/"))
				imageUPath = defaultUPath;
			else {
				scriptValue = executeFileScript(response, "invalid_path", "" , useExternalServer, fileDomain, fileEditorFlag);
				response.getWriter().println(scriptValue);
				return;
			}
		} else {
			if (defaultUPath.substring(0, 1).equals("/"))
				imageUPath = defaultUPath;
			else {
				scriptValue = executeFileScript(response, "invalid_path", "", useExternalServer, fileDomain, fileEditorFlag);
				response.getWriter().println(scriptValue);
				return;
			}
		}
	}

	if (imageUPath.lastIndexOf("/") != imageUPath.length() - 1)
		imageUPath = imageUPath + "/";

	if (imagePhysicalPath.equals("")) {
		String DompaserValue = Dompaser(imageUPath);
		if (DompaserValue.equals("")) {
			imagePhysicalPath = context.getRealPath(imageUPath);

			// 2013.08.26 [2.0.5.23] mwhong tomcat8.0
			if(imagePhysicalPath == null && imageUPath != null && ContextPath != null){
				imagePhysicalPath = context.getRealPath(imageUPath.substring(ContextPath.length()));
			}

			if (!ContextPath.equals("") && !ContextPath.equals("/")) {
				File tempFileRealDIR = new File(imagePhysicalPath);
				if (!tempFileRealDIR.exists()){
					if (imageUPath.indexOf(ContextPath) != -1)
						imagePhysicalPath = context.getRealPath(imageUPath.substring(ContextPath.length()));
				}
			}
		}
		else
			imagePhysicalPath = DompaserValue;
	}
		
	File fileRealFolderWriteCheck = new File(imagePhysicalPath);
	if (!fileRealFolderWriteCheck.exists()) {
		scriptValue = executeFileScript(response, "invalid_path", "" , useExternalServer, fileDomain, fileEditorFlag);
		response.getWriter().println(scriptValue);
		return;
	}
	if (!fileRealFolderWriteCheck.canWrite()) {
		scriptValue = executeFileScript(response, "canWriteErr", imagePhysicalPath, useExternalServer, fileDomain, fileEditorFlag);
		response.getWriter().println(scriptValue);
		return;
	}

	if (imagePhysicalPath.lastIndexOf(File.separator) != imagePhysicalPath.length() - 1)
		imagePhysicalPath += File.separator;

	String filePhysicalPathsubFolder = imagePhysicalPath;
	File SaveSubFolder = new File(filePhysicalPathsubFolder + "upload");
	if(!SaveSubFolder.exists())
		SaveSubFolder.mkdir();
	filePhysicalPathsubFolder += "upload" + File.separator;
	File DeleteTempFolder = null;
	
	try {
		String tempFileFolder = "";

		if (uploadFileSubDir.equals("false") && !imageUPath.equals(""))
			tempFileFolder = tempFolderCreate(imagePhysicalPath);
		else
			tempFileFolder = imagePhysicalPath;
					
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if (isMultipart) {
			String realDir = filePhysicalPathsubFolder;
			DiskFileItemFactory factory = new DiskFileItemFactory();                                   
			factory.setSizeThreshold(2 * 1024 * 1024); 
			ServletFileUpload upload = new ServletFileUpload(factory);                               
			upload.setSizeMax(-1); 
			upload.setHeaderEncoding("utf-8");
			List items = upload.parseRequest(request);       
			Iterator iter=items.iterator();                                                                            

			
			String fileMaxCount = "";
			String fileTitle = "";
			String fileId = "";
			String fileKind = "";
			String fileTempFName = "";
			String fileUNameType = "";
			String editorFrame = "";
			String filename = "";
			String type = "";

			while(iter.hasNext()){
				FileItem fileItem = (FileItem) iter.next();    
				if(fileItem.isFormField()){          
						if( fileItem.getFieldName().equals("fileMaxCount") ) fileMaxCount =  toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("fileTitle") ) fileTitle = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("fileId") ) fileId = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("fileKind") ) fileKind = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("fileTempFName") ) fileTempFName = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("fileUNameType") ) fileUNameType = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("editorFrame") ) editorFrame = toString(fileItem.getString("utf-8"));
													
				} else { 
					if(fileItem.getSize()>0) {   
						if(fileItem.getSize() > maxSize){
							scriptValue = executeFileScript(response, "invalid_size", Integer.toString(maxSize), useExternalServer, fileDomain, fileEditorFlag);
		
							response.getWriter().println(scriptValue);
							return;
						}
						filename = fileItem.getName();
						if (filename.lastIndexOf("\\") != -1) {
							filename = filename.substring(filename.lastIndexOf("\\"), filename.length());
						}
						type = fileItem.getContentType();
						
						
						if (filename.endsWith(".jsp") || filename.endsWith(".js") || filename.endsWith(".html") || filename.endsWith(".htm")) {
							scriptValue = executeFileScript(response, "invalid_file", "prohibited : jsp, js, html, htm", useExternalServer, fileDomain, fileEditorFlag);
							response.getWriter().println(scriptValue);
							return;
						}

						try{
							File uploadedFile=new File(realDir,filename); 
							fileItem.write(uploadedFile);
							fileItem.delete(); 
							DeleteTempFolder = uploadedFile;
						}catch(IOException ex) {
							System.out.println("An internal exception occured!");
						} 
					}
				}
			}
			String fileTempName = "";
			String fileKindSubFolder = ""; 

			fileKindSubFolder = "files";
			if (fileUNameType.equals("real")) 
				fileTempName = filename.substring(0, filename.lastIndexOf("."));
			else if(fileUNameType.equals("random"))
				fileTempName = fileNameTimeSetting();
			else {
				//fileTempName = fileTempFName;
				fileTempName = filename.substring(0, filename.lastIndexOf("."));
				sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
				byte[] keyByte = fileTempName.getBytes("utf-8");
				fileTempName = encoder.encode(keyByte);

				if (fileTempName.indexOf("/") != -1)
					fileTempName = fileTempName.replaceAll("/", "==NamOSeSlaSH=="); 
			}
			String realFileName = fileTempName.replace(' ', '_');
			String fileCheck =filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
			String typeCheck = type.substring(0,type.indexOf("/")); 
/*
			if (!isImageValid("file", fileCheck)) {
				if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
					tempFolderDelete(tempFileFolder);

				scriptValue = executeFileScript(response, "invalid_file", getImageKind("file"), useExternalServer, fileDomain, fileEditorFlag);
				response.getWriter().println(scriptValue);
				return;
			}
*/
			if(uploadFileSubDir.equals("false")) { 
				if(imageUPath.equals("")) {
					File fileSaveSubFolder = new File(imagePhysicalPath + fileKindSubFolder);
					if(!fileSaveSubFolder.exists())
						fileSaveSubFolder.mkdir();
					imagePhysicalPath += fileKindSubFolder + File.separator;
				}
			} else {
				File fileSaveSubFolder = new File(imagePhysicalPath + fileKindSubFolder);
				if(!fileSaveSubFolder.exists())
					fileSaveSubFolder.mkdir();
				imagePhysicalPath += fileKindSubFolder + File.separator;

				saveFolder = getChildDirectory(imagePhysicalPath, fileMaxCount); 
				
				if (saveFolder.equals("")) {	
					if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
						tempFolderDelete(tempFileFolder);

					scriptValue = executeFileScript(response, "invalid_path", "", useExternalServer, fileDomain, fileEditorFlag);
					response.getWriter().println(scriptValue);
					return;
				} else
					imagePhysicalPath += saveFolder;	
			}
			String filenamecheck = checkFileUniqueName(realFileName, imagePhysicalPath, fileCheck);

			String imgLinkParams = "";
			String urlFilePath = fileUPathHost + imageUPath;

			if(uploadFileSubDir.equals("false")) {
				if(imageUPath.equals(""))
					urlFilePath += fileKindSubFolder + File.separator;
			} else
				urlFilePath += fileKindSubFolder + File.separator + saveFolder + File.separator;
			urlFilePath = urlFilePath.replace('\\', '/');

            filenamecheck = filenamecheck.replace("\\", "");

			urlFilePath += filenamecheck;
			imgLinkParams = urlFilePath; 
	
			if (fileTitle == null)
				fileTitle ="";
			if (fileId == null)
				fileId ="";
			if (editorFrame == null)
				editorFrame ="";


			returnParam = "{";
			returnParam += "\"fileURL\":\"" + urlFilePath.replaceAll("'", "\\\\\"") + "\",";
			returnParam += "\"fileTitle\":\"" + fileTitle + "\",";
			returnParam += "\"fileId\":\"" + fileId + "\",";
			returnParam += "\"fileKind\":\"" + fileKind + "\",";
			returnParam += "\"fileType\":\"" + fileCheck + "\",";
			if (fileModify.equals("true"))
				returnParam += "\"fileModify\":\"true\",";
			returnParam += "\"editorFrame\":\"" + editorFrame + "\"";
			returnParam += "}";	
			
			String moveFilePath = imagePhysicalPath + File.separator + filenamecheck;
			int check = fileCopy(filePhysicalPathsubFolder + filename, moveFilePath);

			if(DeleteTempFolder != null){
				DeleteTempFolder.delete();
			}

			if (check == 1) {
				if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
					tempFolderDelete(tempFileFolder);
				if (SaveSubFolder.exists()){
					SaveSubFolder.delete();
				}
				
				scriptValue = executeFileScript(response, "success", returnParam, useExternalServer, fileDomain, fileEditorFlag);
				response.getWriter().println(scriptValue);
				return;
			} else {
				if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
					tempFolderDelete(tempFileFolder);

				scriptValue = executeFileScript(response, "fileCopyFail", "", useExternalServer, fileDomain, fileEditorFlag);	
				response.getWriter().println(scriptValue);
				return;			
			}
		}else{
			response.getWriter().println("not encoding type multipart/form-data");
		}
	} catch (IOException ioe) {
		scriptValue = executeFileScript(response, "invalid_size", Integer.toString(maxSize), useExternalServer, fileDomain, fileEditorFlag);
		
		response.getWriter().println(scriptValue);
		return;
	} catch (org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException e) {
		scriptValue = executeFileScript(response, "invalid_size", Integer.toString(maxSize), useExternalServer, fileDomain, fileEditorFlag);

        response.getWriter().println(scriptValue);
		return;
    } catch (RuntimeException e) {	
		String messageText = "RuntimeException";
		messageText = "<System Error>" + messageText;
		
		scriptValue = executeFileScript(response, "", messageText, useExternalServer, fileDomain, fileEditorFlag);
		response.getWriter().println(scriptValue);
		return;
	}

%>
