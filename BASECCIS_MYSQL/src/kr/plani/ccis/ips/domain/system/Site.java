package kr.plani.ccis.ips.domain.system;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("site")
public class Site extends DefaultDomain {
	private String url;
	private String KDesc;
	private String ip;
	private String sourcePath;
	private String siteType;
	private String siteKey;
	private String siteLanguage;
	private String startTime;
	private String endTime;
	
	public String[] chkSiteIds = null;			//체크 SiteId - 다중삭제용
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SiteId       : ").append(this.getParamSiteId())	.append("\n")
			.append(">> KName        : ").append(this.getKName())		.append("\n")
			.append(">> KDesc        : ").append(this.getKDesc())		.append("\n")
			.append(">> Url          : ").append(this.getUrl())			.append("\n")
			.append(">> Ip           : ").append(this.getIp())			.append("\n")
			.append(">> SiteType     : ").append(this.getSiteType())	.append("\n")
			.append(">> SiteKey      : ").append(this.getSiteKey())	    .append("\n")
			.append(">> SiteLanguage : ").append(this.getSiteLanguage()).append("\n")
			.append(">> State        : ").append(this.getState())		.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SiteID|KName|KDesc|URL|IP|SourcePath|SiteType|SiteLanguage|SiteKey|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getParamSiteId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getKDesc(), "-"))			.append("|")
			.append(StringUtil.getString(this.getUrl(), "-"))			.append("|")
			.append(StringUtil.getString(this.getIp(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSourcePath(), "-"))	.append("|")
			.append(StringUtil.getString(this.getSiteType(), "-"))		.append("|")
			.append(StringUtil.getString(this.getSiteLanguage(), "-"))	.append("|")
			.append(StringUtil.getString(this.getSiteKey(), "-"))		.append("|")
			.append(StringUtil.getString(this.getState(), "-"));
		
		return sbData.toString();
	}
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getKDesc() {
		return KDesc;
	}
	public void setKDesc(String kDesc) {
		KDesc = kDesc;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getSiteType() {
		return siteType;
	}
	public void setSiteType(String siteType) {
		this.siteType = siteType;
	}
	public String getSiteLanguage() {
		return siteLanguage;
	}
	public void setSiteLanguage(String siteLanguage) {
		this.siteLanguage = siteLanguage;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getSourcePath() {
		return sourcePath;
	}
	public void setSourcePath(String sourcePath) {
		this.sourcePath = sourcePath;
	}
	public String getSiteKey() {
		return siteKey;
	}
	public void setSiteKey(String siteKey) {
		this.siteKey = siteKey;
	}
	public String[] getChkSiteIds() {
		return chkSiteIds;
	}
	public void setChkSiteIds(String[] chkSiteIds) {
		this.chkSiteIds = chkSiteIds;
	}

}
