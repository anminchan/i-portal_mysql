package kr.plani.ccis.ips.domain.system;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("code")
public class Code extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = 2977202047467798417L;
	
	private String code;
	private String higherCode;
	private String higherCode_Name;
	
	private int depth;
	private int sort;
	
	private String EName;
	
	private String inputGRVal; //그룹권한 입력값
	
	//in Parameter
	private String inCode;
	private String inSiteID;
	
	private String paramMenuId;
	
	private String paramCode;
	private String paramHigherCode;
	
	private String paramSortCode;
	private String paramSortHigherCode;

	//out Parameter
	private Object outCodeTreeCursor;

	private int codeSchType;
	private String codeSchText;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> Code        : ").append(this.getParamCode()) 	.append("\n")
			.append(">> HigherCode  : ").append(this.getHigherCode())	.append("\n")
			.append(">> SiteId      : ").append(this.getSiteId())		.append("\n")
			.append(">> KName       : ").append(this.getKName())		.append("\n")
			.append(">> Ename       : ").append(this.getEName())		.append("\n")
			.append(">> Depth       : ").append(this.getDepth())		.append("\n")
			.append(">> Sort        : ").append(this.getSort())			.append("\n")
			.append(">> State      	: ").append(this.getState())	.append("\n");
		
		return sbData.toString();
	}
	
	public String makeDMLDataString(){
		//InDMLData ::  Code|HigherCode|KName|Depth|Sort|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getParamCode(), "-"))		.append("|")
			.append(StringUtil.getString(this.getHigherCode(), "-"))	.append("|")
			.append(StringUtil.getString(this.getSiteId(), "-"))		.append("|")			
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getEName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getDepth(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSort(), "-"))			.append("|")
			.append(StringUtil.getString(this.getState(), "-"));

		
		return sbData.toString();
	}	
	
	
	public String getInputGRVal() {
		return inputGRVal;
	}

	public void setInputGRVal(String inputGRVal) {
		this.inputGRVal = inputGRVal;
	}

	
	public String getEName() {
		return EName;
	}

	public void setEName(String EName) {
		this.EName = EName;
	}
	
	public String getHigherCode() {
		return higherCode;
	}

	public void setHigherCode(String higherCode) {
		this.higherCode = higherCode;
	}
	
	public String getHigherCode_Name() {
		return higherCode_Name;
	}

	public void setHigherCode_Name(String higherCode_Name) {
		this.higherCode_Name = higherCode_Name;
	}
	
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getInCode() {
		return inCode;
	}

	public void setInCode(String inCode) {
		this.inCode = inCode;
	}
	
	public String getInSiteID() {
		return inSiteID;
	}

	public void setInSiteID(String inSiteID) {
		this.inSiteID = inSiteID;
	}
	
	public Object getOutCodeTreeCursor() {
		return outCodeTreeCursor;
	}

	public void setOutCodeTreeCursor(Object outCodeTreeCursor) {
		this.outCodeTreeCursor = outCodeTreeCursor;
	}	
	
	public String getParamMenuId() {
		return paramMenuId;
	}

	public void setParamMenuId(String paramMenuId) {
		this.paramMenuId = paramMenuId;
	}
	
	public String getParamHigherCode() {
		return paramHigherCode;
	}

	public void setParamHigherCode(String paramHigherCode) {
		this.paramHigherCode = paramHigherCode;
	}
	
	public String getParamCode() {
		return paramCode;
	}

	public void setParamCode(String paramCode) {
		this.paramCode = paramCode;
	}
	

	public String getParamSortHigherCode() {
		return paramSortHigherCode;
	}

	public void setParamSortHigherCode(String paramSortHigherCode) {
		this.paramSortHigherCode = paramSortHigherCode;
	}
	
	public String getParamSortCode() {
		return paramSortCode;
	}

	public void setParamSortCode(String paramSortCode) {
		this.paramSortCode = paramSortCode;
	}

	public int getCodeSchType() {
		return codeSchType;
	}

	public void setCodeSchType(int codeSchType) {
		this.codeSchType = codeSchType;
	}

	public String getCodeSchText() {
		return codeSchText;
	}

	public void setCodeSchText(String codeSchText) {
		this.codeSchText = codeSchText;
	}

}
