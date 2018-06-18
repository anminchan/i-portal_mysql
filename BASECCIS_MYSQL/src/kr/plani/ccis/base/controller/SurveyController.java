package kr.plani.ccis.base.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.domain.site.Survey;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.SurveyMgrService;

@Controller
@RequestMapping("/survey")
public class SurveyController extends BaseCommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);
	
	@Resource
	CommonService commonService;

	/*설문조사 서비스*/
	@Resource
	SurveyMgrService surveyMgrService;
	
	/*****************************************************
	 * list 설문조사 목록
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		survey.setInParam(request);

		SiteSet siteSet = new SiteSet();
		//기본셋팅
		this.setCommon(commonService, request, model, survey, siteSet);
		
		survey.setSiteId(survey.getMySiteId());
		
		// 검색 parameter 세팅
		survey.setKName(request.getParameter("schKName"));
		
		List <HashMap<?,?>> surveyList = (List<HashMap<?,?>>) surveyMgrService.getSurveyList(survey);

		String outMaxRow = "0";
		
		if(surveyList.size() > 0){
			outMaxRow = surveyList.get(0).get("OUTMAXROW").toString();
		}
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		// View 설정
		model.addAttribute("result", surveyList);
		
		//페이징 정보
		model.addAttribute("rowCnt", survey.getRowCnt());	//페이지 목록수
		model.addAttribute("totalCnt", outMaxRow);	//전체 카운트
		
		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(survey.getMenuId())+
				"&siteId="+StringUtil.nullCheck(survey.getSiteId())+
				"&schSiteId="+StringUtil.nullCheck(request.getParameter("schSiteId"))+
				"&schKName="+StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		survey.setJsp("base/survey/list");
		
		if(siteSet.getSiteKye().equals("mps")){
			return new ModelAndView("mps.content" ,"obj", survey);
		}else{
			return new ModelAndView("common.content", "obj", survey);
		}
		
	}
	
	/*****************************************************
	 * view 설문조사 상세
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/view")
	public ModelAndView view(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		SiteSet siteSet = new SiteSet();

		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, survey, siteSet);
				
		// 사이트 상세 조회
		Survey objRtn = (Survey)surveyMgrService.getObject(survey);
		Survey rtnObject = (Survey)objRtn.getOutCursor();
		
		// 설문참여 가능기간 여부
		String surveyTimeYn = surveyMgrService.getSurveyTimeCheck(survey);
					
		//실행결과 로기 생성
		this.resultLog(survey);
		
		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(survey.getMenuId())+
				"&siteId="+StringUtil.nullCheck(survey.getSiteId())+
				"&schSiteId="+StringUtil.nullCheck(request.getParameter("schSiteId"))+
				"&schKName="+StringUtil.nullCheck(request.getParameter("schKName"))+
				"&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		// View 설정
		model.addAttribute("link", strLink);
		model.addAttribute("result", rtnObject);
		model.addAttribute("surveyTimeYn", surveyTimeYn);
		
		survey.setJsp("base/survey/view");
		
		if(siteSet.getSiteKye().equals("mps")){
			return new ModelAndView("mps.content" ,"obj", survey);
		}else{
			return new ModelAndView("common.content", "obj", survey);
		}
	}
	
	/*****************************************************
	 * view 설문조사 중복참여 여부 조회
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(value="/surveyParticipationCheck")
	public @ResponseBody Object surveyParticipationCheck(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		survey.setInParam(request);
		
		//세션값 가져오기
		SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
		
		String strUserId = "";
		String strDKey = "";
		
		if(scUser == null){
			strUserId = "guest";
		}else{
			strUserId = scUser.getUserId();
			survey.setUserName(scUser.getUserName());
			strDKey = scUser.getdKey();
		}
		
		survey.setUserId(strUserId);
		survey.setDkey(strDKey);
		
		Object obj = surveyMgrService.getSurveyParticipationCheck(survey);
		
		return obj;
	}
	
	/*****************************************************
	 * view 설문조사 참여폼
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/form")
	public ModelAndView form(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		SiteSet siteSet = new SiteSet();
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, survey, siteSet);
		
		Survey objRtn = new Survey();
		Survey rtnSurvey = new Survey();
		
		// 설문조사 상세 조회
		objRtn = (Survey)surveyMgrService.getObject(survey);
		rtnSurvey = (Survey)objRtn.getOutCursor();

		// 문항 목록
		List <?> questionList = surveyMgrService.getQuestionList(survey);
		
		// 답안 목록
		List <?> answerList = surveyMgrService.getPreviewList(survey);
		
		// 수정폼이면 참여정보 조회
		Survey rtnParti = null;
		List <?> rtnReply = null;
		if(survey.getParticipationId() != null){
			//세션값 가져오기
			SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
			
			String strUserId = "";
			String strDKey = "";
			
			if(scUser == null){
				strUserId = "guest";
			}else{
				strUserId = scUser.getUserId();
				survey.setUserName(scUser.getUserName());
				strDKey = scUser.getdKey();
			}
			
			survey.setUserId(strUserId);
			survey.setDkey(strDKey);
			
			rtnParti = (Survey) surveyMgrService.getSurveyParticipation(survey);
			rtnReply = surveyMgrService.getSurveyReplyList(survey); 
		}
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(survey.getMenuId())+
				"&siteId="+StringUtil.nullCheck(survey.getSiteId())+
				"&schSiteId="+StringUtil.nullCheck(request.getParameter("schSiteId"))+
				"&schKName="+StringUtil.nullCheck(request.getParameter("schKName"));
		
		// View 설정
		model.addAttribute("link", strLink);
		model.addAttribute("rtnSurvey", rtnSurvey);
		model.addAttribute("rtnQuestion", questionList);
		model.addAttribute("rtnAnswer", answerList);
		model.addAttribute("rtnParti", rtnParti);
		model.addAttribute("rtnReply", rtnReply);
		
		survey.setJsp("base/survey/form");
		
		if(siteSet.getSiteKye().equals("mps")){
			return new ModelAndView("mps.content" ,"obj", survey);
		}else{
			return new ModelAndView("common.content", "obj", survey);
		}
	}
	
	/*****************************************************************
	 * insert 설문조사 등록/수정
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {

		SiteSet siteSet = new SiteSet();
		
		//기본 Parameter 설정
		survey.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, survey, siteSet);
		
		//세션값 가져오기
		SCookie scUser = (SCookie)request.getSession().getAttribute("USER");
		
		String strUserId = "";
		String strDKey = "";
		
		if(scUser == null){
			strUserId = "guest";
		}else{
			strUserId = scUser.getUserId();
			survey.setUserName(scUser.getUserName());
			strDKey = scUser.getdKey();
		}
		
		survey.setUserId(strUserId);
		survey.setDkey(strDKey);
		
		// 기존 참여정보, 답안 삭제
		Survey partiCheck = (Survey) surveyMgrService.getSurveyParticipationCheck(survey);
		if(partiCheck != null){
			surveyMgrService.deletePartiReply(partiCheck);
		}
		
		// 설문참여 정보 등록
		surveyMgrService.insertSurveyParticipation(survey);
		String participationId = surveyMgrService.getParticipationId();
		survey.setParticipationId(participationId);
		
		// 설문참여 답안 등록
		String [] answers = survey.getAnswers();
		for (int i = 0; i < answers.length; i++) {

			String questionId = answers[i].split("§")[0];
			survey.setQuestionId(questionId);
			
			String answerId = "";
			
			if(answers[i].indexOf("-") < 0){ // 주관식 or 단일답안
				
				answerId = answers[i].split("§")[1];
				survey.setAnswer(answerId);
				surveyMgrService.insertSurveyReply(survey);
				
			}else{ //복수답안
				
				String [] multiChoices = answers[i].split("-");
				
				for (int j = 0; j < multiChoices.length; j++) {
					
					answerId = multiChoices[j].split("§")[1];
					survey.setAnswer(answerId);
					surveyMgrService.insertSurveyReply(survey);
					
				}
			}
		}
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		//실행결과 메세지처리 시
		survey.setOutNotice("저장되었습니다.");
		this.setMessage(request, survey);

		String strLink = "";
		strLink = "&menuId="+StringUtil.nullCheck(survey.getMenuId())+
				"&siteId="+StringUtil.nullCheck(survey.getSiteId())+
				"&schSiteId="+StringUtil.nullCheck(request.getParameter("schSiteId"))+
				"&schKName="+StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/survey?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************
	 * stat 설문조사 통계
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/stat")
	public ModelAndView stat(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		SiteSet siteSet = new SiteSet();
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, survey, siteSet);
		
		
		Survey objRtn = new Survey();
		Survey rtnSurvey = new Survey();
		
		// 설문조사정보 상세 조회
		objRtn = (Survey)surveyMgrService.getObject(survey);
		rtnSurvey = (Survey)objRtn.getOutCursor();

		// 문항 목록
		List <?> questionList = surveyMgrService.getQuestionList(survey);
		
		// 통계 목록
		List <?> statiList = surveyMgrService.getSurveyStatList(survey);
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(survey.getMenuId())+
				"&siteId="+StringUtil.nullCheck(survey.getSiteId())+
				"&schSiteId="+StringUtil.nullCheck(request.getParameter("schSiteId"))+
				"&schKName="+StringUtil.nullCheck(request.getParameter("schKName"))+
				"&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		// View 설정
		model.addAttribute("link", strLink);
		model.addAttribute("rtnSurvey", rtnSurvey);
		model.addAttribute("rtnQuestion", questionList);
		model.addAttribute("rtnStat", statiList);
		
		survey.setJsp("base/survey/stat");
		
		if(siteSet.getSiteKye().equals("mps")){
			return new ModelAndView("mps.content" ,"obj", survey);
		}else{
			return new ModelAndView("common.content", "obj", survey);
		}
	}
	
	/*****************************************************
	 * textAnswerList 주관식 답안 목록 
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/textAnswerList")
	public ModelAndView textAnswerList(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		survey.setInParam(request);
		
		SiteSet siteSet = new SiteSet();
		//기본셋팅
		this.setCommon(commonService, request, model, survey, siteSet);
		
		survey.setSiteId(survey.getMySiteId());
		
		// 검색 parameter 세팅
		survey.setKName(request.getParameter("schKName"));
		
		List <HashMap<?,?>> textAnswerList = (List<HashMap<?,?>>) surveyMgrService.getTextAnswerList(survey);
		
		String outMaxRow = "0";
		if(textAnswerList.size() > 0){
			outMaxRow = textAnswerList.get(0).get("OUTMAXROW").toString();
		}
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		// View 설정
		model.addAttribute("result", textAnswerList);
		
		//페이징 정보
		model.addAttribute("rowCnt", survey.getRowCnt());	//페이지 목록수
		model.addAttribute("totalCnt", outMaxRow);	//전체 카운트
		
		//링크설정
		String strLink = null;
		strLink = "&menuId="+StringUtil.nullCheck(survey.getMenuId())+
				"&siteId="+StringUtil.nullCheck(survey.getSiteId())+
				"&schSiteId="+StringUtil.nullCheck(request.getParameter("schSiteId"))+
				"&schKName="+StringUtil.nullCheck(request.getParameter("schKName"))+
				"&surveyId="+StringUtil.nullCheck(request.getParameter("surveyId"))+
				"&questionId="+StringUtil.nullCheck(request.getParameter("questionId"));
		
		model.addAttribute("link", strLink);
		
		survey.setJsp("base/survey/textAnswerListPopup");
		survey.setViewTitle("주관식 답안 목록");
		
		if(siteSet.getSiteKye().equals("mps")){
			return new ModelAndView("common.layoutPopup" ,"obj", survey);
		}else{
			return new ModelAndView("common.content", "obj", survey);
		}
	}
	
}
