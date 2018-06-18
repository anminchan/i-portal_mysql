package kr.plani.ccis.common.util;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.plani.ccis.ips.domain.site.Files;
import net.coobird.thumbnailator.Thumbnails;

@Component("fileUtil")
public class FileUtil {

	@Value("#{config['upload.dir']}")
	private String uploadDir;

    /**
     * 파일저장
     * @param Directory
     * @param fileName
     * @param bytes
     * @return
     * @throws IOException
     */
    public static boolean saveFile(String Directory, String fileName, byte[] bytes) throws Exception
    {
    	
		File path = new File(Directory);
		if (path.isDirectory() == false) {
			path.mkdirs();
		}
		if (!Directory.substring(Directory.length()-1,Directory.length()).equals("/")) {
			Directory += "/";
		}

		try {
			DataOutputStream fw = new DataOutputStream(new FileOutputStream(Directory+fileName, false));
			fw.write(bytes);
			fw.flush();
			fw.close();
		} catch (IOException e){
			//e.printStackTrace();
        	System.out.println("처리 중 오류가 발생했습니다.");

			return false;
		}
				
		return true;
	}
    
    
    /*
     * 파일 삭제
     */
    public static void deleteFile(String fileName) throws Exception
    {
		File fileDel = new File(fileName);
		fileDel.delete();
	}
    
    /*****************************************************************
	 * multiPartFileUpload 파일 업로드 처리
	 * @param 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
    public Object uploadFormfiles(HttpServletRequest request, HttpServletResponse response, String frmFilename, String updateFilename, String menuId, String fileGubun, String fileType) throws Exception
	{
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		Files uploadFiles = new Files();
		String saveDir = "";
		String strMenuId = menuId;
		int nCnt = 0;
		String strSplit = "";
		StringBuffer sbUserFileName = new StringBuffer();
		StringBuffer sbSystemFileName = new StringBuffer();
		StringBuffer sbFilePath = new StringBuffer();
		StringBuffer sbFileExtension = new StringBuffer();
		StringBuffer sbFileSize = new StringBuffer();
		List<Files> uploadFileList = new ArrayList();
		
		if(isMultipart) 
		{
			try{
				MultipartHttpServletRequest multipartRequest =  (MultipartHttpServletRequest)request;  //다중파일 업로드
				List<MultipartFile> files = multipartRequest.getFiles(frmFilename);
				saveDir = uploadDir + File.separator + fileGubun + File.separator + strMenuId;
				String saveDirPath = saveDir + File.separator;
				
				for(int i = 0; i < files.size(); i++){
					MultipartFile file = files.get(i);
					Files domainFiles = new Files();
					if(nCnt > 0) strSplit = "#";
					nCnt++;
					
					if(file.getSize() == 0){
						nCnt--;
						continue;
					}

					String orgFileName = file.getOriginalFilename();
					String sysFileName = "";  
					long sizeInBytes = file.getSize();
					
					int ext_pos = 0;
					String file_ext = "";
					ext_pos = orgFileName.lastIndexOf(".");
					// 파일 확장자 구하기
					file_ext = orgFileName.substring(ext_pos);
					Date time = new Date();
					sysFileName = time.getTime()+file_ext;
					
					// 허용된 파일 이외에는 첨부할 수 없음
					String strExt = orgFileName.substring(orgFileName.lastIndexOf(".")+1);
					
					if("jsp|java|sh|bat|php|asp|bin|cgi|dll|zip|rar|ace|cab|tar|zipx|7z|lzh|alz|agg|xml".indexOf(strExt) > -1){
						throw new Exception("첨부할 수 없는 파일 형식입니다.");
					}
					
					sbUserFileName.append(strSplit).append(orgFileName);					// 파일명
					sbSystemFileName.append(strSplit).append(sysFileName);					// 파일시스템명
					sbFilePath.append(strSplit).append(saveDirPath);						// 파일경로
					sbFileExtension.append(strSplit).append(strExt);						// 파일확장자
					sbFileSize.append(strSplit).append(new Long(sizeInBytes).toString());	// 파일사이즈
										
					domainFiles.setUserFileName(orgFileName);
					domainFiles.setSystemFileName(sysFileName);
					domainFiles.setFilePath(saveDirPath);
					domainFiles.setFileExtension(strExt);
					domainFiles.setFileSize(new Long(sizeInBytes).toString());
					uploadFileList.add(domainFiles);
					
					File dir = new File(saveDirPath);
					if(! dir.exists()){
						dir.mkdirs();
					}
	                
					String uploadPath = saveDirPath + sysFileName;  
					File uploadFile = new File(uploadPath);
					file.transferTo(uploadFile);  
					
					// 이미지썸네일생성
					if("jpg;jpeg;png;gif;bmp".indexOf(strExt) > -1){
						File image = new File(saveDirPath+sysFileName);
						File thumbnail = new File(saveDirPath+"thumbnails"+File.separator+sysFileName); 
						if (image.exists()) { 
							thumbnail.getParentFile().mkdirs(); 
							Thumbnails.of(image).size(260, 195).outputFormat(strExt).toFile(thumbnail); 
						}
					}
				}
				
				// 기존 저장 파일 추가
				String[] fileInfoArray = request.getParameterValues(updateFilename);
				if(fileInfoArray != null && fileInfoArray.length > 0){
					for(int i=0; i<fileInfoArray.length; i++){
						Files domainFiles = new Files();
						if(fileInfoArray[i] != null){
							if(nCnt > 0) strSplit = "#";
							nCnt++;
							String[] fileInfo = fileInfoArray[i].split("@@"); 		// 저장된파일정보
							
							sbUserFileName.append(strSplit).append(fileInfo[0]); 	// 파일명
							sbSystemFileName.append(strSplit).append(fileInfo[1]); 	// 파일시스템명
							sbFileSize.append(strSplit).append(fileInfo[2]); 		// 파일사이즈
							sbFilePath.append(strSplit).append(fileInfo[3]); 		// 파일경로
							sbFileExtension.append(strSplit).append(fileInfo[4]); 	// 파일확장자
							
							domainFiles.setUserFileName(fileInfo[0].toString());
							domainFiles.setSystemFileName(fileInfo[1].toString());
							domainFiles.setFileSize(fileInfo[2].toString());
							domainFiles.setFilePath(fileInfo[3].toString());
							domainFiles.setFileExtension(fileInfo[4].toString());
							uploadFileList.add(domainFiles);
						}
					}
				}
				
				if(fileType.equals("multi")){
					uploadFiles.setFileCount(nCnt+"");
					uploadFiles.setUserFileName(sbUserFileName.toString());
					uploadFiles.setSystemFileName(sbSystemFileName.toString());
					uploadFiles.setFilePath(sbFilePath.toString());
					uploadFiles.setFileExtension(sbFileExtension.toString());
					uploadFiles.setFileSize(sbFileSize.toString());
					uploadFiles.setFileList(uploadFileList);
				}else if(fileType.equals("single")){
					uploadFiles.setFileCount((nCnt >= 1 ? 1:nCnt)+"");
					uploadFiles.setUserFileName(sbUserFileName.toString().split("#")[0]);
					uploadFiles.setSystemFileName(sbSystemFileName.toString().split("#")[0]);
					uploadFiles.setFilePath(sbFilePath.toString().split("#")[0]);
					uploadFiles.setFileExtension(sbFileExtension.toString().split("#")[0]);
					uploadFiles.setFileSize(sbFileSize.toString().split("#")[0]);
					uploadFiles.setFileList((List<Files>) uploadFileList.get(0));
				}
								
			}catch (FileUploadException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
	        	System.out.println("처리 중 오류가 발생했습니다.");
			}catch (IOException e){
				//e.printStackTrace();
	        	System.out.println("처리 중 오류가 발생했습니다.");
			}catch (Exception e){
				//e.printStackTrace();
	        	System.out.println("처리 중 오류가 발생했습니다.");
			}
		}
		return uploadFiles;
	}
    
}
