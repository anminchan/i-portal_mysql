package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("contentSet")
public class ContentSet extends DefaultDomain {
	private String url;
    
	private String menu_Name;
	private String depth;
	private String sort;
	private String higherId;
	private String tabYN;
	private String tabYN_Name;
	private String menuType;
	private String menuType_Name;
	private String namePath;
	private String secretYN;
	private String secretYN_Name;
	private String rssYN;
	private String rssYN_Name;
	private String countryYN;
	private String countryYN_Name;
	private String imageYN;
	private String imageYN_Name;
	private String snsYN;
	private String snsYN_Name;
	private String newYN;
	private String newYN_Name;
	private String appYN;
	private String appYN_Name;
	
	private int fileMaxCount;
	private int fileMaxSize;
	private String KDesc;
	private String boardId;
	private String boardKind;
	private String boardListKind;
	private String boardListKind_Name;
	private String boardKind_Name;
	private String categoryYN;
	private String categoryYN_Name;
	private int pageCount;
	private String commentYN;
	private String commentYN_Name;
	private String noticeYN;
	private String noticeYN_Name;
	private String startTime;
	private String endTime;
	private String addField1;
	private String addField2;
	private String addField3;
	private String addField4;
	private String addField5;
	private String addField6;
	private String addField7;
	private String addField8;
	private String addField9;
	private String addField10;
	private String State;
	private String cnt;
	private String thumbnailListKind;
	private String categoryTabYN;
	
	private String paramMenuId;
	
	private String category;
	private String categoryId;
	private String categoryName;
	
	private String manageUser;
	private String parent_cnt;
	private String child_cnt;
	
	private String Search_System;
	private String referenceMenus;
	
	private String boardHeaderKHtml;
	private String boardFooterKHtml;
	
	private String customizingYN;
	private String customizingInfo;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
			.append(">> boardID        : ").append(this.getBoardId())        .append("\n")
			.append(">> siteID         : ").append(this.getSiteId())	     .append("\n")
			.append(">> menuID         : ").append(this.getParamMenuId())    .append("\n")
			.append(">> KName          : ").append(this.getKName())	     	 .append("\n")
			.append(">> KDesc          : ").append(this.getKDesc())		 	 .append("\n")
			.append(">> boardKind      : ").append(this.getBoardKind())	 	 .append("\n")
			.append(">> commentYN      : ").append(this.getCommentYN())		 .append("\n")
			.append(">> noticeYN       : ").append(this.getNoticeYN())	     .append("\n")
			.append(">> secretYN       : ").append(this.getSecretYN())	     .append("\n")
			.append(">> rssYN          : ").append(this.getRssYN())	         .append("\n")
			.append(">> imageYN        : ").append(this.getImageYN())	     .append("\n")
			.append(">> snsYN          : ").append(this.getSnsYN())		     .append("\n")
			.append(">> newYN          : ").append(this.getNewYN())		     .append("\n")
			.append(">> fileMaxCount   : ").append(this.getFileMaxCount()) 	 .append("\n")
			.append(">> fileMaxSize    : ").append(this.getFileMaxSize())	 .append("\n")
			.append(">> State     	   : ").append(this.getState())	     	 .append("\n")
			.append(">> StartTime      : ").append(this.getStartTime())	 	 .append("\n")
			.append(">> EndTime        : ").append(this.getEndTime())	 	 .append("\n");
		
		return sbData.toString();
	}
	
	public String makeDMLDataString(String refMenuIds, String categoryCount, String categoryId, String categoryName, String customizingCount, String customizingInfo){
		//public String makeDMLDataString(String searchCount, String searchCode1, String searchCode2, String categoryCount, String categoryId, String categoryName, String confirmUserCount, String confirmUserId, String chargeUserCount, String chargeUserId, String writeUserCount, String writeUserId, String writeUser2Count, String writeUser2Id){
		//InDMLData ::  BoardID|MenuID|KName|KDesc|BoardKind|PageCount|CommentYN|NoticeYN|SecretYN|RssYN|CategoryYN|ImageYN|SnsYN|FileMaxCount|FileMaxSize|AddField1|AddField2|AddField3|State|카테고리갯수|(1)카테고리ID#(2)카테고리ID#...|(1)카테고리명#(2)카테고리명#...
		StringBuffer sbData = new StringBuffer();

		sbData
			.append(StringUtil.getString(this.getBoardId(), "-"))	  .append("|")
			.append(StringUtil.getString(this.getParamMenuId(), "-")) .append("|")
			.append(StringUtil.getString(this.getKName(), "-"))		  .append("|")
			.append(StringUtil.getString(this.getKDesc(), "-"))		  .append("|")
			.append(StringUtil.getString(this.getBoardKind(), "-"))	  .append("|")
			.append(StringUtil.getString(this.getBoardListKind(), "-")).append("|")
			.append(StringUtil.getString(this.getPageCount(), "-"))	  .append("|")
			.append(StringUtil.getString(this.getCommentYN(), "-"))	  .append("|")
			.append(StringUtil.getString(this.getNoticeYN(), "-"))	  .append("|")
			.append(StringUtil.getString(this.getSecretYN(), "-"))	  .append("|")
			.append(StringUtil.getString(this.getRssYN(), "-"))       .append("|")
			.append(StringUtil.getString(this.getCategoryYN(), "-"))  .append("|")
			.append(StringUtil.getString(this.getImageYN(), "-"))     .append("|")
			.append(StringUtil.getString(this.getSnsYN(), "-"))	      .append("|")
			.append(StringUtil.getString(this.getNewYN(), "-"))	      .append("|")
			.append(StringUtil.getString(this.getFileMaxCount(), "0")).append("|")
			.append(StringUtil.getString(this.getFileMaxSize(), "0")) .append("|")
			.append(StringUtil.getString(this.getCountryYN(), "-"))   .append("|")
			.append(StringUtil.getString(this.getAppYN(), "-"))       .append("|")
			.append(StringUtil.getString(this.getCustomizingYN(), "-")).append("|")
			.append(StringUtil.getString(this.getAddField1(), ""))	  .append("|")
			.append(StringUtil.getString(this.getAddField2(), ""))	  .append("|")
			.append(StringUtil.getString(this.getAddField3(), ""))    .append("|")
			.append(StringUtil.getString(this.getAddField4(), ""))	  .append("|")
			.append(StringUtil.getString(this.getAddField5(), ""))	  .append("|")
			.append(StringUtil.getString(this.getAddField6(), ""))    .append("|")
			.append(StringUtil.getString(this.getState(), "-"))	 	  .append("|")
		    .append(StringUtil.getString(refMenuIds, "-"))			  .append("|")
			.append(StringUtil.getString(categoryCount, "0"))		  .append("|")
			.append(StringUtil.getString(categoryId, "-"))            .append("|")
			.append(StringUtil.getString(categoryName, "-"))          .append("|")
			.append(StringUtil.getString(customizingCount, "0"))	  .append("|")
			.append(StringUtil.getString(customizingInfo, "-"));
		
		return sbData.toString();
	}
	
	public String getMenu_Name() {
		return menu_Name;
	}

	public void setMenu_Name(String menu_Name) {
		this.menu_Name = menu_Name;
	}

	public String getDepth() {
		return depth;
	}

	public void setDepth(String depth) {
		this.depth = depth;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getHigherId() {
		return higherId;
	}

	public void setHigherId(String higherId) {
		this.higherId = higherId;
	}

	public String getTabYN() {
		return tabYN;
	}

	public void setTabYN(String tabYN) {
		this.tabYN = tabYN;
	}

	public String getTabYN_Name() {
		return tabYN_Name;
	}

	public void setTabYN_Name(String tabYN_Name) {
		this.tabYN_Name = tabYN_Name;
	}

	public String getMenuType() {
		return menuType;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getMenuType_Name() {
		return menuType_Name;
	}

	public void setMenuType_Name(String menuType_Name) {
		this.menuType_Name = menuType_Name;
	}

	public String getNamePath() {
		return namePath;
	}

	public void setNamePath(String namePath) {
		this.namePath = namePath;
	}

	public String getSecretYN() {
		return secretYN;
	}

	public void setSecretYN(String secretYN) {
		this.secretYN = secretYN;
	}

	public String getSecretYN_Name() {
		return secretYN_Name;
	}

	public void setSecretYN_Name(String secretYN_Name) {
		this.secretYN_Name = secretYN_Name;
	}

	public int getFileMaxCount() {
		return fileMaxCount;
	}

	public void setFileMaxCount(int fileMaxCount) {
		this.fileMaxCount = fileMaxCount;
	}

	public int getFileMaxSize() {
		return fileMaxSize;
	}

	public void setFileMaxSize(int fileMaxSize) {
		this.fileMaxSize = fileMaxSize;
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

	public String getBoardId() {
		return boardId;
	}

	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}

	public String getBoardKind() {
		return boardKind;
	}

	public void setBoardKind(String boardKind) {
		this.boardKind = boardKind;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public String getBoardKind_Name() {
		return boardKind_Name;
	}

	public void setBoardKind_Name(String boardKind_Name) {
		this.boardKind_Name = boardKind_Name;
	}

	public String getCategoryYN() {
		return categoryYN;
	}

	public void setCategoryYN(String categoryYN) {
		this.categoryYN = categoryYN;
	}

	public String getCategoryYN_Name() {
		return categoryYN_Name;
	}

	public void setCategoryYN_Name(String categoryYN_Name) {
		this.categoryYN_Name = categoryYN_Name;
	}

	public String getCommentYN() {
		return commentYN;
	}

	public void setCommentYN(String commentYN) {
		this.commentYN = commentYN;
	}

	public String getCommentYN_Name() {
		return commentYN_Name;
	}

	public void setCommentYN_Name(String commentYN_Name) {
		this.commentYN_Name = commentYN_Name;
	}

	public String getNoticeYN() {
		return noticeYN;
	}

	public void setNoticeYN(String noticeYN) {
		this.noticeYN = noticeYN;
	}

	public String getNoticeYN_Name() {
		return noticeYN_Name;
	}

	public void setNoticeYN_Name(String noticeYN_Name) {
		this.noticeYN_Name = noticeYN_Name;
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

	public String getAddField1() {
		return addField1;
	}

	public void setAddField1(String addField1) {
		this.addField1 = addField1;
	}

	public String getAddField2() {
		return addField2;
	}

	public void setAddField2(String addField2) {
		this.addField2 = addField2;
	}

	public String getAddField3() {
		return addField3;
	}

	public void setAddField3(String addField3) {
		this.addField3 = addField3;
	}

	public String getAddField4() {
		return addField4;
	}

	public void setAddField4(String addField4) {
		this.addField4 = addField4;
	}

	public String getAddField5() {
		return addField5;
	}

	public void setAddField5(String addField5) {
		this.addField5 = addField5;
	}

	public String getAddField6() {
		return addField6;
	}

	public void setAddField6(String addField6) {
		this.addField6 = addField6;
	}

	public String getState() {
		return State;
	}

	public void setState(String state) {
		State = state;
	}

	public String getParamMenuId() {
		return paramMenuId;
	}

	public void setParamMenuId(String paramMenuId) {
		this.paramMenuId = paramMenuId;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getManageUser() {
		return manageUser;
	}

	public void setManageUser(String manageUser) {
		this.manageUser = manageUser;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getRssYN() {
		return rssYN;
	}

	public void setRssYN(String rssYN) {
		this.rssYN = rssYN;
	}

	public String getRssYN_Name() {
		return rssYN_Name;
	}

	public void setRssYN_Name(String rssYN_Name) {
		this.rssYN_Name = rssYN_Name;
	}

	public String getImageYN() {
		return imageYN;
	}

	public void setImageYN(String imageYN) {
		this.imageYN = imageYN;
	}

	public String getImageYN_Name() {
		return imageYN_Name;
	}

	public void setImageYN_Name(String imageYN_Name) {
		this.imageYN_Name = imageYN_Name;
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

	public String getBoardListKind() {
		return boardListKind;
	}

	public void setBoardListKind(String boardListKind) {
		this.boardListKind = boardListKind;
	}

	public String getBoardListKind_Name() {
		return boardListKind_Name;
	}

	public void setBoardListKind_Name(String boardListKind_Name) {
		this.boardListKind_Name = boardListKind_Name;
	}

	public String getSearch_System() {
		return Search_System;
	}

	public void setSearch_System(String search_System) {
		Search_System = search_System;
	}

	public String getCountryYN() {
		return countryYN;
	}

	public void setCountryYN(String countryYN) {
		this.countryYN = countryYN;
	}

	public String getCountryYN_Name() {
		return countryYN_Name;
	}

	public void setCountryYN_Name(String countryYN_Name) {
		this.countryYN_Name = countryYN_Name;
	}

	public String getReferenceMenus() {
		return referenceMenus;
	}

	public void setReferenceMenus(String referenceMenus) {
		this.referenceMenus = referenceMenus;
	}

	public String getSnsYN() {
		return snsYN;
	}

	public void setSnsYN(String snsYN) {
		this.snsYN = snsYN;
	}

	public String getSnsYN_Name() {
		return snsYN_Name;
	}

	public void setSnsYN_Name(String snsYN_Name) {
		this.snsYN_Name = snsYN_Name;
	}

	public String getBoardHeaderKHtml() {
		return boardHeaderKHtml;
	}

	public void setBoardHeaderKHtml(String boardHeaderKHtml) {
		this.boardHeaderKHtml = boardHeaderKHtml;
	}

	public String getBoardFooterKHtml() {
		return boardFooterKHtml;
	}

	public void setBoardFooterKHtml(String boardFooterKHtml) {
		this.boardFooterKHtml = boardFooterKHtml;
	}

	public String getNewYN() {
		return newYN;
	}

	public void setNewYN(String newYN) {
		this.newYN = newYN;
	}

	public String getNewYN_Name() {
		return newYN_Name;
	}

	public void setNewYN_Name(String newYN_Name) {
		this.newYN_Name = newYN_Name;
	}

	public String getThumbnailListKind() {
		return thumbnailListKind;
	}

	public void setThumbnailListKind(String thumbnailListKind) {
		this.thumbnailListKind = thumbnailListKind;
	}

	public String getCategoryTabYN() {
		return categoryTabYN;
	}

	public void setCategoryTabYN(String categoryTabYN) {
		this.categoryTabYN = categoryTabYN;
	}

	public String getAppYN() {
		return appYN;
	}

	public void setAppYN(String appYN) {
		this.appYN = appYN;
	}

	public String getAppYN_Name() {
		return appYN_Name;
	}

	public void setAppYN_Name(String appYN_Name) {
		this.appYN_Name = appYN_Name;
	}

	public String getCustomizingYN() {
		return customizingYN;
	}

	public void setCustomizingYN(String customizingYN) {
		this.customizingYN = customizingYN;
	}

	public String getCustomizingInfo() {
		return customizingInfo;
	}

	public void setCustomizingInfo(String customizingInfo) {
		this.customizingInfo = customizingInfo;
	}

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getAddField7() {
		return addField7;
	}

	public void setAddField7(String addField7) {
		this.addField7 = addField7;
	}

	public String getAddField8() {
		return addField8;
	}

	public void setAddField8(String addField8) {
		this.addField8 = addField8;
	}

	public String getAddField9() {
		return addField9;
	}

	public void setAddField9(String addField9) {
		this.addField9 = addField9;
	}

	public String getAddField10() {
		return addField10;
	}

	public void setAddField10(String addField10) {
		this.addField10 = addField10;
	}
	
}
