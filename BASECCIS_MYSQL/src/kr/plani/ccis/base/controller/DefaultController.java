package kr.plani.ccis.base.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.base.domain.UserGrade;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.TabooWord;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.domain.system.Menu;
import kr.plani.ccis.ips.service.site.TabooWordMgrService;
/*****************************************************************
* 기본 공통 컨트롤
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2014. 8. 12. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 01.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
public class DefaultController extends BaseCommonController
{
	// 메뉴ID 사용 시, 개발/운영 구분 (DEV/PROD)
	private static final String SERVER_MODE = "PROD";

	private static final Logger logger = LoggerFactory.getLogger(DefaultController.class);
	
	/** 공통기능 서비스   */
	@Resource
	private BaseService baseService;
	
	@Resource
	private TabooWordMgrService tabooWordMgrService;

	/*****************************************************************
	* main 사이트별 메인 컨트롤
	* @param request
	* @param response
	* @param menu
	* @param model
	* @return ModelAndView
	* @throws Exception
	*******************************************************************/
	@RequestMapping({ "/site", "/site/{siteId}" })
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response, DefaultDomain defaultDomain, Menu menu, Model model) throws Exception{
		// 서버 모드 설정
		model.addAttribute("SERVER_MODE", SERVER_MODE);
		String strMain = "";
		
		defaultDomain.setMySiteId(defaultDomain.getSiteId().toUpperCase());
		//logger.info("getMySiteId>>>" + menu.getMySiteId());

		SiteSet siteSet = new SiteSet();
		siteSet.mainGubun = "main";
		model.addAttribute("mainGubun", siteSet.mainGubun);

		//사이트 정보 조회
		HashMap siteInfo = (HashMap)baseService.selectSiteInfo(defaultDomain);

		if(StringUtil.nullCheck(siteInfo).equals("")){
			printWriterLog("error.site.bad.url", response);
			return null;
		}
		
		String strSiteType = (String)siteInfo.get("SITETYPE");
		siteSet.siteType = strSiteType;
		siteSet.siteKye = (String)siteInfo.get("SITEKEY");
		
		/*if(StringUtil.nullCheck(siteSet.siteType).equals("")){
			printWriterLog("error.site.bad.url", response);
			return null;
		}*/
		
		if(siteSet.siteType.equals("M")){
			if(siteSet.siteKye.equals("")){
				return null;
			}else{				
		        printWriterLog("error.site.bad.url", response);
				return null;
			}
			
		}else{
			strMain = request.getContextPath() + "/" + siteSet.siteKye;

			RedirectView rv = new RedirectView(strMain);
			rv.setExposeModelAttributes(false);
			return new ModelAndView(rv);
		}
	}
		
	/*****************************************************************
	* menuPage 메뉴별 이동 컨트롤
	* @param request
	* @param response
	* @param menu
	* @param model
	* @return ModelAndView
	* @throws Exception
	*******************************************************************/
	@RequestMapping({ "/{menuId}", "/menu", "/menu/{menuId}" })
	public ModelAndView menuPage(HttpServletRequest request, HttpServletResponse response, Menu menu, Model model) throws Exception {
		boolean bChk = false;
		
		String strUrl = "";
		String strMenuType = "";
		String strMenuId = "";
		
		menu.setMenuId(menu.getMenuId().toUpperCase());
		
		//세션값 가져오기
		SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
		logger.info("sc>>"+scUser);
		
		String strUserId = "";
		if(scUser == null){
			strUserId = "guest";
		}else{
			strUserId = scUser.getUserId();
		}
		
		//관리자 페이지일경우 관리자 세션가져오기
		HashMap siteInfoMenu = (HashMap)baseService.selectSite(menu);
		if(StringUtil.nullCheck(siteInfoMenu).equals("")){			
	        printWriterLog("error.menu.bad.url", response);
			return null;
		}
		
		//String strSiteId = (String)siteInfoMenu.get("SITEID");
		String strSiteKey = (String)siteInfoMenu.get("SITEKEY");
		String strSiteId = (String)siteInfoMenu.get("SITEID");
		if(strSiteKey.equals("ips")){
			//관리자 세션값 가져오기
			SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");

			if(sc == null){
				logger.info("로그인 필요");
				throw new ModelAndViewDefiningException(new ModelAndView("redirect:/i-portal/loginForm"));
			}
			strUserId = sc.getUserId();
		}
		
		menu.setMyId(strUserId);
		menu.setMySiteId(strSiteId);
		
		// 메뉴 조회
		List<?> aList = (List<?>)baseService.selectMenuInfoList(menu);
		for(int i=0; i<aList.size(); i++){
			HashMap siteInfo = (HashMap) aList.get(i);

			strMenuType = (String)siteInfo.get("MENUTYPE");
			strUrl = (String)siteInfo.get("PROGRAMURL");
			strUrl = StringUtil.nullCheck(strUrl);
			strMenuId = (String)siteInfo.get("MENUID");
			
			if(strMenuType.equals("C")){
				bChk = true;
				break;
			}else if(strMenuType.equals("P")){
				if(!strUrl.equals("") && !strUrl.equals("-") && !strUrl.equals(null)){
					bChk = true;
					break;
				}
			}
		}
		
		menu.setMenuId(strMenuId);
		
		if(!bChk){			
	        printWriterLog("error.menu.bad.url", response);
			return null;
		}

		if(strMenuType.equals("L") || strMenuType.equals("P")){
			if(strUrl.indexOf("menuId")>0){
				strUrl = request.getContextPath() + strUrl;
			}else{
				if(strUrl.indexOf("?")>0){
					strUrl = request.getContextPath() + strUrl + "&menuId="+strMenuId+"&siteId="+menu.getSiteId();
				}else{
					strUrl = request.getContextPath() + strUrl + "?menuId="+strMenuId+"&siteId="+menu.getSiteId();
				}
			}

			logger.info("strUrl >>>" + strUrl);
			RedirectView rv = new RedirectView(strUrl);
			rv.setExposeModelAttributes(false);
			return new ModelAndView(rv);	
		}else if(strMenuType.equals("C")){
			strUrl = "/board?menuId="+menu.getMenuId()+"&siteId="+menu.getSiteId();
			RedirectView rv = new RedirectView(request.getContextPath().concat(strUrl));
			rv.setExposeModelAttributes(false);
			return new ModelAndView(rv);
		}else{
			menu.setJsp("/base/content");
			return new ModelAndView("mps.sub.layout", "obj", menu);
		}
	}
	
	/*****************************************************************
	* satisfactionJson 만족도 등록 컨트롤
	* @param userGrade
	* @param request
	* @param model
	* @return Object
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/satisfaction/form", method=RequestMethod.GET)
	public @ResponseBody Object satisfactionJson (@ModelAttribute UserGrade userGrade, HttpServletRequest request, Model model) throws Exception {

		SiteSet siteSet = new SiteSet();
		// 기본 셋팅
		this.setCommon(baseService, request, model, userGrade, siteSet);

		// Parameter 설정
		userGrade.setInParam(request);
		
		userGrade.setInWorkName("고객만족도관리");
		userGrade.setInCondition("입력");

		//InDMLData ::  MenuID|LinkID|Grade|KText
		userGrade.setInDMLData(userGrade.makeDMLDataString());

		// 저장
		UserGrade objRtn = (UserGrade)baseService.insertSatisfaction(userGrade);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		return null;
	}
	
	/*****************************************************************
	* listRss RSS 컨트롤
	* @param userGrade
	* @param request
	* @param model
	* @return Object
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/rss")
	public ModelAndView listRss (@ModelAttribute DefaultDomain defaultDomain, @ModelAttribute Menu menu, @ModelAttribute ContentSet contentSet, @ModelAttribute Content content, @ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception {
		boolean bChk = false;
		
		String strUrl = "";
		String strMenuType = "";
		String strMenuId = "";
		
		menu.setMenuId(menu.getMenuId().toUpperCase());
		
		//세션값 가져오기
		SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
				
		String strUserId = "";
		if(scUser == null){
			strUserId = "guest";
		}else{
			strUserId = scUser.getUserId();
		}
				
		menu.setMyId(strUserId);
				
		// 메뉴 조회
		List<?> aList = (List<?>)baseService.selectMenuInfoList(menu);
		
		String menuKName = "";
		for(int i=0; i<aList.size(); i++){
			HashMap siteInfo = (HashMap) aList.get(i);
			strMenuType = (String)siteInfo.get("MENUTYPE");
			strUrl = (String)siteInfo.get("PROGRAMURL");
			strUrl = StringUtil.nullCheck(strUrl);
			strMenuId = (String)siteInfo.get("MENUID");
			menuKName = (String)siteInfo.get("KNAME");
			
			if(strMenuType.equals("C")){
				bChk = true;
				break;
			}
		}
				
		menu.setMenuId(strMenuId);

		if(strMenuType.equals("C")){
		
			// Parameter 설정
			contentSet.setInParam(request);
			contentSet.setParamMenuId(contentSet.getMenuId());
					
			// 콘텐츠설정 조회
			ContentSet objRtn = (ContentSet)baseService.getContentSet(contentSet);
					
			ContentSet setItem = (ContentSet)objRtn.getOutCursor();
					
			// Parameter 설정
			title.setInParam(request);
						
			title.setRowCnt(setItem.getRowCnt());
			//Title rtnBoard = new Title();
			List<?> list = null;
					
			list = baseService.selectRssList(title);
			
			/*if(setItem.getBoardKind().equals("FREE")){
				// 자유형게시판 조회
				rtnBoard = (Title)baseService.getFreeBoardList(title);
			}else if(setItem.getBoardKind().equals("NOTICE")){
				// 공지형게시판 조회
				rtnBoard = (Title)baseService.getListNoticeBoard(title);
				
			}else if(setItem.getBoardKind().equals("THUMBNAIL") || setItem.getBoardKind().equals("VOD")){
				
				if(setItem.getBoardKind().equals("THUMBNAIL")){
					// 썸네일형게시판 조회
					rtnBoard = (Title)baseService.getThumbnailBoardList(title);
				}else if(setItem.getBoardKind().equals("VOD")){
					// 동형게시판 조회
					rtnBoard = (Title)baseService.getListVodBoard(title);
				}
				
			}else if(setItem.getBoardKind().equals("VOD")){
				// 썸네일형게시판 조회
				rtnBoard = (Title)baseService.getListVodBoard(title);
				
			}else if(setItem.getBoardKind().equals("LINK")){
				// 공지형게시판 조회
				rtnBoard = (Title)baseService.getListLinkBoard(title);
			}else if(setItem.getBoardKind().equals("APPEAL") || setItem.getBoardKind().equals("REPLY")){
				// 민원형게시판 조회
				rtnBoard = (Title)baseService.getAppealBoardList(title);
			}else if(setItem.getBoardKind().equals("ETCNOTICE1")){
				// 입찰/수의 계약 게시판 조회
				rtnBoard = (Title)baseService.getTenderBoardList(title);
			}*/
			
			//List<HashMap<String, String>> item = (List<HashMap<String, String>>)rtnBoard.getOutCursor();

			//maxIndex, minIndex 조회
			/*String maxIndex = null;
			String minIndex = null;
			
			for(int i=0; i<item.size(); i++){
				if(item.get(i).get("NOTICETITLEYN").equals("N")){
					maxIndex = item.get(i).get("MAXINDEX");
					minIndex = item.get(i).get("MININDEX");
					break;
				}
			}*/
			
			model.addAttribute("menuKName", menuKName);
			model.addAttribute("result", list);

			//링크 정보
			String strLink = "";
			strLink = "&menuId=" + title.getMenuId();
			model.addAttribute("link", strLink);
		}

		return new ModelAndView("base/rss/rss", "obj", title);
	}
	
	/*****************************************************************
	* 유해어 검출
	* @param NewsLetter
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/tabooWord")
	public @ResponseBody List<?> listAjax(@ModelAttribute TabooWord tabooWord, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		tabooWord.setInParam(request);
		
		// 금기어설정 조회
		List<?> list = tabooWordMgrService.selectTabooWordList(tabooWord);

		return list;
	}
	
}
