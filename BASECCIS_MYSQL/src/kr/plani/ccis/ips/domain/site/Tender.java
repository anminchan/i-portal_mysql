package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;

@Alias("tender")
public class Tender extends Link implements Serializable {
	
	private static final long serialVersionUID = -111160536899219696L;
	
	private String tenderNo;
	private String selfYN;
	private double tenderAmt = 0;
	private String tenderDate;
	private String bidCompanyName;
	private int bidAmt = 0;
	private String contractStartDate;
	private String contractEndDate;
	private String tenderState;
	private String noticeDate;
	private String KHtml;
	
	//TenderNo|SelfYN|NoticeDate|TenderAmt|TenderDate|BidCompanyName|BidAmt|ContractStartDate|ContractEndDate|TenderState|
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
			.append(">> tenderNo				: ").append(this.getTenderNo())				.append("\n")
			.append(">> selfYN					: ").append(this.getSelfYN())				.append("\n")
			.append(">> noticeDate				: ").append(this.getNoticeDate())			.append("\n")
			.append(">> tenderAmt				: ").append(this.getTenderAmt())			.append("\n")
			.append(">> tenderDate				: ").append(this.getTenderDate())			.append("\n")
			.append(">> bidCompanyName			: ").append(this.getBidCompanyName())		.append("\n")
			.append(">> BidAmt					: ").append(this.getBidAmt())				.append("\n")
			.append(">> contractStartDate		: ").append(this.getContractStartDate())	.append("\n")
			.append(">> contractEndDate			: ").append(this.getContractEndDate())		.append("\n")
			.append(">> tenderState       		: ").append(this.getTenderState())			.append("\n");
		return sbData.toString();
	}
	
	public String makeDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getNoticeDate(), "-").equals("-")) this.setNoticeDate(this.getNoticeDate().replaceAll("-", ""));
		if(!StringUtil.getString(this.getTenderDate(), "-").equals("-")) this.setTenderDate(this.getTenderDate().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContractStartDate(), "-").equals("-")) this.setContractStartDate(this.getContractStartDate().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContractEndDate(), "-").equals("-")) this.setContractEndDate(this.getContractEndDate().replaceAll("-", ""));

		sbData
			.append(StringUtil.getString(this.getTenderNo(), "-"))				.append("|")
			.append(StringUtil.getString(this.getSelfYN(), "-"))				.append("|")
			.append(StringUtil.getString(this.getNoticeDate(), "-"))			.append("|")
			.append(StringUtil.getString(this.getTenderAmt(), "0"))				.append("|")
			.append(StringUtil.getString(this.getTenderDate(), "-"))			.append("|")
			.append(StringUtil.getString(this.getBidCompanyName(), "-"))		.append("|")
			.append(StringUtil.getString(this.getBidAmt(), "0"))				.append("|")
			.append(StringUtil.getString(this.getContractStartDate(), "-"))		.append("|")
			.append(StringUtil.getString(this.getContractEndDate(), "-"))		.append("|")
			.append(StringUtil.getString(this.getTenderState(), "-"));
		
		return sbData.toString();
	}
	
	//MenuId|BoardID|LinkID|Kname|OpenYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|
	public String makeContentDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
			.append(">> menuID					: ").append(this.getMenuId())				.append("\n")
			.append(">> boardID        			: ").append(this.getBoardId())				.append("\n")
			.append(">> linkID					: ").append(this.getLinkId())         		.append("\n")
			.append(">> kName					: ").append(this.getKName())				.append("\n")
			.append(">> openYN          		: ").append(this.getOpenYN())				.append("\n")
			.append(">> noticeTitleYN			: ").append(this.getNoticeTitleYN())		.append("\n")
			.append(">> keyword1				: ").append(this.getKeyword1())				.append("\n")
			.append(">> keyword2       			: ").append(this.getKeyword2())				.append("\n")
			.append(">> keyword3       			: ").append(this.getKeyword3())				.append("\n")
			.append(">> contents1       		: ").append(this.getContents1())			.append("\n")
			.append(">> contents2				: ").append(this.getContents2())			.append("\n")
			.append(">> contents3				: ").append(this.getContents3())			.append("\n")
			.append(">> categoryId				: ").append(this.getCategoryId())			.append("\n")			
			.append(">> startTime				: ").append(this.getStartTime())			.append("\n")
			.append(">> endTime					: ").append(this.getEndTime())				.append("\n");			
		
		return sbData.toString();
	}
	
	public String makeContentDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
			.append(StringUtil.getString(this.getMenuId(), "-"))				.append("|")
			.append(StringUtil.getString(this.getBoardId(), "-"))				.append("|")
			.append(StringUtil.getString(this.getLinkId(), "-1"))         		.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))					.append("|")
			.append(StringUtil.getString(this.getOpenYN(), "Y"))				.append("|")
			.append(StringUtil.getString(this.getNoticeTitleYN(), "N"))			.append("|")
			.append(StringUtil.getString(this.getKeyword1(), "-"))				.append("|")
			.append(StringUtil.getString(this.getKeyword2(), "-"))				.append("|")
			.append(StringUtil.getString(this.getKeyword3(), "-"))				.append("|")
			.append(StringUtil.getString(this.getContents1(), "-"))				.append("|")
			.append(StringUtil.getString(this.getContents2(), "-"))				.append("|")
			.append(StringUtil.getString(this.getContents3(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCategoryId(), "-"))			.append("|")			
			.append(StringUtil.getString(this.getStartTime(), "-"))				.append("|")
			.append(StringUtil.getString(this.getEndTime(), "-"));
		
		return sbData.toString();
	}
	
	public String makeContentDMLDataString2(String searchCount, String searchCode1, String searchCode2, String mainYN){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
			.append(StringUtil.getString(this.getMenuId(), "-"))				.append("|")
			.append(StringUtil.getString(this.getBoardId(), "-"))				.append("|")
			.append(StringUtil.getString(this.getLinkId(), "-1"))         		.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))					.append("|")
			.append(StringUtil.getString(this.getOpenYN(), "Y"))				.append("|")
			.append(StringUtil.getString(this.getNoticeTitleYN(), "N"))			.append("|")
			.append(StringUtil.getString(this.getKeyword1(), "-"))				.append("|")
			.append(StringUtil.getString(this.getKeyword2(), "-"))				.append("|")
			.append(StringUtil.getString(this.getKeyword3(), "-"))				.append("|")
			.append(StringUtil.getString(this.getContents1(), "-"))				.append("|")
			.append(StringUtil.getString(this.getContents2(), "-"))				.append("|")
			.append(StringUtil.getString(this.getContents3(), "-"))				.append("|")
			.append(StringUtil.getString(this.getCategoryId(), "-"))			.append("|")			
			.append(StringUtil.getString(this.getStartTime(), "-"))				.append("|")
			.append(StringUtil.getString(this.getEndTime(), "-"))				.append("|")
			
			.append(StringUtil.getString(searchCount, "0"))		       			.append("|")
			.append(StringUtil.getString(searchCode1, "-"))						.append("|")
		    .append(StringUtil.getString(searchCode2, "-"))						.append("|")
		    .append(StringUtil.getString(mainYN, "-"));
		
		return sbData.toString();
	}
	
	public String getTenderNo() {
		return tenderNo;
	}
	public void setTenderNo(String tenderNo) {
		this.tenderNo = tenderNo;
	}
	public String getSelfYN() {
		return selfYN;
	}
	public void setSelfYN(String selfYN) {
		this.selfYN = selfYN;
	}
	public String getTenderDate() {
		return tenderDate;
	}
	public void setTenderDate(String tenderDate) {
		this.tenderDate = tenderDate;
	}
	public String getBidCompanyName() {
		return bidCompanyName;
	}
	public void setBidCompanyName(String bidCompanyName) {
		this.bidCompanyName = bidCompanyName;
	}
	public String getContractStartDate() {
		return contractStartDate;
	}
	public void setContractStartDate(String contractStartDate) {
		this.contractStartDate = contractStartDate;
	}
	public String getContractEndDate() {
		return contractEndDate;
	}
	public void setContractEndDate(String contractEndDate) {
		this.contractEndDate = contractEndDate;
	}
	public String getTenderState() {
		return tenderState;
	}
	public void setTenderState(String tenderState) {
		this.tenderState = tenderState;
	}
	public String getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(String noticeDate) {
		this.noticeDate = noticeDate;
	}
	public double getTenderAmt() {
		return tenderAmt;
	}
	public void setTenderAmt(double tenderAmt) {
		this.tenderAmt = tenderAmt;
	}

	public int getBidAmt() {
		return bidAmt;
	}

	public void setBidAmt(int bidAmt) {
		this.bidAmt = bidAmt;
	}

	public String getKHtml() {
		return KHtml;
	}

	public void setKHtml(String kHtml) {
		KHtml = kHtml;
	}
	
}
