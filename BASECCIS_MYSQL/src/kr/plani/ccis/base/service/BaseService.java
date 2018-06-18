package kr.plani.ccis.base.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.plani.ccis.base.domain.UserGrade;
import kr.plani.ccis.base.mapper.BaseMapper;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.common.User;
import kr.plani.ccis.ips.domain.site.Banner;
import kr.plani.ccis.ips.domain.site.Category;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Doodles;
import kr.plani.ccis.ips.domain.site.FamilySite;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.PopupWindow;
import kr.plani.ccis.ips.domain.site.PopupZone;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.domain.site.VisualZone;
import kr.plani.ccis.ips.domain.system.Site;

@Service("baseService")
public class BaseService {
	
	@Resource
	BaseMapper baseMapper;
	
	/*****************************************************************
	* readLocation 메뉴 로케이션 정보 받아오기
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object readLocation(Object obj) throws Exception {
		baseMapper.connectLog(obj);
		return baseMapper.readLocation(obj);
	}

	/*****************************************************************
	* listCombo 공통 코드 받아오기
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object[] listCode(Object obj) throws Exception {
		DefaultDomain inObj = (DefaultDomain)obj;
		baseMapper.listCode(inObj);
		
		DefaultDomain tmpInObj = new DefaultDomain();
		tmpInObj.setCopyParam(inObj);
		tmpInObj.setNavigation(inObj.getNavigation());
		tmpInObj.setMenuName(inObj.getMenuName());

		return new Object[] { tmpInObj.getNavigation(), tmpInObj.getMenuName()};
	}
	

	/*****************************************************************
	* listSite 사이트 목록 받아오기
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listSite(Object obj) throws Exception {
		Site inObj = (Site)obj;
		return baseMapper.listSite(inObj);
	}
	
	/*****************************************************************
	* listAdminSite 사이트 목록 받아오기
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listAdminSite(Object obj) throws Exception {
		Site inObj = (Site)obj;
		
		String groupId = baseMapper.selectGroupId(inObj);
		if(groupId.equals("GROUP00001")) inObj.setInGubun("all");
		
		return baseMapper.listAdminSite(inObj);
	}
	
	/*****************************************************************
	 * listCate 카테고리 목록 받아오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> listCate(Object obj) throws Exception {
		Category inObj = (Category)obj;
		return baseMapper.listCate(inObj);
	}
	
	/*****************************************************************
	 * listUserMenu 사용자 메뉴목록 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object listUserMenu(Object obj) throws Exception {
		DefaultDomain inObj = (DefaultDomain)obj;
		return baseMapper.listUserMenu(inObj);
	}
	
	/*****************************************************************
	 * selectContentsFile 컨텐츠의 대표이미지 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectContentsFile(Object obj) throws Exception {
		return baseMapper.selectContentsFile(obj);
	}
	
	/*****************************************************************
	 * selectFiles 파일정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectFiles(Object obj) throws Exception {
		return baseMapper.selectFiles(obj);
	}
	
	/*****************************************************************
	 * selectFiles 파일log
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public void fileHitLog(Object obj) throws Exception {
		baseMapper.fileHitLog(obj);
	}

	/*****************************************************************
	 * selectSite 사이트정보 가져오기 - 메뉴ID
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectSite(Object obj) throws Exception {
		return baseMapper.selectSite(obj);
	}
	
	/*****************************************************************
	 * selectSiteInfo 사이트정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectSiteInfo(Object obj) throws Exception {
		return baseMapper.selectSiteInfo(obj);
	}
	
	/*****************************************************************
	 * selectSiteInfo 사이트정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectSiteKeyInfo(Object obj) throws Exception {
		return baseMapper.selectSiteKeyInfo(obj);
	}

	/*****************************************************************
	 * selectDynamicSiteInfo 동적사이트정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectDynamicSiteInfo(Object obj) throws Exception {
		return baseMapper.selectDynamicSiteInfo(obj);
	}

	/*****************************************************************
	 * selectDynamicFile 동적사이트 파일 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectDynamicSiteFile(Object obj) throws Exception {
		return baseMapper.selectDynamicSiteFile(obj);
	}

	/*****************************************************************
	 * selectDynamicSiteContentSet 동적사이트 body 콘텐츠 설정정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectDynamicSiteContentSet(Object obj) throws Exception {
		return baseMapper.selectDynamicSiteContentSet(obj);
	}

	/*****************************************************************
	 * selectDynamicSiteContent 동적사이트 body 콘텐츠 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectDynamicSiteContent(Object obj) throws Exception {
		return baseMapper.selectDynamicSiteContent(obj);
	}
	
	/*****************************************************************
	 * selectMenuInfo 메뉴정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectMenuInfo(Object obj) throws Exception {
		return baseMapper.selectMenuInfo(obj);
	}
	
	/*****************************************************************
	 * selectMenuInfo 선택 메뉴의 하위메뉴 정보 가져오기
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object selectMenuInfoList(Object obj) throws Exception {
		return baseMapper.selectMenuInfoList(obj);
	}
	
	/*****************************************************************
	 * 사용자로그인
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public Object[] getLogin(Object obj) throws Exception {
		User inObj = (User)obj;
		baseMapper.getLogin(inObj);
		
		User tmpInObj = new User();
		tmpInObj.setCopyParam(inObj);
		tmpInObj.setOutResult(inObj.getOutResult());
		tmpInObj.setOutNotice(inObj.getOutNotice());
		tmpInObj.setOutCursor(inObj.getOutCursor());

		return new Object[] { tmpInObj.getOutResult(), tmpInObj.getOutNotice(), tmpInObj.getOutCursor()};
	}
	
	//콘텐츠 관려 시작
	/***************************************************
	 * getContentSet 콘텐츠 설정 정보 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object getContentSet(Object obj) throws Exception {
		ContentSet inObj = (ContentSet)obj;
		baseMapper.viewBoard(inObj);
		
		List<?> aList = null;
		aList = (List<?>)inObj.getOutCursor();
		
		if(aList.size() > 0) inObj.setOutCursor(aList.get(0));
		else inObj.setOutCursor(null);
		
		return inObj;
	}
	
	/***************************************************
	 * getContent 콘텐츠 정보 조회 (정적콘텐츠)
	 * @param obj
	 * @return
	 * @throws Exception
	 **************************************************/
	public Object getContent(Object obj) throws Exception {
		Content inObj = (Content)obj;
		baseMapper.viewContent(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/************************************************************
	 * getBoardList 게시판 리스트 갯수
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public int getBoardListCnt(Object obj) throws Exception {
		Title inObj = (Title)obj;
		return baseMapper.listBoardCnt(inObj);
	}
	
	/************************************************************
	 * getBoardList 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> getBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		return baseMapper.listBoard(inObj);
	}
	
	/************************************************************
	 * getFreeBoardList 자유형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getFreeBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listFreeBoard(inObj);
		
		return inObj;
	}

	/************************************************************
	 * getFreeBoard 자유형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getFreeBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewFreeBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/**********************************************************
	 * actFreeBoard 자유형 게시판 입력/수정/삭제
	 * @param obj
	 * @return
	 * @throws Exception
	 **********************************************************/
	public Object actBoard(Object obj) throws Exception {
		Content inObj = (Content)obj;
		baseMapper.actBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getNoticeBoardList 공지형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListNoticeBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listNoticeBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getNoticeBoardList 공지형 게시판 리스트(주요일정)
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListCalendarBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listCalendarBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getNoticeBoard 공지형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getNoticeBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewNoticeBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/************************************************************
	 * getThumbnailBoardList 썸네일 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getThumbnailBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listThumbnailBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getThumbnailBoard 썸네일 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getThumbnailBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewThumbnailBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/************************************************************
	 * getVodBoardList 동영상형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListVodBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listVodBoard(inObj);
		
		return inObj;
	}

	/************************************************************
	 * getVodBoard 동영상형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getVodBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewVodBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}

	
	/************************************************************
	 * getListLinkBoard 링크형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListLinkBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listLinkBoard(inObj);
		
		return inObj;
	};

	/************************************************************
	 * getListClippingBoard 클리핑형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListClippingBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listClippingBoard(inObj);
		
		return inObj;
	};
	
	/************************************************************
	 * getListLinkBoard 민원형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getAppealBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listAppealBoard(inObj);
		
		return inObj;
	};
	
	/************************************************************
	 * getReplyBoardList 관리자답변형 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getReplyBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listReplyBoard(inObj);
		
		return inObj;
	};
	
	/************************************************************
	 * getLinkBoard 민원형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getAppealBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewAppealBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		if(((List<?>)inObj.getOutCursor3()).size() > 0 ){
		inObj.setOutCursor3(((List<?>)inObj.getOutCursor3()).get(0));
		}
		
		return inObj;
	};
	
	/************************************************************
	 * getLinkBoard 관리자답변형 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getReplyBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewReplyBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		if(((List<?>)inObj.getOutCursor3()).size() > 0 ){
		inObj.setOutCursor3(((List<?>)inObj.getOutCursor3()).get(0));
		}
		
		return inObj;
	};
	
	/************************************************************
	 * getFileList 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getListFiles(Object obj) throws Exception{
		Link inObj = (Link)obj;
		baseMapper.listFiles(obj);

		return inObj.getOutCursor();
	}
	
	/*****************************************************************
	* getObjectList 팝업존 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listPopupZone(Object obj) throws Exception{
		PopupZone inObj = (PopupZone)obj;
		return baseMapper.listPopupZone(inObj);
	}
		
	/*****************************************************************
	 * getObjectList 팝업창 목록 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 *******************************************************************/
	public List<?> listPopupWindow(Object obj) throws Exception{
		PopupWindow inObj = (PopupWindow)obj;
		
		return baseMapper.listPopupWindow(inObj);
	}
	
	/*****************************************************************
	* getObjectList 비주얼존 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listVisualZone(Object obj) throws Exception{
		VisualZone inObj = (VisualZone)obj;
		return baseMapper.listVisualZone(inObj);
	}
	
	/*****************************************************************
	* getObjectList 베너 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listBanner(Object obj) throws Exception{
		Banner inObj = (Banner)obj;
		return baseMapper.listBanner(inObj);
	}
	
	/*****************************************************************
	* getObjectList Family Site 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listFamilySite(Object obj) throws Exception{
		FamilySite inObj = (FamilySite)obj;
		return baseMapper.listFamilySite(inObj);
	}
	
	/*****************************************************************
	* insertSatisfaction 만족도 등록
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object insertSatisfaction(Object obj) throws Exception{
		UserGrade inObj = (UserGrade)obj;
		baseMapper.insertSatisfaction(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getListPhoto 포토 리스트
	 * @param 
	 * @return List<?>
	 * @throws Exception
	 ***********************************************************/
	public List<?> getListPhoto() throws Exception{
		return baseMapper.listPhoto();
	}
	
	/************************************************************
	 * getChkGroupRole 파일다운로드 권한여부
	 * @param 
	 * @return List<?>
	 * @throws Exception
	 ***********************************************************/
	public Object getChkGroupRole(Object obj) throws Exception{
		return baseMapper.getChkGroupRole(obj);
	}
	
	public String getChkMenuId(Object obj) throws Exception{
		return baseMapper.getChkMenuId(obj);
	}
	
	public int selectAutonomyPersonCnt(Object obj) throws Exception{
		return baseMapper.selectAutonomyPersonCnt(obj);
	}
	
	public List<?> selectAutonomyPersonList(Object obj) throws Exception{
		return baseMapper.selectAutonomyPersonList(obj);
	}
	
	/*****************************************************************
	* getObjectList 모바일 공지형게시판 원문 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object getOriginalInfo(Object obj) throws Exception
	{
		Link inObj = (Link)obj;
		return baseMapper.getOriginalInfo(inObj);
	}
	
	/*****************************************************************
	* getObjectList 모바일 공지형게시판 원문 location 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public Object getOriginalLoc(Object obj) throws Exception
	{
		Link inObj = (Link)obj;
		return baseMapper.getOriginalLoc(inObj);
	}
	
	/************************************************************
	 * selectRssList RSS 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> selectRssList(Object obj) throws Exception{
		return baseMapper.selectRssList(obj);
	}
	
	/************************************************************
	 * selectLastNewsLetter 사이트 마지막 뉴스레터 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object selectLastNewsLetter(Object obj) throws Exception{
		return baseMapper.selectLastNewsLetter(obj);
	}
	
	public int insertChangeLog(Object obj)throws Exception{
		return baseMapper.insertChangeLog(obj);
	}
	
	/************************************************************
	 * getMyKeywordList 추천키워드 목록 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> getKeywordList(Object obj) throws Exception{
		return baseMapper.listKeyword(obj);
	}

	/************************************************************
	 * selectLinkUrl 링크형 게시물의 URL 조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object selectLinkUrl(Object obj) throws Exception {
		return baseMapper.linkUrl(obj);
	}

	/************************************************************
	 * getCardBoardList 썸네일 게시판 리스트
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getCardBoardList(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.listCardBoard(inObj);
		
		return inObj;
	}
	
	/************************************************************
	 * getCardBoard 썸네일 게시판 상세조회
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public Object getCardBoard(Object obj) throws Exception {
		Title inObj = (Title)obj;
		baseMapper.viewCardBoard(inObj);
		inObj.setOutCursor(((List<?>)inObj.getOutCursor()).get(0));
		
		return inObj;
	}
	
	/************************************************************
	 * selectListAllNewsLetter 알림마당 > 뉴스레터 > 전체 게시판
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public List<?> selectListAllNewsLetter(Object obj) throws Exception {
		return baseMapper.selectListAllNewsLetter(obj);
	}
	
	/************************************************************
	 * fileViewerCnt 유무여부
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public String fileViewerInfo(Object obj) throws Exception{
		return baseMapper.fileViewerInfo(obj);
	}
	
	/************************************************************
	 * fileViewerLog 생성
	 * @param obj
	 * @return
	 * @throws Exception
	 ***********************************************************/
	public void fileViewerLog(Object obj) throws Exception{
		baseMapper.fileViewerLog(obj);
	}
	
	public List<?> getBoardListSet(Object obj) throws Exception {
		return baseMapper.selectBoardListSet(obj);
	}
	
	/*private static CommonService instance;
    
    // 싱글톤 패턴
    public CommonService(){}
    public static CommonService getInstance(){
        if(instance==null)
            instance=new CommonService();
        return instance;
    }

	public void setTotalCount() throws Exception {
		commonMapper.setTotalCount();
	}
	
	public int getTotalCount() throws Exception {
		return commonMapper.getTotalCount();
	}
	
	public int getTodayCount() throws Exception {
		return commonMapper.getTodayCount();
	}*/
	
	/*****************************************************************
	* getObjectList 두들 목록 조회
	* @param obj
	* @return
	* @throws Exception
	*******************************************************************/
	public List<?> listDoodles(Object obj) throws Exception
	{
		Doodles inObj = (Doodles)obj;
		
		return baseMapper.listDoodles(inObj);
	}
}
