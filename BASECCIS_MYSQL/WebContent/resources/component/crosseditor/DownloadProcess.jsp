<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="com.namo.crossuploader.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>

<%
	System.out.println("◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆");
	out.clear(); 
	FileDownload fileDownload = new FileDownload(request, response); 
	
	try { 
		String fileId = request.getParameter("CD_FILE_ID"); 
		String filePath = request.getParameter("filePath"); 
		System.out.println("filePath◆◆◆"+filePath);

		/**
		* 다운로드 할 파일 경로 설정
		* DB 등에 저장된 파일의 정보를 가져옵니다. 샘플에서는 아래 파일들이 존재하는 것을 가정합니다.
		*/ 
		String fileNameAlias = ""; 
		filePath = request.getRealPath(filePath);
		if(fileId.compareTo("FILEID_0001") == 0) 
			fileNameAlias = "namo_watermark.gif"; 
		else if(fileId.compareTo("FILEID_0002") == 0) 
			fileNameAlias = "photoeditor_msg_title.gif"; 
		else if(fileId.compareTo("FILEID_0003") == 0)
			fileNameAlias = "video.gif"; 
		else 
			throw new Exception("다운로드 할 파일이 업습니다."); 
    
		filePath += (File.separator + fileNameAlias); 

		// fileNameAlias는 웹서버 환경에 따라 적절히 인코딩 되어야 합니다.
		fileNameAlias = URLEncoder.encode(fileNameAlias, "UTF-8"); 
		 
		// attachment 옵션에 따라 파일 종류에 관계 없이 항상 파일 저장 대화상자를 출력할 수 있습니다. 
		boolean attachment = true;  
		// resumable 옵션에 따라 파일 이어받기가 가능합니다.
		// 클라이언트에서 이어받기 요청이 있어야 하며, 이어받기 요청이 없을 경우 일반 다운로드와 동일하게 동작합니다.<
		boolean resumable = true;  
		// filePath에 지정된 파일을 fileNameAlias 이름으로 다운로드 합니다. 
		fileDownload.startDownload(filePath, fileNameAlias, attachment, resumable); 
		
		// 다른 유형의 다운로드 함수들
		// startDownload(String filePath); 
		// startDownload(String filePath, boolean attachment); 
		// startDownload(String filePath, boolean attachment, boolean resumable); 
		// startDownload(String filePath, String fileNameAlias); 
		// startDownload(String filePath, String fileNameAlias, boolean attachment); 
		// startStreamDownload(InputStream inputStream, String fileNameAlias, long fileSize, boolean attachment); 
	}
	catch(CrossUploaderException ex) { 
		response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		System.out.println("다운로드 중 예외 발생 : " + ex.getMessage()); 
	}
	catch(Exception ex) { 
		response.setStatus(response.SC_INTERNAL_SERVER_ERROR);
		System.out.println("다운로드 중 예외 발생 : " + ex.getMessage()); 	
	}
%>