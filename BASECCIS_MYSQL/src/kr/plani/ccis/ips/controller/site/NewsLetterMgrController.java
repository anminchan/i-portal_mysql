package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

//import kr.plani.ccis.base.domain.Email;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.ExcelDownload;
import kr.plani.ccis.common.util.NamoCrossFile;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.NewsLetter;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentMgrService;
import kr.plani.ccis.ips.service.site.NewsLetterMgrService;

@Controller
@RequestMapping("/mgr/newsLetterMgr")
public class NewsLetterMgrController extends BaseController
{
	private static final Logger logger = LoggerFactory.getLogger(NewsLetterMgrController.class);

	/**
	 * 콘텐츠관리 서비스
	 */
	@Resource
	private ContentMgrService contentMgrService;

	@Resource
	BaseService baseService;

	@Resource
	CommonService commonService;

	@Resource
	NewsLetterMgrService newsLetterMgrService;

	/*첨부파일관련*/
	@Resource
	private NamoCrossFile namoCrossFile;

	/*****************************************************
	 * list - 뉴스레터 조회
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView list(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		//기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		List<?> list = null;
		SCookie sc = (SCookie) request.getSession().getAttribute("ADMUSER");

		if (sc.getTotalAuth().equals("Y"))
		{
			list = newsLetterMgrService.getNewsLetterList(newsLetter);

			model.addAttribute("result", list);

			//페이징 정보
			model.addAttribute("rowCnt", newsLetter.getRowCnt());    //페이지 목록수
			model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map) list.get(0)).get("TOTAL_CNT"))));    //전체 카운트
		}
		else
		{
			if (StringUtil.isNotBlank(newsLetter.getSiteId()))
			{
				list = newsLetterMgrService.getNewsLetterList(newsLetter);

				model.addAttribute("result", list);

				//페이징 정보
				model.addAttribute("rowCnt", newsLetter.getRowCnt());    //페이지 목록수
				model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map) list.get(0)).get("TOTAL_CNT"))));    //전체 카운트
			}
		}

		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
				"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
				"&schStartDate=" + StringUtil.nullCheck(newsLetter.getSchStartDate()) +
				"&schEndDate=" + StringUtil.nullCheck(newsLetter.getSchEndDate()) +
				"&pageNum=" + StringUtil.nullCheck(newsLetter.getPageNum()) +
				"&schText=" + URLEncoder.encode(StringUtil.nullCheck(newsLetter.getSchText()), "UTF-8");

		model.addAttribute("link", strLink);

		newsLetter.setJsp("site/newsLetterMgr/list");
		return new ModelAndView("ips.layout", "obj", newsLetter);
	}

	/*****************************************************
	 * form - 뉴스레터 등록/수정
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.GET, value = "/form")
	public ModelAndView form(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		//기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		// 뉴스레터 정보 로드
		Map<String, String> result = (Map<String, String>) newsLetterMgrService.getNewsLetter(newsLetter);

		model.addAttribute("result", result);

		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
				"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
				"&pageNum=" + StringUtil.nullCheck(newsLetter.getPageNum()) +
				"&schStartDate=" + StringUtil.nullCheck(newsLetter.getSchStartDate()) +
				"&schEndDate=" + StringUtil.nullCheck(newsLetter.getSchEndDate()) +
				"&schText=" + URLEncoder.encode(StringUtil.nullCheck(newsLetter.getSchText()), "UTF-8");

		model.addAttribute("link", strLink);

		newsLetter.setJsp("site/newsLetterMgr/form");
		return new ModelAndView("ips.layout", "obj", newsLetter);
	}

	/*****************************************************
	 * updateNewLetter - 뉴스레터 정보 저장
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.POST, value = "/updateNewLetter")
	public ModelAndView updateNewLetter(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		// 기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		// 업로드할 파일 정보 처리
		// 기존 파일 삭제를 위한 조건
//		if (StringUtil.isNotBlank(request.getParameter("upImageUFileName")))
//		{
//			// 기존 파일을 확인 후, 삭제
//			if (StringUtil.isNotBlank(newsLetter.getUpImageSFileName()))
//			{
//				// 기존파일이 있는경우
//				namoCrossFile.fileDeleteAttempt(newsLetter.getUpImageFilePath(), newsLetter.getUpImageSFileName());
//			}
//
//			// 업로드 파일 받기
//			Files uploadFiles = (Files) namoCrossFile.fileUploadAttempt("ALL",request);        //ALL경우 전체 파일업로드, 첨부파일 컨포넌트를 여러개 썼을경우 하나씩 뽑을경우 컨포넌트 이름 입력
//
//			// 저장할 파일세팅
//			newsLetter.setUpImageFileName(uploadFiles.getUserFileName());
//			newsLetter.setUpImageSFileName(uploadFiles.getSystemFileName());
//			newsLetter.setUpImageFilePath(uploadFiles.getFilePath());
//		}


		if (newsLetter.getNewsLetterId() != null && !newsLetter.getNewsLetterId().equals(""))
		{
			newsLetterMgrService.updateNewsLetter(newsLetter);
		}
		else
		{
			newsLetterMgrService.insertNewsLetter(newsLetter);
		}

		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
				"&newsLetterId=" + StringUtil.nullCheck(newsLetter.getNewsLetterId()) +
				"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
				"&saveStatus=" + StringUtil.nullCheck(newsLetter.getSaveStatus()) +
				"&pageNum=" + StringUtil.nullCheck(newsLetter.getPageNum()) +
				"&schStartDate=" + StringUtil.nullCheck(newsLetter.getSchStartDate()) +
				"&schEndDate=" + StringUtil.nullCheck(newsLetter.getSchEndDate()) +
				"&version=" + StringUtil.nullCheck(newsLetter.getVersion()) +
				"&schText=" + URLEncoder.encode(StringUtil.nullCheck(newsLetter.getSchText()), "UTF-8");

		model.addAttribute("link", strLink);

		// View 설정
		String redirectView = "/mgr/newsLetterMgr/formPortlet?";

		if ("save".equals(newsLetter.getSaveStatus()) || "preView".equals(newsLetter.getSaveStatus()))
		{
			redirectView = "/mgr/newsLetterMgr/form?";
		}
		else if ("createNewsLetter".equals(newsLetter.getSaveStatus()))
		{
			redirectView = "/mgr/newsLetterMgr/formPortlet?";
		}

		RedirectView rv = new RedirectView(request.getContextPath().concat(redirectView + strLink));
		return new ModelAndView(rv);
	}

	/*****************************************************
	 * formPotlet - 뉴스레터 포틀릿 등록/수정
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.GET, value = "/formPortlet")
	public ModelAndView formPotlet(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		// 기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		// 저장된 뉴스레터 정보를 로드
		model.addAttribute("newsletter", newsLetterMgrService.getNewsLetter(newsLetter));

		// 저장되어 있는 포틀릿 정보 로드
		model.addAttribute("portletLineList", newsLetterMgrService.getNewsLetterPortletLineList(newsLetter));
		model.addAttribute("portletList", newsLetterMgrService.getNewsLetterPortletList(newsLetter));

		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
				"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
				"&pageNum=" + StringUtil.nullCheck(newsLetter.getPageNum()) +
				"&schStartDate=" + StringUtil.nullCheck(newsLetter.getSchStartDate()) +
				"&schEndDate=" + StringUtil.nullCheck(newsLetter.getSchEndDate()) +
				"&schText=" + URLEncoder.encode(StringUtil.nullCheck(newsLetter.getSchText()), "UTF-8");

		model.addAttribute("link", strLink);

		newsLetter.setJsp("site/newsLetterMgr/formPortlet");
		return new ModelAndView("ips.layout", "obj", newsLetter);
	}

	/*****************************************************
	 * updateNewsLetterPortlet - 뉴스레터 정보 저장
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.POST, value = "/updateNewsLetterPortlet")
	public ModelAndView updateNewsLetterPortlet(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);
		newsLetter.setInRowsPerPage(10);

		// 기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		// 포틀릿 정보 업데이트
		newsLetterMgrService.updateNewsLetterPoretlet(newsLetter, request);

		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
				"&newsLetterId=" + StringUtil.nullCheck(newsLetter.getNewsLetterId()) +
				"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
				"&saveStatus=" + StringUtil.nullCheck(newsLetter.getSaveStatus()) +
				"&pageNum=" + StringUtil.nullCheck(newsLetter.getPageNum()) +
				"&schStartDate=" + StringUtil.nullCheck(newsLetter.getSchStartDate()) +
				"&schEndDate=" + StringUtil.nullCheck(newsLetter.getSchEndDate()) +
				"&version=" + StringUtil.nullCheck(newsLetter.getVersion()) +
				"&schText=" + URLEncoder.encode(StringUtil.nullCheck(newsLetter.getSchText()), "UTF-8");

		model.addAttribute("link", strLink);

		// View 설정
		String redirectView = "/mgr/newsLetterMgr/form?";

		if ("save".equals(newsLetter.getSaveStatus()) || "preView".equals(newsLetter.getSaveStatus()))
		{
			redirectView = "/mgr/newsLetterMgr/formPortlet?";
		}
		else if ("prev".equals(newsLetter.getSaveStatus()))
		{
			redirectView = "/mgr/newsLetterMgr/form?";
		}

		RedirectView rv = new RedirectView(request.getContextPath().concat(redirectView + strLink));
		return new ModelAndView(rv);
	}

	/*****************************************************************
	 * listContent 콘텐츠 조회
	 * @param defaultDomain
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value = "/htmlEditorTypePopup")
	public ModelAndView htmlEditorTypePopup(@ModelAttribute DefaultDomain defaultDomain, @RequestParam String htmlId, HttpServletRequest request, Model model) throws Exception
	{
		model.addAttribute("htmlId", htmlId);

		defaultDomain.setJsp("site/newsLetterMgr/htmlEditorTypePopup");

		return new ModelAndView("ips.layoutPopup02", "obj", defaultDomain);
	}

	/*****************************************************
	 * selectMailResult 메일결과
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.GET, value = "/mailResult")
	public ModelAndView mailResult(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{

		newsLetter.setInParam(request);

		//기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		List<?> list = newsLetterMgrService.selectMailResult(newsLetter);

		model.addAttribute("result", list);

		//페이징 정보
		model.addAttribute("rowCnt", newsLetter.getRowCnt());    //페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map) list.get(0)).get("TOTAL_CNT"))));    //전체 카운트

		//링크설정
		String strLink = null;
		strLink =	"&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
					"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
					"&appEmail=" + StringUtil.nullCheck(newsLetter.getAppEmail()) +
					"&sendFlag=" + StringUtil.nullCheck(newsLetter.getSendFlag()) +
					"&newsLetterId=" + StringUtil.nullCheck(newsLetter.getNewsLetterId());

		model.addAttribute("link", strLink);

		newsLetter.setJsp("site/newsLetterMgr/resultMail");
		newsLetter.setViewTitle("이메일 발송 내역");
		return new ModelAndView("ips.layoutPopup", "obj", newsLetter);
	}

	@RequestMapping(value = "/mailResultExcelDown")
	public void mailResultExcelDown(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception
	{
		newsLetter.setInParam(request);

		newsLetter.setRowCnt(1000);
		newsLetter.setExcelDownYn("Y");
		newsLetter.setPageNum(0);

		List list = newsLetterMgrService.selectMailResult(newsLetter);

		model.addAttribute("result", list);

		//실행결과 로기 생성
		this.resultLog(newsLetter);

		String[] headerName = {"이메일", "성공여부", "실패이유"};
		String[] columnName = {"EMAIL", "SEND_FLAG_NM", "SEND_RSLT_CD_NM"};
		String sheetName = "뉴스레터 발송결과";

		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}

	/*****************************************************
	 * mailAppList 메일 신청 현황
	 * @param newsLetter
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method = RequestMethod.GET, value = "/mailAppList")
	public ModelAndView mailAppList(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		newsLetter.setInParam(request);

		//기본셋팅
		this.setCommon(commonService, request, model, newsLetter);

		List<?> list = newsLetterMgrService.selectNewsLetterApp(newsLetter);

		model.addAttribute("result", list);

		//페이징 정보
		model.addAttribute("rowCnt", newsLetter.getRowCnt());    //페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map) list.get(0)).get("TOTAL_CNT"))));    //전체 카운트

		//링크설정
		String strLink = null;
		strLink =	"&menuId=" + StringUtil.nullCheck(newsLetter.getMenuId()) +
					"&siteId=" + StringUtil.nullCheck(newsLetter.getSiteId()) +
					"&schStartDate=" + StringUtil.nullCheck(newsLetter.getSchStartDate()) +
					"&schEndDate=" + StringUtil.nullCheck(newsLetter.getSchEndDate()) +
					"&rcvYn=" + StringUtil.nullCheck(newsLetter.getRcvYn()) +
					"&appEmail=" + StringUtil.nullCheck(newsLetter.getAppEmail()) +
					"&newsLetterId=" + StringUtil.nullCheck(newsLetter.getNewsLetterId());

		model.addAttribute("link", strLink);

		newsLetter.setJsp("site/newsLetterMgr/appList");
		newsLetter.setViewTitle("뉴스레터 신청 현황");
		return new ModelAndView("ips.layoutPopup", "obj", newsLetter);
	}

	@RequestMapping(value = "/mailAppListExcelDown")
	public void mailAppListExcelDown(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception
	{

		newsLetter.setInParam(request);

		newsLetter.setRowCnt(1000);
		newsLetter.setExcelDownYn("Y");
		newsLetter.setPageNum(0);

		List list = newsLetterMgrService.selectNewsLetterApp(newsLetter);

		model.addAttribute("result", list);

		//실행결과 로기 생성
		this.resultLog(newsLetter);

		// int -> String
		for (int i = 0; i < list.size(); i++)
		{
			((Map) list.get(i)).put("APPTIME", String.valueOf(((Map) list.get(i)).get("APPTIME")));
		}

		String[] headerName = {"이메일", "신청일", "수신여부"};
		String[] columnName = {"APPEMAIL", "APPTIME", "RCV_YN_NM"};
		String sheetName = "뉴스레터 신청현황";

		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}

	@RequestMapping(value = "/ExcelDown")
	public void excelDown(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception
	{

		newsLetter.setInParam(request);

		//기본셋팅
		newsLetter.setRowCnt(1000);
		newsLetter.setExcelDownYn("Y");

		List list = newsLetterMgrService.getNewsLetterList(newsLetter);

		//실행결과 로기 생성
		this.resultLog(newsLetter);

		// int -> String
		for (int i = 0; i < list.size(); i++)
		{
			((Map) list.get(i)).put("INSTIME", String.valueOf(((Map) list.get(i)).get("INSTIME")));
		}

		String[] headerName = {"제목", "등록자", "등록일", "공개여부", "발송결과"};
		String[] columnName = {"KNAME", "INSUSERNAME", "INSTIME", "OPENYN", ""};
		String sheetName = "뉴스레터정보";

		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/sendEmail")
	@ResponseBody
	public boolean sendEmail(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		//기본 셋팅
		newsLetter.setInParam(request);

		boolean rtnMsg = false;

		String siteId = request.getParameter("siteId");
		String newsLetterId = request.getParameter("newsLetterId");

		newsLetter.setSiteId(siteId);
		newsLetter.setNewsLetterId(newsLetterId);
		newsLetter.setRcvYn("Y");

		Map<String, String> result = (Map<String, String>) newsLetterMgrService.getNewsLetter(newsLetter);
		List<?> newsLetterAppList = newsLetterMgrService.selectNewsLetterApp(newsLetter);

		String title = "";
		String content = "";
		String urlInfo = request.getParameter("urlInfo");

		String userName = "메일";

		title = result.get("KNAME").toString();
		content = "";

		//세션값 가져오기
		SCookie scUser = (SCookie) request.getSession().getAttribute("ADMUSER");

		String formUserNm = scUser.getUserName();
		String formUserId = scUser.getUserId();

		//발신자 정보 설정
		if ("SITE00002".equals(siteId))
		{  //한국보건산업진흥원
			formUserNm = "한국보건산업진흥원";
			formUserId = "khidisd@khidi.or.kr";
		}
		else if ("SITE00003".equals(siteId))
		{ //고령친화산업지원센터
			formUserNm = "고령친화산업지원센터";
			formUserId = "senior@khidi.or.kr";
		}
		else if ("SITE00004".equals(siteId))
		{ //의료기기산업정보
			formUserNm = "의료기기산업지원실";
			formUserId = "medicaldevice@khidi.or.kr";
		}
		else if ("SITE00017".equals(siteId))
		{ //해외진출(kohes)
			formUserNm = "의료해외진출종합정보포털";
			formUserId = "kohes@khidi.or.kr";
		}
		else
		{
			formUserNm = "한국보건산업진흥원";
			formUserId = "khidisd@khidi.or.kr";
		}

		try
		{

//			Email email = new Email();
//
//			// 발신자 정보 입력
//			email.setMail_Kind("99"); // 메일종류 기본 : 입력하지 않으면 공통으로 01 사용
//			email.setSubject(title);
//			//email.setSubject("한국 보건산업 진흥원 홈페이지 회원가입 이메일 인증 안내 메일입니다."); // 메일 제목
//			email.setSend_Email(formUserId); // 발신자 이메일 : 입력하지 않으면 공통으로 khidisd@khidi.or.kr 사용
//			email.setSend_Name(formUserNm); // 발신자 이름 : 입력하지 않으면 공통으로 관리자 사용
//
//			//현재일 가져오기
//			Date date = new Date();
//			SimpleDateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd");
//			String sendDate = formatdate.format(date);
//
//			// 수신자 정보 입력
//			String[] emailId;
//			String[] emailName;
//
//			emailId = new String[newsLetterAppList.size()];
//			emailName = new String[newsLetterAppList.size()];
//
//			emailId[0] = ((HashMap) newsLetterAppList.get(0)).get("APPEMAIL").toString();
//			emailName[0] = userName;
//
//			email.setEmail(emailId);    // 수신자 이메일 필수
//			email.setName(emailName);    // 수신자 이름 필수
//			email.setMapping1(sendDate); //현재날짜 넣어줘야함
//			email.setMapping2(content);
//			email.setMapping4(newsLetter.getNewsLetterId());
//			email.setUrlInfo(urlInfo);
//			email.setPrc_gubun("newsLetter");
//			email.setSiteId(siteId);
//
//			// 이메일 추가정보
//			email.setSerFld1(newsLetter.getMySiteId());     // 사이트ID
//			email.setSerFld2(newsLetter.getMenuId());       // 메뉴ID
//			email.setSerFld3(newsLetter.getNavigation());   // LOCATION
//			email.setSerFld4(title);                       // 업무(텍스트형태)
//			email.setSerFld5(newsLetter.getNewsLetterId());  // 고유업무키값
//
//			rtnMsg = EmailUtil.sendEmail(baseService, email, request, model);

		}
		catch (Exception e)
		{
			logger.error("eorro:::s" + e);
		}

		return rtnMsg;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/sendEmailTest")
	@ResponseBody
	public boolean sendEmailTest(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		//기본 셋팅
		newsLetter.setInParam(request);

		boolean rtnMsg = false;

		String siteId = request.getParameter("siteId");
		String newsLetterId = request.getParameter("newsLetterId");
		String appEmail = request.getParameter("appEmail");

		newsLetter.setSiteId(siteId);
		newsLetter.setNewsLetterId(newsLetterId);

		// 뉴스레터 정보 로드
		Map<String, String> result = (Map<String, String>) newsLetterMgrService.getNewsLetter(newsLetter);

		// List newsLetterAppList = newsLetterMgrService.selectNewsLetterApp(newsLetter);

		String title = "";
		String content = "";
		String urlInfo = request.getParameter("urlInfo");

		String userName = "메일";

		title = result.get("KNAME").toString();
		content = "";

		SCookie scUser = (SCookie) request.getSession().getAttribute("ADMUSER");

		String formUserNm = scUser.getUserName();
		String formUserId = scUser.getUserId();

		logger.info("formUserNm///////////////////////////////////" + formUserNm);
		logger.info("formUserId///////////////////////////////////" + formUserId);

		try
		{
//			Email email = new Email();
//
//			// 발신자 정보 입력
//			email.setMail_Kind("99"); // 메일종류 기본 : 입력하지 않으면 공통으로 01 사용
//			email.setSubject(title);
//			//email.setSubject("한국 보건산업 진흥원 홈페이지 회원가입 이메일 인증 안내 메일입니다."); // 메일 제목
//			email.setSend_Email(formUserId); // 발신자 이메일 : 입력하지 않으면 공통으로 khidisd@khidi.or.kr 사용
//			email.setSend_Name(formUserNm); // 발신자 이름 : 입력하지 않으면 공통으로 관리자 사용
//
//			//현재일 가져오기
//			Date date = new Date();
//			SimpleDateFormat formatdate = new SimpleDateFormat("yyyy-MM-dd");
//			String sendDate = formatdate.format(date);
//
//			// 수신자 정보 입력
//			String[] emailId;
//			String[] emailName;
//
//			emailId = new String[1];
//			emailName = new String[1];
//
//			emailId[0] = appEmail;
//			emailName[0] = userName;
//
//			email.setEmail(emailId);    // 수신자 이메일 필수
//			email.setName(emailName);    // 수신자 이름 필수
//			email.setMapping1(sendDate); //현재날짜 넣어줘야함
//			email.setMapping2(content);
//			email.setMapping4(newsLetter.getNewsLetterId());
//			email.setUrlInfo(urlInfo);
//			email.setSiteId(siteId);
//
//			// 이메일 추가정보
//			email.setSerFld1(newsLetter.getMySiteId());     // 사이트ID
//			email.setSerFld2(newsLetter.getMenuId());       // 메뉴ID
//			email.setSerFld3(newsLetter.getNavigation());   // LOCATION
//			email.setSerFld4(title);                       // 업무(텍스트형태)
//			email.setSerFld5("");  // 고유업무키값
//
//			rtnMsg = EmailUtil.sendEmail(baseService, email, request, model);
		}
		catch (Exception e)
		{
			logger.error("eorro:::s" + e);
		}

		return rtnMsg;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/sendEmailCancel")
	@ResponseBody
	public String sendEmailCancel(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		String rtnMsg = "FAILURE";

		rtnMsg = newsLetterMgrService.sendEmailCancel(request);

		return rtnMsg;

	}


	// 콘텐츠선택 팝업을 위한 영역 -- 시작

	/*****************************************************************
	 * popupSelectContents - 콘텐츠 설정트리 목록 조회
	 * @param site
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(method = RequestMethod.GET, value = "/popupSelectContents")
	public ModelAndView popupSelectContents(@ModelAttribute ContentSet contentSet, @RequestParam String subjectId, @RequestParam String linkId, HttpServletRequest request, Model model) throws Exception
	{
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setSiteId(request.getParameter("siteId"));
		contentSet.setParamMenuId(contentSet.getMenuId());

		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);

		if (!StringUtil.isNotBlank(contentSet.getSiteId())) contentSet.setSiteId("SITE00001");

		//메뉴 조회
		ContentSet objRtn = null;

		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		SCookie sc = (SCookie) request.getSession().getAttribute("ADMUSER");
		if (sc.getTotalAuth().equals("Y"))
		{
			objRtn = (ContentSet) contentMgrService.getContentSetList(contentSet);
		}
		else
		{
			objRtn = (ContentSet) contentMgrService.getContentSetAdminList(contentSet);
		}

		//실행결과 로기 생성
		this.resultLog(contentSet);

		// View 설정
		model.addAttribute("result", objRtn.getOutCursor());

		// 링크 설정
		String strLink = "";
		strLink = "&subjectId=" + StringUtil.nullCheck(subjectId) +
				"&linkId=" + StringUtil.nullCheck(linkId);

		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", contentSet.getParamMenuId());
		model.addAttribute("pSiteId", contentSet.getSiteId());


		contentSet.setJsp("site/newsLetterMgr/popupSelectContents");

		return new ModelAndView("ips.layoutPopup", "obj", contentSet);
	}

	/*****************************************************************
	 * listContents - 정적콘텐츠
	 * @param content
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=CONTENTS")
	public ModelAndView listContents(@ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception
	{
		// Parameter 설정
		content.setInParam(request);
		content.setParamMenuId(content.getMenuId());

		// 기본 셋팅
		this.setCommon(commonService, request, model, content);

		// 콘텐츠설정 조회
		Content objRtn = (Content) contentMgrService.getContentSet(content);
		model.addAttribute("rtnSetting", objRtn.getOutCursor());

		// 정적콘텐츠 조회
		Content rtnContent = (Content) contentMgrService.getContent(content);

		Content rtnContentC = (Content) rtnContent.getOutCursor();

		// 정적콘텐츠 이력조회
		Content rtnHistory = (Content) contentMgrService.getHistory(rtnContentC);

		// 정적콘텐츠 공유 메뉴 조회
		Content rtnContentLinkList = (Content) contentMgrService.ListContentsLink(content);

		model.addAttribute("rtnContentLinkList", rtnContentLinkList.getOutCursor());

		model.addAttribute("rtnContent", rtnContentC);
		model.addAttribute("rtnHistory", rtnHistory.getOutCursor());

		content.setJsp("site/newsLetterMgr/popupContentsList");

		return new ModelAndView("ips.content.layout", "obj", content);
	}

	/*********************************************************************
	 * listFreeBoard - 자유형게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ********************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=FREE", method = RequestMethod.GET)
	public ModelAndView listFreeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);

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

		title.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", title);
	}

	/*****************************************************************
	 * listNoticeBoard - 공지형게시판 리스트
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=NOTICE", method = RequestMethod.GET)
	public ModelAndView listNoticeBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception
	{
		// Parameter 설정
			contentSet.setInParam(request);
			contentSet.setParamMenuId(contentSet.getMenuId());
			title.setInParam(request);
			
			// 기본 셋팅
			this.setCommon(commonService, request, model, contentSet);
			
			// 콘텐츠설정 조회
			ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
			ContentSet setItem = (ContentSet)objRtn.getOutCursor();
			model.addAttribute("rtnSetting", setItem);
			
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
				"&schType=" + title.getSchType() +
				"&schText=" + StringUtil.nullCheck(title.getSchText()) +
				"&categoryId=" + StringUtil.nullCheck(title.getCategoryId()) +
				"&continent=" + StringUtil.nullCheck(title.getContinent()) +
				"&country=" + StringUtil.nullCheck(title.getCountry());

		model.addAttribute("link", strLink);

		contentSet.setJsp("site/newsLetterMgr/popupContentsList");

		return new ModelAndView("ips.content.layout", "obj", contentSet);
	}

	/***********************************************************************
	 * listThumbnailBoard - 썸네일형 게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ***********************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=THUMBNAIL", method = RequestMethod.GET)
	public ModelAndView listThumbnailBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);
		
		// 기본 boardStyle 지정
		if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
			title.setBoardStyle("Gallery");
		}
		
		//int viewLength = 0;
		// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9] 
		if(title.getBoardStyle().equals("Gallery")){
			title.setRowCnt(9);
		}
		
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

		title.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", title);
	}

	/*****************************************************************
	 * listLinkBoard - 링크형게시판 리스트
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=LINK", method = RequestMethod.GET)
	public ModelAndView listLinkBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);		
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", objRtn.getOutCursor());
		
		// 링크게시판 조회
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

		contentSet.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", contentSet);
	}

	/*****************************************************************
	 * listClippingBoard - 클리핑형게시판 리스트
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=CLIPPING", method = RequestMethod.GET)
	public ModelAndView listClippingBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);		
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		model.addAttribute("rtnSetting", objRtn.getOutCursor());
		
		// 링크게시판 조회
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

		contentSet.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", contentSet);
	}

	/*****************************************************************
	 * listVodBoard - 동영상형게시판 리스트
	 * @param boardKind
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=VOD", method = RequestMethod.GET)
	public ModelAndView listVodBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);
		
		// 기본 boardStyle 지정
		if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
			title.setBoardStyle("Text");
		}
		
		//int viewLength = 0;
		// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9] 
		if(title.getBoardStyle().equals("Gallery")){
			title.setRowCnt(9);
		}
				
		// 동영상게시판 조회
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

		title.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", title);
	}

	/******************************************************************
	 * listAppealBoard - 민원형게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=APPEAL", method = RequestMethod.GET)
	public ModelAndView listAppealBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);
		
		// 민원게시판 조회
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

		title.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", title);
	}

	/******************************************************************
	 * listReplyBoard - My관리자답변형게시판 리스트
	 * @param contentSet
	 * @param title
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 ******************************************************************/
	@RequestMapping(value = "/popupContentsList", params = "boardKind=REPLY", method = RequestMethod.GET)
	public ModelAndView listReplyBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);
		
		// 관리자답변형 게시판 조회
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

		title.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", title);
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
	@RequestMapping(params="boardKind=CARD", method=RequestMethod.GET)
	public ModelAndView listCardBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Title title, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setParamMenuId(contentSet.getMenuId());

		title.setInParam(request);

		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);

		// 콘텐츠설정 조회
		ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();
		model.addAttribute("rtnSetting", setItem);


		// 기본 boardStyle 지정
		if(contentSet.getBoardStyle() == null || contentSet.getBoardStyle().equals("") ){
			title.setBoardStyle("Gallery");
		}

		int viewLength = 0;

		// boardStyle별 리스트 갯수 지정[text : set value / image : 10 / gallery : 9]
		if(title.getBoardStyle().equals("Text")){
			title.setRowCnt(setItem.getRowCnt());
		}else if(title.getBoardStyle().equals("Image")){
			viewLength = 50;
			title.setRowCnt(10);
		}else if(title.getBoardStyle().equals("Gallery")){
			viewLength = 100;
			title.setRowCnt(9);
		}

		// 썸네일게시판 조회
		Title rtnCardBoard = (Title)contentMgrService.getCardBoardList(title);
		List<HashMap<String, String>> item = (List<HashMap<String, String>>)rtnCardBoard.getOutCursor();

		//maxIndex, minIndex 조회
		String maxIndex = null;
		String minIndex = null;

		for(int i=0; i<item.size(); i++){
			if(item.get(i).get("NOTICETITLEYN").equals("N")){
				maxIndex = item.get(i).get("MAXINDEX");
				minIndex = item.get(i).get("MININDEX");
				break;
			}
		}

		model.addAttribute("result", item);

		//페이징 정보
		model.addAttribute("totalCnt", rtnCardBoard.getOutMaxRow());	//전체 카운트
		model.addAttribute("transCnt", contentMgrService.getTransCnt(contentSet));	//T_TRANS확인

		//링크 정보
		String strLink = "";

		strLink = "&menuId=" + title.getMenuId() +
				"&maxIndex=" + maxIndex +
				"&minIndex=" + minIndex	+
				"&boardKind=CARD" +
				"&schType="+title.getSchType() +
				"&schText="+StringUtil.nullCheck(title.getSchText()) +
				"&boardStyle="+StringUtil.nullCheck(title.getBoardStyle())+
				"&categoryId="+StringUtil.nullCheck(title.getCategoryId());

		model.addAttribute("link", strLink);

		title.setJsp("site/newsLetterMgr/popupContentsList");
		return new ModelAndView("ips.content.layout", "obj", title);
	}
	
	@RequestMapping(value = "/updatePreviewHtml", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String updatePreviewHtml(@ModelAttribute NewsLetter newsLetter, HttpServletRequest request, Model model) throws Exception
	{
		try {
			//기본 셋팅
			newsLetter.setInParam(request);
			
			newsLetterMgrService.updatePreviewHtml(newsLetter);
			
			return "success";
			
		} catch (Exception e) {
			return "failed";
		}
		
	}
}