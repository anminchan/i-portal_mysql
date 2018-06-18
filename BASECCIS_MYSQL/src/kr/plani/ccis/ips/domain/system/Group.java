package kr.plani.ccis.ips.domain.system;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("group")
public class Group extends DefaultDomain {
	
	private String sourcePath;
	private int depth;
	private String higherId;
	private String groupType;
	private String groupType_Name;	
	private String kind;
	private String kind_Name;
	private String joinDate;
	private String KDesc;
	private int cnt;
	private String rnum;
	
	private String groupId;
	private String searchType;
	private String searchText;
	
	private String inSearchType;
	private String inSearchText;
	private String inGroupType;	
	
	public String[] chkGroupIds = null;			//체크 SiteId - 다중삭제용
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> GroupId       : ").append(this.getGroupId())			.append("\n")
			.append(">> KName		  : ").append(this.getKName())				.append("\n")
			.append(">> KDesc		  : ").append(this.getKDesc())				.append("\n")
			.append(">> GroupType     : ").append(this.getGroupType())			.append("\n")			
			.append(">> State 		  : ").append(this.getState())				.append("\n");
						
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  GroupID|TempleteID|SubYN|KName|KDesc|URL|Context|IP|SourcePath|Depth|HigherID|GroupType|GroupLanguage|UserMngYN|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getGroupId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))		.append("|")
			.append(StringUtil.getString(this.getKDesc(), "-"))		.append("|")
			.append(StringUtil.getString(this.getGroupType(), "-"))	.append("|")			
			.append(StringUtil.getString(this.getState(), "-"));
		
		return sbData.toString();
	}
	
	public String makeDataString1(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> GroupID       : ").append(this.getGroupId())			.append("\n")
			.append(">> UserID		  : ").append(this.getUserId())				.append("\n")
			.append(">> State		  : ").append(this.getState())				.append("\n");			
		
		return sbData.toString();
	}


	public String makeDMLDataString1(){
		//InDMLData ::  GroupID|UserID|State
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getGroupId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getUserId(), "-"))	.append("|")						
			.append(StringUtil.getString(this.getState(), "-"));	
		
		return sbData.toString();
	}
	
	public int getDepth() {
		return depth;
	}
	
	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	
	public String getHigherId() {
		return higherId;
	}
	
	public void setHigherId(String higherId) {
		this.higherId = higherId;
	}
	
	
	public String getGroupType() {
		return groupType;
	}
	
	public void setGroupType(String groupType) {
		this.groupType = groupType;
	}	
	
	public String getGroupType_Name() {
		return groupType_Name;
	}

	public void setGroupType_Name(String groupType_Name) {
		this.groupType_Name = groupType_Name;
	}
	
	
	public String getSourcePath() {
		return sourcePath;
	}
	
	public void setSourcePath(String sourcePath) {
		this.sourcePath = sourcePath;
	}
	
	
	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	
	
	public String getInSearchType() {
		return inSearchType;
	}
	
	public void setInSearchType(String inSearchType) {
		this.inSearchType = inSearchType;
	}
	
	
	public String getInSearchText() {
		return inSearchText;
	}
	
	public void setInSearchText(String inSearchText) {
		this.inSearchText = inSearchText;
	}
	
	public String getInGroupType() {
		return inGroupType;
	}
	
	public void setInGroupType(String inGroupType) {
		this.inGroupType = inGroupType;
	}
	
	
	public String getSearchType() {
		return searchType;
	}
	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}	
	
	
	public String getSearchText() {
		return searchText;
	}
	
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getKind_Name() {
		return kind_Name;
	}

	public void setKind_Name(String kind_Name) {
		this.kind_Name = kind_Name;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}


	public String getKDesc() {
		return KDesc;
	}


	public void setKDesc(String kDesc) {
		KDesc = kDesc;
	}


	public int getCnt() {
		return cnt;
	}


	public void setCnt(int cnt) {
		this.cnt = cnt;
	}


	public String getRnum() {
		return rnum;
	}


	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public String[] getChkGroupIds() {
		return chkGroupIds;
	}

	public void setChkGroupIds(String[] chkGroupIds) {
		this.chkGroupIds = chkGroupIds;
	}
	
	
}
