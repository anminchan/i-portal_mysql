package kr.plani.ccis.ips.domain.site;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("imagePool")
public class ImagePool extends DefaultDomain {

	private int schType;
	private String schText;

	private String imagePoolId;
	private String KDesc;
	private String imageFileName;
	private String imageSFileName;
	private String filePath;
	private String keyword1;
	private String keyword2;
	private String keyword3;
	private String keyword4;
	private String keyword5;
	private String KName;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SiteId        : ").append(this.getSiteId())		    .append("\n")
			.append(">> ImagePoolId   : ").append(this.getImagePoolId())    .append("\n")
			.append(">> KName         : ").append(this.getKName())		    .append("\n")
			.append(">> KDesc         : ").append(this.getKDesc())		    .append("\n")
			.append(">> ImageFileName : ").append(this.getImageFileName())  .append("\n")
			.append(">> ImageSFileName: ").append(this.getImageSFileName()) .append("\n")
			.append(">> FilePath      : ").append(this.getFilePath())		.append("\n")
			.append(">> Keyword1     : ").append(this.getKeyword1())		.append("\n")
			.append(">> Keyword2     : ").append(this.getKeyword2())		.append("\n")
			.append(">> Keyword3     : ").append(this.getKeyword3())		.append("\n")
			.append(">> Keyword4     : ").append(this.getKeyword4())		.append("\n")
			.append(">> Keyword5     : ").append(this.getKeyword5())		.append("\n")
			.append(">> State         : ").append(this.getState())			.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SiteID|PopupZoneID|KName|ImageFileName|ImageSFileNmae|FilePath|LinkURL|Sort|StratTime|EndTime|NewWindowYn|State
		StringBuffer sbData = new StringBuffer();

		sbData			
			.append(StringUtil.getString(this.getImagePoolId(), ""))	.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getImageFileName(), "-"))	.append("|")
			.append(StringUtil.getString(this.getImageSFileName(), "-")).append("|")
			.append(StringUtil.getString(this.getFilePath(), "-"))		.append("|")
			.append(StringUtil.getString(this.getKeyword1(), "-"))			.append("|")
			.append(StringUtil.getString(this.getKeyword2(), "-"))		.append("|")
			.append(StringUtil.getString(this.getKeyword3(), "-"))		.append("|")
			.append(StringUtil.getString(this.getKeyword4(), "-"))   .append("|")
			.append(StringUtil.getString(this.getKeyword5(), "-"))   .append("|")			
			.append(StringUtil.getString(this.getState(), "-"));
		
		return sbData.toString();
	}

	
	public int getSchType() {
		return schType;
	}

	public void setSchType(int schType) {
		this.schType = schType;
	}

	public String getSchText() {
		return schText;
	}

	public void setSchText(String schText) {
		this.schText = schText;
	}

	public String getImagePoolId() {
		return imagePoolId;
	}

	public void setImagePoolId(String imagePoolId) {
		this.imagePoolId = imagePoolId;
	}

	public String getKDesc() {
		return KDesc;
	}

	public void setKDesc(String kDesc) {
		KDesc = kDesc;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageSFileName() {
		return imageSFileName;
	}

	public void setImageSFileName(String imageSFileName) {
		this.imageSFileName = imageSFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}

	public String getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}

	public String getKeyword3() {
		return keyword3;
	}

	public void setKeyword3(String keyword3) {
		this.keyword3 = keyword3;
	}

	public String getKeyword4() {
		return keyword4;
	}

	public void setKeyword4(String keyword4) {
		this.keyword4 = keyword4;
	}

	public String getKeyword5() {
		return keyword5;
	}

	public void setKeyword5(String keyword5) {
		this.keyword5 = keyword5;
	}

	public String getKName() {
		return KName;
	}

	public void setKName(String kName) {
		KName = kName;
	}
	
}
