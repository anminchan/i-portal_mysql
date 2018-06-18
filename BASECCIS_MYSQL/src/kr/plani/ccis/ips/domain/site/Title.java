package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;

@Alias("title")
public class Title extends ContentSet implements Serializable {
	
	private static final long serialVersionUID = -8941057334164625127L;
	
	private int titleId;
	private int hitCount;
	private int upCount;

	private String openYN="Y";
	private String userName;
	
	private String process;
	private String noticeTitleYN;
	private String secretTitleYN;
	
	private String createTime;
	private String startTime;
	private String endTime;
	private String noticeStartTime;
	private String noticeEndTime;
	
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String keyword4;
	private String keyword5;
	private String keyword6;
	private String keyword7;
	private String keyword8;
	private String keyword9;
	private String keyword10;
	
	private String contents1;
	private String contents2;
	private String contents3;
	private String contents4;
	private String contents5;
	private String contents6;
	
	private String contents7;  //텍스트 추가
	private String contents8;  //텍스트 추가
	private String contents9;  //텍스트 추가
	private String contents10; //텍스트 추가
	
	private String linkUrl;
	private String categoryId;
	
	public String[] linkIds;
	
	/*Out Parameter*/
	private String outMenuTitle;
	private String outMenuDesc;
	
	private int outEventId;
	
	private String YEAR;
	private String MONTH;
	private String DD;
	private String yearMonth;
	
	private String pKeyword;

	public String[] getLinkIds() {
		return linkIds;
	}
	public void setLinkIds(String[] linkIds) {
		this.linkIds = linkIds;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getUpCount() {
		return upCount;
	}
	public void setUpCount(int upCount) {
		this.upCount = upCount;
	}
	public String getOpenYN() {
		return openYN;
	}
	public void setOpenYN(String openYN) {
		this.openYN = openYN;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
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
	public String getKeyword1() {
		return keyword1;
	}
	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}
	public String getKeyword2() {
		return keyword2;
	}
	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}
	public String getKeyword3() {
		return keyword3;
	}
	public void setKeyword3(String keyword3) {
		this.keyword3 = keyword3;
	}
	public String getContents1() {
		return contents1;
	}
	public void setContents1(String contents1) {
		this.contents1 = contents1;
	}
	public String getContents2() {
		return contents2;
	}
	public void setContents2(String contents2) {
		this.contents2 = contents2;
	}
	public String getContents3() {
		return contents3;
	}
	public void setContents3(String contents3) {
		this.contents3 = contents3;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = StringUtil.paramUnscript(categoryId);
	}
	public String getOutMenuTitle() {
		return outMenuTitle;
	}
	public void setOutMenuTitle(String outMenuTitle) {
		this.outMenuTitle = outMenuTitle;
	}
	public String getOutMenuDesc() {
		return outMenuDesc;
	}
	public void setOutMenuDesc(String outMenuDesc) {
		this.outMenuDesc = outMenuDesc;
	}
	public int getTitleId() {
		return titleId;
	}
	public void setTitleId(int titleId) {
		this.titleId = titleId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNoticeTitleYN() {
		return noticeTitleYN;
	}
	public void setNoticeTitleYN(String noticeTitleYN) {
		this.noticeTitleYN = noticeTitleYN;
	}
	public String getSecretTitleYN() {
		return secretTitleYN;
	}
	public void setSecretTitleYN(String secretTitleYN) {
		this.secretTitleYN = secretTitleYN;
	}
	public String getContents4() {
		return contents4;
	}
	public void setContents4(String contents4) {
		this.contents4 = contents4;
	}
	public String getContents5() {
		return contents5;
	}
	public void setContents5(String contents5) {
		this.contents5 = contents5;
	}
	public String getContents6() {
		return contents6;
	}
	public void setContents6(String contents6) {
		this.contents6 = contents6;
	}
	public int getOutEventId() {
		return outEventId;
	}
	public void setOutEventId(int outEventId) {
		this.outEventId = outEventId;
	}
	public String getYEAR() {
		return YEAR;
	}
	public void setYEAR(String yEAR) {
		YEAR = yEAR;
	}
	public String getMONTH() {
		return MONTH;
	}
	public void setMONTH(String mONTH) {
		MONTH = mONTH;
	}
	public String getDD() {
		return DD;
	}
	public void setDD(String dD) {
		DD = dD;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getpKeyword() {
		return pKeyword;
	}
	public void setpKeyword(String pKeyword) {
		this.pKeyword = pKeyword;
	}
	public String getKeyword4() {
		return keyword4;
	}
	public void setKeyword4(String keyword4) {
		this.keyword4 = keyword4;
	}
	public String getKeyword5() {
		return keyword5;
	}
	public void setKeyword5(String keyword5) {
		this.keyword5 = keyword5;
	}
	public String getKeyword6() {
		return keyword6;
	}
	public void setKeyword6(String keyword6) {
		this.keyword6 = keyword6;
	}
	public String getKeyword7() {
		return keyword7;
	}
	public void setKeyword7(String keyword7) {
		this.keyword7 = keyword7;
	}
	public String getKeyword8() {
		return keyword8;
	}
	public void setKeyword8(String keyword8) {
		this.keyword8 = keyword8;
	}
	public String getKeyword9() {
		return keyword9;
	}
	public void setKeyword9(String keyword9) {
		this.keyword9 = keyword9;
	}
	public String getKeyword10() {
		return keyword10;
	}
	public void setKeyword10(String keyword10) {
		this.keyword10 = keyword10;
	}
	public String getNoticeStartTime() {
		return noticeStartTime;
	}
	public void setNoticeStartTime(String noticeStartTime) {
		this.noticeStartTime = noticeStartTime;
	}
	public String getNoticeEndTime() {
		return noticeEndTime;
	}
	public void setNoticeEndTime(String noticeEndTime) {
		this.noticeEndTime = noticeEndTime;
	}
	public String getContents7() {
		return contents7;
	}
	public void setContents7(String contents7) {
		this.contents7 = contents7;
	}
	public String getContents8() {
		return contents8;
	}
	public void setContents8(String contents8) {
		this.contents8 = contents8;
	}
	public String getContents9() {
		return contents9;
	}
	public void setContents9(String contents9) {
		this.contents9 = contents9;
	}
	public String getContents10() {
		return contents10;
	}
	public void setContents10(String contents10) {
		this.contents10 = contents10;
	}
	
}
