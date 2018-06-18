package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("attachFile")
public class AttachFile extends DefaultDomain {

	private int attachFileId;
	private String userName;
	private String KHtml;
	private String userFileName;
	private String systemFileName;
	private String filePath;	
	private String fileExtension;
	private int fileId;
	private int fileSize;
	private String insTime;
	private String fileYn;
	private String attachFileIds;
	private String[] attachFileIdsact;
	
	public String[] getAttachFileIdsact() {
		return attachFileIdsact;
	}
	public void setAttachFileIdsact(String[] attachFileIdsact) {
		this.attachFileIdsact = attachFileIdsact;
	}
	public String getAttachFileIds() {
		return attachFileIds;
	}
	public void setAttachFileIds(String attachFileIds) {
		this.attachFileIds = attachFileIds;
	}
	public String getFileYn() {
		return fileYn;
	}
	public void setFileYn(String fileYn) {
		this.fileYn = fileYn;
	}
	public String getInsTime() {
		return insTime;
	}
	public void setInsTime(String insTime) {
		this.insTime = insTime;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public int getAttachFileId() {
		return attachFileId;
	}
	public void setAttachFileId(int attachFileId) {
		this.attachFileId = attachFileId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getKHtml() {
		return KHtml;
	}
	public void setKHtml(String kHtml) {
		KHtml = kHtml;
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
	public int getFileId() {
		return fileId;
	}
	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	
}
