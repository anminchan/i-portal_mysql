package kr.plani.ccis.ips.domain.system;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;

@Alias("auth")
public class Auth extends DefaultDomain{
 
	  private String  groupid;
	  private String  roleid;
	  private int  depth;  
	  private int  sort;   
	  private String  higherid;
	  private String  roleid_1;
	  private String  checkyn_1;
	  private String  roleid_2;
	  private String  checkyn_2;
	  private String  roleid_3;
	  private String  checkyn_3;
	  private String  roleid_4;
	  private String  checkyn_4;
	  private String  roleid_5;
	  private String  checkyn_5;
	 
	  
	//in Parameter
	private String inGroupID;
	private String inputGRVal; //그룹권한 입력값
	
	//out Parameter
	private Object outGroupRoleCursor;
	  
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(">> Menuid  	: ").append(this.getMenuId())		.append("\n")
			.append(">> Siteid  	: ").append(this.getSiteId())		.append("\n") 
			.append(">> Kname   	: ").append(this.getKName())		.append("\n") 
			.append(">> Depth       : ").append(this.getDepth())		.append("\n")  
			.append(">> Sort        : ").append(this.getSort())			.append("\n")   
			.append(">> Higherid    : ").append(this.getHigherid())		.append("\n")
			.append(">> Roleid_1    : ").append(this.getRoleid_1())		.append("\n")
			.append(">> Checkyn_1   : ").append(this.getCheckyn_1())	.append("\n")
			.append(">> Roleid_2    : ").append(this.getRoleid_2())		.append("\n")
			.append(">> Checkyn_2   : ").append(this.getCheckyn_2())	.append("\n")
			.append(">> Roleid_3    : ").append(this.getRoleid_3())		.append("\n")
			.append(">> Checkyn_3   : ").append(this.getCheckyn_3())	.append("\n")
			.append(">> Roleid_4    : ").append(this.getRoleid_4())		.append("\n")
			.append(">> Checkyn_4   : ").append(this.getCheckyn_4())	.append("\n")
			.append(">> Roleid_5    : ").append(this.getRoleid_5())		.append("\n")
			.append(">> Checkyn_5   : ").append(this.getCheckyn_5())	.append("\n");
		
		return sbData.toString();
	}

	public String makeDMLDataString(){
		//InDMLData ::  Menuid|Siteid|Kname|Depth|Sort|Higherid|Roleid_1|Checkyn_1|Roleid_2|Checkyn_2|Roleid_3|Checkyn_3|Roleid_4|Checkyn_4|Roleid_5|Checkyn_5
		StringBuffer sbData = new StringBuffer();
		
		sbData
			.append(StringUtil.getString(this.getMenuId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getSiteId(), "-"))	.append("|") 
			.append(StringUtil.getString(this.getKName(), "-"))	    .append("|") 
			.append(StringUtil.getString(this.getDepth(), "-"))	    .append("|")  
			.append(StringUtil.getString(this.getSort(), "-"))	    .append("|")   
			.append(StringUtil.getString(this.getHigherid(), "-"))	.append("|")
			.append(StringUtil.getString(this.getRoleid_1(), "-"))	.append("|")
			.append(StringUtil.getString(this.getCheckyn_1(), "-"))	.append("|")
			.append(StringUtil.getString(this.getRoleid_2(), "-"))	.append("|")
			.append(StringUtil.getString(this.getCheckyn_2(), "-"))	.append("|")
			.append(StringUtil.getString(this.getRoleid_3(), "-"))	.append("|")
			.append(StringUtil.getString(this.getCheckyn_3(), "-"))	.append("|")
			.append(StringUtil.getString(this.getRoleid_4(), "-"))	.append("|")
			.append(StringUtil.getString(this.getCheckyn_4(), "-"))	.append("|")
			.append(StringUtil.getString(this.getRoleid_5(), "-"))	.append("|")
			.append(StringUtil.getString(this.getCheckyn_5(), "-"))	.append("|");
		
		return sbData.toString();
	}
	
	public String getRoleid() {
		return roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	public String getInputGRVal() {
		return inputGRVal;
	}

	public void setInputGRVal(String inputGRVal) {
		this.inputGRVal = inputGRVal;
	}

	public String getInGroupID() {
		return inGroupID;
	}

	public void setInGroupID(String inGroupID) {
		this.inGroupID = inGroupID;
	}
	
	public Object getOutGroupRoleCursor() {
		return outGroupRoleCursor;
	}

	public void setOutGroupRoleCursor(Object outGroupRoleCursor) {
		this.outGroupRoleCursor = outGroupRoleCursor;
	}
	
	public String getGroupid(){
		  return groupid;
	  }  
	  
	  public void setGroupid(String groupid) {
	  	this.groupid = groupid;
  	}	  
	  
    public int getDepth(){
		  return depth;
	  }   

	  public void setDepth(int depth) {
	  	this.depth = depth;
  	}
  	
    public int getSort(){
		  return sort;
	  }    

	  public void setSort(int sort) {
	  	this.sort = sort;
  	}
  	
    public String getHigherid(){
		  return higherid;
	  } 

	  public void setHigherid(String higherid) {
	  	this.higherid = higherid;
  	}
  	
    public String getRoleid_1(){
		  return roleid_1;
	  } 

	  public void setRoleid_1(String roleid_1) {
	  	this.roleid_1 = roleid_1;
  	}
  	
    public String getCheckyn_1(){
		  return checkyn_1;
	  } 

	  public void setCheckyn_1(String checkyn_1) {
	  	this.checkyn_1 = checkyn_1;
  	}
  	
    public String getRoleid_2(){
		  return roleid_2;
	  } 

	  public void setRoleid_2(String roleid_2) {
	  	this.roleid_2 = roleid_2;
  	}
  	
    public String getCheckyn_2(){
		  return checkyn_2;
	  } 

	  public void setCheckyn_2(String checkyn_2) {
	  	this.checkyn_2 = checkyn_2;
  	}
  	
    public String getRoleid_3(){
		  return roleid_3;
	  } 

	  public void setRoleid_3(String roleid_3) {
	  	this.roleid_3 = roleid_3;
  	}
  	
    public String getCheckyn_3(){
		  return checkyn_3;
	  } 

	  public void setCheckyn_3(String checkyn_3) {
	  	this.checkyn_3 = checkyn_3;
  	}
  	
    public String getRoleid_4(){
		  return roleid_4;
	  } 

	  public void setRoleid_4(String roleid_4) {
	  	this.roleid_4 = roleid_4;
  	}
  	
    public String getCheckyn_4(){
		  return checkyn_4;
	  } 

	  public void setCheckyn_4(String checkyn_4) {
	  	this.checkyn_4 = checkyn_4;
  	}
  	
    public String getRoleid_5(){
		  return roleid_5;
	  } 

	  public void setRoleid_5(String roleid_5) {
	  	this.roleid_5 = roleid_5;
  	}
  	
    public String getCheckyn_5(){
		  return checkyn_5;
	  } 
    
    public void setCheckyn_5(String checkyn_5) {
	  	this.checkyn_5 = checkyn_5;
  	}
	
}
