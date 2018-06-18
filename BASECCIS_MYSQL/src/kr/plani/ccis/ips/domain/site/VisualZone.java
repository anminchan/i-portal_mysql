package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("visualZone")
public class VisualZone extends DefaultDomain {
	private String url;
    
	private String site_Name;
	private String KDesc;
	private String visualZoneId;
	private String imageFileName;
	private String imageSFileName;
	private String filePath;
	private String linkURL;
	private int sort;
	private String newWindowYn;
	private String state;
	
	public String[] chkVisualZoneIds = null;			//체크 SiteId - 다중삭제용
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SiteId        : ").append(this.getSiteId())		    .append("\n")
			.append(">> VisualZoneId  : ").append(this.getVisualZoneId())   .append("\n")
			.append(">> KName         : ").append(this.getKName())		    .append("\n")
			.append(">> KDesc         : ").append(this.getKDesc())		    .append("\n")
			.append(">> ImageFileName : ").append(this.getImageFileName())  .append("\n")
			.append(">> ImageSFileName: ").append(this.getImageSFileName()) .append("\n")
			.append(">> FilePath      : ").append(this.getFilePath())		.append("\n")
			.append(">> Sort     	  : ").append(this.getSort())			.append("\n")
			.append(">> NewWindowYn   : ").append(this.getNewWindowYn())	.append("\n")
			.append(">> State         : ").append(this.getState())			.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SiteID|VisualZoneID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|NewWindowYn|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getSiteId(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getVisualZoneId(), ""))	.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getImageFileName(), "-"))	.append("|")
			.append(StringUtil.getString(this.getImageSFileName(), "-")).append("|")
			.append(StringUtil.getString(this.getFilePath(), "-"))		.append("|")
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

	public String getVisualZoneId() {
		return visualZoneId;
	}

	public void setVisualZoneId(String visualZoneId) {
		this.visualZoneId = visualZoneId;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageSFileName() {
		return imageSFileName;
	}

	public void setImageSFileName(String imageSFileName) {
		this.imageSFileName = imageSFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String[] getChkVisualZoneIds() {
		return chkVisualZoneIds;
	}

	public void setChkVisualZoneIds(String[] chkVisualZoneIds) {
		this.chkVisualZoneIds = chkVisualZoneIds;
	}

}