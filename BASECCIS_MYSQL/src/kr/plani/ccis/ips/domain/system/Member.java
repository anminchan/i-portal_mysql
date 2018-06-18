package kr.plani.ccis.ips.domain.system;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("member")
public class Member extends DefaultDomain implements Serializable {

	private static final long serialVersionUID = 413865608334470100L;

	private String url;
	
	private String prePassword;
	private String password;
	private String certification;
	private String key1;
	private String key2;
	private String key3;
	private String dkey;
	private String kind;
	private String kind_Name;
	
	private String photoFileName;
	private String photoFilePath;
	
	private String passwordTime;
	private String withDrawTime;
	private String joinDate;
	private String joinSiteID;
	private String outDate;
	
	public String[] chkUserIds = null;
				
	public String[] getChkUserIds() {
		return chkUserIds;
	}
	public void setChkUserIds(String[] chkUserIds) {
		this.chkUserIds = chkUserIds;
	}			
			
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getPrePassword() {
		return prePassword;
	}
	public void setPrePassword(String prePassword) {
		this.prePassword = prePassword;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getCertification() {
		return certification;
	}
	public void setCertification(String certification) {
		this.certification = certification;
	}
	public String getKey1() {
		return key1;
	}
	public void setKey1(String key1) {
		this.key1 = key1;
	}
	public String getKey2() {
		return key2;
	}
	public void setKey2(String key2) {
		this.key2 = key2;
	}
	public String getKey3() {
		return key3;
	}
	public void setKey3(String key3) {
		this.key3 = key3;
	}
	public String getDkey() {
		return dkey;
	}
	public void setDkey(String dkey) {
		this.dkey = dkey;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getKind_Name() {
		return kind_Name;
	}
	public void setKind_Name(String kind_Name) {
		this.kind_Name = kind_Name;
	}
	public String getPhotoFileName() {
		return photoFileName;
	}
	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}
	public String getPhotoFilePath() {
		return photoFilePath;
	}
	public void setPhotoFilePath(String photoFilePath) {
		this.photoFilePath = photoFilePath;
	}
	public String getPasswordTime() {
		return passwordTime;
	}
	public void setPasswordTime(String passwordTime) {
		this.passwordTime = passwordTime;
	}
	public String getWithDrawTime() {
		return withDrawTime;
	}
	public void setWithDrawTime(String withDrawTime) {
		this.withDrawTime = withDrawTime;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getJoinSiteID() {
		return joinSiteID;
	}
	public void setJoinSiteID(String joinSiteID) {
		this.joinSiteID = joinSiteID;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	
}
