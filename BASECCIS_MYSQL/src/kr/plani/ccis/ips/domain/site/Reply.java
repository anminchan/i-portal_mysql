package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("reply")
public class Reply extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = -7208558617112827653L;
	
	private String replyId;
	private String linkId;
	private String replyDesc;
	private String isMyReply;
	
	private String dmlUserName;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
			.append(">> linkId          : ").append(this.getLinkId())			.append("\n")
			.append(">> replyId         : ").append(this.getReplyId())			.append("\n")
			.append(">> replyDesc       : ").append(this.getReplyDesc())		.append("\n");			
		
		return sbData.toString();
	}
	
	public String makeDMLDataString(){
		//InDMLData ::  replyId|linkID|replyDesc
		StringBuffer sbData = new StringBuffer();

		sbData
			.append(StringUtil.getString(this.getLinkId(), "-"))		.append("|")
			.append(StringUtil.getString(this.getReplyId(), "-1"))		.append("|")
			.append(StringUtil.getString(this.getReplyDesc(), "-"));	
		
		return sbData.toString();
	}
	
	public String getReplyId() {
		return replyId;
	}
	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}
	public String getLinkId() {
		return linkId;
	}
	public void setLinkId(String linkId) {
		this.linkId = linkId;
	}
	public String getReplyDesc() {
		return replyDesc;
	}
	public void setReplyDesc(String replyDesc) {
		this.replyDesc = replyDesc;
	}

	public String getDmlUserName() {
		return dmlUserName;
	}

	public void setDmlUserName(String dmlUserName) {
		this.dmlUserName = dmlUserName;
	}

	public String getIsMyReply() {
		return isMyReply;
	}

	public void setIsMyReply(String isMyReply) {
		this.isMyReply = isMyReply;
	}
	
}
