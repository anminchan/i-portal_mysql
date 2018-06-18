package kr.plani.ccis.ips.domain.system;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("search")
public class Search extends DefaultDomain implements Serializable {
	
	private static final long serialVersionUID = 3207909996967446541L;
	
	private String searchCode;
	private String searchType;
	private String searchType_Name;
	private String searchKName;
	private String searchKDesc;
	private int sort;
	private String imageFileName;
	private String imageSFileName;
	private String filePath;
	
	// 입력 Parameter
	private String inSearchType;
	private String inSearchCode;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> SearchCode    : ").append(this.getSearchCode())		.append("\n")
			.append(">> SearchType    : ").append(this.getSearchType())		.append("\n")
			.append(">> SearchKname   : ").append(this.getSearchKName())	.append("\n")
			.append(">> SearchKdesc   : ").append(this.getSearchKDesc())	.append("\n")
			.append(">> Sort          : ").append(this.getSort())			.append("\n")
			.append(">> ImageFileName : ").append(this.getImageFileName())  .append("\n")
			.append(">> ImageSFileName: ").append(this.getImageSFileName()) .append("\n")
			.append(">> FilePath      : ").append(this.getFilePath())		.append("\n")
			.append(">> State         : ").append(this.getState())          .append("\n");
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  SearchCode|SearchType|SearchKName|SearchKDesc|Sort|ImageFileName|ImageSFileName|FilePat|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getSearchCode(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSearchType(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSearchKName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSearchKDesc(), "-"))			.append("|")
			.append(StringUtil.getString(this.getSort(), "-"))					.append("|")
			.append(StringUtil.getString(this.getImageFileName(), "-"))			.append("|")
			.append(StringUtil.getString(this.getImageSFileName(), "-"))		.append("|")
			.append(StringUtil.getString(this.getFilePath(), "-"))				.append("|")
			.append(StringUtil.getString(this.getState(), "-"));
		
		return sbData.toString();
	}

	public String getSearchCode() {
		return searchCode;
	}

	public void setSearchCode(String searchCode) {
		this.searchCode = searchCode;
	}

	public String getSearchType() {
		return searchType;
	}
	

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	
	public String getSearchType_Name() {
		return searchType_Name;
	}

	public void setSearchType_Name(String searchType_Name) {
		this.searchType_Name = searchType_Name;
	}

	public String getSearchKName() {
		return searchKName;
	}

	public void setSearchKName(String searchKName) {
		this.searchKName = searchKName;
	}

	public String getSearchKDesc() {
		return searchKDesc;
	}

	public void setSearchKDesc(String searchKDesc) {
		this.searchKDesc = searchKDesc;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getInSearchType() {
		return inSearchType;
	}

	public void setInSearchType(String inSearchType) {
		this.inSearchType = inSearchType;
	}

	public String getInSearchCode() {
		return inSearchCode;
	}

	public void setInSearchCode(String inSearchCode) {
		this.inSearchCode = inSearchCode;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
