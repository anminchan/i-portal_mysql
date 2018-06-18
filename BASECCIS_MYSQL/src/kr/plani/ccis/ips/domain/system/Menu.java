package kr.plani.ccis.ips.domain.system;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("menu")
public class Menu extends DefaultDomain {
	private String url;
    
	private String KDesc;
	private int Depth;
	private int Sort;
	private String HigherID;
	private String HigherID_Name;
	private String ImagePath;
	private String ImageFile;
	private String MenuType;
	private String ProgramURL;
	private String ChargeUserID;
	private String ChargeUserID_Name;
	private String TabYN;
	private String UserGradeYN;
	private String State;
	private String startTime;
	private String endTime;
	private String Search_System;
	private String displayYN;
	private String newMenuYN;
	private String imgKind;

	private String parent_cnt;
	private String child_cnt;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> MenuId        : ").append(this.getParamMenuId()) .append("\n")
			.append(">> SiteId        : ").append(this.getSiteId())	     .append("\n")
			.append(">> KName         : ").append(this.getKName())	     .append("\n")
			.append(">> KDesc         : ").append(this.getKDesc())		 .append("\n")
			.append(">> TabYN         : ").append(this.getTabYN())		 .append("\n")
			.append(">> Depth         : ").append(this.getDepth())		 .append("\n")
			.append(">> Sort          : ").append(this.getSort())		 .append("\n")
			.append(">> HigherId      : ").append(this.getHigherID())	 .append("\n")
			.append(">> ImagePath     : ").append(this.getImagePath())	 .append("\n")
			.append(">> ImageFile     : ").append(this.getImageFile())	 .append("\n")
			.append(">> ProgramURL    : ").append(this.getProgramURL())	 .append("\n")
			.append(">> ChargeUserID  : ").append(this.getChargeUserID()).append("\n")
			.append(">> UserGradeYN   : ").append(this.getUserGradeYN()) .append("\n")
			.append(">> DisplayYN     : ").append(this.getDisplayYN())   .append("\n")
			.append(">> State     	  : ").append(this.getState())	     .append("\n")
			.append(">> StartTime     : ").append(this.getStartTime())	 .append("\n")
			.append(">> EndTime       : ").append(this.getEndTime())	 .append("\n");
		
		return sbData.toString();
	}
	
	public String makeDMLDataString(){
		//MenuID|SiteID|KName|Depth|Sort|HigherID|ImagePath|ImageFile|ProgramURL|ChargeUserID|TabYN|UserGradeYN|DisplayYN|MenuType|State|NewMenuYN...
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getParamMenuId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getSiteId(), "-"))	    .append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getDepth(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSort(), "-"))			.append("|")
			.append(StringUtil.getString(this.getHigherID(), "-"))		.append("|")
			.append(StringUtil.getString(this.getImagePath(), "-"))		.append("|")
			.append(StringUtil.getString(this.getImageFile(), "-"))		.append("|")
			.append(StringUtil.getString(this.getProgramURL(), "-"))	.append("|")
			.append(StringUtil.getString(this.getChargeUserID(), "-"))	.append("|")
			.append(StringUtil.getString(this.getTabYN(), "-"))		    .append("|")
			.append(StringUtil.getString(this.getUserGradeYN(), "-"))	.append("|")
			.append(StringUtil.getString(this.getDisplayYN(), "-"))		.append("|")
			.append(StringUtil.getString(this.getMenuType(), "-"))		.append("|")
			.append(StringUtil.getString(this.getState(), "-"))			.append("|")
			.append(StringUtil.getString(this.getNewMenuYN(), "-"))		.append("|")
		    .append(StringUtil.getString(this.getImgKind(), "-"));
					
		
		return sbData.toString();
	}
	

	public String getKDesc() {
		return KDesc;
	}

	public void setKDesc(String kDesc) {
		KDesc = kDesc;
	}

	public int getDepth() {
		return Depth;
	}

	public void setDepth(int depth) {
		Depth = depth;
	}

	public int getSort() {
		return Sort;
	}

	public void setSort(int sort) {
		Sort = sort;
	}

	public String getHigherID() {
		return HigherID;
	}

	public void setHigherID(String higherID) {
		HigherID = higherID;
	}

	public String getHigherID_Name() {
		return HigherID_Name;
	}

	public void setHigherID_Name(String higherID_Name) {
		HigherID_Name = higherID_Name;
	}

	public String getImagePath() {
		return ImagePath;
	}

	public void setImagePath(String imagePath) {
		ImagePath = imagePath;
	}

	public String getImageFile() {
		return ImageFile;
	}

	public void setImageFile(String imageFile) {
		ImageFile = imageFile;
	}

	public String getMenuType() {
		return MenuType;
	}

	public void setMenuType(String menuType) {
		MenuType = menuType;
	}

	public String getProgramURL() {
		return ProgramURL;
	}

	public void setProgramURL(String programURL) {
		ProgramURL = programURL;
	}

	public String getChargeUserID() {
		return ChargeUserID;
	}

	public void setChargeUserID(String chargeUserID) {
		ChargeUserID = chargeUserID;
	}

	public String getChargeUserID_Name() {
		return ChargeUserID_Name;
	}

	public void setChargeUserID_Name(String chargeUserID_Name) {
		ChargeUserID_Name = chargeUserID_Name;
	}

	public String getUserGradeYN() {
		return UserGradeYN;
	}

	public void setUserGradeYN(String userGradeYN) {
		UserGradeYN = userGradeYN;
	}

	public String getTabYN() {
		return TabYN;
	}

	public void setTabYN(String tabYN) {
		TabYN = tabYN;
	}

	public String getState() {
		return State;
	}

	public void setState(String state) {
		State = state;
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

	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	public String getSearch_System() {
		return Search_System;
	}

	public void setSearch_System(String search_System) {
		Search_System = search_System;
	}

	public String getDisplayYN() {
		return displayYN;
	}

	public void setDisplayYN(String displayYN) {
		this.displayYN = displayYN;
	}

	public String getNewMenuYN() {
		return newMenuYN;
	}

	public void setNewMenuYN(String newMenuYN) {
		this.newMenuYN = newMenuYN;
	}

	public String getImgKind() {
		return imgKind;
	}

	public void setImgKind(String imgKind) {
		this.imgKind = imgKind;
	}

	public String getParent_cnt() {
		return parent_cnt;
	}

	public void setParent_cnt(String parent_cnt) {
		this.parent_cnt = parent_cnt;
	}

	public String getChild_cnt() {
		return child_cnt;
	}

	public void setChild_cnt(String child_cnt) {
		this.child_cnt = child_cnt;
	}
	
}
