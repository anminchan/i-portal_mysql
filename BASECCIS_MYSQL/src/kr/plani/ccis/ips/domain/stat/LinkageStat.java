package kr.plani.ccis.ips.domain.stat;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("linkageStat")
public class LinkageStat extends DefaultDomain {
	private String statDate;
	private String statCnt;
	private String totalCnt;
	private String rate;
	
	public String getStatDate() {
		return statDate;
	}
	public void setStatDate(String statDate) {
		this.statDate = statDate;
	}
	public String getStatCnt() {
		return statCnt;
	}
	public void setStatCnt(String statCnt) {
		this.statCnt = statCnt;
	}
	public String getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(String totalCnt) {
		this.totalCnt = totalCnt;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}
}