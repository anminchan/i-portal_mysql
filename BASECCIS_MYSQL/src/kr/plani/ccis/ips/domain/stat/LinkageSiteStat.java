package kr.plani.ccis.ips.domain.stat;

import java.util.List;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("linkageSiteStat")
public class LinkageSiteStat extends DefaultDomain {
	
	private String siteName;
	private String statisSchGubun;
	private List<LinkageStat> linkageStatArr;
	private List searchDateList;
	private List searchSiteList;
	
	public String getStatisSchGubun() {
		return statisSchGubun;
	}
	public void setStatisSchGubun(String statisSchGubun) {
		this.statisSchGubun = statisSchGubun;
	}
	
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public List<LinkageStat> getLinkageStatArr() {
		return linkageStatArr;
	}
	public void setLinkageStatArr(List<LinkageStat> linkageStatArr) {
		this.linkageStatArr = linkageStatArr;
	}
	
	public List getSearchDateList() {
		return searchDateList;
	}
	public void setSearchDateList(List searchDateList) {
		this.searchDateList = searchDateList;
	}
	public List getSearchSiteList() {
		return searchSiteList;
	}
	public void setSearchSiteList(List searchSiteList) {
		this.searchSiteList = searchSiteList;
	}
}