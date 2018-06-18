package kr.plani.ccis.base.domain;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("userGrade")
public class UserGrade extends DefaultDomain {
	private static final long serialVersionUID = -4454022008109852967L;
	
	private String userGradeId;
	private String linkId;
	private String grade;
	private String KText;
	
	public String makeDMLDataString(){
		//InDMLData ::  MenuID|LinkID|Grade|KText
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getMenuId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getLinkId(), ""))		.append("|")
			.append(StringUtil.getString(this.getGrade(), ""))      .append("|")
			.append(StringUtil.getString(this.getKText(), "-"));

		return sbData.toString();
	}

	public String getUserGradeId() {
		return userGradeId;
	}

	public void setUserGradeId(String userGradeId) {
		this.userGradeId = userGradeId;
	}

	public String getLinkId() {
		return linkId;
	}

	public void setLinkId(String linkId) {
		this.linkId = linkId;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getKText() {
		return KText;
	}

	public void setKText(String kText) {
		KText = kText;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
