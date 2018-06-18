package kr.plani.ccis.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownloadView extends AbstractView {
	private static final Logger logger = LoggerFactory.getLogger(FileDownloadView.class);
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userAgent = request.getHeader("User-Agent");
		
		FileInputStream fileInputStream = null;
		
		try {
			if(model.get("downloadFile") != null) {
				File downloadFile = new File(model.get("downloadFile").toString());			

				// 파일다운로드를 위한 변수 설정
				String contentLength = downloadFile.length() > -1 ? String.valueOf(downloadFile.length()) : "0";
				String contentType = model.get("contentType") != null ? model.get("contentType").toString() : "application/octet-stream";
				String contentTransferEncoding = model.get("contentTransferEncoding") != null ? model.get("contentTransferEncoding").toString() : "binary";
				String contentDisposition = model.get("downloadFileName") != null ? model.get("downloadFileName").toString() : downloadFile.getName();

				// 파일다운로드 처리
				if(downloadFile.isFile() && downloadFile.exists()) {
					
					response.setContentType(contentType);
					response.setBufferSize(1024 * 4);
					response.setHeader("Content-Length", contentLength);
					response.setHeader("Content-Transfer-Encoding", contentTransferEncoding);
					
					if (userAgent.indexOf("MSIE 5.5") > -1) {
						response.setContentType("doesn/matter");
						response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(contentDisposition, "UTF-8").replace("+", "%20") + "\";");
					} else if (userAgent.indexOf("MSIE") > -1) {
						response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(contentDisposition, "UTF-8").replace("+", "%20") + "\";");
					} else {
						response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(contentDisposition, "UTF-8").replace("+", "%20") + "\";");
					}
					
					fileInputStream = new FileInputStream(downloadFile.getCanonicalPath());
					
					if(fileInputStream != null) {
						FileCopyUtils.copy(fileInputStream,  response.getOutputStream());
						response.flushBuffer();
						response.getOutputStream().flush();
						fileInputStream.close();
					}
				} else {
					//logger.info("fileNotFoundMessage >> 1");
					fileNotFoundMessage(model, request, response);
					logger.info("fileNotFoundMessage1 >> " + model.get("downloadFile").toString());
				}
			} else {
				//logger.info("fileNotFoundMessage >> 2");
				fileNotFoundMessage(model, request, response);
				logger.info("fileNotFoundMessage2 >> " + model.get("downloadFile"));
			}
		} catch (Exception e) {
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		} finally {
			fileInputStream = null;
		}
	}
	
	private void fileNotFoundMessage(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ServletOutputStream sos = null;
		
		try {
			sos = response.getOutputStream();
			response.setContentType("text/html; charset=utf-8");
			response.setCharacterEncoding("utf-8");
			sos.println("<html>");
			sos.println("<head><title>file not found error page </title></head>");
			sos.println("<script type='text/javascript'>");
			sos.println("alert('This file is not found');");
			sos.println("history.back(-1);");
			sos.println("</script>");
			sos.println("</html>");			
			sos.flush();
		} catch (IOException e) {
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");
		} finally {
			if(sos != null) {
				sos.flush();
				sos.close();
			}
		}
	}
}
