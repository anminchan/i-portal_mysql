package kr.plani.ccis.ips.controller.site;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.FileUtil;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.controller.system.SiteMgrController;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Files;
import kr.plani.ccis.ips.domain.site.GuestInfo;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Reply;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentMgrService;

/*****************************************************************
* 콘첸츠등록관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2017. 05. 01. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 01.		mcahn		 작성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/contentMgr")
public class ContentMgrController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(SiteMgrController.class);

	/** 콘텐츠관리 서비스   */
	@Resource
	private ContentMgrService contentMgrService;
	
	@Resource
	private CommonService commonService;

	/*첨부파일관련*/
	@Resource
	private NamoCrossFile namoCrossFile;

	@Resource
	private FileUtil fileUtil;
	
	/*****************************************************************
	* list 콘텐츠 설정트리 목록 조회
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute ContentSet contentSet, HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setSiteId(request.getParameter("siteId"));
		contentSet.setParamMenuId(contentSet.getMenuId());

		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);
		
		if(!StringUtil.isNotBlank(contentSet.getSiteId())) contentSet.setSiteId(getSiteId());
				
		//메뉴 조회
		//ContentSet objRtn = null;
		List<?> objRtn = null;
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		if(sc.getTotalAuth().equals("Y")){
			objRtn = (List<?>)contentMgrService.getContentSetList(contentSet);
		}else{
			objRtn = (List<?>)contentMgrService.getContentSetAdminList(contentSet);
		}
		
		//실행결과 로기 생성
		this.resultLog(contentSet);
		
		// View 설정
		model.addAttribute("result", objRtn);
		model.addAttribute("resultSite", commonService.getSiteName(contentSet));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pSiteId", contentSet.getSiteId());
		
		// 컨텐츠 설정정보에서 바로 넘어온경우
		model.addAttribute("moveMenuId", request.getParameter("moveMenuId"));
		model.addAttribute("moveBoardKind", request.getParameter("moveBoardKind"));
		
		contentSet.setJsp("site/contentMgr/form");
		return new ModelAndView("ips.layout", "obj", contentSet);
	}

	/*****************************************************************
	* contentForm 정적콘텐츠 
	* @param content
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(params="boardKind=CONTENTS")
	public ModelAndView formContent( @ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		content.setInParam(request);
		content.setParamMenuId(content.getMenuId());

		// 기본 셋팅
		//this.setCommon(commonService, request, model, content);
		
		// 콘텐츠설정 조회
		//Content objRtn = (Content)contentMgrService.getContentSet(content);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(content));
		
		// 정적콘텐츠 조회
		Content rtnContent = (Content)contentMgrService.getContent(content);
		//Content rtnContentC= (Content)rtnContent.getOutCursor();
		
		// 정적콘텐츠 이력조회
		//Content rtnHistory = (Content)contentMgrService.getHistory(rtnContentC);
		
		// 정적콘텐츠 공유 메뉴 조회
		//Content rtnContentLinkList = (Content) contentMgrService.ListContentsLink(content);
		
		model.addAttribute("rtnContentLinkList", contentMgrService.ListContentsLink(content));
		model.addAttribute("rtnContent", rtnContent);		
		model.addAttribute("rtnHistory", contentMgrService.getHistory(rtnContent));

		//경영공시담당자
		//this.setAutonomy(commonService, model, content);
		
		content.setJsp("site/contentMgr/content/form");
		return new ModelAndView("ips.content.layout", "obj", content);
	}
	
	/*****************************************************************
	* contentForm 정적콘텐츠 입력/수정 
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/actContent", method=RequestMethod.POST)	
	public ModelAndView actContent( @ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
				
		// Parameter 설정
		content.setInParam(request);
		content.setParamMenuId(content.getMenuId());
		content.setInWorkName("콘텐츠관리");
		content.setInCLOBData1(request.getParameter("KHtml"));

		// 기본 셋팅
		//this.setCommon(commonService, request, model, content);
				 
		if(StringUtil.isNotBlank(content.getLinkId())){
			content.setInCondition("수정");
		}else{
			content.setInCondition("입력");
		}
		
		// 변경후 데이타 저장(inAfterData)
		content.setInAfterData(content.makeDataString());

		//InDMLData ::  Menuid|BoardID|LinkID|Kname|Keyword1|Keyword2|Keyword3
		//content.setInDMLData(content.makeDMLDataString());
		
		// 저장
		Content objRtn = (Content) contentMgrService.actContent(content);
		
		//실행결과 로기 생성
		content.setDmlType(content.getInCondition().equals("입력") ? "I" : content.getInCondition().equals("수정") ? "U" : "D");
		content.setDmlNotice("정상적으로 ("+content.getInWorkName()+")"+content.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(content);
		
		//실행결과 로기 생성
		this.resultLog(content);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		// 정적콘텐츠 조회
		Content rtnContent = (Content)contentMgrService.getContent(content);
		//Content rtnContentC= (Content)rtnContent.getOutCursor();
		
		// 정적콘텐츠 이력조회
		//Content rtnHistory = (Content)contentMgrService.getHistory(rtnContent);
		
		// 정적콘텐츠 공유 메뉴 조회
		//Content rtnContentLinkList = (Content) contentMgrService.ListContentsLink(content);
		
		model.addAttribute("rtnContentLinkList", contentMgrService.ListContentsLink(content));
		model.addAttribute("rtnContent", rtnContent);
		model.addAttribute("rtnHistory", contentMgrService.getHistory(rtnContent));
		
		content.setJsp("site/contentMgr/content/form");
		return new ModelAndView("ips.content.layout", "obj", content);
	}
	
	@RequestMapping(value="/selectContentMenuPopup")
    public ModelAndView selectMenuPopup(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		content.setInParam(request);
		
		// 파라메타 세팅
		content.setSiteId(request.getParameter("siteId"));

		if(!StringUtil.isNotBlank(content.getSiteId())) content.setSiteId(getSiteId());
		
		// 콘텐츠설정 조회
		Content objRtn = (Content) contentMgrService.getObjectList(content);
		
		//실행결과 로기 생성
		this.resultLog(content);
		
		// View 설정
		model.addAttribute("result", objRtn.getOutCursor());
		model.addAttribute("resultSite", commonService.getSiteName(content));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(content.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", content.getParamMenuId());
		model.addAttribute("pSiteId", content.getSiteId());

		content.setJsp("site/contentMgr/content/selectContentMenuPopup");
		content.setViewTitle("선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", content);
 
    }
	
	@RequestMapping(value="/actListContentLink")
    public @ResponseBody Content actListContentLink(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
    	
		content.setInWorkName("정적콘텐츠공유관리");
		content.setInParam(request);
		content.setInCondition(request.getParameter("condition"));
		
		// 현재MenuID|이관MenuID|LinkID|TitleID
		content.setInDMLData(request.getParameter("menuId") + "|" + request.getParameter("copyMenuId") + "|" + request.getParameter("linkId") + "|" + request.getParameter("titleId"));
		
		Content objRtn = (Content)contentMgrService.actListContentLink(content);
    	
    	return objRtn;
    }
	
	/*********************************************************************
	 * freeBoardList 자유형게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ********************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=FREE")
	public ModelAndView listFreeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, title);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 자유게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);

		//페이징 정보
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=FREE" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		title.setJsp("site/contentMgr/free/list");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/*******************************************************************
	 * freeBoardView 자유형게시판 상세
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@RequestMapping(value="/view", params="boardKind=FREE")
	public ModelAndView viewFreeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 자유게시판 상세조회
		//Link rtnFreeBoard = (Link)contentMgrService.getFreeBoard(link);
		HashMap item = (HashMap) contentMgrService.getBoardView(link);
		
		model.addAttribute("rtnContent", item);
		model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
		
		link.setParentLinkId(item.get("PARENTLINKID").toString());
		link.setReplyNo(item.get("REPLYNO").toString());
		model.addAttribute("rtnFrevNext", contentMgrService.getBoardFrevNext(link));

		// 조회수 증가
		contentMgrService.updateBoardHitCount(link);
		
		//HashMap hm = (HashMap) rtnFreeBoard.getOutCursor();
		
		Title title = new Title();
		title.setMenuId(contentSet.getMenuId());
		title.setInParam(request);
		title.setTitleId(Integer.parseInt(item.get("TITLEID").toString()));
		
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//실행결과 로기 생성
		//this.resultLog(rtnFreeBoard);
		
		//링크 정보
		String strLink = "";
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=FREE" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/free/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*******************************************************************
	 * freeBoardView 자유형게시판 폼
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=FREE")
	public ModelAndView formFreeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		link.setMyName("전체관리자");
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			// 자유게시판 상세조회
			//Link rtnFreeBoard = (Link)contentMgrService.getFreeBoard(link);
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로기 생성
			//this.resultLog(rtnFreeBoard);
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
			// 자유게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getFreeBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=FREE" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/free/form"+link.getFileFormType()); // 파일입력폼에 따라 달라 짐
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actFreeBoard 자유형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actFreeBoard", method=RequestMethod.POST)
	public ModelAndView actFreeBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("자유형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		//dml data 변수
		/*String contentDml = null;
		String guestDml = null;
		String fileDml = null;*/
		
		//after data  변수
		String contentData = null;
		String guestData = null;
		String fileData = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
			}else{ // namoFiles
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//dmlData 설정
			/*contentDml = content.makeFreeDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();*/
			
			//afterData 설정
			contentData = content.makeFreeDataString();
			guestData = guestInfo.makeFreeDataString(); 
			fileData = uploadFiles.makeFreeDataString();

			//content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
			content.setInAfterData(contentData+guestData+fileData);
			
			//objRtn = (Content) contentMgrService.actFreeBoard(content);
			objRtn = (Content) contentMgrService.actBoard(content, uploadFiles, guestInfo);
			
		}else{
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				/*contentDml = content.makeFreeDMLDataString();
				fileDml = files.makeFreeDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				
				logger.info(contentDml+"|"+guestDml+"|"+fileDml);
				content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);*/
				//objRtn = (Content) contentMgrService.actFreeBoard(content);
				objRtn = (Content) contentMgrService.actBoard(content, null, null);
			}
		}
		
		// changLog
		content.setDmlType(content.getInCondition().equals("입력") ? "I" : content.getInCondition().equals("수정") ? "U" : "D");
		content.setDmlNotice("정상적으로 ("+content.getInWorkName()+")"+content.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(content);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
				
		//링크 정보
		String strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		if(content.getInCondition().equals("수정")){
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr/view?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	* listNoticeBoard 공지형게시판 리스트
	* @param boardKind
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=NOTICE")
	public ModelAndView listNoticeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 공지게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		//페이징 정보
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인

		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=NOTICE" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId())+
				"&continent="+StringUtil.nullCheck(title.getContinent())+
				"&country="+StringUtil.nullCheck(title.getCountry());
		
		model.addAttribute("link", strLink);
		
		title.setJsp("site/contentMgr/notice/list");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/*****************************************************************
	 * formNoticeBoard 공지형게시판 폼
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=NOTICE")
	public ModelAndView formNoticeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		//경영공시담당자
		//this.setAutonomy(commonService, model, contentSet);
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setMyName("전체관리자");
		link.setInParam(request);

		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			// 공지게시판 상세조회
			//Link rtnNoticeBoard = (Link)contentMgrService.getNoticeBoard(link);
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로그 생성
			//this.resultLog(rtnNoticeBoard);
			
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
			// 공지게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getNoticeBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=NOTICE" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId()) +
				"&continent="+StringUtil.nullCheck(link.getContinent())+
				"&country="+StringUtil.nullCheck(link.getCountry());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/notice/form"+link.getFileFormType());
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*****************************************************************
	 * viewNoticeBoard 공지형게시판 상세
	 * @param site
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/view", params="boardKind=NOTICE")
	public ModelAndView viewNoticeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 공지게시판 상세조회
		//Link rtnNoticeBoard = (Link)contentMgrService.getNoticeBoard(link);
		HashMap item = (HashMap) contentMgrService.getBoardView(link);
		
		model.addAttribute("rtnContent", item);
		model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
		
		link.setParentLinkId(item.get("PARENTLINKID").toString());
		link.setReplyNo(item.get("REPLYNO").toString());
		model.addAttribute("rtnFrevNext", contentMgrService.getBoardFrevNext(link));
				
		// 조회수 증가
		contentMgrService.updateBoardHitCount(link);
		
		//HashMap hm = (HashMap) rtnNoticeBoard.getOutCursor();
		
		Title title = new Title();
		title.setMenuId(contentSet.getMenuId());
		title.setInParam(request);
		title.setTitleId(Integer.parseInt(item.get("TITLEID").toString()));
		
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//실행결과 로기 생성
		//this.resultLog(rtnNoticeBoard);
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=NOTICE" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId()) +
				"&continent="+StringUtil.nullCheck(title.getContinent()) +
				"&country="+StringUtil.nullCheck(title.getCountry());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/notice/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actNoticeBoard 공지형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actNoticeBoard", method=RequestMethod.POST)
	public ModelAndView actNoticeBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("공지형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		// After data 변수
		String contentData = null;
		String fileData = null;
		String guestData = null;
		
		// DML data 변수
		/*String contentDml = null;
		String fileDml = null;
		String guestDml = null;*/

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();

		if(arrLinkId.length <= 1){ // 등록 or 수정
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
			}else{ // namoFiles
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//parameter 설정
			contentData = content.makeNoticeDataString();
			fileData = uploadFiles.makeFreeDataString();
			guestData = guestInfo.makeFreeDataString();
			
			/*contentDml = content.makeNoticeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();*/
			
			content.setInAfterData(contentData + guestData + fileData);
			//content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
			//objRtn = (Content) contentMgrService.actNoticeBoard(content);	
			objRtn = (Content) contentMgrService.actBoard(content, uploadFiles, guestInfo);
		} else { // 삭제
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				/*contentDml = content.makeNoticeDMLDataString();
				fileDml = files.makeFreeDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				
				content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);*/
				//objRtn = (Content) contentMgrService.actNoticeBoard(content);
				objRtn = (Content) contentMgrService.actBoard(content, null, null);
			}
		}
		
		//changLog
		content.setDmlType(content.getInCondition().equals("입력") ? "I" : content.getInCondition().equals("수정") ? "U" : "D");
		content.setDmlNotice("정상적으로 ("+content.getInWorkName()+")"+content.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(content);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
				
		//링크 정보		
		String strLink = request.getParameter("link");
			
		model.addAttribute("link", strLink);
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		if(content.getInCondition().equals("수정")){
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr/view?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		return new ModelAndView(rv);
	}
	
	/***********************************************************************
	 * listThumbnailBoard 썸네일형 게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=THUMBNAIL")
	public ModelAndView listThumbnailBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 기본 boardStyle 지정
		if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
			title.setBoardStyle("Gallery");
		}
		
		//int viewLength = 0;
		// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9] 
		if(title.getBoardStyle().equals("Text")){
			//title.setRowCnt(setItem.getRowCnt());
		}else if(title.getBoardStyle().equals("Image")){
			//viewLength = 50;
			//title.setRowCnt(10);
		}else if(title.getBoardStyle().equals("Gallery")){
			//viewLength = 100;
			title.setRowCnt(9);
		}
		
		// 썸네일게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=THUMBNAIL" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(title.getBoardStyle())+
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);

		title.setJsp("site/contentMgr/thumbnail/list"+title.getBoardStyle());
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/*********************************************************************
	 * viewThumbnailBoard 썸네일형게시판 상세
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *********************************************************************/
	@RequestMapping(value="/view", params="boardKind=THUMBNAIL")
	public ModelAndView viewThumbnailBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 썸네일게시판 상세조회
		//Link rtnThumbnailBoard = (Link)contentMgrService.getThumbnailBoard(link);
		HashMap item = (HashMap) contentMgrService.getBoardView(link);
		
		model.addAttribute("rtnContent", item);
		model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
		
		link.setParentLinkId(item.get("PARENTLINKID").toString());
		link.setReplyNo(item.get("REPLYNO").toString());
		model.addAttribute("rtnFrevNext", contentMgrService.getBoardFrevNext(link));

		// 조회수 증가
		contentMgrService.updateBoardHitCount(link);
		
		Title title = new Title();
		title.setMenuId(contentSet.getMenuId());
		title.setInParam(request);
		title.setTitleId(Integer.parseInt(item.get("TITLEID").toString()));
		
		//실행결과 로기 생성
		//this.resultLog(rtnThumbnailBoard);
		
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=THUMBNAIL" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(link.getBoardStyle()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/thumbnail/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*****************************************************************
	 * formThumbnailBoard 썸네일형게시판 폼
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=THUMBNAIL")
	public ModelAndView formThumbnailBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setMyName("전체관리자");
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			// 썸네일게시판 상세조회
			//Link rtnThumbnail = (Link)contentMgrService.getThumbnailBoard(link);
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로기 생성
			//this.resultLog(rtnThumbnail);
		
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
			// 썸네일게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getThumbnailBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();*/
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=THUMBNAIL" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(link.getBoardStyle()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/thumbnail/form"+link.getFileFormType());
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actThumbnailBoard 썸네일형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actThumbnailBoard", method=RequestMethod.POST)
	public ModelAndView actThumbnailBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		logger.info("썸네일형 게시판 입력/수정/삭제");
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("썸네일형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		//dml data 변수
		String contentDml = null;
		String guestDml = null;
		String fileDml = null;
		
		//after data  변수
		String contentData = null;
		String guestData = null;
		String fileData = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		String altInfo = request.getParameter("altInfoArr");
		String altInfoFirst = request.getParameter("altInfoFirst");
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
			}else{ // namoFiles
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//content Image 파일 정보 설정
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
				content.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
				content.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
				content.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
			}
			
			//parameter 설정
			contentData = content.makeFreeDataString();
			guestData = guestInfo.makeFreeDataString(); 
			fileData = uploadFiles.makeFreeDataString();
			
			/*contentDml = content.makeThumbnailDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();*/
			
			content.setInAfterData(contentData + guestData + fileData);
			//content.setInDMLData(contentDml+"|"+altInfoFirst+"|"+guestDml+"|"+fileDml+"|"+altInfo);
			
			//objRtn = (Content) contentMgrService.actThumbnailBoard(content);
			objRtn = (Content) contentMgrService.actBoard(content, uploadFiles, guestInfo);
		} else {
			
			/*Files uploadFiles = (Files)namoCrossFile.fileUploadAttempt(files, request);
			
			//content Image 파일 정보 설정
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
			content.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
			content.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
			content.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
			}*/
			
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				/*contentDml = content.makeThumbnailDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				fileDml = files.makeFreeDMLDataString();
				
				content.setInDMLData(contentDml+"|"+altInfoFirst+"|"+guestDml+"|"+fileDml+"|"+altInfo);*/
				//objRtn = (Content) contentMgrService.actThumbnailBoard(content);
				objRtn = (Content) contentMgrService.actBoard(content, null, null);
			}
		}
		
		//changLog
		content.setDmlType(content.getInCondition().equals("입력") ? "I" : content.getInCondition().equals("수정") ? "U" : "D");
		content.setDmlNotice("정상적으로 ("+content.getInWorkName()+")"+content.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(content);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//링크 정보
		String strLink = "";
		strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		if(content.getInCondition().equals("수정")){
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr/view?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		
		logger.info(rv.getUrl());
		
		return new ModelAndView(rv);
	}
	
	/************************************************************
	 * replyListJson 댓글 리스트
	 * @param reply
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************/
	@RequestMapping(value="/replyList")
	public @ResponseBody List<?> replyListJson(@ModelAttribute Reply reply, HttpServletRequest request, Model model) throws Exception{
		
		//기본 셋팅
		reply.setInParam(request);
		
		List<Reply> rtnList = new ArrayList<Reply>();
		List<Reply> list = (List<Reply>)contentMgrService.getReplyList(reply);
		
		SCookie sc = (SCookie)request.getSession().getAttribute("USER");
		SCookie admSc = (SCookie)request.getSession().getAttribute("ADMUSER");
		String userId = "";
		
		if (sc != null || admSc != null) {
			userId = sc != null ? sc.getUserId() : admSc.getUserId();
		}
		
		String dmlUserId = "";
		Reply isMyReply = new Reply();
		
		for(int i=0; i <list.size(); i++){
			isMyReply = new Reply();
			dmlUserId = (String) list.get(i).getDmlUserId();
			isMyReply = list.get(i);
			if(dmlUserId.equals(userId)){
				isMyReply.setIsMyReply("Y");
			}else{
				isMyReply.setIsMyReply("N");
			}
			rtnList.add(i, isMyReply);
		}
		
		return rtnList;
	}
	
	/************************************************************
	 * replyAct 댓글 입력/수정/삭제
	 * @param reply
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************/
	@RequestMapping(value="/replyAct", method=RequestMethod.POST)
	public @ResponseBody String replyActJson(@ModelAttribute Reply reply, HttpServletRequest request, Model model) throws Exception{
		
		//기본 셋팅
		reply.setInParam(request);
		reply.setInWorkName("댓글관리");
		reply.setInDMLData(reply.makeDMLDataString());
		
		if(request.getSession().getAttribute("USER") == null && request.getSession().getAttribute("ADMUSER") == null){
			return "NOUSER";
		}
		
		contentMgrService.actReply(reply);
		
		return "SUCCESS";
	}
	
	/****************************************************************
	 * replyDelteJson 댓글 삭제
	 * @param reply
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/replyDelete", method=RequestMethod.POST)
	public @ResponseBody String replyDeleteJson(@ModelAttribute Reply reply, HttpServletRequest request, Model model) throws Exception {

		//기본 셋팅
		reply.setInParam(request);
		reply.setInWorkName("댓글관리");
		reply.setInCondition("삭제");
		reply.setInDMLData(reply.makeDMLDataString());
		
		contentMgrService.actReply(reply);
		
		return null;
	}
	
	/*****************************************************************
	* listLinkBoard 링크형게시판 리스트
	* @param boardKind
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=LINK")
	public ModelAndView listLinkBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);		
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 링크게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=LINK" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId()) +
				"&continent="+StringUtil.nullCheck(title.getContinent()) +
				"&country="+StringUtil.nullCheck(title.getCountry());
		
		model.addAttribute("link", strLink);
		
		title.setJsp("site/contentMgr/link/list");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/*****************************************************************
	 * formLinkBoard 링크형게시판 폼
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=LINK")
	public ModelAndView formLinkBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setMyName("전체관리자");
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			
			// 링크게시판 상세조회
			//Link rtnLinkBoard = (Link)contentMgrService.getLinkBoard(link);
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로그 생성
			//this.resultLog(rtnLinkBoard);
		
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){

			// 링크게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getLinkBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=LINK" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId()) +
				"&continent="+StringUtil.nullCheck(link.getContinent()) +
				"&country="+StringUtil.nullCheck(link.getCountry());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/link/form");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actLinkBoard 링크형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actLinkBoard", method=RequestMethod.POST)
	public ModelAndView actLinkBoard(@ModelAttribute Content content, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("링크형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		//After data  변수
		String contentData = null;
		String guestData = null;
		
		//DML data 변수
		String contentDml = null;
		String guestDml = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){									
			//parameter 설정			
			contentData = content.makeLinkDataString();
			guestData = guestInfo.makeFreeDataString();
			
			//DML data 설정
			/*contentDml = content.makeLinkDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();*/
			
			content.setInAfterData(contentData + guestData);
			//content.setInDMLData(contentDml+"|"+guestDml);
			//objRtn = (Content) contentMgrService.actLinkBoard(content);			
			objRtn = (Content) contentMgrService.actBoard(content, null, guestInfo);		
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				/*contentDml = content.makeLinkDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				
				content.setInDMLData(contentDml+"|"+guestDml);
				objRtn = (Content) contentMgrService.actLinkBoard(content);*/
				objRtn = (Content) contentMgrService.actBoard(content, null, null);
			}
		}
		
		//changLog
		content.setDmlType(content.getInCondition().equals("입력") ? "I" : content.getInCondition().equals("수정") ? "U" : "D");
		content.setDmlNotice("정상적으로 ("+content.getInWorkName()+")"+content.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(content);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//링크 정보		
		String strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	* listLinkBoard 클리핑형게시판 리스트
	* @param boardKind
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=CLIPPING")
	public ModelAndView listClippingBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);		
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 링크게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);

		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=CLIPPING" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);

		title.setJsp("site/contentMgr/clipping/list");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/*****************************************************************
	 * formLinkBoard 클리핑형게시판 폼
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=CLIPPING")
	public ModelAndView formClippingBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		link.setMyName("전체관리자");
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			
			// 링크게시판 상세조회
			//Link rtnLinkBoard = (Link)contentMgrService.getClippingBoard(link);
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로그 생성
			//this.resultLog(rtnLinkBoard );
		
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){

			// 링크게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getClippingBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=CLIPPING" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/clipping/form");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actLinkBoard 클리핑형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actClippingBoard", method=RequestMethod.POST)
	public ModelAndView actClippingBoard(@ModelAttribute Content content, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("클리핑형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		//After data  변수
		String contentData = null;
		String guestData = null;
		
		//DML data 변수
		String contentDml = null;
		String guestDml = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){						
			//parameter 설정			
			contentData = content.makeClippingDataString();
			guestData = guestInfo.makeFreeDataString();
			
			//DML data 설정
			contentDml = content.makeClippingDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			
			content.setInAfterData(contentData + guestData);
			content.setInDMLData(contentDml+"|"+guestDml);
			objRtn = (Content) contentMgrService.actClippingBoard(content);			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				contentDml = content.makeClippingDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				
				content.setInDMLData(contentDml+"|"+guestDml);
				objRtn = (Content) contentMgrService.actClippingBoard(content);
			}
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//링크 정보		
		String strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	* listVodBoard 동영상형게시판 리스트
	* @param boardKind
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=VOD")
	public ModelAndView listVodBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 기본 boardStyle 지정
		if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
			title.setBoardStyle("Text");
		}
		
		//int viewLength = 0;
		// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9] 
		if(title.getBoardStyle().equals("Text")){
			//title.setRowCnt(setItem.getRowCnt());
		}else if(title.getBoardStyle().equals("Image")){
			//viewLength = 50;
			//title.setRowCnt(10);
		}else if(title.getBoardStyle().equals("Gallery")){
			//viewLength = 100;
			title.setRowCnt(9);
		}
				
		// 동영상게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);

		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				  "&boardKind=VOD" + 
				  "&schType="+title.getSchType() + 
				  "&schText="+StringUtil.nullCheck(title.getSchText()) +
				  "&boardStyle="+StringUtil.nullCheck(title.getBoardStyle())+
				  "&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);

		title.setJsp("site/contentMgr/vod/list"+title.getBoardStyle());
		return new ModelAndView("ips.content.layout", "obj", title);
	}

	/*****************************************************************
	 * formVodBoard 동영상형게시판 폼
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=VOD")
	public ModelAndView formVodBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setMyName("전체관리자");
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			
			// 공지게시판 상세조회
			//Link rtnVodBoard = (Link)contentMgrService.getVodBoard(link);
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로그 생성
			//this.resultLog(rtnVodBoard);
		
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){

			// 공지게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getVodBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();

			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				  "&rowCnt=" + link.getRowCnt() +
				  "&menuId=" + link.getMenuId() + 
				  "&boardKind=VOD" + 
				  "&schType="+link.getSchType() + 
				  "&schText="+StringUtil.nullCheck(link.getSchText()) +
				  "&boardStyle="+StringUtil.nullCheck(link.getBoardStyle()) +
				  "&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/vod/form"+link.getFileFormType());
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*****************************************************************
	 * viewVodBoard 동영상형게시판 상세
	 * @param boardkind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/view", params="boardKind=VOD")
	public ModelAndView viewVodBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		//실행결과 로기 생성
		//this.resultLog(objRtn);

		// 공지게시판 상세조회
		//Link rtnVodBoard = (Link)contentMgrService.getVodBoard(link);
		HashMap item = (HashMap) contentMgrService.getBoardView(link);
		
		model.addAttribute("rtnContent", item);
		model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
		
		link.setParentLinkId(item.get("PARENTLINKID").toString());
		link.setReplyNo(item.get("REPLYNO").toString());
		model.addAttribute("rtnFrevNext", contentMgrService.getBoardFrevNext(link));
			
		Title title = new Title();
		title.setMenuId(contentSet.getMenuId());
		title.setInParam(request);
		title.setTitleId(Integer.parseInt(item.get("TITLEID").toString()));
		
		// 조회수 증가
		contentMgrService.updateBoardHitCount(link);
		
		//실행결과 로기 생성
		//this.resultLog(rtnVodBoard);

		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				  "&rowCnt=" + link.getRowCnt() +
				  "&menuId=" + link.getMenuId() + 
				  "&boardKind=VOD" + 
				  "&schType="+link.getSchType() + 
				  "&schText="+StringUtil.nullCheck(link.getSchText()) +
				  "&boardStyle="+StringUtil.nullCheck(link.getBoardStyle()) +
				  "&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/vod/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actVodBoard 동영상형 게시판 입력/수정/삭제
	 * @param boardkind
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actVodBoard", method=RequestMethod.POST)
	public ModelAndView actVodBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("동영상형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		// After data 변수
		String contentData = null;
		String fileData = null;
		String guestData = null;
		
		// DML data 변수
		String contentDml = null;
		String fileDml = null;
		String guestDml = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "fileImg_upload", "fileImgId", content.getMenuId(), "board", "single"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
				content.setImageFileName(uploadFiles.getUserFileName());
				content.setImageSFileName(uploadFiles.getSystemFileName());
				content.setFilePath(uploadFiles.getFilePath());
				
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
				
			}else{ // namoFiles
				// 첨부파일 JSON정보
				JSONParser jsonParser = new JSONParser();
				Object jsonObj = null;
		 		JSONArray jsonArray = null;
				JSONObject jsonObject = null;
				// 첨부파일 JSON정보
				
				// 나모 이미지 컴포넌트
				// 이미지 첨부가 없을경우
				if(!StringUtil.isNotBlank(request.getParameter("modifiedFilesInfoImages"))) {
					if(StringUtil.isNotBlank(content.getImageFileName())){
						NamoCrossFile.fileDeleteAttempt(content.getFilePath(), content.getImageSFileName());
						content.setImageFileName(null);
						content.setImageSFileName(null);
						content.setFilePath(null);
					}
				}else{
					String modifiedFilesInfo = request.getParameter("modifiedFilesInfoImages"); 
					jsonObj = jsonParser.parse(modifiedFilesInfo); 
					jsonArray = (JSONArray)jsonObj; 
					if(jsonArray.size() > 0){
						jsonObject = (JSONObject)jsonArray.get(0); 
						String[] strData = StringUtil.strToArr((String)jsonObject.get("fileId"), "@@");
						if(!Boolean.parseBoolean((String) jsonObject.get("isDeleted"))){
							content.setImageFileName((String)jsonObject.get("fileName"));
							content.setImageSFileName(strData[2]);
							content.setFilePath(strData[3]);
						}else{
							NamoCrossFile.fileDeleteAttempt(strData[3], strData[2]);
							if("jpg;jpeg;png;gif;bmp".indexOf(strData[2].toString().toLowerCase().substring(strData[2].toString().lastIndexOf(".")+1)) > -1){
								NamoCrossFile.fileDeleteAttempt(strData[3]+"thumbnails"+File.separator, strData[2]);
							}
						}
					}
				}
				
				// 이미지 파일 등록
				if(StringUtil.isNotBlank(request.getParameter("uploadedFilesInfoImages"))) {
					String uploadedFilesInfoImages = request.getParameter("uploadedFilesInfoImages");
					jsonObj = jsonParser.parse(uploadedFilesInfoImages); 
					jsonArray = (JSONArray)jsonObj; 
					if(jsonArray.size() > 0){
						if(StringUtil.isNotBlank(content.getImageFileName())){
							NamoCrossFile.fileDeleteAttempt(content.getFilePath(), content.getImageSFileName());
						}
						jsonObject = (JSONObject)jsonArray.get(0);
						
						content.setImageFileName((String)jsonObject.get("origfileName"));
						content.setImageSFileName((String)jsonObject.get("fileName"));
						content.setFilePath((String)jsonObject.get("lastSavedDirectoryPath"));
					}
				}
				
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//parameter 설정
			contentData = content.makeVodDataString();
			guestData = guestInfo.makeFreeDataString();
			fileData = uploadFiles.makeFreeDataString();					
			
			contentDml = content.makeVodDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();		
					
			content.setInAfterData(contentData + guestData + fileData);			
			content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
			objRtn = (Content) contentMgrService.actVodBoard(content);	
			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				contentDml = content.makeVodDMLDataString();
				fileDml = files.makeFreeDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();				
				
				content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
				objRtn = (Content) contentMgrService.actVodBoard(content);
			}
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//링크 정보
		String strLink = "";
		strLink = request.getParameter("link");
				
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
				
		if(content.getInCondition().equals("수정")){
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr/view?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		
		return new ModelAndView(rv);
	}		
	
	/******************************************************************
	 * listAppealBoard 민원형게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=APPEAL")
	public ModelAndView listAppealBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 민원게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		//페이징 정보
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=APPEAL" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);

		title.setJsp("site/contentMgr/appeal/list");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/******************************************************************************
	 * viewAppealBoard 민원형게시판 상세
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************************/
	@RequestMapping(value="/view", params="boardKind=APPEAL")
	public ModelAndView viewAppealBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {

		logger.info("민원형게시판 상세");
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 민원게시판 상세조회
		//Link rtnAppealBoard = (Link)contentMgrService.getAppealBoard(link);
		
		HashMap item = (HashMap) contentMgrService.getBoardView(link);
		
		model.addAttribute("rtnContent", item);
		model.addAttribute("rtnComment", contentMgrService.getBoardViewAnswer(link));
		model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
		
		link.setParentLinkId(item.get("PARENTLINKID").toString());
		link.setReplyNo(item.get("REPLYNO").toString());
		model.addAttribute("rtnFrevNext", contentMgrService.getBoardFrevNext(link));

		// 조회수 증가
		contentMgrService.updateBoardHitCount(link);
				
		//실행결과 로기 생성
		//this.resultLog(rtnAppealBoard);
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=APPEAL" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/appeal/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/**********************************************************************************
	 * formAppealBoard 민원형게시판 폼
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=APPEAL")
	public ModelAndView formAppealBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		String path = "Question";
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			// 민원게시판 상세조회
			/*Link rtnAppealBoard = (Link)contentMgrService.getAppealBoard(link);
			
			HashMap<String, String> rtnContent = new HashMap<String, String>();
			rtnContent = (HashMap<String, String>)rtnAppealBoard.getOutCursor();*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnComment", contentMgrService.getBoardViewAnswer(link));
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
			
			//질문자인지 확인 
			if(link.getMyId().equals(rtnBoard.get("USERID"))){
				logger.info("민원형게시판 질문 폼");
				path = "Question"+link.getFileFormType();
			}else {
				logger.info("민원형게시판 답변 폼");
				path = "Answer";
			}
			
			//실행결과 로기 생성
			//this.resultLog(rtnAppealBoard);
		
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
			// 민원게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getAppealBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
			
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=APPEAL" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/appeal/form"+path);
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*****************************************************************
	 * actAppealBoard 민원형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actAppealBoard", method=RequestMethod.POST)
	public ModelAndView actAppealBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		//Menuid|BoardID|LinkID|Kname|OpenYN|secretTitleYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|AppealUserID|GuestName|Key1|Key2|Key3|Dkey|FileCount|UserFileName|SystemFileName|FilePath|FileExtension|FileSize
		content.setInWorkName("민원형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		//dml data 변수
		String contentDml = null;
		String guestDml = null;
		String fileDml = null;
		
		//after data  변수
		String contentData = null;
		String guestData = null;
		String fileData = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
			}else{ // namoFiles
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//dmlData 설정
			contentDml = content.makeAppealDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();
			
			//afterData 설정
			contentData = content.makeAppearlDataString();
			guestData = guestInfo.makeFreeDataString(); 
			fileData = uploadFiles.makeFreeDataString();

			logger.info(contentDml+"|"+guestDml+"|"+fileDml);
			content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
			content.setInAfterData(contentData+guestData+fileData);
			
			objRtn = (Content) contentMgrService.actAppealBoard(content);
			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				Files uploadFiles = (Files)namoCrossFile.fileUploadAttempt(files, request);
				
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				//dmlData  설정
				contentDml = content.makeAppealDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				fileDml = uploadFiles.makeFreeDMLDataString();
				
				//afterData 설정
				contentData = content.makeAppearlDataString();
				guestData = guestInfo.makeFreeDataString(); 
				fileData = uploadFiles.makeFreeDataString();
				
				logger.info(contentDml+"|"+guestDml+"|"+fileDml);
				content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
				content.setInAfterData(contentData+guestData+fileData);
				
				objRtn = (Content) contentMgrService.actAppealBoard(content);
			}
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//링크 정보
		String strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		if(content.getInCondition().equals("입력")) {
			String parent = request.getParameter("parentId");
			if(parent != null && parent != "" && Integer.parseInt(parent) > 0){
				//답글 일때
				rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
			}else{
				//답글이 아닐때
				strLink = "pageNum=1"+strLink.substring(strLink.indexOf("&"), strLink.length());
				rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
			}
		}else if(content.getInCondition().equals("수정")) {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		return new ModelAndView(rv);
	}
	
	/******************************************************************
	 * listReplyBoard My관리자답변형게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=REPLY")
	public ModelAndView listReplyBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		// 관리자답변형 게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=REPLY" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		title.setJsp("site/contentMgr/reply/list");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/******************************************************************************
	 * viewReplyBoard 관리자답변형게시판 상세
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************************/
	@RequestMapping(value="/view", params="boardKind=REPLY")
	public ModelAndView viewReplyBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 민원게시판 상세조회
		Link rtnReplyBoard = (Link)contentMgrService.getReplyBoard(link);
		
		model.addAttribute("rtnContent", rtnReplyBoard.getOutCursor());
		model.addAttribute("rtnComment", rtnReplyBoard.getOutCursor1());
		model.addAttribute("rtnFileList", rtnReplyBoard.getOutCursor2());
		model.addAttribute("rtnFrevNext", rtnReplyBoard.getOutCursor3());
		
		//실행결과 로기 생성
		this.resultLog(rtnReplyBoard);
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=REPLY" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/reply/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/**********************************************************************************
	 * formReplyBoard 관리자답변형게시판 폼
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=REPLY")
	public ModelAndView formReplyBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);
		
		String path = "Question";
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			// 관리자답변형게시판 상세조회
			/*Link rtnReplyBoard = (Link)contentMgrService.getReplyBoard(link);
			
			HashMap<String, String> rtnContent = new HashMap<String, String>();
			rtnContent = (HashMap<String, String>)rtnReplyBoard.getOutCursor();*/
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnComment", contentMgrService.getBoardViewAnswer(link));
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
			
			//질문자인지 확인 
			if(link.getMyId().equals(rtnBoard.get("USERID"))){
				logger.info("관리자답변형게시판 질문 폼");
				path = "Question"+link.getFileFormType();
			}else {
				logger.info("관리자답변형게시판 답변 폼");
				path = "Answer";
			}
			
			//실행결과 로기 생성
			//this.resultLog(rtnReplyBoard);
			
			// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
			// 민원게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getReplyBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=REPLY" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/reply/form"+path);
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*****************************************************************
	 * actMyReplyBoard 관리자 답변형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actReplyBoard", method=RequestMethod.POST)
	public ModelAndView actReplyBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		//Menuid|BoardID|LinkID|Kname|OpenYN|SecretTitleYN|NoticeTitleYN|Keyword1|Keyword2|Keyword3|Contents1|Contents2|Contents3|CategoryID|StartTime|EndTime|AppealUserID|GuestName|Key1|Key2|Key3|Dkey|FileCount|UserFileName|SystemFileName|FilePath|FileExtension|FileSize
		content.setInWorkName("관리자답변형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		content.setAppealUserId(content.getDmlUserId());
		
		//dml data 변수
		String contentDml = null;
		String guestDml = null;
		String fileDml = null;
		
		//after data  변수
		String contentData = null;
		String guestData = null;
		String fileData = null;
		
		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
			}else{ // namoFiles
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//dmlData 설정
			contentDml = content.makeReplyDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();
			
			//afterData 설정
			contentData = content.makeReplyDataString();
			guestData = guestInfo.makeFreeDataString(); 
			fileData = uploadFiles.makeFreeDataString();
			
			logger.info(contentDml+"|"+guestDml+"|"+fileDml);
			content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
			content.setInAfterData(contentData+guestData+fileData);
			
			objRtn = (Content) contentMgrService.actReplyBoard(content);
			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				Files uploadFiles = (Files)namoCrossFile.fileUploadAttempt(files, request);
				
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				//dmlData  설정
				contentDml = content.makeReplyDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				fileDml = uploadFiles.makeFreeDMLDataString();
				
				//afterData 설정
				contentData = content.makeReplyDataString();
				guestData = guestInfo.makeFreeDataString(); 
				fileData = uploadFiles.makeFreeDataString();
				
				logger.info(contentDml+"|"+guestDml+"|"+fileDml);
				content.setInDMLData(contentDml+"|"+guestDml+"|"+fileDml);
				content.setInAfterData(contentData+guestData+fileData);
				
				objRtn = (Content) contentMgrService.actReplyBoard(content);
			}
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
				
		//링크 정보
		String strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		if(content.getInCondition().equals("입력")) {
			String parent = request.getParameter("parentId");
			if(parent != null && parent != "" && Integer.parseInt(parent) > 0){
				//답글 일때
				rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
			}else{
				//답글이 아닐때
				strLink = "pageNum=1"+strLink.substring(strLink.indexOf("&"), strLink.length());
				rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
			}
		}else if(content.getInCondition().equals("수정")) {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		return new ModelAndView(rv);
	}

	@RequestMapping(value="/selectBbsTransMenuPopup")
    public ModelAndView selectBbsTransMenuPopup(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		
		// 파라메타 세팅
		content.setSiteId(request.getParameter("siteId"));

		if(!StringUtil.isNotBlank(content.getSiteId())) content.setSiteId(getSiteId());
		
		// 콘텐츠설정 조회
		Content objRtn = (Content) contentMgrService.getObjectList(content);
		
		//실행결과 로기 생성
		this.resultLog(content);
		
		// View 설정
		model.addAttribute("result", objRtn.getOutCursor());
		model.addAttribute("resultSite", commonService.getSiteName(content));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(content.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", content.getParamMenuId());
		model.addAttribute("pSiteId", content.getSiteId());
		
		content.setJsp("site/contentMgr/selectBbsTransMenuPopup");
		content.setViewTitle("선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", content);
 
    }
	
	@RequestMapping(value="/chkTransYn")
    public @ResponseBody HashMap chkTransYn(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
    	
		content.setInWorkName("정적콘텐츠공유관리");

		content.setInParam(request);
		
		HashMap<String, String> rtnMsg = new HashMap<String, String>();
		
		rtnMsg = (HashMap<String, String>) contentMgrService.chkTransYn(content);
		
		//Content objRtn = (Content)contentMgrService.actListContentLink(content);
    	
    	return rtnMsg;
    }
	
	@RequestMapping(value="/actBbsTrans")
	public @ResponseBody String actBbsTrans(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		
		content.setInWorkName("정적콘텐츠공유관리");
		
		content.setInParam(request);
		
		String rtnMsg = "FAILURE";
		
		try {
			contentMgrService.actBbsTrans(content);
			rtnMsg = "SUCCESS";
		} catch (Exception e) {
			rtnMsg = "FAILURE";
			logger.info("오류발생");
		}
		
		//Content objRtn = (Content)contentMgrService.actListContentLink(content);
		
		return rtnMsg;
	}
	
	@RequestMapping(value="/transCnt")
	public @ResponseBody int transCnt(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		content.setInParam(request);
		
		return contentMgrService.getTransCnt(content);
	}
	
	@RequestMapping(value="/selectBbsShareMenuPopup")
    public ModelAndView selectBbsShareMenuPopup(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		
		// 파라메타 세팅
		content.setSiteId(request.getParameter("siteId"));

		if(!StringUtil.isNotBlank(content.getSiteId())) content.setSiteId(getSiteId());
		
		// 콘텐츠설정 조회
		Content objRtn = (Content) contentMgrService.getObjectList(content);
		
		//실행결과 로기 생성
		this.resultLog(content);
		
		// View 설정
		model.addAttribute("result", objRtn.getOutCursor());
		model.addAttribute("resultSite", commonService.getSiteName(content));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(content.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", content.getParamMenuId());
		model.addAttribute("pSiteId", content.getSiteId());
		
		content.setJsp("site/contentMgr/selectBbsShareMenuPopup");
		content.setViewTitle("선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", content);
		
    }
	
	@RequestMapping(value="/actListBoardLink")
    public @ResponseBody Content actListBoardLink(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
    	
		content.setInParam(request);

		content.setInWorkName("게시판공유관리");
		content.setInCondition("입력");
		//content.setInCondition(request.getParameter("condition"));
		
		Content objRtn = null;
				
		//다중 삭제위한 처리
		String[] arrBbsShare = null;
		arrBbsShare = request.getParameterValues("bbsShare");
		
		if(arrBbsShare.length <= 1){
			// 현재MenuID|이관MenuID|LinkID|TitleID
			content.setInDMLData(arrBbsShare[0].split("§§")[0] + "|" + request.getParameter("copyMenuId") + "|" + arrBbsShare[0].split("§§")[1] + "|" + arrBbsShare[0].split("§§")[2]);		
			
			objRtn = (Content)contentMgrService.actListBoardLink(content);
			
		} else {
			for(int i=(arrBbsShare.length-1); i<arrBbsShare.length; i--){
				// 현재MenuID|이관MenuID|LinkID|TitleID
				content.setInDMLData(arrBbsShare[i].split("§§")[0] + "|" + request.getParameter("copyMenuId") + "|" + arrBbsShare[i].split("§§")[1] + "|" + arrBbsShare[i].split("§§")[2]);		
				
				objRtn = (Content)contentMgrService.actListBoardLink(content);
				
			}
		}
    	
    	return objRtn;
    }
	
	/**
	 * selectKeywordSearchPopup 키워드 리스트
	 * @param content
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/selectKeywordSearchPopup")
    public ModelAndView selectKeywordSearchPopup(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		content.setInParam(request);
				
		// 콘텐츠설정 조회
		List<?> list = contentMgrService.selectKeywordSearchList(content);
		
		//실행결과 로기 생성
		this.resultLog(content);
		
		// View 설정
		model.addAttribute("result", list);
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(content.getMenuId());
		
		model.addAttribute("link", strLink);
		content.setJsp("site/contentMgr/selectKeywordSearchPopup");
		content.setViewTitle("키워드검색");
		return new ModelAndView("ips.layoutPopup", "obj", content);
 
    }
	
	/***********************************************************************
	 * listCardBoard 카드형 게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(params="boardKind=CARD")
	public ModelAndView listCardBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", setItem);
		
		
		// 기본 boardStyle 지정
		if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
			title.setBoardStyle("Gallery");
		}
		
		//int viewLength = 0;
		// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9] 
		if(title.getBoardStyle().equals("Text")){
			//title.setRowCnt(setItem.getRowCnt());
		}else if(title.getBoardStyle().equals("Image")){
			//viewLength = 50;
			//title.setRowCnt(10);
		}else if(title.getBoardStyle().equals("Gallery")){
			//viewLength = 100;
			title.setRowCnt(9);
		}
		
		// 썸네일게시판 조회
		title.setRowCnt(setItem.getPageCount());
		contentSet.setRowCnt(setItem.getPageCount());
		List<?> boardList = contentMgrService.getBoardList(title);
		int boardListCnt = contentMgrService.getBoardListCnt(title);
		
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId() + 
				"&boardKind=CARD" + 
				"&schType="+title.getSchType() + 
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(title.getBoardStyle())+
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());
		
		model.addAttribute("link", strLink);

		title.setJsp("site/contentMgr/card/list"+title.getBoardStyle());
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	/*********************************************************************
	 * viewCardBoard 카드형게시판 상세
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *********************************************************************/
	@RequestMapping(value="/view", params="boardKind=CARD")
	public ModelAndView viewCardBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 썸네일게시판 상세조회
		Link rtnCardBoard = (Link)contentMgrService.getCardBoard(link);
		model.addAttribute("rtnContent", rtnCardBoard.getOutCursor());
		model.addAttribute("rtnFileList", rtnCardBoard.getOutCursor1());
		model.addAttribute("rtnFrevNext", rtnCardBoard.getOutCursor2());
				
		HashMap hm = (HashMap) rtnCardBoard.getOutCursor();
		
		Title title = new Title();
		title.setMenuId(contentSet.getMenuId());
		title.setInParam(request);
		title.setTitleId(Integer.parseInt(hm.get("TITLEID").toString()));
		
		//실행결과 로기 생성
		this.resultLog(rtnCardBoard);
		
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=CARD" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(link.getBoardStyle()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/card/view");
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/*****************************************************************
	 * formCardBoard 카드형게시판 폼
	 * @param contentSet
	 * @param link
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form", params="boardKind=CARD")
	public ModelAndView formCardBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		
		link.setMyName("전체관리자");
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		link.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));
		
		//실행결과 로기 생성
		//this.resultLog(objRtn);
		
		// 수정데이터 조회
		if(StringUtil.nullCheck(link.getLinkId()) != "" && link.getLinkId() > 0){
			// 썸네일게시판 상세조회
			//Link rtnCard = (Link)contentMgrService.getCardBoard(link);
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);
			
			// 변경전 데이타 저장(inBeforeData)	
			Content content = new Content();
			rtnBoard.put("INBEFOREDATA", content.makeDataStringHashMap(rtnBoard));
			
			model.addAttribute("rtnContent", rtnBoard);
			model.addAttribute("rtnFileList", contentMgrService.getBoardFiles(link));
						
			//실행결과 로기 생성
			//this.resultLog(rtnCard);
		
		// 답글 타이틀 조회	
		} else if(StringUtil.nullCheck(link.getParentLinkId()) != ""){
			// 썸네일게시판 상세조회
			link.setLinkId(Integer.parseInt(link.getParentLinkId()));
			/*Link rtnParent = (Link)contentMgrService.getCardBoard(link);
			HashMap<String, String> parentData = (HashMap<String, String>)rtnParent.getOutCursor();
			
			model.addAttribute("title", "re :"+parentData.get("KNAME"));*/
			
			HashMap rtnBoard = (HashMap) contentMgrService.getBoardView(link);

			model.addAttribute("title", "re :"+rtnBoard.get("KNAME"));
		}
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + link.getPageNum() +
				"&rowCnt=" + link.getRowCnt() +
				"&menuId=" + link.getMenuId() + 
				"&boardKind=CARD" + 
				"&schType="+link.getSchType() + 
				"&schText="+StringUtil.nullCheck(link.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(link.getBoardStyle()) +
				"&categoryId="+StringUtil.nullCheck(link.getCategoryId());
		
		model.addAttribute("link", strLink);
		
		link.setJsp("site/contentMgr/card/form"+link.getFileFormType());
		return new ModelAndView("ips.content.layout", "obj", link);
	}
	
	/****************************************************************
	 * actCardBoard 카드형 게시판 입력/수정/삭제
	 * @param content
	 * @param files
	 * @param guestInfo
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ****************************************************************/
	@RequestMapping(value="/actCardBoard", method=RequestMethod.POST)
	public ModelAndView actCardBoard(@ModelAttribute Content content, @ModelAttribute Files files, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		logger.info("카드형 게시판 입력/수정/삭제");
		
		//기본 셋팅
		content.setInParam(request);
		files.setInParam(request);
		guestInfo.setInParam(request);
		
		content.setInWorkName("카드형게시판관리");
		content.setInCLOBData1(content.getKHtml());
		
		//dml data 변수
		String contentDml = null;
		String guestDml = null;
		String fileDml = null;
		
		//after data  변수
		String contentData = null;
		String guestData = null;
		String fileData = null;

		//다중 삭제위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");
		
		String altInfo = request.getParameter("altInfoArr");
		String altInfoFirst = request.getParameter("altInfoFirst");
		
		Content objRtn = new Content();
		
		if(arrLinkId.length <= 1){
			Files uploadFiles = new Files();
			
			if(content.getFileFormType().equals("_inputFiles")){ // inputFile
				// multipartFileUpload
				uploadFiles = (Files) fileUtil.uploadFormfiles(request, response, "file_upload", "fileId", content.getMenuId(), "board", "multi"); // (request, response, 신규Input파일명, 수정Input파일명, 저장폴더명) 
			}else{ // namoFiles
				uploadFiles = (Files)namoCrossFile.fileUploadAttempt(content, request);
			}
			
			//content Image 파일 정보 설정
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
				content.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
				content.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
				content.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
			}
			
			//parameter 설정
			contentData = content.makeCardDataString();
			guestData = guestInfo.makeFreeDataString(); 
			fileData = uploadFiles.makeFreeDataString();
			
			contentDml = content.makeCardDMLDataString();
			guestDml = guestInfo.makeFreeDMLDataString();
			fileDml = uploadFiles.makeFreeDMLDataString();
			
			content.setInAfterData(contentData + guestData + fileData);
			content.setInDMLData(contentDml+"|"+altInfoFirst+"|"+guestDml+"|"+fileDml+"|"+altInfo);
			
			objRtn = (Content) contentMgrService.actThumbnailBoard(content);
		} else {
			
			Files uploadFiles = (Files)namoCrossFile.fileUploadAttempt(files, request);
			
			//content Image 파일 정보 설정
			if(uploadFiles.getFileList() != null && uploadFiles.getFileList().size() > 0){
			content.setImageFileName(uploadFiles.getFileList().get(0).getUserFileName());
			content.setImageSFileName(uploadFiles.getFileList().get(0).getSystemFileName());
			content.setFilePath(uploadFiles.getFileList().get(0).getFilePath());
			}
			
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i]);
				
				contentDml = content.makeCardDMLDataString();
				guestDml = guestInfo.makeFreeDMLDataString();
				fileDml = files.makeFreeDMLDataString();
				
				content.setInDMLData(contentDml+"|"+altInfoFirst+"|"+guestDml+"|"+fileDml+"|"+altInfo);
				objRtn = (Content) contentMgrService.actThumbnailBoard(content);
			}
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
				
		//링크 정보
		String strLink = "";
		strLink = request.getParameter("link");
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		if(content.getInCondition().equals("수정")){
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr/view?").concat(strLink).concat("&linkId=").concat(content.getLinkId()));
		}else {
			rv.setUrl(request.getContextPath().concat("/mgr/contentMgr?").concat(strLink));
		}
		
		logger.info(rv.getUrl());
		
		return new ModelAndView(rv);
	}
	
}
