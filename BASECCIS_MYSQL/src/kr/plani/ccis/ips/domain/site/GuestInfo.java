package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("guestInfo")
public class GuestInfo extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = 7654056370665954584L;

	private String titleId;
	
	private String guestName;
	private String key1;
	private String key2;
	private String key3;
	private String dKey;
	
	public String makeFreeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append(">> guestName		: ").append(this.getGuestName())		.append("\n")
		.append(">> key1			: ").append(this.getKey1())				.append("\n")
		.append(">> key2			: ").append(this.getKey2())				.append("\n")
		.append(">> key3			: ").append(this.getKey3())				.append("\n")
		.append(">> DKey			: ").append(this.getdKey())				.append("\n");
		return sbData.toString();
	}
	
	public String makeFreeDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		sbData
		.append(StringUtil.getString(this.getGuestName(), "-"))		.append("|")
		.append(StringUtil.getString(this.getKey1(), ""))			.append("|")
		.append(StringUtil.getString(this.getKey2(), ""))			.append("|")
		.append(StringUtil.getString(this.getKey3(), ""))			.append("|")
		.append(StringUtil.getString(this.getdKey(), "-"));			
		return sbData.toString();
	}
	
	public String getTitleId() {
		return titleId;
	}
	public void setTitleId(String titleId) {
		this.titleId = titleId;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public String getKey1() {
		return key1;
	}
	public void setKey1(String key1) {
		this.key1 = key1;
	}
	public String getKey2() {
		return key2;
	}
	public void setKey2(String key2) {
		this.key2 = key2;
	}
	public String getKey3() {
		return key3;
	}
	public void setKey3(String key3) {
		this.key3 = key3;
	}
	public String getdKey() {
		return dKey;
	}
	public void setdKey(String dKey) {
		this.dKey = dKey;
	}
}
