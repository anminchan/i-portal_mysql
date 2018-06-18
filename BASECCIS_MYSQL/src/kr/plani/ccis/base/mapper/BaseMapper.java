package kr.plani.ccis.base.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("baseCommonMapper")
public interface BaseMapper {
	/*
	 * 메뉴 로케이션 받아오기
	 */
	public void connectLog(Object obj);
	public Object readLocation(Object obj);
	
	/*
	 * 공통코드 받아오기
	 */
	public List<?> listCode(Object obj);	
	
	/*
	 * 사이트 목록 받아오기
	 */
	public String selectGroupId (Object obj);
	public List<?> listSite(Object obj);
	
	/*
	 * 사이트 목록 받아오기(권한이 있는 사이트)
	 */
	public List<?> listAdminSite(Object obj);
	
	/*
	 * 카테고리 목록 받아오기
	 */
	public List<?> listCate(Object obj);

	/*
	 * 사용자 메뉴 받아오기
	 */
	public List<?> listUserMenu(Object obj);
	
	/*
	 * 파일받아오기
	 */
	public Object selectFiles(Object obj);
	
	/*
	 * 파일받아오기
	 */
	public void fileHitLog(Object obj);

	/*
	 * 컨텐츠의 대표이미지
	 */
	public Object selectContentsFile(Object obj);
	
	/*
	 * 사이트정보 가져오기 - menuId
	 */
	public Object selectSite(Object obj);

	/*
	 * 사이트정보 가져오기
	 */
	public Object selectSiteInfo(Object obj);	// param : mySiteId
	public Object selectSiteKeyInfo(Object obj); //param : siteKey

	/*
	 * 동적 사이트정보 가져오기
	 */
	public Object selectDynamicSiteInfo(Object obj);
	
	/*
	 * 동적 사이트 첨부파일 가져오기
	 */
	public List<?> selectDynamicSiteFile(Object obj);

	/*
	 * 동적사이트 콘텐츠 설정 정보 받아오기
	 */
	public List<?> selectDynamicSiteContentSet(Object obj);

	/*
	 * 동적사이트 콘텐츠 받아오기
	 */
	public List<?> selectDynamicSiteContent(Object obj);
	
	/*
	 * 메뉴정보 가져오기
	 */
	public Object selectMenuInfo(Object obj);
	
	/*
	 * 현제 메뉴의 하위메뉴 정보 가져오기
	 */
	public List<?> selectMenuInfoList(Object obj);
	
	/*
	 * 로그인
	 */
	public Object getLogin(Object obj);
	
	/*
	 * 정적컨텐츠 가져오기
	 */
	public Object viewContent(Object obj);
	
	/*
	 * 컨텐츠 설정 정보 가져오기
	 */
	public Object viewBoard(Object obj);
	
	/*게시판 입력/수정/삭제 */
	public Object actBoard(Object obj);

	/* 통합게시판 */
	public int listBoardCnt(Object obj);
	public List<?> listBoard(Object obj);
	
	/*자유형 게시판*/
	public Object listFreeBoard(Object obj);
	public Object viewFreeBoard(Object obj);

	/*공지형 게시판*/
	public Object listNoticeBoard(Object obj);
	public Object viewNoticeBoard(Object obj);
	public Object listCalendarBoard(Object obj);
	
	/*썸네일형 게시판*/
	public Object listThumbnailBoard(Object obj);
	public Object viewThumbnailBoard(Object obj);
	
	/*링크형 게시판*/
	public Object listLinkBoard(Object obj);
	public Object viewLinkBoard(Object obj);
	
	/*클리핑형 게시판*/
	public Object listClippingBoard(Object obj);
	public Object viewClippingBoard(Object obj);
	
	/*동영상형 게시판*/
	public Object listVodBoard(Object obj);
	public Object viewVodBoard(Object obj);
	
	/*민원형 게시판*/
	public Object listAppealBoard(Object obj);
	public Object listReplyBoard(Object obj);
	public Object viewAppealBoard(Object obj);
	public Object viewReplyBoard(Object obj);
	
	/*댓글*/
	public Object listReply(Object obj);
	public Object actReply(Object obj);

	public Object update(Object obj);
	public Object delete(Object obj);
	
	/*게시판 첨부파일 조회*/
	public List<?> listFiles(Object obj);
	
	/*팝업 목록 조회*/
	public List<?> listPopupZone(Object obj);
	
	/*행사 목록 조회*/
	public List<?> listEvent(Object obj);
	
	/*팝업창 목록 조회*/
	public List<?> listPopupWindow(Object obj);
	
	/*비주얼 목록 조회*/
	public List<?> listVisualZone(Object obj);
	
	/*배너 목록 조회*/
	public List<?> listBanner(Object obj);
	
	/*Family Site 목록 조회*/
	public List<?> listFamilySite(Object obj);

	/*만족도 등록*/
	public Object insertSatisfaction(Object obj);
	
	/*Email정보 등록*/
	public Object insertEmail(Object obj);
	
	/*SMS정보 등록*/
	public Object insertSMS(Object obj);

	/*MMS정보 등록*/
	public Object insertMMS(Object obj);
	
	/*
	 * 메인화면 포토 리스트 조회
	 */
	public List<?> listPhoto();
	
	/*파일다운로드 권한여부*/
	public Object getChkGroupRole(Object obj);
	
	public String getChkMenuId(Object obj);
	
	/*경영공시 담당자 Count*/
	public int selectAutonomyPersonCnt(Object obj);
	public List<?> selectAutonomyPersonList(Object obj);
	
	/*모바일 공지형게시판 원문 조회*/
	public Object getOriginalInfo(Object obj);
	/*모바일 공지형게시판 원문 location 조회*/
	public Object getOriginalLoc(Object obj);
	
	/*RSS 게시판 List 조회*/
	public List<?> selectRssList(Object obj);

	/*공개된 마지막 뉴스레터 조회*/
	public Object selectLastNewsLetter(Object obj);
	
	public int insertChangeLog(Object obj);

	/*행사 List 조회*/
	public List<?> listEventMonth(Object obj);
	
	/*추천키워드 목록 조회*/ 
	public List<?> listKeyword(Object obj);

	/*링크형 게시물의 URL 조회*/ 
	public Object linkUrl(Object obj);
	
	/*썸네일형 게시판*/
	public Object listCardBoard(Object obj);
	public Object viewCardBoard(Object obj);
	
	/*알림마당 > 뉴스레터 > 전체 게시판*/
	public List<?> selectListAllNewsLetter(Object obj);
	
	/*파일뷰어로그*/
	public String fileViewerInfo(Object obj);
	public void fileViewerLog(Object obj);
	
	public List<?> selectBoardListSet(Object obj);
	/*
	 * 방문자
	 */
	/*public void setTotalCount();
	public int getTotalCount();
	public int getTodayCount();*/
	
	/*두들 목록*/
	public List<?> listDoodles(Object obj);
}
