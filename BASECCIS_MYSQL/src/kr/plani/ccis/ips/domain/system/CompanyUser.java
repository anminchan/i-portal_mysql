package kr.plani.ccis.ips.domain.system;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;

@Alias("companyUser")
public class CompanyUser extends Member implements Serializable {

	private static final long serialVersionUID = 958576343888982796L;
	
	private String corpRegno;
	private String ceoName;
	private String business;
	private String businessDesc;
	private String chargeName;
	private String chargePhone;
	private String chargeCellPhone;
	private String chargeEmail;
	private String mailing;
	private String mailReceive;
	private String interest;
	private String corpPhone;
	private String corpFax;
	private String homepage;
	private String corpZipCode;
	private String corpAddress1;
	private String corpAddress2;
	private String corpType;	//사업자형태
	private String chargeDeptName;	//담당자부서명
	
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
			.append(">> Key1         						: ").append(this.getKey1())					.append("\n")
			.append(">> Key2        						: ").append(this.getKey2())					.append("\n")
			.append(">> Key3        						: ").append(this.getKey3())					.append("\n")
			.append(">> DKey         						: ").append(this.getDkey())					.append("\n")
			.append(">> KName         						: ").append(this.getKName())				.append("\n")
			.append(">> Kind         						: ").append(this.getKind())					.append("\n")
			.append(">> PasswordTime(YYYYMMDDHH24MISS)		: ").append(this.getPasswordTime())			.append("\n")
			.append(">> WithdrawTime(YYYYMMDDHH24MISS)		: ").append(this.getWithDrawTime())			.append("\n")
			.append(">> JoinSiteID                  		: ").append(this.getJoinSiteID())			.append("\n")
			.append(">> JoinDate(YYYYMMDD)          		: ").append(this.getJoinDate())  			.append("\n")
			.append(">> OutDate(YYYYMMDD)					: ").append(this.getOutDate())				.append("\n")
			.append(">> CorpRegNO							: ").append(this.getCorpRegno())			.append("\n")
			.append(">> CorpType							: ").append(this.getCorpType())				.append("\n")
			.append(">> CEOName								: ").append(this.getCeoName())				.append("\n")
			.append(">> Business							: ").append(this.getBusiness())				.append("\n")
			.append(">> BusinessDesc						: ").append(this.getBusinessDesc())			.append("\n")
			.append(">> ChargeName							: ").append(this.getChargeName())			.append("\n")
			.append(">> ChargePhone							: ").append(this.getChargePhone())          .append("\n")
			.append(">> ChargeCellPhone						: ").append(this.getChargeCellPhone())      .append("\n")
			.append(">> ChargeDeptName						: ").append(this.getChargeDeptName())		.append("\n")
			.append(">> ChargeEmail							: ").append(this.getChargeEmail())          .append("\n")
			.append(">> Mailing								: ").append(this.getMailing())				.append("\n")
			.append(">> MailReceive							: ").append(this.getMailReceive())          .append("\n")
			.append(">> Interest							: ").append(this.getInterest())				.append("\n")
			.append(">> CorpPhone							: ").append(this.getCorpPhone())			.append("\n")
			.append(">> CorpFAX								: ").append(this.getCorpFax())				.append("\n")
			.append(">> HomePage							: ").append(this.getHomepage())				.append("\n")
			.append(">> CorpZipcode							: ").append(this.getCorpZipCode())          .append("\n")
			.append(">> CorpAddress1						: ").append(this.getCorpAddress1())			.append("\n")
			.append(">> CorpAddress2						: ").append(this.getCorpAddress2())			.append("\n")
			.append(">> State								: ").append(this.getState())				.append("\n");
			
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  UserID|Password|Certification|Key1|Key2|Key3|DKey|KName|Kind|PasswordTime(YYYYMMDDHH24MISS)|WithdrawTime(YYYYMMDDHH24MISS)|JoinSiteID|JoinDate(YYYYMMDD)|OutDate(YYYYMMDD)|CorpRegNO|CorpType|CEOName|Business|BusinessDesc|ChargeName|ChargeEmail|ChargePhone|ChargeCellPhone|ChargeDeptName|Mailing|MailReceive|Interest|CorpPhone|CorpFAX|HomePage|CorpZipcode|CorpAddress1|CorpAddress2|State
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
			.append(StringUtil.getString(this.getKind(), "C"))					.append("|")
			.append(StringUtil.getString(this.getPasswordTime(), "-"))			.append("|")
			.append(StringUtil.getString(this.getWithDrawTime(), "-"))			.append("|")
			.append(StringUtil.getString(this.getJoinSiteID(), "-"))			.append("|")
			.append(StringUtil.getString(this.getJoinDate(), "-"))				.append("|")
			.append(StringUtil.getString(this.getOutDate(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCorpRegno(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCorpType(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCeoName(), "-"))				.append("|")
			.append(StringUtil.getString(this.getBusiness(), "-"))				.append("|")
			.append(StringUtil.getString(this.getBusinessDesc(), "-"))			.append("|")
			.append(StringUtil.getString(this.getChargeName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getChargeEmail(), "-"))			.append("|")			
			.append(StringUtil.getString(this.getChargePhone(), "-"))			.append("|")
			.append(StringUtil.getString(this.getChargeCellPhone(), "-"))		.append("|")
			.append(StringUtil.getString(this.getChargeDeptName(), "-"))		.append("|")
			.append(StringUtil.getString(this.getMailing(), "N"))				.append("|")
			.append(StringUtil.getString(this.getCorpPhone(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCorpFax(), "-"))				.append("|")
			.append(StringUtil.getString(this.getHomepage(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCorpZipCode(), "-"))			.append("|")
			.append(StringUtil.getString(this.getCorpAddress1(), "-"))			.append("|")
			.append(StringUtil.getString(this.getCorpAddress2(), "-"))			.append("|")
			.append(StringUtil.getString(this.getState(), "-"));
			
		return sbData.toString();
	}
	
	public String getCorpRegno() {
		return corpRegno;
	}
	public void setCorpRegno(String corpRegno) {
		this.corpRegno = corpRegno;
	}
	public String getCorpType() {
		return corpType;
	}

	public void setCorpType(String corpType) {
		this.corpType = corpType;
	}		
	public String getCeoName() {
		return ceoName;
	}
	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}
	public String getBusiness() {
		return business;
	}
	public void setBusiness(String business) {
		this.business = business;
	}
	public String getBusinessDesc() {
		return businessDesc;
	}
	public void setBusinessDesc(String businessDesc) {
		this.businessDesc = businessDesc;
	}
	public String getChargeName() {
		return chargeName;
	}
	public void setChargeName(String chargeName) {
		this.chargeName = chargeName;
	}
	public String getChargePhone() {
		return chargePhone;
	}
	public void setChargePhone(String chargePhone) {
		this.chargePhone = chargePhone;
	}
	public String getMailing() {
		return mailing;
	}
	public void setMailing(String mailing) {
		this.mailing = mailing;
	}
	public String getMailReceive() {
		return mailReceive;
	}
	public void setMailReceive(String mailReceive) {
		this.mailReceive = mailReceive;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getCorpPhone() {
		return corpPhone;
	}
	public void setCorpPhone(String corpPhone) {
		this.corpPhone = corpPhone;
	}
	public String getCorpFax() {
		return corpFax;
	}
	public void setCorpFax(String corpFax) {
		this.corpFax = corpFax;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
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

	public String getChargeEmail() {
		return chargeEmail;
	}

	public void setChargeEmail(String chargeEmail) {
		this.chargeEmail = chargeEmail;
	}

	public String getChargeCellPhone() {
		return chargeCellPhone;
	}

	public void setChargeCellPhone(String chargeCellPhone) {
		this.chargeCellPhone = chargeCellPhone;
	}
	
	public String getChargeDeptName() {
		return chargeDeptName;
	}

	public void setChargeDeptName(String chargeDeptName) {
		this.chargeDeptName = chargeDeptName;
	}

	public String getSiteInfo() {
		return siteInfo;
	}
	public void setSiteInfo(String siteInfo) {
		this.siteInfo = siteInfo;
	}
	
	public String getOldUserId() {
		return oldUserId;
	}
	public void setOldUserId(String oldUserId) {
		this.oldUserId = oldUserId;
	}
	
	public String getUserGubun() {
		return userGubun;
	}
	public void setUserGubun(String userGubun) {
		this.userGubun = userGubun;
	}	
	
}
