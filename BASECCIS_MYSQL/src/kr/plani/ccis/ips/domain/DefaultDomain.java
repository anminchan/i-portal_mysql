package kr.plani.ccis.ips.domain;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.type.Alias;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;

@Alias("defaultDomain")
public class DefaultDomain {
	private static final Logger logger = LoggerFactory.getLogger(DefaultDomain.class);
	
	private int count;
	private List<?> list;
	
	private String jsp;
	
	//파일 관련
	private String fileGubun;                     // 파일등록구분(사이트구분 : 생성폴더)
	private String fileMenuId;                    // 파일세부구분(메뉴구분 : 생성폴더)
	private String uploadFileDir;
	private String fileFormType = "_inputFiles";  // 파일폼타입(무료:유료 / _inputFiles:빈값)
	private String fileRealSize;
	//페이징 Parameter
	private int pageNum = 1;						//페이지 번호
	private int rowCnt = 10;						//페이지당 리스트수
	private int lstNum = 1;							//리스트번호
	
	private int upDown = 1;							//0 : CURRENT, 1 : 첫페이지 로딩 OR 다음리스트, 2 : 이전리스트
	private String minIndex = "99999999999999";		//최소인덱스
	private String maxIndex = "99999999999999";		//최대인덱스
	
	//사용자별 메뉴 변수
	private String mySiteId = "";					//사용자 사이트ID
	private String mySiteKey = "";					//사용자 사이트Key
	private String myId = "";						//사용자 ID
	private String myName = "전체관리자";				//사용자 이름
	
	private String rtnUrl = "";						//로그인후 리턴 url
	
	//공통 변수
	private String no1 = "0";				//순번1
	private String no2;						//순번2
	private String siteId;					//사이트ID
	private String siteName;				//사이트명
	private String higherMenuId;			//상위메뉴ID
	private String referenceMenuId;			//참조메뉴ID
	private String referenceSiteId;			//참조사이트ID
	private String menuId;					//메뉴ID
	public String[] menuIds = null;			//메뉴IDS
	private String userId;					//사용자 ID
	private String menuName;				//메뉴명
	private String KName;					//한글명
	private String condition;				//업무처리명(입력, 수정, 삭제..)
	private String boardStyle;				//게시판 형태(text, image, gallery)
	private String boardMoveKind;			//게시판 이동 시 종류
	
	private String state;					//상태
	private String insuserId;				//생성자ID
	private String insIp;					//생성자IP
	private String insTime;					//생성시각
	private String dmlUserId;				//처리자ID
	private String dmlIp;					//처리자IP
	private String dmlTime;					//처리시각
	private String dmlLog;					//처리로그
	
	private String navigation;				//메뉴 네비게이션
	private int schType;					//검색구분
	private String schText;					//검색어
	private String schStartDate;			//검색시작일
	private String schEndDate;				//검색종료일
	
	private String inRECUserID;				//개인정보조회 로그 해당 사용자
	private String inRECDesc;				//개인정보조회 로그 해당 내용
	
	private Boolean isMobile = false;   	//모바일기기접속여부
	private String newCheck; 				//새로운글카운트
	
	//프로시져 호출 기본 
	private int 	inRowsPerPage;			//한페이지 표시수(목록수)
	private int 	inTargetPage;			//현제 페이지
	private int 	inSchType;				//검색구분(0.전체, 1 ...)
	private String	inSchText;				//검색어
	private String	inSchStartDate;			//검색시작일
	private String	inSchEndDate;			//검색종료일

	//공통 - DML 서버 in parameter
	private String 	inWorkName;				//실행 작업명
	private String 	inCondition;			//업무처리명(입력, 수정, 삭제...)
	private String 	inDMLData;				//입력처리 데이타(데이타1|데이타2|데이타3....)
	private String 	inCLOBData1;			//html 데이타 등 긴데이타 처리용
	private String 	inCLOBData2;			//html 데이타 등 긴데이타 처리용
	
	private String 	inGubun;				//data 연계 추가
	
	//공통 in parameter
	private String 	inExecMenuId;			//실행메뉴id
	private String 	inBeforeData;			//처리전데이터
	private String 	inAfterData;			//처리후데이터
	private String 	inTerminal;				//접속터미널명
	private String 	inOsUser;				//터미널유저
	private String 	inModule;				//접속모듈
	private String 	inDMLUserId;			//처리자ID
	private String 	inDMLIp;				//처리자IP
	
	//공통 out parameter
	private String 	outObjectName;			//객체이름
	private String 	outResult;				//실행결과
	private int 	outRowCount;			//결과RowCount
	private String 	outNotice;				//실행결과 알림
	private int 	outMaxRow;				//전체 카운트
	private int 	outMaxPage;				//전체 페이지
	private String 	multiCount;				//여러개 카운트
	
	private Object 	outCursor;				//실행결과 커서
	private Object 	outCursor1;				//실행결과 커서
	private Object 	outCursor2;				//실행결과 커서
	private Object 	outCursor3;				//실행결과 커서
	private Object 	outCursor4;				//실행결과 커서
	private Object  outUserMenuCursor;      //사용자별메뉴 커서
	
	//공통 화면 타이틀 parameter
	private Object  viewTitle;				//사용자별메뉴 커서
	
	private String excelDownYn = "N";

	// 공통 메세지
	private String message;
	
	// 공통처리 아이디
	private String useComId;
	
	//공통 로그
	private String objectName = "QUERYDML";
	private String objectType = "QUERY";
	private String dmlType;
	private String dmlNotice;
	
	//공통기능 parameter
	private String continent;           //대륙
	private String country;             //국가
	private String paramSiteId;
	private String paramMenuId;
	
	// 개발도구필요 parameter
	private String dbOwner;
	private String tableName;
	
	/**
	 * 공통 IN-Parameter 설정
	 * 공통 이외의 것은 각자 도메인에서 추가하여 set으로 설정
	 */
	public void setInParam(HttpServletRequest request)
	{
		this.inRowsPerPage 	= this.rowCnt;
		this.inTargetPage 	= this.pageNum;
		
		this.inSchType		= this.schType;
		this.inSchText 		= StringUtil.paramUnscript(StringUtil.getString(this.schText, ""));
		
		this.inExecMenuId	= StringUtil.getString(this.menuId, "");

		//세션값 가져오기
		SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
		SCookie scAdmUser = (SCookie)request.getSession().getAttribute("ADMUSER");

		String strUserId = "";
		String strUserName = "";
		if(scUser == null && scAdmUser == null){
			strUserId = "guest";
		}else{
			
			if(scUser != null){
				strUserId = scUser.getUserId();
				strUserName = scUser.getUserName();
			}
			
			if(scAdmUser != null){
				strUserId = scAdmUser.getUserId();
				strUserName = scAdmUser.getUserName();
			}
		}

		String userAgent = request.getHeader("User-Agent");
		String strTerminal = StringUtil.os(userAgent);
		String strModule = StringUtil.browser(userAgent);
		boolean mobile1 = userAgent.matches(".*(iP(hone|od|ad)|Android|Mobile|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|Kindle|lgtelecom|nokia|SonyEricesson).*");
		boolean mobile2 = userAgent.matches(".*(LG|SAMSUNG|Samsung).*");
		
		if(mobile1 || mobile2) this.isMobile = true;
		else this.isMobile = false;
		
		this.inTerminal 	= strTerminal;
		this.inOsUser 		= strUserId;
		this.inModule 		= strModule;
		this.inDMLUserId 	= strUserId;
		this.inDMLIp 		= request.getRemoteAddr();
		
		this.myId			= strUserId;
		this.myName         = strUserName;
	}
	
	/**
	 * 공통 IN-Parameter 설정
	 * 공통 이외의 것은 각자 도메인에서 추가하여 set으로 설정
	 */
	public void setCopyParam(DefaultDomain inObj){
		DefaultDomain copyObj = (DefaultDomain)inObj;
		this.inWorkName 	= copyObj.getInWorkName();
		this.inCondition 	= copyObj.getInCondition();
		
		this.inExecMenuId	= copyObj.getInExecMenuId();
		this.inTerminal 	= copyObj.getInTerminal();
		this.inOsUser 		= copyObj.getInOsUser();
		this.inModule 		= copyObj.getInModule();
		this.inDMLUserId 	= copyObj.getInDMLUserId();
		this.inDMLIp 		= copyObj.getInDMLIp();

		this.myId 		= copyObj.getMyId();
		this.myName     = copyObj.getMyName();
		this.mySiteId	= copyObj.getMySiteId();
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}

	public String getJsp() {
		return jsp;
	}

	public void setJsp(String jsp) {
		this.jsp = jsp;
	}

	public String getNo1() {
		return no1;
	}

	public void setNo1(String no1) {
		this.no1 = no1;
	}

	public String getNo2() {
		return no2;
	}

	public void setNo2(String no2) {
		this.no2 = no2;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = StringUtil.paramUnscript(siteId);
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getMenuId() {
		return menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = StringUtil.paramUnscript(menuId);
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = StringUtil.paramUnscript(userId);
	}

	public String getKName() {
		return KName;
	}

	public void setKName(String kName) {
		KName = StringUtil.paramUnscript(kName);
	}
	
	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	public String getBoardStyle() {
		return boardStyle;
	}

	public void setBoardStyle(String boardStyle) {
		this.boardStyle = boardStyle;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getInsuserId() {
		return insuserId;
	}

	public void setInsuserId(String insuserId) {
		this.insuserId = insuserId;
	}

	public String getInsIp() {
		return insIp;
	}

	public void setInsIp(String insIp) {
		this.insIp = insIp;
	}

	public String getInsTime() {
		return insTime;
	}

	public void setInsTime(String insTime) {
		this.insTime = insTime;
	}

	public String getDmlUserId() {
		return dmlUserId;
	}

	public void setDmlUserId(String dmlUserId) {
		this.dmlUserId = dmlUserId;
	}

	public String getDmlIp() {
		return dmlIp;
	}

	public void setDmlIp(String dmlIp) {
		this.dmlIp = dmlIp;
	}

	public String getDmlTime() {
		return dmlTime;
	}

	public void setDmlTime(String dmlTime) {
		this.dmlTime = dmlTime;
	}

	public String getDmlLog() {
		return dmlLog;
	}

	public void setDmlLog(String dmlLog) {
		this.dmlLog = dmlLog;
	}

	public int getInRowsPerPage() {
		return inRowsPerPage;
	}

	public void setInRowsPerPage(int inRowsPerPage) {
		this.inRowsPerPage = inRowsPerPage;
	}

	public int getInTargetPage() {
		return inTargetPage;
	}

	public void setInTargetPage(int inTargetPage) {
		this.inTargetPage = inTargetPage;
	}

	public String getInWorkName() {
		return inWorkName;
	}

	public void setInWorkName(String inWorkName) {
		this.inWorkName = inWorkName;
	}
	
	
	public String getInGubun() {
		return inGubun;
	}

	public void setInGubun(String inGubun) {
		this.inGubun = inGubun;
	}	

	public String getInCondition() {
		return inCondition;
	}

	public void setInCondition(String inCondition) {
		this.inCondition = inCondition;
	}

	public String getInDMLData() {
		return inDMLData;
	}

	public void setInDMLData(String inDMLData) {
		this.inDMLData = inDMLData;
	}

	public String getInCLOBData1() {
		return inCLOBData1;
	}

	public void setInCLOBData1(String inCLOBData1) {
		this.inCLOBData1 = inCLOBData1;
	}

	public String getInCLOBData2() {
		return inCLOBData2;
	}

	public void setInCLOBData2(String inCLOBData2) {
		this.inCLOBData2 = inCLOBData2;
	}

	public String getInExecMenuId() {
		return inExecMenuId;
	}

	public void setInExecMenuId(String inExecMenuId) {
		this.inExecMenuId = inExecMenuId;
	}

	public String getInBeforeData() {
		return inBeforeData;
	}

	public void setInBeforeData(String inBeforeData) {
		this.inBeforeData = inBeforeData;
	}

	public String getInAfterData() {
		return inAfterData;
	}

	public void setInAfterData(String inAfterData) {
		this.inAfterData = inAfterData;
	}

	public String getInTerminal() {
		return inTerminal;
	}

	public void setInTerminal(String inTerminal) {
		this.inTerminal = inTerminal;
	}

	public String getInOsUser() {
		return inOsUser;
	}

	public void setInOsUser(String inOsUser) {
		this.inOsUser = inOsUser;
	}

	public String getInModule() {
		return inModule;
	}

	public void setInModule(String inModule) {
		this.inModule = inModule;
	}

	public String getInDMLUserId() {
		return inDMLUserId;
	}

	public void setInDMLUserId(String inDMLUserId) {
		this.inDMLUserId = inDMLUserId;
	}

	public String getInDMLIp() {
		return inDMLIp;
	}

	public void setInDMLIp(String inDMLIp) {
		this.inDMLIp = inDMLIp;
	}

	public String getOutObjectName() {
		return outObjectName;
	}

	public void setOutObjectName(String outObjectName) {
		this.outObjectName = outObjectName;
	}

	public String getOutResult() {
		return outResult;
	}

	public void setOutResult(String outResult) {
		this.outResult = outResult;
	}

	public int getOutRowCount() {
		return outRowCount;
	}

	public void setOutRowCount(int outRowCount) {
		this.outRowCount = outRowCount;
	}

	public String getOutNotice() {
		return outNotice;
	}

	public void setOutNotice(String outNotice) {
		this.outNotice = outNotice;
	}

	public int getOutMaxRow() {
		return outMaxRow;
	}

	public void setOutMaxRow(int outMaxRow) {
		this.outMaxRow = outMaxRow;
	}

	public int getOutMaxPage() {
		return outMaxPage;
	}

	public void setOutMaxPage(int outMaxPage) {
		this.outMaxPage = outMaxPage;
	}

	public Object getOutCursor() {
		return outCursor;
	}

	public void setOutCursor(Object outCursor) {
		this.outCursor = outCursor;
	}

	public int getRowCnt() {
		return rowCnt;
	}

	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}

	public int getLstNum() {
		return lstNum;
	}

	public void setLstNum(int lstNum) {
		this.lstNum = lstNum;
	}
	
	public int getUpDown() {
		return upDown;
	}

	public void setUpDown(int upDown) {
		this.upDown = upDown;
	}

	public String getMinIndex() {
		return minIndex;
	}

	public void setMinIndex(String minIndex) {
		this.minIndex = minIndex;
	}

	public String getMaxIndex() {
		return maxIndex;
	}

	public void setMaxIndex(String maxIndex) {
		this.maxIndex = maxIndex;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getNavigation() {
		return navigation;
	}

	public void setNavigation(String navigation) {
		this.navigation = navigation;
	}

	public Object getOutCursor1() {
		return outCursor1;
	}

	public void setOutCursor1(Object outCursor1) {
		this.outCursor1 = outCursor1;
	}

	public Object getOutCursor2() {
		return outCursor2;
	}

	public void setOutCursor2(Object outCursor2) {
		this.outCursor2 = outCursor2;
	}
	
	public Object getOutCursor3() {
		return outCursor3;
	}

	public void setOutCursor3(Object outCursor3) {
		this.outCursor3 = outCursor3;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
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

	public int getInSchType() {
		return inSchType;
	}

	public void setInSchType(int inSchType) {
		this.inSchType = inSchType;
	}

	public String getInSchText() {
		return inSchText;
	}

	public void setInSchText(String inSchText) {
		this.inSchText = inSchText;
	}

	public Object getOutUserMenuCursor() {
		return outUserMenuCursor;
	}

	public void setOutUserMenuCursor(Object outUserMenuCursor) {
		this.outUserMenuCursor = outUserMenuCursor;
	}

	public String getMySiteId() {
		return mySiteId;
	}

	public void setMySiteId(String mySiteId) {
		this.mySiteId = mySiteId;
	}

	public String getHigherMenuId() {
		return higherMenuId;
	}

	public void setHigherMenuId(String higherMenuId) {
		this.higherMenuId = higherMenuId;
	}

	public String getMyId() {
		return myId;
	}

	public void setMyId(String myId) {
		this.myId = myId;
	}
	
	public String getMyName() {
		return myName;
	}

	public void setMyName(String myName) {
		this.myName = myName;
	}

	public String getInSchStartDate() {
		return inSchStartDate;
	}

	public void setInSchStartDate(String inSchStartDate) {
		this.inSchStartDate = inSchStartDate;
	}

	public String getInSchEndDate() {
		return inSchEndDate;
	}

	public void setInSchEndDate(String inSchEndDate) {
		this.inSchEndDate = inSchEndDate;
	}

	public String getMultiCount() {
		return multiCount;
	}

	public void setMultiCount(String multiCount) {
		this.multiCount = multiCount;
	}
	
	public Object getViewTitle() {
		return viewTitle;
	}

	public void setViewTitle(Object viewTitle) {
		this.viewTitle = viewTitle;
	}

	public String getSchStartDate() {
		return schStartDate;
	}

	public void setSchStartDate(String schStartDate) {
		this.schStartDate = schStartDate;
	}

	public String getSchEndDate() {
		return schEndDate;
	}

	public void setSchEndDate(String schEndDate) {
		this.schEndDate = schEndDate;
	}

	public String getFileGubun() {
		return fileGubun;
	}

	public void setFileGubun(String fileGubun) {
		this.fileGubun = fileGubun;
	}

	public String getExcelDownYn() {
		return excelDownYn;
	}

	public void setExcelDownYn(String excelDownYn) {
		this.excelDownYn = excelDownYn;
	}

	public String getRtnUrl() {
		return rtnUrl;
	}

	public void setRtnUrl(String rtnUrl) {
		this.rtnUrl = rtnUrl;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getUseComId() {
		return useComId;
	}

	public void setUseComId(String useComId) {
		this.useComId = useComId;
	}

	public String getInRECUserID() {
		return inRECUserID;
	}

	public void setInRECUserID(String inRECUserID) {
		this.inRECUserID = inRECUserID;
	}

	public String getInRECDesc() {
		return inRECDesc;
	}

	public void setInRECDesc(String inRECDesc) {
		this.inRECDesc = inRECDesc;
	}

	public String[] getMenuIds() {
		return menuIds;
	}

	public void setMenuIds(String[] menuIds) {
		this.menuIds = menuIds;
	}

	public String getContinent() {
		return continent;
	}

	public void setContinent(String continent) {
		this.continent = StringUtil.paramUnscript(continent);
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = StringUtil.paramUnscript(country);
	}

	public String getReferenceMenuId() {
		return referenceMenuId;
	}

	public void setReferenceMenuId(String referenceMenuId) {
		this.referenceMenuId = referenceMenuId;
	}

	public String getReferenceSiteId() {
		return referenceSiteId;
	}

	public void setReferenceSiteId(String referenceSiteId) {
		this.referenceSiteId = referenceSiteId;
	}

	//공통 로그
	public String getObjectName() {
		return objectName;
	}

	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}

	public String getObjectType() {
		return objectType;
	}

	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}

	public String getDmlType() {
		return dmlType;
	}

	public void setDmlType(String dmlType) {
		this.dmlType = dmlType;
	}

	public String getDmlNotice() {
		return dmlNotice;
	}

	public void setDmlNotice(String dmlNotice) {
		this.dmlNotice = dmlNotice;
	}

	public Object getOutCursor4() {
		return outCursor4;
	}

	public void setOutCursor4(Object outCursor4) {
		this.outCursor4 = outCursor4;
	}

	public String getParamSiteId() {
		return paramSiteId;
	}

	public void setParamSiteId(String paramSiteId) {
		this.paramSiteId = paramSiteId;
	}

	public String getParamMenuId() {
		return paramMenuId;
	}

	public void setParamMenuId(String paramMenuId) {
		this.paramMenuId = paramMenuId;
	}

	public Boolean getIsMobile() {
		return isMobile;
	}

	public void setIsMobile(Boolean isMobile) {
		this.isMobile = isMobile;
	}

	public String getNewCheck() {
		return newCheck;
	}

	public void setNewCheck(String newCheck) {
		this.newCheck = newCheck;
	}

	public String getFileMenuId() {
		return fileMenuId;
	}

	public void setFileMenuId(String fileMenuId) {
		this.fileMenuId = fileMenuId;
	}

	public String getUploadFileDir() {
		return uploadFileDir;
	}

	public void setUploadFileDir(String uploadFileDir) {
		this.uploadFileDir = uploadFileDir;
	}

	public String getDbOwner() {
		return dbOwner;
	}

	public void setDbOwner(String dbOwner) {
		this.dbOwner = dbOwner;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getMySiteKey() {
		return mySiteKey;
	}

	public void setMySiteKey(String mySiteKey) {
		this.mySiteKey = mySiteKey;
	}

	public String getFileFormType() {
		return fileFormType;
	}

	public void setFileFormType(String fileFormType) {
		this.fileFormType = fileFormType;
	}

	public String getFileRealSize() {
		return fileRealSize;
	}

	public void setFileRealSize(String fileRealSize) {
		this.fileRealSize = fileRealSize;
	}

	public String getBoardMoveKind() {
		return boardMoveKind;
	}

	public void setBoardMoveKind(String boardMoveKind) {
		this.boardMoveKind = boardMoveKind;
	}
	
}
