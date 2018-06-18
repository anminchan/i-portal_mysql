package kr.plani.ccis.common.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import kr.plani.ccis.ips.domain.site.Files;

@Component("namoCrossFile")
public class NamoCrossFile {

	private static final Logger logger = LoggerFactory.getLogger(NamoCrossFile.class);
	
	@Value("#{config['upload.dir']}")
	private String uploadDir;
	
	/*****************************************************************
	* fileUploadAttempt 파일 업로드 공통 모듈 DML 생성용
	* @param request
	* @param strComponentName
	* @return
	*******************************************************************/
	public Object fileUploadAttempt(Object obj, HttpServletRequest request){	
		Files uploadFiles = new Files();
		List<Files> uploadFileList = new ArrayList();
		
		try { 
			int nCnt = 0;
			String strSplit = "";
			StringBuffer sbUserFileName = new StringBuffer();
			StringBuffer sbSystemFileName = new StringBuffer();
			StringBuffer sbFilePath = new StringBuffer();
			StringBuffer sbFileExtension = new StringBuffer();
			StringBuffer sbFileSize = new StringBuffer();
			
			// 첨부파일 JSON정보
			JSONParser jsonParser = new JSONParser();
			Object jsonObj = null;
	 		JSONArray jsonArray = null;
			JSONObject jsonObject = null;
			
			/**
			* addUploadedFile로 추가한 파일 정보를 처리합니다.
			* 샘플에서는 JSON 타입으로 데이터를 교환하고 있습니다. 필요 시 다른 형식으로 조합해서 사용하실 수 있습니다.
			*/
			if(StringUtil.isNotBlank(request.getParameter("modifiedFilesInfo"))) {
				String modifiedFilesInfo = request.getParameter("modifiedFilesInfo"); 
				jsonObj = jsonParser.parse(modifiedFilesInfo); 
				jsonArray = (JSONArray)jsonObj; 
				if(jsonArray.size() > 0){
					for(int i=0; i<jsonArray.size(); i++) {
						Files files = new Files();
						if(nCnt > 0) strSplit = "#";
						nCnt++;
						
						jsonObject = (JSONObject)jsonArray.get(i); 
						String[] strData = StringUtil.strToArr((String)jsonObject.get("fileId"), "@@");
						String strExt = jsonObject.get("fileName").toString().substring(jsonObject.get("fileName").toString().lastIndexOf(".")+1);
						String strFilePath = "";
						if(strData.length >= 4){
							strFilePath = strData[4];
						}else{							
							strFilePath = uploadDir + File.separator + strData[0] + File.separator + strData[1] + File.separator;
						}
						
						if(!Boolean.parseBoolean((String) jsonObject.get("isDeleted"))){
							if(strFilePath.toString().indexOf(uploadDir.replaceAll("\\\\", "/")) > -1){ //파일업로드 취약점(지정된 업로드 경로가 아닌경우)
								sbUserFileName.append(strSplit).append((String)jsonObject.get("fileName"));
								sbSystemFileName.append(strSplit).append(strData[2]);
								sbFilePath.append(strSplit).append(strFilePath);
								sbFileExtension.append(strSplit).append(strExt);
								sbFileSize.append(strSplit).append(Integer.parseInt((String)jsonObject.get("fileSize")));
								
								files.setUserFileName((String)jsonObject.get("fileName"));
								files.setSystemFileName(strData[2]);
								files.setFilePath(strFilePath);
								files.setFileExtension(strExt);
								files.setFileSize((String)jsonObject.get("fileSize"));
								uploadFileList.add(files);
							}
							
						}else{
							nCnt--;
							
							//파일 삭제
							try {
								logger.debug("파일 삭제 시작 >>>>> ");
								// 파일이 저장될 서버측 전체경로
								String saveFilePath = "";
								saveFilePath = strFilePath + strData[2];

								logger.debug("파일 삭제 : " + saveFilePath);
								File file = new File(saveFilePath);
									
								if(file.exists()){
									if(file.delete()){
										logger.debug("fileDelete success !!! ");
									}else{
										logger.debug("fileDelete fail !!! ");
									}
								}
								
								if("jpg;jpeg;png;gif;bmp".indexOf(strExt.toLowerCase()) > -1){
									fileDeleteAttempt(strFilePath+"thumbnails"+File.separator, strData[2]);
								}
							} catch (Exception e) {
								logger.info("", e);
							}
						}
					}
				}
			}

			/**
			* 업로드 된 정보를 출력합니다.
			* 샘플에서는 JSON 타입으로 데이터를 교환하고 있습니다. 필요 시 다른 형식으로 조합해서 사용하실 수 있습니다.
			*/
			if(StringUtil.isNotBlank(request.getParameter("uploadedFilesInfo"))) {
				String uploadedFilesInfo = request.getParameter("uploadedFilesInfo"); 
				jsonObj = jsonParser.parse(uploadedFilesInfo); 
				jsonArray = (JSONArray)jsonObj; 
				if(jsonArray.size() > 0){
					for(int i=0; i<jsonArray.size(); i++) {
						Files files = new Files();
						if(nCnt > 0) strSplit = "#";
						nCnt++;
						
						jsonObject = (JSONObject)jsonArray.get(i); 

						if(jsonObject.get("lastSavedDirectoryPath").toString().indexOf(uploadDir.replaceAll("\\\\", "/")) > -1){ //파일업로드 취약점(지정된 업로드 경로가 아닌경우)
							sbUserFileName.append(strSplit).append((String)jsonObject.get("origfileName"));
							sbSystemFileName.append(strSplit).append((String)jsonObject.get("fileName"));
							sbFilePath.append(strSplit).append((String)jsonObject.get("lastSavedDirectoryPath"));
							sbFileExtension.append(strSplit).append((String)jsonObject.get("fileExtension"));
							sbFileSize.append(strSplit).append(Integer.parseInt((String)jsonObject.get("fileSize")));
							
							files.setUserFileName((String)jsonObject.get("origfileName"));
							files.setSystemFileName((String)jsonObject.get("fileName"));
							files.setFilePath((String)jsonObject.get("lastSavedDirectoryPath"));
							files.setFileExtension((String)jsonObject.get("fileExtension"));
							files.setFileSize((String)jsonObject.get("fileSize"));
							uploadFileList.add(files);
						}
					}
				}
			}
			
			uploadFiles.setFileCount(nCnt+"");
			uploadFiles.setUserFileName(sbUserFileName.toString());
			uploadFiles.setSystemFileName(sbSystemFileName.toString());
			uploadFiles.setFilePath(sbFilePath.toString());
			uploadFiles.setFileExtension(sbFileExtension.toString());
			uploadFiles.setFileSize(sbFileSize.toString());
			uploadFiles.setFileList(uploadFileList);
			
		}catch (Exception e){
			//e.printStackTrace();
		}
		
		return uploadFiles;
	}
	
	/*****************************************************************
	* fileDeleteAttempt 파일 삭제 공통 모듈 DML 생성용
	* @param request
	* @param 
	* @return
	*******************************************************************/
	public static void fileDeleteAttempt(String strFilePath, String strSystemFileName)
	{
		try {
			logger.debug("파일 삭제 시작 >>>>> ");

			// 파일이 저장될 서버측 전체경로
			String saveFilePath = "";
			saveFilePath = strFilePath + strSystemFileName;
				
			File file = new File(saveFilePath);
				
			if(file.exists()){
				if(file.delete()){
					logger.debug("fileDelete success !!! ");
				}else{
					logger.debug("fileDelete fail !!! ");
				}
			}
			
		} catch (Exception e) {
			logger.info("", e);
		}
	}
}
