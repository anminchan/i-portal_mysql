package kr.plani.ccis.ips.domain.common;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("sample")
public class Sample extends DefaultDomain implements Serializable {

	private static final long serialVersionUID = 1000652579114690205L;
	
	// 공통
	private int sampleId;
	private String sampleTitle;
	private String sampleContent;
	private String[] sampleIds;
	
	private String userFileName;
	private String systemFileName;
	private String filePath;
	private String fileExtension;
	private String fileSize;
	private String fileInfo;
	
	public int getSampleId() {
		return sampleId;
	}
	public void setSampleId(int sampleId) {
		this.sampleId = sampleId;
	}
	public String getSampleTitle() {
		return sampleTitle;
	}
	public void setSampleTitle(String sampleTitle) {
		this.sampleTitle = sampleTitle;
	}
	public String getSampleContent() {
		return sampleContent;
	}
	public void setSampleContent(String sampleContent) {
		this.sampleContent = sampleContent;
	}
	public String[] getSampleIds() {
		return sampleIds;
	}
	public void setSampleIds(String[] sampleIds) {
		this.sampleIds = sampleIds;
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
	public String getFileInfo() {
		return fileInfo;
	}
	public void setFileInfo(String fileInfo) {
		this.fileInfo = fileInfo;
	}	
	
}
