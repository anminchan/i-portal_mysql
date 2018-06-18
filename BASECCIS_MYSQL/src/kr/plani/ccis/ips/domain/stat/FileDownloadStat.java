package kr.plani.ccis.ips.domain.stat;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("fileDownloadStat")
public class FileDownloadStat extends DefaultDomain {
	
	private String hitDate;
	private String titleId;
	private String fileId;
	private String userFileName;
	private String systemFileName;
	private String hitCount;
	private String fileGubun;
	private String menuGubun;
	private String statGubun;
	private String tLocation;
	
	
	public String gettLocation() {
		return tLocation;
	}
	public void settLocation(String tLocation) {
		this.tLocation = tLocation;
	}
	public String getHitDate() {
		return hitDate;
	}
	public void setHitDate(String hitDate) {
		this.hitDate = hitDate;
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
	public String getHitCount() {
		return hitCount;
	}
	public void setHitCount(String hitCount) {
		this.hitCount = hitCount;
	}
	public String getFileGubun() {
		return fileGubun;
	}
	public void setFileGubun(String fileGubun) {
		this.fileGubun = fileGubun;
	}
	public String getMenuGubun() {
		return menuGubun;
	}
	public void setMenuGubun(String menuGubun) {
		this.menuGubun = menuGubun;
	}
	public String getStatGubun() {
		return statGubun;
	}
	public void setStatGubun(String statGubun) {
		this.statGubun = statGubun;
	}
	
}