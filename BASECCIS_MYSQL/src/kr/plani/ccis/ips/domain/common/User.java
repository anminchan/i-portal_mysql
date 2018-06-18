package kr.plani.ccis.ips.domain.common;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("user")
public class User extends DefaultDomain implements Serializable {

	private static final long serialVersionUID = 1000652579114690205L;
	
	// 공통
	private String userCnt;
	private String kName;
	private String kind;
	private String kindName;

	// 내부회원일 경우
	private String deptId;
	private String deptName;
	
	// 기업회원일 경우
	private String corpRegNo;
	private String ceoName;
	
	private String password;
	private String certification;
	private String key1;
	private String key2;
	private String key3;
	private String dkey;
	private String passwordTime;
	private String withdrawTime;
	private String joinSiteId;
	private String joinDate;
	private String outDate;
	
	private String receiveMail;
	
	private String mailCertiYn;
	
	private String cellPhone;
	private String homeZipCode;
	private String homeAddress1;
	private String homeAddress2;
	private String homePhone;
	
	private String corpZipCode;
	private String corpAddress1;
	private String corpAddress2;
	
	private String totalAuth;			//전체관리자 권한 여부	- Y:전체관리자
	
	
	public String makeTempPasswordDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> UserId       : ").append(this.getUserId())	 	.append("\n")
			.append(">> Password     : ").append(this.getPassword())	.append("\n");
		
		return sbData.toString();
	}

	public String makeTempPasswordDMLDataString(){
		//InDMLData ::  UserID|Password
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getUserId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getPassword(), "-"));
		
		return sbData.toString();
	}
	
	
	public String getUserCnt() {
		return userCnt;
	}

	public void setUserCnt(String userCnt) {
		this.userCnt = userCnt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getkName() {
		return kName;
	}
	public void setkName(String kName) {
		this.kName = kName;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getCorpRegNo() {
		return corpRegNo;
	}
	public void setCorpRegNo(String corpRegNo) {
		this.corpRegNo = corpRegNo;
	}
	public String getCeoName() {
		return ceoName;
	}
	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
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
	public String getPasswordTime() {
		return passwordTime;
	}
	public void setPasswordTime(String passwordTime) {
		this.passwordTime = passwordTime;
	}
	public String getWithdrawTime() {
		return withdrawTime;
	}
	public void setWithdrawTime(String withdrawTime) {
		this.withdrawTime = withdrawTime;
	}
	public String getJoinSiteId() {
		return joinSiteId;
	}
	public void setJoinSiteId(String joinSiteId) {
		this.joinSiteId = joinSiteId;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	public String getKindName() {
		return kindName;
	}
	public void setKindName(String kindName) {
		this.kindName = kindName;
	}

	public String getMailCertiYn() {
		return mailCertiYn;
	}

	public void setMailCertiYn(String mailCertiYn) {
		this.mailCertiYn = mailCertiYn;
	}
	
	public String getReceiveMail() {
		return receiveMail;
	}

	public void setReceiveMail(String receiveMail) {
		this.receiveMail = receiveMail;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
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
	
	public String getCorpZipCode() {
		return corpZipCode;
	}

	public void setCorpZipCode(String corpZipCode) {
		this.corpZipCode = corpZipCode;
	}

	public String getCorpAddress1() {
		return corpAddress1;
	}

	public void setCorpAddress1(String corpAddress1) {
		this.corpAddress1 = corpAddress1;
	}

	public String getCorpAddress2() {
		return corpAddress2;
	}

	public void setCorpAddress2(String corpAddress2) {
		this.corpAddress2 = corpAddress2;
	}

	public String getHomePhone() {
		return homePhone;
	}

	public void setHomePhone(String homePhone) {
		this.homePhone = homePhone;
	}

	public String getTotalAuth() {
		return totalAuth;
	}

	public void setTotalAuth(String totalAuth) {
		this.totalAuth = totalAuth;
	}
	
}
