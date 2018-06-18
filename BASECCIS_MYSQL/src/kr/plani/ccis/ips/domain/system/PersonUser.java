package kr.plani.ccis.ips.domain.system;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;

@Alias("personUser")
public class PersonUser extends Member implements Serializable {
	
	private static final long serialVersionUID = -8111171881209768866L;
	
	//기본정보
	private String mailing;	  //메일링
	private String cellPhone; //휴대폰번호
	private String homePhone; //전화번호
	
	private String birthDate; 	//생년월일
	private String solarYn; 	//양력유무
	private String gender;		//성별
	
	private String homeZipCode;	  //우편번호
	private String homeAddress1;  //기본주소
	private String homeAddress2;  //상세주소
	
	//ID통합용 
	private String oldUserId;
	private String siteInfo;
	private String userGubun;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> UserID         						: ").append(this.getUserId())				.append("\n")
			.append(">> Password         					: ").append(this.getPassword())				.append("\n")
			.append(">> Certification         				: ").append(this.getCertification())		.append("\n")
			.append(">> DKey         						: ").append(this.getDkey())					.append("\n")
			.append(">> KName         						: ").append(this.getKName())				.append("\n")
			.append(">> Kind         						: ").append(this.getKind())					.append("\n")
			.append(">> Mailing        						: ").append(this.getMailing())				.append("\n")
			.append(">> CellPhone      						: ").append(this.getCellPhone())			.append("\n")
			.append(">> birthDate      						: ").append(this.getBirthDate())			.append("\n")
			.append(">> PasswordTime(YYYYMMDDHH24MISS)		: ").append(this.getPasswordTime())			.append("\n")
			.append(">> WithdrawTime(YYYYMMDDHH24MISS)		: ").append(this.getWithDrawTime())			.append("\n")
			.append(">> JoinSiteID                  		: ").append(this.getJoinSiteID())			.append("\n")
			.append(">> JoinDate(YYYYMMDD)          		: ").append(this.getJoinDate())  			.append("\n")
			.append(">> OutDate(YYYYMMDD)					: ").append(this.getOutDate())				.append("\n")
			.append(">> State								: ").append(this.getState())				.append("\n");
			
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  UserID|Password|Certification|DKey|KName|Email|CellPhone|BirthDate|Gender|Kind|PasswordTime(YYYYMMDDHH24MISS)|WithdrawTime(YYYYMMDDHH24MISS)|JoinSiteID|JoinDate(YYYYMMDD)|OutDate(YYYYMMDD)|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getUserId(), "-"))				.append("|")
			.append(StringUtil.getString(this.getPassword(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCertification(), "-"))			.append("|")
			.append(StringUtil.getString(this.getKey1(), "-"))					.append("|")
			.append(StringUtil.getString(this.getKey2(), "-"))					.append("|")
			.append(StringUtil.getString(this.getKey3(), "-"))					.append("|")
			.append(StringUtil.getString(this.getDkey(), "-"))					.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))					.append("|")
			.append(StringUtil.getString(this.getKind(), "P"))					.append("|")
			.append(StringUtil.getString(this.getPasswordTime(), "-"))			.append("|")
			.append(StringUtil.getString(this.getWithDrawTime(), "-"))			.append("|")
			.append(StringUtil.getString(this.getJoinSiteID(), "-"))			.append("|")
			.append(StringUtil.getString(this.getJoinDate(), "-"))				.append("|")
			.append(StringUtil.getString(this.getOutDate(), "-"))				.append("|")
			.append(StringUtil.getString(this.getMailing(), "N"))				.append("|")
			.append(StringUtil.getString(this.getCellPhone(), "-"))				.append("|")
			.append(StringUtil.getString(this.getHomePhone(), "-"))				.append("|")
			.append(StringUtil.getString(this.getBirthDate(), "-"))				.append("|")
			.append(StringUtil.getString(this.getSolarYn(), "-"))				.append("|")
			.append(StringUtil.getString(this.getGender(), "-"))				.append("|")
			.append(StringUtil.getString(this.getHomeZipCode(), "-"))			.append("|")
			.append(StringUtil.getString(this.getHomeAddress1(), "-"))			.append("|")
			.append(StringUtil.getString(this.getHomeAddress2(), "-"))			.append("|")
			.append(StringUtil.getString(this.getState(), "-"));
			
		return sbData.toString();
	}

	public String getMailing() {
		return mailing;
	}

	public void setMailing(String mailing) {
		this.mailing = mailing;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getHomePhone() {
		return homePhone;
	}

	public void setHomePhone(String homePhone) {
		this.homePhone = homePhone;
	}

	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}

	public String getSolarYn() {
		return solarYn;
	}

	public void setSolarYn(String solarYn) {
		this.solarYn = solarYn;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getHomeZipCode() {
		return homeZipCode;
	}

	public void setHomeZipCode(String homeZipCode) {
		this.homeZipCode = homeZipCode;
	}

	public String getHomeAddress1() {
		return homeAddress1;
	}

	public void setHomeAddress1(String homeAddress1) {
		this.homeAddress1 = homeAddress1;
	}

	public String getHomeAddress2() {
		return homeAddress2;
	}

	public void setHomeAddress2(String homeAddress2) {
		this.homeAddress2 = homeAddress2;
	}

	public String getOldUserId() {
		return oldUserId;
	}

	public void setOldUserId(String oldUserId) {
		this.oldUserId = oldUserId;
	}

	public String getSiteInfo() {
		return siteInfo;
	}

	public void setSiteInfo(String siteInfo) {
		this.siteInfo = siteInfo;
	}

	public String getUserGubun() {
		return userGubun;
	}

	public void setUserGubun(String userGubun) {
		this.userGubun = userGubun;
	}

}
