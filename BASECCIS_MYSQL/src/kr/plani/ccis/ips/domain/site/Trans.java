package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("trans")
public class Trans extends DefaultDomain {
	
	private String transId;
	private String transMenuId;
	private String transTargetMenuId;

	private String paramMenuId;
	
	private String transGubun;
	
	public String[] TRANSID_ARR;
	public String[] TRANSID_TARGET_ARR;
	
	public String getTransId() {
		return transId;
	}
	public void setTransId(String transId) {
		this.transId = transId;
	}
	
	public String getTransMenuId() {
		return transMenuId;
	}
	public void setTransMenuId(String transMenuId) {
		this.transMenuId = transMenuId;
	}
	public String getTransTargetMenuId() {
		return transTargetMenuId;
	}
	public void setTransTargetMenuId(String transTargetMenuId) {
		this.transTargetMenuId = transTargetMenuId;
	}
	public String getParamMenuId() {
		return paramMenuId;
	}
	public void setParamMenuId(String paramMenuId) {
		this.paramMenuId = paramMenuId;
	}
	public String getTransGubun() {
		return transGubun;
	}
	public void setTransGubun(String transGubun) {
		this.transGubun = transGubun;
	}
	public String[] getTRANSID_ARR() {
		return TRANSID_ARR;
	}
	public void setTRANSID_ARR(String[] tRANSID_ARR) {
		this.TRANSID_ARR = tRANSID_ARR;
	}
	public String[] getTRANSID_TARGET_ARR() {
		return TRANSID_TARGET_ARR;
	}
	public void setTRANSID_TARGET_ARR(String[] tRANSID_TARGET_ARR) {
		this.TRANSID_TARGET_ARR = tRANSID_TARGET_ARR;
	}
	
	
}
