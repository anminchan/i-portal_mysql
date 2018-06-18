package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("familySite")
public class FamilySite extends DefaultDomain {
	private String url;
    
	private String site_Name;
	private String KDesc;
	private String siteLinkId;
	private String linkURL;
	private int sort;
	private String newWindowYn;
	
	public String[] chkSiteLinkIds = null;			//체크 FamilySiteId - 다중삭제용
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SiteId        : ").append(this.getSiteId())		    .append("\n")
			.append(">> SiteLinkId    : ").append(this.getSiteLinkId())     .append("\n")
			.append(">> KName         : ").append(this.getKName())		    .append("\n")
			.append(">> KDesc         : ").append(this.getKDesc())		    .append("\n")
			.append(">> Sort     	  : ").append(this.getSort())			.append("\n")
			.append(">> NewWindowYn   : ").append(this.getNewWindowYn())	.append("\n")
			.append(">> State         : ").append(this.getState())			.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SiteID|FamilySiteID|KName|LinkURL|Sort|NewWindowYn|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getSiteId(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getSiteLinkId(), ""))    .append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getLinkURL(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getSort(), "-"))			.append("|")
			.append(StringUtil.getString(this.getNewWindowYn(), "-"))   .append("|")
			.append(StringUtil.getString(this.getState(), "-"));
		
		return sbData.toString();
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSite_Name() {
		return site_Name;
	}

	public void setSite_Name(String site_Name) {
		this.site_Name = site_Name;
	}

	public String getKDesc() {
		return KDesc;
	}

	public void setKDesc(String kDesc) {
		KDesc = kDesc;
	}

	public String getSiteLinkId() {
		return siteLinkId;
	}

	public void setSiteLinkId(String siteLinkId) {
		this.siteLinkId = siteLinkId;
	}

	public String[] getChkSiteLinkIds() {
		return chkSiteLinkIds;
	}

	public void setChkSiteLinkIds(String[] chkSiteLinkIds) {
		this.chkSiteLinkIds = chkSiteLinkIds;
	}

	public String getLinkURL() {
		return linkURL;
	}

	public void setLinkURL(String linkURL) {
		this.linkURL = linkURL;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}
	
	public String getNewWindowYn() {
		return newWindowYn;
	}

	public void setNewWindowYn(String newWindowYn) {
		this.newWindowYn = newWindowYn;
	}

}
