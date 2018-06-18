<%@page contentType="text/html;charset=utf-8" %>
<%@page import="java.util.*"%>
<%@page import="java.util.regex.PatternSyntaxException"%>
<%@page import="java.io.*"%>
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
			response.getWriter().println(InetAddress.getLocalHost().getHostAddress());
			return;
		}
	}
	*/
	int maxSize = 5242880;
	if(request.getParameter("imageSizeLimit") != null){
		maxSize = Integer.parseInt(detectXSSEx(request.getParameter("imageSizeLimit")));
	}
	String defaultUPath = detectXSSEx(request.getParameter("defaultUPath"));
	String imageUPath = detectXSSEx(request.getParameter("imageUPath"));
	String imageUPathHost = "http://" + request.getHeader("host");
	String imagePhysicalPath = "";
%>
<%@include file="ImagePath.jsp"%>
<%
	String imageModify = ""; 
	if (detectXSSEx(request.getParameter("imagemodify")) != null)
		imageModify = detectXSSEx(request.getParameter("imagemodify"));
	
	String imageEditorFlag = "";
	if (detectXSSEx(request.getParameter("imageEditorFlag")) != null)
		imageEditorFlag = detectXSSEx(request.getParameter("imageEditorFlag"));
	
	String uploadFileSubDir = "";
	if (detectXSSEx(request.getParameter("uploadFileSubDir")) != null)
		uploadFileSubDir = detectXSSEx(request.getParameter("uploadFileSubDir"));
	
	String imageDomain = ""; 
	if (detectXSSEx(request.getParameter("imageDomain")) != null)
		imageDomain = detectXSSEx(request.getParameter("imageDomain"));

	String useExternalServer = "";
	if (detectXSSEx(request.getParameter("useExternalServer")) != null)
		useExternalServer = detectXSSEx(request.getParameter("useExternalServer"));

	String checkPlugin = "";
	if (detectXSSEx(request.getParameter("checkPlugin")) != null) 
		checkPlugin = detectXSSEx(request.getParameter("checkPlugin"));	

	String fileType = "";
	if (detectXSSEx(request.getParameter("fileType")) != null) 
		fileType = detectXSSEx(request.getParameter("fileType"));	
		
	String imageTemp = "";
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
				imageTemp = imageUPath.substring(7);
				imageUPath = imageTemp.substring(imageTemp.indexOf("/"));
				imageUPathHost = "http://" + imageTemp.substring(0, imageTemp.indexOf("/"));
			}
			else if (imageUPath.substring(0, 8).equals("https://")) {
				imageTemp = imageUPath.substring(8);
				imageUPath = imageTemp.substring(imageTemp.indexOf("/"));
				imageUPathHost = "https://" + imageTemp.substring(0, imageTemp.indexOf("/"));
			}
			else if (!imageUPath.substring(0, 1).equals("/")) {
				scriptValue = executeScript(response, "invalid_path", "", useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
				response.getWriter().println(scriptValue);
				return;
			}
		} else {
			if (!imageUPath.substring(0, 1).equals("/")) {
				scriptValue = executeScript(response, "invalid_path", "" , useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
				response.getWriter().println(scriptValue);
				return;
			}
		}
	} else {
		if (defaultUPath.length() > 7) {
			if (defaultUPath.substring(0, 7).equals("http://")) {
				imageTemp = defaultUPath.substring(7);
				imageUPath = imageTemp.substring(imageTemp.indexOf("/"));
			}
			else if (defaultUPath.substring(0, 8).equals("https://")) {
				imageTemp = defaultUPath.substring(8);
				imageUPath = imageTemp.substring(imageTemp.indexOf("/"));
			} else if (defaultUPath.substring(0, 1).equals("/"))
				imageUPath = defaultUPath;
			else {
				scriptValue = executeScript(response, "invalid_path", "" , useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
				response.getWriter().println(scriptValue);
				return;
			}
		} else {
			if (defaultUPath.substring(0, 1).equals("/"))
				imageUPath = defaultUPath;
			else {
				scriptValue = executeScript(response, "invalid_path", "", useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
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
		scriptValue = executeScript(response, "invalid_path", "" , useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
		response.getWriter().println(scriptValue);
		return;
	}
	if (!fileRealFolderWriteCheck.canWrite()) {
		scriptValue = executeScript(response, "canWriteErr", imagePhysicalPath, useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
		response.getWriter().println(scriptValue);
		return;
	}

	if (imagePhysicalPath.lastIndexOf(File.separator) != imagePhysicalPath.length() - 1)
		imagePhysicalPath += File.separator;

	String imagePhysicalPathsubFolder = imagePhysicalPath;
	File SaveSubFolder = new File(imagePhysicalPathsubFolder + "upload");
	if(!SaveSubFolder.exists())
		SaveSubFolder.mkdir();
	imagePhysicalPathsubFolder += "upload" + File.separator;
	File DeleteTempFolder = null;
	
	try {
		String tempFileFolder = "";

		if (uploadFileSubDir.equals("false") && !imageUPath.equals(""))
			tempFileFolder = tempFolderCreate(imagePhysicalPath);
		else
			tempFileFolder = imagePhysicalPath;
					
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if (isMultipart) {
			String realDir = imagePhysicalPathsubFolder;
			DiskFileItemFactory factory = new DiskFileItemFactory();                                   
			factory.setSizeThreshold(2 * 1024 * 1024);   
			ServletFileUpload upload = new ServletFileUpload(factory);                               
			upload.setSizeMax(-1); 
			upload.setHeaderEncoding("utf-8");
			List items = upload.parseRequest(request);       
			Iterator iter=items.iterator();                                                                            

			
			String imageMaxCount = "";
			String imageTitle = "";
			String imageAlt = "";
			String imageWidth = "";
			String imageWidthUnit ="";
			String imageHeight = "";
			String imageHeightUnit = ""; 
			
			/*
			* 2013.03.28 [3.0] mwHong
			*
			* imageMarginSet
			* 
			*/
			String imageMarginLeft = "";
			String imageMarginLeftUnit ="";
			String imageMarginRight = "";
			String imageMarginRightUnit = ""; 
			String imageMarginTop = "";
			String imageMarginTopUnit ="";
			String imageMarginBottom = "";
			String imageMarginBottomUnit = ""; 
			
			String imageAlign = "";
			String imageId = "";
			String imageClass = "";
			String imageBorder = "";
			String imageKind = "";
			String imageTempFName = "";
			String imageUNameType = "";
			String imageUNameEncode = "";
			String imageViewerPlay = "";
			String imageOrgPath = "";
			String editorFrame = "";
			String filename = "";
			String type = "";

			while(iter.hasNext()){
				FileItem fileItem = (FileItem) iter.next();    
				if(fileItem.isFormField()){          
						if( fileItem.getFieldName().equals("imageMaxCount") ) imageMaxCount =  toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageTitle") ) imageTitle = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageAlt") ) imageAlt = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageWidth") ) imageWidth = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageWidthUnit") ) imageWidthUnit = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageHeight") ) imageHeight = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageHeightUnit") ) imageHeightUnit = toString(fileItem.getString("utf-8"));
						
						/*
						* 2013.03.28 [3.0] mwHong
						*
						* imageMarginSet
						* 
						*/
						if( fileItem.getFieldName().equals("imageMaginLeft") ) imageMarginLeft = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginLeftUnit") ) imageMarginLeftUnit = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginRight") ) imageMarginRight = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginRightUnit") ) imageMarginRightUnit = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginTop") ) imageMarginTop = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginTopUnit") ) imageMarginTopUnit = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginBottom") ) imageMarginBottom = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageMaginBottomUnit") ) imageMarginBottomUnit = toString(fileItem.getString("utf-8"));
						
						if( fileItem.getFieldName().equals("imageAlign") ) imageAlign = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageId") ) imageId = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageClass") ) imageClass = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageBorder") ) imageBorder = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageKind") ) imageKind = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageTempFName") ) imageTempFName = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageUNameType") ) imageUNameType = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageUNameEncode") ) imageUNameEncode = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageViewerPlay") ) imageViewerPlay = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("imageOrgPath") ) imageOrgPath = toString(fileItem.getString("utf-8"));
						if( fileItem.getFieldName().equals("editorFrame") ) editorFrame = toString(fileItem.getString("utf-8"));
													
				} else {  
					if(fileItem.getSize()>0) { 
						if(fileItem.getSize() > maxSize){
							scriptValue = executeScript(response, "invalid_size", Integer.toString(maxSize), useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
		
							response.getWriter().println(scriptValue);
							return;
						}
						filename = fileItem.getName();
						if (filename.lastIndexOf("\\") != -1) {
							filename = filename.substring(filename.lastIndexOf("\\")+1, filename.length());
						}
						if(checkPlugin.equals("false")) {	
							filename = fileNameTimeSetting()+"."+fileType;
						}
						type = fileItem.getContentType();

						if (filename != null) {
						  if (filename.endsWith(".jsp") || filename.endsWith(".js") || filename.endsWith(".html") || filename.endsWith(".htm")) {
							   scriptValue = executeScript(response, "invalid_image", "prohibited : jsp, js, html, htm", useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
							   response.getWriter().println(scriptValue);
							   return;
						   }
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
			String imageKindSubFolder = ""; 

			if (imageKind.toLowerCase().indexOf("flash") != -1)
				imageKindSubFolder = "flashes"; 	
			else if (imageKind.toLowerCase().indexOf("image") != -1)
				imageKindSubFolder = "images"; 	
			else
				imageKindSubFolder = "movies"; 
			if (imageUNameType.equals("real")) 
				fileTempName = filename.substring(0, filename.lastIndexOf("."));
			else if(imageUNameType.equals("random")){
				fileTempName = fileNameTimeSetting();
			}
			else {
				//fileTempName = imageTempFName;
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
			
			if (!isImageValid(imageKind, fileCheck)) {
				if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
					tempFolderDelete(tempFileFolder);

				scriptValue = executeScript(response, "invalid_image", getImageKind(imageKind), useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
				response.getWriter().println(scriptValue);
				return;
			}
			if(uploadFileSubDir.equals("false")) { 
				if(imageUPath.equals("")) {
					File imageSaveSubFolder = new File(imagePhysicalPath + imageKindSubFolder);
					if(!imageSaveSubFolder.exists())
						imageSaveSubFolder.mkdir();
					imagePhysicalPath += imageKindSubFolder + File.separator;
				}
			} else {
				File imageSaveSubFolder = new File(imagePhysicalPath + imageKindSubFolder);
				if(!imageSaveSubFolder.exists())
					imageSaveSubFolder.mkdir();
				imagePhysicalPath += imageKindSubFolder + File.separator;

				saveFolder = getChildDirectory(imagePhysicalPath, imageMaxCount); 
				
				if (saveFolder.equals("")) {	
					if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
						tempFolderDelete(tempFileFolder);

					scriptValue = executeScript(response, "invalid_path", "", useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
					response.getWriter().println(scriptValue);
					return;
				} else
					imagePhysicalPath += saveFolder;	
			}
			String filenamecheck = checkFileUniqueName(realFileName, imagePhysicalPath, fileCheck);	

			String imgLinkParams = "";
			String urlFilePath = imageUPathHost + imageUPath;

			if(uploadFileSubDir.equals("false")) {
				if(imageUPath.equals(""))
					urlFilePath += imageKindSubFolder + File.separator;
			} else
				urlFilePath += imageKindSubFolder + File.separator + saveFolder + File.separator;
			urlFilePath = urlFilePath.replace('\\', '/');

			if (imageViewerPlay.equals("true")) {
				String curUrlPath = request.getRequestURI();


				curUrlPath = curUrlPath.substring(0, curUrlPath.lastIndexOf("/"));
				String imgLinkPathRename = imageUPathHost + curUrlPath + "/ImageViewer.jsp?imagesrc=";
				
				if (imageUNameType.equals("real")) {
					String enFileName = filenamecheck.substring(0, filenamecheck.lastIndexOf("."));
					String enFileExt = filenamecheck.substring(filenamecheck.lastIndexOf("."));
					sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();
					byte[] keyByte = enFileName.getBytes("utf-8");
					imgLinkParams = URLEncoder.encode(urlFilePath + encoder.encode(keyByte).replaceAll("/", "==NamOSeSlaSH==") + enFileExt + "|" + imageUNameType);
					urlFilePath = imgLinkPathRename + imgLinkParams;
				} else {
					imgLinkParams = URLEncoder.encode(urlFilePath + filenamecheck + "|" + imageUNameType);
					urlFilePath = imgLinkPathRename + imgLinkParams;
				}
			} else {
				urlFilePath += filenamecheck;
				imgLinkParams = urlFilePath; 
			}
			if (imageOrgPath != null && !imageOrgPath.equals(""))
				imageOrgPath += "|" + urlFilePath;
	
			if (imageTitle == null)
				imageTitle ="";
			if (imageAlt == null)
				imageAlt ="";
			if (imageWidth == null)
				imageWidth ="";
			if (imageWidthUnit == null)
				imageWidthUnit = "";
			if (imageHeight == null)
				imageHeight ="";
			if (imageHeightUnit == null)
				imageHeightUnit = "";
				
			/*
			* 2013.03.28 [3.0] mwHong
			*
			* imageMarginSet
			* 
			*/	
			if (imageMarginLeft == null)
				imageMarginLeft ="";
			if (imageMarginLeftUnit == null)
				imageMarginLeftUnit = "";
			if (imageMarginRight == null)
				imageMarginRight ="";
			if (imageMarginRightUnit == null)
				imageMarginRightUnit = "";
			if (imageMarginTop == null)
				imageMarginTop ="";
			if (imageMarginTopUnit == null)
				imageMarginTopUnit = "";
			if (imageMarginBottom == null)
				imageMarginBottom ="";
			if (imageMarginBottomUnit == null)
				imageMarginBottomUnit = "";
				
				
			if (imageAlign == null)
				imageAlign ="";
			if (imageId == null)
				imageId ="";
			if (imageClass == null)
				imageClass = "";
			if (imageBorder == null)
				imageBorder ="";
			if (imageOrgPath == null)
				imageOrgPath ="";
			if (editorFrame == null)
				editorFrame ="";


			returnParam = "{";
			returnParam += "\"imageURL\":\"" + urlFilePath.replaceAll("'", "\\\\\"") + "\",";
			returnParam += "\"imageTitle\":\"" + imageTitle + "\",";
			returnParam += "\"imageAlt\":\"" + imageAlt + "\",";
			returnParam += "\"imageWidth\":\"" + imageWidth + "\",";
			returnParam += "\"imageWidthUnit\":\"" + imageWidthUnit + "\",";
			returnParam += "\"imageHeight\":\"" + imageHeight + "\",";
			returnParam += "\"imageHeightUnit\":\"" + imageHeightUnit + "\",";
			
			/*
			* 2013.03.28 [3.0] mwHong
			*
			* imageMarginSet
			*
			*/
			returnParam += "\"imageMarginLeft\":\"" + imageMarginLeft + "\",";
			returnParam += "\"imageMarginLeftUnit\":\"" + imageMarginLeftUnit + "\",";
			returnParam += "\"imageMarginRight\":\"" + imageMarginRight + "\",";
			returnParam += "\"imageMarginRightUnit\":\"" + imageMarginRightUnit + "\",";
			returnParam += "\"imageMarginTop\":\"" + imageMarginTop + "\",";
			returnParam += "\"imageMarginTopUnit\":\"" + imageMarginTopUnit + "\",";
			returnParam += "\"imageMarginBottom\":\"" + imageMarginBottom + "\",";
			returnParam += "\"imageMarginBottomUnit\":\"" + imageMarginBottomUnit + "\",";
			
			returnParam += "\"imageAlign\":\"" + imageAlign + "\",";
			returnParam += "\"imageId\":\"" + imageId + "\",";
			returnParam += "\"imageClass\":\"" + imageClass + "\",";
			returnParam += "\"imageBorder\":\"" + imageBorder + "\",";
			returnParam += "\"imageKind\":\"" + imageKind + "\",";
			returnParam += "\"imageOrgPath\":\"" + imageOrgPath + "\",";
			if(imageKind.equals("image")) {
				int oriWidth = 0;
				int oriHeight = 0;
				try {
					//2012.06.05 [2.0.4.16->2.0.4.17] nkpark heap memory
					File oriObj = new File(imagePhysicalPathsubFolder + filename);
					Image img = new ImageIcon(imagePhysicalPathsubFolder + filename).getImage();
					oriWidth = img.getWidth(null);
					oriHeight = img.getHeight(null);
				} catch(RuntimeException e) {
					System.out.println("An internal exception occured!");
				}
				
				returnParam += "\"imageOrgWidth\":\"" + oriWidth + "\",";
				returnParam += "\"imageOrgHeight\":\"" + oriHeight + "\",";
			}
			if (imageModify.equals("true"))
				returnParam += "\"imageModify\":\"true\",";
			returnParam += "\"editorFrame\":\"" + editorFrame + "\"";
			returnParam += "}";	
			
			String moveFilePath = imagePhysicalPath + File.separator + filenamecheck;
			int check = fileCopy(imagePhysicalPathsubFolder + filename, moveFilePath);

			if(DeleteTempFolder != null){
				DeleteTempFolder.delete();
			}

			if (check == 1) {
				if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
					tempFolderDelete(tempFileFolder);
				if (SaveSubFolder.exists()){
					SaveSubFolder.delete();
				}

				if (imageEditorFlag.equals("flashPhoto")) {
					scriptValue = "{";
					scriptValue += "\"result\":\"success\",";
					scriptValue += "\"imageURL\":\"" + urlFilePath + "\",";
					scriptValue += "\"addmsg\":" + returnParam;
					scriptValue += "}";
				} else{
					scriptValue = executeScript(response, "success", returnParam, useExternalServer, imageDomain, imageEditorFlag, checkPlugin);

					//response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE"); 
					//response.setHeader("Access-Control-Max-Age", "3600"); 
					//response.setHeader("Access-Control-Allow-Headers", "x-requested-with"); 
					response.setHeader("Access-Control-Allow-Origin", "*"); 	
				}
					
				response.getWriter().println(scriptValue);
				
				return;
			} else {
				if(uploadFileSubDir.equals("false") && !imageUPath.equals(""))
					tempFolderDelete(tempFileFolder);

				scriptValue = executeScript(response, "fileCopyFail", "", useExternalServer, imageDomain, imageEditorFlag, checkPlugin);	
				response.getWriter().println(scriptValue);
				return;			
			}
		}else{
				response.getWriter().println("not encoding type multipart/form-data");
		}
	} catch (IOException ioe) {
		scriptValue = executeScript(response, "invalid_size", Integer.toString(maxSize), useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
		
		response.getWriter().println(scriptValue);
		return;
	} catch (org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException e) {
		scriptValue = executeScript(response, "invalid_size", Integer.toString(maxSize), useExternalServer, imageDomain, imageEditorFlag, checkPlugin);

        response.getWriter().println(scriptValue);
		return;
    } catch (RuntimeException e) {	
		
		String messageText = "RuntimeException";
		messageText = "<System Error>" + messageText;
		
		scriptValue = executeScript(response, "", messageText, useExternalServer, imageDomain, imageEditorFlag, checkPlugin);
		response.getWriter().println(scriptValue);
		return;
	}

%>
