package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("newsTicker")
public class NewsTicker extends DefaultDomain {
	private String url;
    
	private int newsTickerId;
	private String linkURL;
	private String startTime;
	private String endTime;
	private String newWindowYn;
	
	public String[] newsTickerIds = null;			//체크 SiteId - 다중삭제용

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getNewsTickerId() {
		return newsTickerId;
	}

	public void setNewsTickerId(int newsTickerId) {
		this.newsTickerId = newsTickerId;
	}

	public String getLinkURL() {
		return linkURL;
	}

	public void setLinkURL(String linkURL) {
		this.linkURL = linkURL;
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

	public String[] getNewsTickerIds() {
		return newsTickerIds;
	}

	public void setNewsTickerIds(String[] newsTickerIds) {
		this.newsTickerIds = newsTickerIds;
	}
	
}
