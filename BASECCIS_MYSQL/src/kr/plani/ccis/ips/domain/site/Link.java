package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("link")
public class Link extends Title implements Serializable {
	
	private static final long serialVersionUID = -7531125732703040389L;
	
	private int linkId;
	private String parentLinkId;
	private String replyNo;
	private String refMenuId;
	
	public int getLinkId() {
		return linkId;
	}
	public void setLinkId(int linkId) {
		this.linkId = linkId;
	}
	public String getParentLinkId() {
		return parentLinkId;
	}
	public void setParentLinkId(String parentLinkId) {
		this.parentLinkId = parentLinkId;
	}
	public String getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(String replyNo) {
		this.replyNo = replyNo;
	}
	public String getRefMenuId() {
		return refMenuId;
	}
	public void setRefMenuId(String refMenuId) {
		this.refMenuId = refMenuId;
	}
	
}
