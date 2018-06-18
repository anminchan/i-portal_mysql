package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;
import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("files")
public class Files extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = -1031432425113771606L;
	
	private String titleId;
	private String fileId;
	
	private String userFileName;
	private String systemFileName;
	private String filePath;
	private String fileExtension;
	private String fileSize;
	private String fileInfo;
	
	private String fileCount;
	
	private List<Files> fileList;
	
	private String fileDownType;  // 파일다운로드타입(C : 클릭, 자동)
	
	public String makeFreeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append(">> FileCount		: ").append(this.getFileCount())	     	 .append("\n")
		.append(">> UserFileName	: ").append(this.getUserFileName())	     	 .append("\n")
		.append(">> SystemFileName	: ").append(this.getSystemFileName())	     .append("\n")
		.append(">> FilePath		: ").append(this.getFilePath())	     	     .append("\n")
		.append(">> fileExtension	: ").append(this.getFileExtension())	     .append("\n")
		.append(">> fileSize		: ").append(this.getFileSize())	     	     .append("\n");
		return sbData.toString();
	}
	
	public String makeFreeDMLDataString(){		
		StringBuffer sbData = new StringBuffer();		
		sbData
		.append(StringUtil.getString(this.getFileCount(), "0"))				.append("|")
		.append(StringUtil.getString(this.getUserFileName(), "-"))			.append("|")
		.append(StringUtil.getString(this.getSystemFileName(), "-"))		.append("|")
		.append(StringUtil.getString(this.getFilePath(), "-"))				.append("|")
		.append(StringUtil.getString(this.getFileExtension(), "-"))			.append("|")
		.append(StringUtil.getString(this.getFileSize(), "-"));		
		return sbData.toString();
	}

	public String getTitleId() {
		return titleId;
	}

	public void setTitleId(String titleId) {
		this.titleId = titleId;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getUserFileName() {
		return userFileName;
	}

	public void setUserFileName(String userFileName) {
		this.userFileName = userFileName;
	}

	public String getSystemFileName() {
		return systemFileName;
	}

	public void setSystemFileName(String systemFileName) {
		this.systemFileName = systemFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileExtension() {
		return fileExtension;
	}

	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileCount() {
		return fileCount;
	}

	public void setFileCount(String fileCount) {
		this.fileCount = fileCount;
	}

	public List<Files> getFileList() {
		return fileList;
	}

	public void setFileList(List<Files> fileList) {
		this.fileList = fileList;
	}

	public String getFileInfo() {
		return fileInfo;
	}

	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}

	public String getFileDownType() {
		return fileDownType;
	}

	public void setFileDownType(String fileDownType) {
		this.fileDownType = fileDownType;
	}

}
