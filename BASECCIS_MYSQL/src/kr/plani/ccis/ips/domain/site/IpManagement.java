package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("ipManagement")
public class IpManagement extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = -111160536899219696L;

	private int seq;
	private String ip_1;
	private String ip_2;
	private String ip_3;
	private String ip_4;
	private String allwYN;
	private String remk;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getIp_1() {
		return ip_1;
	}
	public void setIp_1(String ip_1) {
		this.ip_1 = ip_1;
	}
	public String getIp_2() {
		return ip_2;
	}
	public void setIp_2(String ip_2) {
		this.ip_2 = ip_2;
	}
	public String getIp_3() {
		return ip_3;
	}
	public void setIp_3(String ip_3) {
		this.ip_3 = ip_3;
	}
	public String getIp_4() {
		return ip_4;
	}
	public void setIp_4(String ip_4) {
		this.ip_4 = ip_4;
	}
	public String getAllwYN() {
		return allwYN;
	}
	public void setAllwYN(String allwYN) {
		this.allwYN = allwYN;
	}
	public String getRemk() {
		return remk;
	}
	public void setRemk(String remk) {
		this.remk = remk;
	}
	
}
