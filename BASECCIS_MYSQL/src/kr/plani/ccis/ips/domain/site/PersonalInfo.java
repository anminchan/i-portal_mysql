package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("personalInfo")
public class PersonalInfo extends DefaultDomain {
	private String KDesc;
	private String personalInfoId;
	public String[] chkPersonalInfoIds = null;			//체크 SiteId - 다중삭제용
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> PersonalInfoId   : ").append(this.getPersonalInfoId())    .append("\n")
			.append(">> KName         : ").append(this.getKName())		    .append("\n")
			.append(">> KDesc         : ").append(this.getKDesc())		    .append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SiteID|PersonalInfoID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|NewWindowYn|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getPersonalInfoId(), ""))	.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|");
		
		return sbData.toString();
	}

	public String getKDesc() {
		return KDesc;
	}
	public void setKDesc(String kDesc) {
		KDesc = kDesc;
	}
	public String getPersonalInfoId() {
		return personalInfoId;
	}
	public void setPersonalInfoId(String personalInfoId) {
		this.personalInfoId = personalInfoId;
	}

	public String[] getChkPersonalInfoIds() {
		return chkPersonalInfoIds;
	}

	public void setChkPersonalInfoIds(String[] chkPersonalInfoIds) {
		this.chkPersonalInfoIds = chkPersonalInfoIds;
	}
	
}
