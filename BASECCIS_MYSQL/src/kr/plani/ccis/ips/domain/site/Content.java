package kr.plani.ccis.ips.domain.site;

import java.io.Serializable;
import java.util.HashMap;

import org.apache.ibatis.type.Alias;

import kr.plani.ccis.common.util.StringUtil;

@Alias("content")
public class Content extends Title implements Serializable {
	
	private static final long serialVersionUID = -8941057334164625127L;

	private String contentsId;
	private String kText;
	private String KHtml;
	private String imageFileName;
	private String imageSFileName;
	private String filePath;
	private String altInfo;
	private String menuName;
	private String boardName;
	private String linkId;
	private String parentLinkId;
	private String appealUserId;
	private String titleMenuID;
	private String origin;
	private String reportTime;
	
	public String makeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
			.append(">> menuID         : ").append(this.getParamMenuId())    .append("\n")
			.append(">> boardID        : ").append(this.getBoardId())        .append("\n")
			.append(">> linkID         : ").append(this.getLinkId())         .append("\n")
			.append(">> kName          : ").append(this.getKName())	     	 .append("\n")
			.append(">> keyword1       : ").append(this.getKeyword1())	     .append("\n")
			.append(">> keyword2       : ").append(this.getKeyword2())	     .append("\n")
			.append(">> keyword3       : ").append(this.getKeyword3())	     .append("\n")
			.append(">> keyword4       : ").append(this.getKeyword4())	     .append("\n")
			.append(">> keyword5       : ").append(this.getKeyword5())	     .append("\n")
			.append(">> keyword6       : ").append(this.getKeyword6())	     .append("\n")
			.append(">> keyword7       : ").append(this.getKeyword7())	     .append("\n")
			.append(">> keyword8       : ").append(this.getKeyword8())	     .append("\n")
			.append(">> keyword9       : ").append(this.getKeyword9())	     .append("\n")
			.append(">> keyword10       : ").append(this.getKeyword10())     .append("\n");			
		
		return sbData.toString();
	}
	
	public String makeDataStringHashMap(HashMap item){
		StringBuffer sbData = new StringBuffer();
		sbData
			.append(">> menuID         : ").append(item.get("MENUID"))    		 .append("\n")
			.append(">> boardID        : ").append(item.get("BOARDID"))          .append("\n")
			.append(">> linkID         : ").append(item.get("LINKID"))           .append("\n")
			.append(">> kName          : ").append(item.get("KNAME"))	     	 .append("\n")
			.append(">> keyword1       : ").append(item.get("KEYWORD1"))	     .append("\n")
			.append(">> keyword2       : ").append(item.get("KEYWORD2"))	     .append("\n")
			.append(">> keyword3       : ").append(item.get("KEYWORD3"))	     .append("\n")
			.append(">> keyword4       : ").append(item.get("KEYWORD4"))	     .append("\n")
			.append(">> keyword5       : ").append(item.get("KEYWORD5"))	     .append("\n")
			.append(">> keyword6       : ").append(item.get("KEYWORD6"))	     .append("\n")
			.append(">> keyword7       : ").append(item.get("KEYWORD7"))	     .append("\n")
			.append(">> keyword8       : ").append(item.get("KEYWORD8"))	     .append("\n")
			.append(">> keyword9       : ").append(item.get("KEYWORD9"))	     .append("\n")
			.append(">> keyword10      : ").append(item.get("KEYWORD10"))        .append("\n");			
		
		return sbData.toString();
	}
	
	public String makeDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();

		sbData
			.append(StringUtil.getString(this.getParamMenuId(), "-"))	.append("|")
			.append(StringUtil.getString(this.getBoardId(), "-")) 		.append("|")
			.append(StringUtil.getString(this.getLinkId(), "-1"))		.append("|")
			.append(StringUtil.getString(this.getKName(), "-"))		  	.append("|")
			.append(StringUtil.getString(this.getKeyword1(), ""))	  	.append("|")			
			.append(StringUtil.getString(this.getKeyword2(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword3(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword4(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword5(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword6(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword7(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword8(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword9(), ""))	  	.append("|")
			.append(StringUtil.getString(this.getKeyword10(), ""));	
		
		return sbData.toString();
	}
	
	/*참조형 게시판 입력확인*/
	public String makeReferenceDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> secretTitleYN   : ").append(this.getSecretTitleYN())		.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())		    .append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> contents4		: ").append(this.getContents4())			.append("\n")
		.append(">> contents5		: ").append(this.getContents5())			.append("\n")
		.append(">> contents6		: ").append(this.getContents6())			.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
	
	/*참조형 게시판 입력 데이터*/
	public String makeReferenceDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getNoticeStartTime(), "-").equals("-")) this.setNoticeStartTime(this.getNoticeStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getNoticeEndTime(), "-").equals("-")) this.setNoticeEndTime(this.getNoticeEndTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContents4(), "-").equals("-")) this.setContents4(this.getContents4().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContents5(), "-").equals("-")) this.setContents5(this.getContents5().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContents6(), "-").equals("-")) this.setContents6(this.getContents6().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getSecretTitleYN(), "N"))    	.append("|")
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents4(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents5(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents6(), ""))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), ""))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), ""))			.append("|")
		.append(StringUtil.getString(this.getNoticeStartTime(), ""))	.append("|")
		.append(StringUtil.getString(this.getNoticeEndTime(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageFileName(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), ""))	    .append("|")
		.append(StringUtil.getString(this.getFilePath(), ""))			.append("|")
		.append(StringUtil.getString(this.getImageYN_Name(), ""));
		
		return sbData.toString();
	}
	
	/*자유형 게시판 아웃 데이터*/
	public String makeFreeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> secretTitleYN   : ").append(this.getSecretTitleYN())		.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> Continent	    : ").append(this.getContinent())			.append("\n")
		.append(">> Country	        : ").append(this.getCountry())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")
		.append(">> keyword4        : ").append(this.getKeyword4())	            .append("\n")
		.append(">> keyword5        : ").append(this.getKeyword5())	     	    .append("\n")
		.append(">> keyword6        : ").append(this.getKeyword6())	       		.append("\n")
		.append(">> keyword7        : ").append(this.getKeyword7())	     		.append("\n")
		.append(">> keyword8        : ").append(this.getKeyword8())	    		.append("\n")
		.append(">> keyword9        : ").append(this.getKeyword9())	     		.append("\n")
		.append(">> keyword10       : ").append(this.getKeyword10())	    	.append("\n")
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")		
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
		
	public String makeFreeDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getNoticeStartTime(), "-").equals("-")) this.setNoticeStartTime(this.getNoticeStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getNoticeEndTime(), "-").equals("-")) this.setNoticeEndTime(this.getNoticeEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getSecretTitleYN(), "N"))    	.append("|")
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getNoticeStartTime(), ""))	.append("|")
		.append(StringUtil.getString(this.getNoticeEndTime(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageFileName(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), ""))		.append("|")
		.append(StringUtil.getString(this.getFilePath(), ""))			.append("|")
		.append(StringUtil.getString(this.getImageYN_Name(), ""));
		
		return sbData.toString();
	}
	
	/*공지형 게시판 입력확인*/
	public String makeNoticeDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> secretTitleYN   : ").append(this.getSecretTitleYN())		.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())		    .append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> contents4		: ").append(this.getContents4())			.append("\n")
		.append(">> contents5		: ").append(this.getContents5())			.append("\n")
		.append(">> contents6		: ").append(this.getContents6())			.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
	
	/*공지형 게시판 입력 데이터*/
	public String makeNoticeDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getNoticeStartTime(), "-").equals("-")) this.setNoticeStartTime(this.getNoticeStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getNoticeEndTime(), "-").equals("-")) this.setNoticeEndTime(this.getNoticeEndTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContents4(), "-").equals("-")) this.setContents4(this.getContents4().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContents5(), "-").equals("-")) this.setContents5(this.getContents5().replaceAll("-", ""));
		if(!StringUtil.getString(this.getContents6(), "-").equals("-")) this.setContents6(this.getContents6().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getSecretTitleYN(), "N"))    	.append("|")
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents4(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents5(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents6(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents7(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents8(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents9(), ""))			.append("|")
		.append(StringUtil.getString(this.getContents10(), ""))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), ""))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), ""))			.append("|")
		.append(StringUtil.getString(this.getNoticeStartTime(), ""))	.append("|")
		.append(StringUtil.getString(this.getNoticeEndTime(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageFileName(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), ""))	    .append("|")
		.append(StringUtil.getString(this.getFilePath(), ""))			.append("|")
		.append(StringUtil.getString(this.getImageYN_Name(), ""));
		
		return sbData.toString();
	}
	
	/*썸네일형 게시판 입력확인*/
	public String makeThumbnailDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())		    .append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
	
	public String makeThumbnailDMLDataString(){
		//InDMLData ::  Menuid|BoardID|LinkID|Kname|OpenYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|ImageFileName|ImageSFileName|FilePath
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")		
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getImageFileName(), "-"))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), "-"))	.append("|")
		.append(StringUtil.getString(this.getFilePath(), "-"));
		return sbData.toString();
	}
	
	/* 링크형 게시판 입력확인 */
	public String makeLinkDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> Continent	    : ").append(this.getContinent())			.append("\n")
		.append(">> Country	        : ").append(this.getCountry())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())			.append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> LinkURL			: ").append(this.getLinkUrl())				.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}

	/* 링크형 게시판 입력 데이터 */
	public String makeLinkDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkUrl(), "-"))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))           .append("|")
		.append(StringUtil.getString(this.getImageFileName(), ""))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), ""))	    .append("|")
		.append(StringUtil.getString(this.getFilePath(), ""))			.append("|")
		.append(StringUtil.getString(this.getImageYN_Name(), ""));
		
		return sbData.toString();
	}
	
	/* 클리핑형 게시판 입력확인 */
	public String makeClippingDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> Continent	    : ").append(this.getContinent())			.append("\n")
		.append(">> Country	        : ").append(this.getCountry())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())			.append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> LinkURL			: ").append(this.getLinkUrl())				.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}

	/* 클리핑형 게시판 입력 데이터 */
	public String makeClippingDMLDataString(){
		//InDMLData ::  menuID|boardID|linkID|kName|keyword1|keyword2|keyword3
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkUrl(), "-"))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getOrigin(), "-"))			.append("|")
		.append(StringUtil.getString(this.getReportTime(), "-"));
		
		return sbData.toString();
	}
	
	/* 동영상형 게시판 입력확인 */
	public String makeVodDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())	   	    .append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> LinkURL			: ").append(this.getLinkUrl())				.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
	
	public String makeVodDMLDataString(){
		//InDMLData :: Menuid|BoardID|LinkID|Kname|OpenYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|LinkURL|CategoryID|StartTime|EndTime|ImageFileName|ImageSFileName|FilePath
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkUrl(), ""))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getImageFileName(), "-"))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), "-"))	.append("|")
		.append(StringUtil.getString(this.getFilePath(), "-"))			.append("|")
	    .append(StringUtil.getString(this.getImageYN_Name(), ""));
		
		return sbData.toString();
	}
	
	/*민원형 게시판 입력 확인*/
	public String makeAppearlDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> secretTitleYN   : ").append(this.getSecretTitleYN())		.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())	   	    .append("\n")
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n")
		.append(">> appealUserid	: ").append(this.getAppealUserId())			.append("\n");
		return sbData.toString();
	}
	
	/*민원형 게시판 입력 데이터*/
	public String makeAppealDMLDataString(){
		//InDMLData ::  Menuid|BoardID|LinkID|Kname|OpenYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|AppealUserID
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getSecretTitleYN(), "N"))    	.append("|")
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getAppealUserId(), ""));
		
		return sbData.toString();
	}
	
	/*관리자답변형 게시판 입력 확인*/
	public String makeReplyDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> secretTitleYN   : ").append(this.getSecretTitleYN())		.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
	
	/*관리자답변형 게시판 입력 데이터*/
	public String makeReplyDMLDataString(){
		//InDMLData ::  Menuid|BoardID|LinkID|Kname|OpenYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|AppealUserID
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getSecretTitleYN(), "N"))    	.append("|")
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"));
		
		return sbData.toString();
	}
	
	/*삭제콘텐츠 게시판 입력확인*/
	public String makeDeleteDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> paramMenuId	    : ").append(this.getParamMenuId())	.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())		.append("\n");
		return sbData.toString();
	}

	/*삭제콘텐츠 게시판 입력 데이터*/
	public String makeDeleteDMLDataString(){
		//InDMLData ::  ParamMenuId|LinkID
		StringBuffer sbData = new StringBuffer();
		
		sbData
		.append(StringUtil.getString(this.getParamMenuId(), "-"))	    .append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"));
		
		return sbData.toString();
	}
	
	/*카드형 게시판 입력확인*/
	public String makeCardDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> menuID			: ").append(this.getMenuId())				.append("\n")
		.append(">> boardID			: ").append(this.getBoardId())				.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())				.append("\n")
		.append(">> kName			: ").append(this.getKName())				.append("\n")
		.append(">> openYN			: ").append(this.getOpenYN())				.append("\n")
		.append(">> noticeTitleYN	: ").append(this.getNoticeYN())				.append("\n")
		.append(">> keyword1		: ").append(this.getKeyword1())				.append("\n")
		.append(">> keyword2		: ").append(this.getKeyword2())				.append("\n")
		.append(">> keyword3		: ").append(this.getKeyword3())				.append("\n")			
		.append(">> keyword4		: ").append(this.getKeyword4())				.append("\n")			
		.append(">> keyword5		: ").append(this.getKeyword5())				.append("\n")			
		.append(">> keyword6		: ").append(this.getKeyword6())				.append("\n")			
		.append(">> keyword7		: ").append(this.getKeyword7())				.append("\n")			
		.append(">> keyword8		: ").append(this.getKeyword8())				.append("\n")			
		.append(">> keyword9		: ").append(this.getKeyword9())				.append("\n")			
		.append(">> keyword10		: ").append(this.getKeyword10())		    .append("\n")			
		.append(">> contents1		: ").append(this.getContents1())			.append("\n")
		.append(">> contents2		: ").append(this.getContents2())			.append("\n")
		.append(">> contents3		: ").append(this.getContents3())			.append("\n")
		.append(">> categoryId		: ").append(this.getCategoryId())			.append("\n")
		.append(">> startTime		: ").append(this.getStartTime())			.append("\n")
		.append(">> endTime			: ").append(this.getEndTime())				.append("\n");
		return sbData.toString();
	}
	
	/*카드형 게시판 입력 데이터*/
	public String makeCardDMLDataString(){
		//InDMLData ::  Menuid|BoardID|LinkID|Kname|OpenYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|ImageFileName|ImageSFileName|FilePath
		StringBuffer sbData = new StringBuffer();
		
		if(!StringUtil.getString(this.getStartTime(), "-").equals("-")) this.setStartTime(this.getStartTime().replaceAll("-", ""));
		if(!StringUtil.getString(this.getEndTime(), "-").equals("-")) this.setEndTime(this.getEndTime().replaceAll("-", ""));
		
		sbData
		.append(StringUtil.getString(this.getMenuId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getBoardId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"))			.append("|")
		.append(StringUtil.getString(this.getKName(), "-"))				.append("|")
		.append(StringUtil.getString(this.getOpenYN(), "-"))	    	.append("|")			
		.append(StringUtil.getString(this.getNoticeYN(), "N"))	    	.append("|")
		.append(StringUtil.getString(this.getContinent(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getCountry(), "-"))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword1(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword2(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword3(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword4(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword5(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword6(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword7(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword8(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword9(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getKeyword10(), ""))	    	.append("|")
		.append(StringUtil.getString(this.getContents1(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents2(), "-"))			.append("|")
		.append(StringUtil.getString(this.getContents3(), "-"))			.append("|")		
		.append(StringUtil.getString(this.getCategoryId(), "-"))		.append("|")
		.append(StringUtil.getString(this.getStartTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getEndTime(), "-"))			.append("|")
		.append(StringUtil.getString(this.getImageFileName(), "-"))		.append("|")
		.append(StringUtil.getString(this.getImageSFileName(), "-"))	.append("|")
		.append(StringUtil.getString(this.getFilePath(), "-"));
		return sbData.toString();
	}
	
	/*승인콘텐츠 게시판 입력확인*/
	public String makeAppDataString(){
		StringBuffer sbData = new StringBuffer();
		sbData
		.append("\n")
		.append(">> paramMenuId	    : ").append(this.getParamMenuId())	.append("\n")
		.append(">> linkID			: ").append(this.getLinkId())		.append("\n");
		return sbData.toString();
	}

	/*승인콘텐츠 게시판 입력 데이터*/
	public String makeAppDMLDataString(){
		//InDMLData ::  ParamMenuId|LinkID
		StringBuffer sbData = new StringBuffer();
		
		sbData
		.append(StringUtil.getString(this.getParamMenuId(), "-"))	    .append("|")
		.append(StringUtil.getString(this.getLinkId(), "-"));
		
		return sbData.toString();
	}
	
	public String getContentsId() {
		return contentsId;
	}
	public void setContentsId(String contentsId) {
		this.contentsId = contentsId;
	}
	public String getkText() {
		return kText;
	}
	public void setkText(String kText) {
		this.kText = kText;
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
	public String getAltInfo() {
		return altInfo;
	}
	public void setAltInfo(String altInfo) {
		this.altInfo = altInfo;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getLinkId() {
		return linkId;
	}

	public void setLinkId(String linkId) {
		this.linkId = linkId;
	}

	public String getKHtml() {
		return KHtml;
	}

	public void setKHtml(String kHtml) {
		KHtml = kHtml;
	}

	public String getAppealUserId() {
		return appealUserId;
	}

	public void setAppealUserId(String appealUserId) {
		this.appealUserId = appealUserId;
	}

	public String getTitleMenuID() {
		return titleMenuID;
	}

	public void setTitleMenuID(String titleMenuID) {
		this.titleMenuID = titleMenuID;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getReportTime() {
		return reportTime;
	}

	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}

	public String getParentLinkId() {
		return parentLinkId;
	}

	public void setParentLinkId(String parentLinkId) {
		this.parentLinkId = parentLinkId;
	}
	
}
