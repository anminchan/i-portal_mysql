package kr.plani.ccis.ips.domain.stat;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("categoryStat")
public class CategoryStat extends DefaultDomain {
	
	private String statisSchGubun;
	private String paramMenuId;
	private String inNo;
	public String[] chkIds = null;
	private String siteName;
	
	private String categoryGubun;
	
	
	public String getStatisSchGubun() {
		return statisSchGubun;
	}

	public void setStatisSchGubun(String statisSchGubun) {
		this.statisSchGubun = statisSchGubun;
	}

	public String getParamMenuId() {
		return paramMenuId;
	}

	public void setParamMenuId(String paramMenuId) {
		this.paramMenuId = paramMenuId;
	}

	public String[] getChkIds() {
		return chkIds;
	}

	public void setChkIds(String[] chkIds) {
		this.chkIds = chkIds;
	}

	public String getInNo() {
		return inNo;
	}

	public void setInNo(String inNo) {
		this.inNo = inNo;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getCategoryGubun() {
		return categoryGubun;
	}

	public void setCategoryGubun(String categoryGubun) {
		this.categoryGubun = categoryGubun;
	}
	
}