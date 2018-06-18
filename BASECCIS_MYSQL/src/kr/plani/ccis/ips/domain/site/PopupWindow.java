package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("popupWindow")
public class PopupWindow extends DefaultDomain {
	private String url;
    
	private String site_Name;
	private String KDesc;
	private String popupId;
	private String imageFileName;
	private String imageSFileName;
	private String filePath;
	private String linkURL;
	private int sort;
	private int positionX;
	private int positionY;
	private int popupWidth;
	private int popupHeight;
	private String startTime;
	private String endTime;
	private String newWindowYn;
	private String daySessionYn;
	
	public String[] chkPopupIds = null;			//체크 SiteId - 다중삭제용
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SiteId        : ").append(this.getSiteId())		    .append("\n")
			.append(">> PopupId       : ").append(this.getPopupId())        .append("\n")
			.append(">> KName         : ").append(this.getKName())		    .append("\n")
			.append(">> KDesc         : ").append(this.getKDesc())		    .append("\n")
			.append(">> ImageFileName : ").append(this.getImageFileName())  .append("\n")
			.append(">> ImageSFileName: ").append(this.getImageSFileName()) .append("\n")
			.append(">> FilePath      : ").append(this.getFilePath())		.append("\n")
			.append(">> Sort     	  : ").append(this.getSort())			.append("\n")
			.append(">> PositionX     : ").append(this.getPositionX())		.append("\n")
			.append(">> PositionY     : ").append(this.getPositionY())		.append("\n")
			.append(">> PopupWidth    : ").append(this.getPopupWidth())		.append("\n")
			.append(">> PopupHeigh    : ").append(this.getPopupHeight())	.append("\n")
			.append(">> StartTime     : ").append(this.getStartTime())		.append("\n")
			.append(">> EndTime 	  : ").append(this.getEndTime())		.append("\n")
			.append(">> NewWindowYn   : ").append(this.getNewWindowYn())	.append("\n")
			.append(">> DaySessionYn  : ").append(this.getDaySessionYn())	.append("\n")
			.append(">> State         : ").append(this.getState())			.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData :: SiteID|PopupID||KName|KDesc|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|PositionX|PositionY|PopupWidth|PopupHeight|StratTime|EndTime|NewWindowYn|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getSiteId(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getPopupId(), ""))	    .append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getImageFileName(), "-"))	.append("|")
			.append(StringUtil.getString(this.getImageSFileName(), "-")).append("|")
			.append(StringUtil.getString(this.getFilePath(), "-"))		.append("|")
			.append(StringUtil.getString(this.getLinkURL(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getSort(), "-"))			.append("|")
			.append(StringUtil.getString(this.getPositionX(), "-"))		.append("|")
			.append(StringUtil.getString(this.getPositionY(), "-"))		.append("|")
			.append(StringUtil.getString(this.getPopupWidth(), "-"))	.append("|")
			.append(StringUtil.getString(this.getPopupHeight(), "-"))	.append("|")
			.append(StringUtil.getString(this.getStartTime(), "-"))		.append("|")
			.append(StringUtil.getString(this.getEndTime(), "-"))		.append("|")
			.append(StringUtil.getString(this.getNewWindowYn(), "-"))   .append("|")
			.append(StringUtil.getString(this.getDaySessionYn(), "-"))  .append("|")
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
	
	public String getPopupId() {
		return popupId;
	}

	public void setPopupId(String popupId) {
		this.popupId = popupId;
	}

	public int getPositionX() {
		return positionX;
	}

	public void setPositionX(int positionX) {
		this.positionX = positionX;
	}

	public int getPositionY() {
		return positionY;
	}

	public void setPositionY(int positionY) {
		this.positionY = positionY;
	}

	public int getPopupWidth() {
		return popupWidth;
	}

	public void setPopupWidth(int popupWidth) {
		this.popupWidth = popupWidth;
	}

	public int getPopupHeight() {
		return popupHeight;
	}

	public void setPopupHeight(int popupHeight) {
		this.popupHeight = popupHeight;
	}

	public String[] getChkPopupIds() {
		return chkPopupIds;
	}

	public void setChkPopupIds(String[] chkPopupIds) {
		this.chkPopupIds = chkPopupIds;
	}

	public void setSort(int sort) {
		this.sort = sort;
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
	public String getNewWindowYn() {
		return newWindowYn;
	}
	public void setNewWindowYn(String newWindowYn) {
		this.newWindowYn = newWindowYn;
	}

	public String getDaySessionYn() {
		return daySessionYn;
	}

	public void setDaySessionYn(String daySessionYn) {
		this.daySessionYn = daySessionYn;
	}

	public String[] getChkPopupZoneIds() {
		int length = 0;
		if(this.chkPopupIds != null){
			length = this.chkPopupIds.length;
		}
		String [] strArray = new String[length];
		for (int i = 0; i < strArray.length; i++) {
			strArray[i] = chkPopupIds[i];
		}
		return strArray;
	}

	public void setChkPopupZoneIds(String[] chkPopupZoneIds) {
		int length = 0;
		if(chkPopupZoneIds != null){
			length = chkPopupZoneIds.length;
		}
		this.chkPopupIds = new String[length];
		for (int i = 0; i < length; i++) {
			this.chkPopupIds[i] = chkPopupZoneIds[i];
		}
	}
	
}
