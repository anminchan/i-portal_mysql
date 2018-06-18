package kr.plani.ccis.base.domain;


import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("memberInfo")
public class MemberInfo extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = 413865608334470100L;

	private String url;
	private String step;
	
	private String password;
	private String certification;
	private String key1;
	private String key2;
	private String key3;
	private String dkey;
	private String kind;
	private String kind_Name;
	
	private String passwordTime;
	private String withdrawTime;
	private String joinSiteId;
	private String joinDate;
	private String outDate;

	//개인회원정보
	private String birthDate; 	//생년월일
	private String solarYn; 	//양력유무
	private String belong;		//소속
	private String etcBelong;	//기타소속
	private String gender;		//성별
	private String cellPhone;	//휴대전화
	private String mailing;		//메일링여부
	private String mailReceive;	//메일수신구분
	private String interest;	//관심분야
	
	//기업회원정보
	private String corpRegno;	//사업자번호
	private String business;	//업종
	private String ceoName; 	//대표자명
	private String corpType;	//사업자형태
	private String corpPhone;	//전화번호
	private String corpFax;		//팩스번호
	private String corpZipCode;	//우편번호
	private String corpAddress1;	//기본주소
	private String corpAddress2;	//상세주소
	private String chargeName;	//담당자이름
	private String chargeEmail;	//담당자이메일
	private String chargePhone;	//담당자전화번호
	private String chargeCellPhone;	//휴대폰
	private String chargeDeptName;	//담당자부서명
	private String homepage;		//홈페이지
	
	//내부직원정보
	private String positionNm;	//직급명
	private String deptNm;	//부서패스
	private String dutyNm; 	//직책명
	private String deptId;	//부서아이디
	private String chargeWork; //담당업무
	private String sort; // 정부여부 (1:정 그외:부)
	private String phone; //전화번호
	private String dutyId; //직책아이디
	private String positionId; //직급아이디
	private String prePassword;
	private String message;
	private String reJoinYn;
	private String siteInfo;
	private String siteInfoC;
	private String newsLetter; //뉴스레터 수신여부
	private String newsLetterGubun; //뉴스레터 수신여부
	
	//ID통합용 
	private String oldUserId;
	private String email;
	private String gubun;
	
	//직원검색용
	private String deptIdSel_1;	
	private String deptIdSel_2;
	private String deptIdSel_3;
	

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}	

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
	
	public String getSiteInfoC() {
		return siteInfoC;
	}

	public void setSiteInfoC(String siteInfoC) {
		this.siteInfoC = siteInfoC;
	}
	
	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
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

	public String getBelong() {
		return belong;
	}

	public void setBelong(String belong) {
		this.belong = belong;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getEtcBelong() {
		return etcBelong;
	}

	public void setEtcBelong(String etcBelong) {
		this.etcBelong = etcBelong;
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
	
	public String getNewsLetter() {
		return newsLetter;
	}
	
	public void setNewsLetter(String newsLetter) {
		this.newsLetter = newsLetter;
	}
	
	public String getNewsLetterGubun() {
		return newsLetterGubun;
	}
	
	public void setNewsLetterGubun(String newsLetterGubun) {
		this.newsLetterGubun = newsLetterGubun;
	}
	
	public String getCorpRegno() {
		return corpRegno;
	}

	public void setCorpRegno(String corpRegno) {
		this.corpRegno = corpRegno;
	}

	public String getCeoName() {
		return ceoName;
	}

	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}
	
	public String getCorpType() {
		return corpType;
	}

	public void setCorpType(String corpType) {
		this.corpType = corpType;
	}	
	
	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
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

	public String getChargeDeptName() {
		return chargeDeptName;
	}

	public void setChargeDeptName(String chargeDeptName) {
		this.chargeDeptName = chargeDeptName;
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
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
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
	
	
	public String getPositionNm() {
		return positionNm;
	}

	public void setPositionNm(String positionNm) {
		this.positionNm = positionNm;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	public String getDutyNm() {
		return dutyNm;
	}

	public void setDutyNm(String dutyNm) {
		this.dutyNm = dutyNm;
	}
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	
	public String getPrePassword() {
		return prePassword;
	}
	public void setPrePassword(String prePassword) {
		this.prePassword = prePassword;
	}
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getReJoinYn() {
		return reJoinYn;
	}

	public void setReJoinYn(String reJoinYn) {
		this.reJoinYn = reJoinYn;
	}
	
	public String getChargeWork() {
		return chargeWork;
	}

	public void setChargeWork(String chargeWork) {
		this.chargeWork = chargeWork;
	}
	
	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getDutyId() {
		return dutyId;
	}

	public void setDutyId(String dutyId) {
		this.dutyId = dutyId;
	}
	
	public String getPositionId() {
		return positionId;
	}

	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}
	 
	public String getDeptIdSel_1() {
		return deptIdSel_1;
	}

	public void setDeptIdSel_1(String deptIdSel_1) {
		this.deptIdSel_1 = deptIdSel_1;
	}	
	
	public String getDeptIdSel_2() {
		return deptIdSel_2;
	}

	public void setDeptIdSel_2(String deptIdSel_2) {
		this.deptIdSel_2 = deptIdSel_2;
	}
	
	public String getDeptIdSel_3() {
		return deptIdSel_3;
	}

	public void setDeptIdSel_3(String deptIdSel_3) {
		this.deptIdSel_3 = deptIdSel_3;
	}

}
