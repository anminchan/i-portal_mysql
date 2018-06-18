package kr.plani.ccis.ips.controller.site;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.SCookie;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.Survey;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.SurveyMgrService;

/*****************************************************************
* 설문조사관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2015. 9. 23. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2015. 9. 23.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/surveyMgr")
public class SurveyMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(SurveyMgrController.class);

	 /** 설문조사관리 서비스   */
	@Resource
	private SurveyMgrService surveyMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 설문조사 목록 조회
	* @param survey
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		survey.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, survey);

		// 검색 parameter 세팅
		survey.setSiteId(request.getParameter("schSiteId"));
		survey.setKName(request.getParameter("schKName"));
		
		//전체관리자일경우 해당사이트 전체메뉴, 아닐경우 관리 권한이 있는 메뉴
		Survey objRtn = null;
		SCookie sc = (SCookie)request.getSession().getAttribute("ADMUSER");
		if(sc.getTotalAuth().equals("Y")){
			// 설문조사 목록 조회
			objRtn = (Survey)surveyMgrService.getObjectList(survey);

			//실행결과 로기 생성
			this.resultLog(survey);
			
			// View 설정
			model.addAttribute("result", objRtn.getOutCursor());

			//페이징 정보
			model.addAttribute("rowCnt", survey.getRowCnt());	//페이지 목록수
			model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
		}else{
			if(StringUtil.isNotBlank(survey.getSiteId())){
				// 설문조사설정 조회
				objRtn = (Survey)surveyMgrService.getObjectList(survey);

				//실행결과 로기 생성
				this.resultLog(survey);
				
				// View 설정
				model.addAttribute("result", objRtn.getOutCursor());
				
				//페이징 정보
				model.addAttribute("rowCnt", survey.getRowCnt());	//페이지 목록수
				model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
			}
		}
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		survey.setJsp("site/surveyMgr/list");
		return new ModelAndView("ips.layout", "obj", survey);
	}

	/*****************************************************************
	* Form 설문조사 등록/수정 폼
	* @param survey
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object form(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, survey);
				
		Survey rtnSurvey = new Survey();
			
		//siteId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(survey.getSurveyId())){
					
			// 사이트 상세 조회
			Survey objRtn = (Survey)surveyMgrService.getObject(survey);
			rtnSurvey = (Survey)objRtn.getOutCursor();
						
			//실행결과 로기 생성
			this.resultLog(survey);
						
			// 변경전 데이타 저장(inBeforeData)	
			rtnSurvey.setInBeforeData(rtnSurvey.makeDataString());
		}

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
				
		// View 설정
		model.addAttribute("link", strLink);
		model.addAttribute("rtnSurvey", rtnSurvey);	
				
		survey.setJsp("site/surveyMgr/form");
		return new ModelAndView("ips.layout", "obj", survey);
	}
	
	/*****************************************************************
	 * insert 설문조사 등록/수정
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act")
	public ModelAndView insert(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		survey.setInParam(request);
		
		survey.setInWorkName("설문조사관리");
		if(StringUtil.isNotBlank(survey.getSurveyId())){
			survey.setInCondition("수정");
		}else{
			survey.setInCondition("입력");
		}
		
		// 콘텐츠 설명 CLOB세팅
		survey.setInCLOBData1(survey.getKHtml());

		// 변경후 데이타 저장(inAfterData)
		survey.setInAfterData(survey.makeDataString());
		
		//InDMLData :: SiteID|SurveyID|KName|KHtml|OpenYn|SurveyStartTime|SurveyEndTime|SurveyTarget|ResultOpenForm|State
		survey.setInDMLData(survey.makeDMLDataString());

		// 저장
		Survey objRtn = (Survey)surveyMgrService.insertObject(survey);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/surveyMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 설문조사 삭제(데이터삭제)
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete")
	public ModelAndView delete(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		survey.setInParam(request);		

		survey.setInWorkName("설문조사관리");
		survey.setInCondition("삭제");

		//InDMLData ::  SiteID|SurveyID|KName|KHtml|OpenYn|SurveyStartTime|SurveyEndTime|SurveyTarget|ResultOpenForm|State
		survey.setInDMLData(survey.makeDMLDataString());

		// 저장
		Survey objRtn = (Survey)surveyMgrService.deleteObject(survey);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/surveyMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	* list 문항 목록 조회
	* @param survey
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/questionList", method=RequestMethod.GET)
	public ModelAndView questionList(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, survey);
				
		// 설문조사 상세 조회
		Survey objRtn = (Survey)surveyMgrService.getObject(survey);
		Survey rtnSurvey = (Survey)objRtn.getOutCursor();

		// 문항 목록 조회
		List<?> questionList = surveyMgrService.getQuestionList(survey);

		//실행결과 로기 생성
		this.resultLog(survey);
		
		// 설문 참여자 수
		int partiCount = surveyMgrService.getSurveyPartiCount(survey);
		
		// View 설정
		model.addAttribute("rtnSurvey", rtnSurvey);
		model.addAttribute("result", questionList);
		model.addAttribute("partiCount", partiCount);
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);
		
		survey.setJsp("site/surveyMgr/questionList");
		return new ModelAndView("ips.layout", "obj", survey);
	}
	
	/*****************************************************************
	* Form 문항 추가/수정 폼
	* @param survey
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/questionForm", method=RequestMethod.GET)
	public @ResponseBody Object questionForm(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, survey);
				
		Survey rtnQuestion = new Survey();
		List <?> fileList=  null;
		
		// 설문 상세조회
		Survey objRtn = (Survey)surveyMgrService.getQuestion(survey);

		// 문항 상세조회
		if(StringUtil.isNotBlank(survey.getQuestionId())){
			rtnQuestion = (Survey)objRtn.getOutCursor1();
			
			model.addAttribute("rtnAnswer", objRtn.getOutCursor2());
			
			fileList = surveyMgrService.getAnswerFileList(rtnQuestion);
			model.addAttribute("fileResult", fileList);
		}
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		// 변경전 데이타 저장(inBeforeData)	
		rtnQuestion.setInBeforeData(rtnQuestion.makeQuestionDataString());

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
		
		// View 설정
		model.addAttribute("rtnSurvey", objRtn.getOutCursor());
		model.addAttribute("rtnQuestion", rtnQuestion);
				
		survey.setJsp("site/surveyMgr/questionForm");
		return new ModelAndView("ips.layout", "obj", survey);
	}
	
	/*****************************************************************
	 * insert 문항 등록/수정
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/questionAct")
	public ModelAndView questionInsert(@ModelAttribute Survey survey, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		//기본 Parameter 설정
		survey.setInParam(request);
		
		survey.setInWorkName("설문조사문항관리");
		if(StringUtil.isNotBlank(survey.getQuestionId())){
			survey.setInCondition("수정");
		}else{
			survey.setInCondition("입력");
		}
		
		// 객관식 답안 셋팅
		String answerConcat = "";
		String[] fileArray = null;
		if(survey.getAnswerType().equals("2")){ // 객관식
			for (int i = 0; i < survey.getAnswers().length; i++) {
				if(i==(survey.getAnswers().length - 1)){
					answerConcat += survey.getAnswers()[i];
				}else{
					answerConcat += survey.getAnswers()[i] + "#";
				}
			}
		}else if(survey.getAnswerType().equals("3")){ // 이미지
			List list = new ArrayList(Arrays.asList(request.getParameterValues("fileVal")));
			list.removeAll(Collections.singleton(null));
			list.removeAll(Collections.singleton(""));
			fileArray = (String[]) list.toArray(new String[list.size()]);
			answerConcat = StringUtil.arrToStr(fileArray, "#");
		}

		// 답안데이터
		survey.setAnswerCount(Integer.toString(answerConcat.split("#").length));
		survey.setAnswer(answerConcat);
				
		// 변경후 데이타 저장(inAfterData)
		survey.setInAfterData(survey.makeQuestionDataString());
		
		//InDMLData :: SurveyID|QuestionID|KName|AnswerType|MultipleChoiceType|답압갯수|(1)답안#(2)답안#...#(3)답안#...(이미지일경우에는 ImageFileName@ImageFileSName@FilePath#ImageFileName@ImageFileSName@FilePath)...
		survey.setInDMLData(survey.makeQuestionDMLDataString());

		// 저장
		Survey objRtn = (Survey)surveyMgrService.insertObject(survey);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(survey.getSiteId()) +
				  "&surveyId=" + StringUtil.nullCheck(survey.getSurveyId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());

		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/surveyMgr/questionList?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 문항 삭제(데이터삭제)
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/questionDelete")
	public ModelAndView questionDelete(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		survey.setInParam(request);		

		survey.setInWorkName("설문조사문항관리");
		survey.setInCondition("삭제");

		//InDMLData :: SurveyID|QuestionID|KName|AnswerType|MultipleChoiceType|답압갯수|(1)답안#(2)답안#...#(3)답안#...(이미지일경우에는 ImageFileName@ImageFileSName@FilePath#ImageFileName@ImageFileSName@FilePath)...
		survey.setInDMLData(survey.makeQuestionDMLDataString());

		// 삭제
		Survey objRtn = (Survey)surveyMgrService.deleteQuestion(survey);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		//this.setMessage(request, objRtn);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(survey.getSiteId()) +
				  "&surveyId=" + StringUtil.nullCheck(survey.getSurveyId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(request.getParameter("schType")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/surveyMgr/questionList?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************
	 * list 답안 복사 팝업
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/answerCopyPopup")
	public ModelAndView answerCopyPopup(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		// 설문조사 상세 조회
		Survey objRtn = (Survey)surveyMgrService.getObject(survey);
		Survey rtnSurvey = (Survey)objRtn.getOutCursor();

		// 문항 목록 조회
		List<?> questionList = surveyMgrService.getQuestionList(survey);

		//실행결과 로기 생성
		this.resultLog(survey);
		
		// View 설정
		model.addAttribute("rtnSurvey", rtnSurvey);
		model.addAttribute("result", questionList);
		
		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&surveyId="+StringUtil.nullCheck(survey.getSurveyId()) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);
		
		survey.setJsp("site/surveyMgr/answerCopyPopup");
		survey.setViewTitle("답안복사");
		return new ModelAndView("ips.layoutPopup", "obj", survey);
	}
	
	/*****************************************************************
	 * insert 답안복사
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/answerCopy")
	public ModelAndView answerCopy(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		survey.setInParam(request);

		String questionId = null;
		String kName = survey.getKName();
		survey.setInWorkName("설문조사문항관리");
		
		if(StringUtil.isNotBlank(survey.getQuestionId())){
			questionId = survey.getQuestionId(); // 원본 ID
			survey.setInCondition("수정");
		}else{
			survey.setInCondition("입력");
		}
		
		// 복사할 문항 상세조회
		String chkQuestionId = survey.getChkQuestionId();
		survey.setQuestionId(chkQuestionId);
		Survey copyReturn = (Survey)surveyMgrService.getQuestion(survey);
		Survey copyQuestion = (Survey)copyReturn.getOutCursor1();
		
		// 복사할 답안 목록
		List<Survey> answerList = (List)copyReturn.getOutCursor2();
		String listSize = "0";
		if(answerList != null){
			listSize = answerList.size() + "";
		}
		
		// 복사할 답안 셋팅
		String answerConcat = "";
		if(copyQuestion.getAnswerType().equals("2")){ // 객관식
			for (int i = 0; i < answerList.size(); i++) {
				if((i+1)==answerList.size()){ // 마지막 답안일 경우 구분자 빼기
					answerConcat += answerList.get(i).getKName();
				}else{
					answerConcat += answerList.get(i).getKName()+"#";
				}
			}
		}else if(copyQuestion.getAnswerType().equals("3")){ // 이미지일 경우 이미지 파일 복사
			
			InputStream is = null;
			OutputStream os = null;
			
			for (int i = 0; i < answerList.size(); i++) {
				
				// 원본파일 정보
				String fileName = answerList.get(i).getImageFileName();
				String sFileName = answerList.get(i).getImageSFileName();
				String filePath = answerList.get(i).getFilePath();
				File originFile = new File(filePath+sFileName);
				
				// 복사하며 새로운 파일명
				Calendar cal = Calendar.getInstance();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmSS");
				String time = dateFormat.format(cal.getTime());
				String sFileCopyName = sFileName.split("[.]")[0] + time + "." + sFileName.split("[.]")[1];
				File copyFile = new File(filePath+sFileCopyName);
				
				// 파일복사
				is = new FileInputStream(originFile);
				os = new FileOutputStream(copyFile);
				
				int arrayLength = 0;
				
				if(originFile != null){
					if((int) originFile.length() > -1){
						arrayLength = (int) originFile.length();
					}
				}
				
				if(arrayLength > 0){
					byte[] buffer = new byte[arrayLength];
					
					int length;
					while ((length = is.read(buffer)) > 0) {
						os.write(buffer, 0, length);
					}
					is.close();
					os.close();
					
					if((i+1)==answerList.size()){
						answerConcat += fileName + "@" + sFileCopyName + "@" + filePath;
					}else{
						answerConcat += fileName + "@" + sFileCopyName + "@" + filePath + "#";
					}
				}else{
					is.close();
					os.close();
				}
			}
		}
		
		survey.setQuestionId(questionId);
		survey.setAnswerType(copyQuestion.getAnswerType());
		survey.setMultipleChoiceType(copyQuestion.getMultipleChoiceType());
		survey.setKName(kName);
		survey.setAnswerCount(listSize);
		survey.setAnswer(answerConcat);
		
		// 변경후 데이타 저장(inAfterData)
		survey.setInAfterData(survey.makeQuestionDataString());
		
		//InDMLData :: SurveyID|QuestionID|KName|AnswerType|MultipleChoiceType|답압갯수|(1)답안#(2)답안#...#(3)답안#...(이미지일경우에는 ImageFileName@ImageFileSName@FilePath#ImageFileName@ImageFileSName@FilePath)...
		survey.setInDMLData(survey.makeQuestionDMLDataString());
		
		// 저장
		survey = (Survey)surveyMgrService.insertObject(survey);
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		//실행결과 메세지처리 시
		this.setMessage(request, survey);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(survey.getSiteId()) +
				  "&surveyId=" + StringUtil.nullCheck(survey.getSurveyId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schType=" + StringUtil.nullCheck(survey.getSchType()) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/surveyMgr/questionList?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************
	 * preview 미리보기
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/
	@RequestMapping(method=RequestMethod.GET, value="/preview")
	public ModelAndView preview(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception{
		
		// 페키지 호출 기본 Parameter 설정
		survey.setInParam(request);
		
		// 설문조사 상세 조회
		Survey objRtn = (Survey)surveyMgrService.getObject(survey);
		Survey rtnSurvey = (Survey)objRtn.getOutCursor();

		List <?> questionList = surveyMgrService.getQuestionList(survey);
		
		// 미리보기 목록
		List <?> previewList = surveyMgrService.getPreviewList(survey);
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		// View 설정
		model.addAttribute("rtnSurvey", rtnSurvey);
		model.addAttribute("rtnQuestion", questionList);
		model.addAttribute("rtnPreview", previewList);
		
		//링크설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		survey.setJsp("site/surveyMgr/preview");
		survey.setViewTitle("설문조사");
		return new ModelAndView("ips.layoutPopup", "obj", survey);
	}
	
	/*****************************************************************
	* stat 설문조사 통계
	* @param survey
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/stat", method=RequestMethod.GET)
	public ModelAndView stat(@ModelAttribute Survey survey, HttpServletRequest request, Model model) throws Exception {
		
		// 기본 Parameter 설정
		survey.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, survey);
		
		// 설문조사정보 상세 조회
		Survey objRtn = (Survey)surveyMgrService.getObject(survey);
		Survey rtnSurvey = (Survey)objRtn.getOutCursor();
		
		// 문항 목록
		List <?> questionList = surveyMgrService.getQuestionList(survey);
		
		// 통계 목록
		List <?> statiList = surveyMgrService.getSurveyStatList(survey);
		
		// 설문 참여자 수
		int partiCount = surveyMgrService.getSurveyPartiCount(survey);
		
		//실행결과 로기 생성
		this.resultLog(survey);
	
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName")) +
				  "&pageNum=" + StringUtil.nullCheck(survey.getPageNum());
		
		model.addAttribute("link", strLink);
		model.addAttribute("rtnSurvey", rtnSurvey);
		model.addAttribute("rtnQuestion", questionList);
		model.addAttribute("rtnStat", statiList);
		model.addAttribute("partiCount", partiCount);
		
		survey.setJsp("site/surveyMgr/stat");
		return new ModelAndView("ips.layout", "obj", survey);
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
		
		// 기본 Parameter 설정
		survey.setInParam(request);
		
		List <HashMap<?,?>> textAnswerList = (List<HashMap<?,?>>) surveyMgrService.getTextAnswerList(survey);
		
		String outMaxRow = "0";
		if(textAnswerList.size() > 0){
			outMaxRow = textAnswerList.get(0).get("OUTMAXROW").toString();
		}
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(survey.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName="+StringUtil.nullCheck(request.getParameter("schKName"))+
				  "&surveyId="+StringUtil.nullCheck(request.getParameter("surveyId"))+
				  "&questionId="+StringUtil.nullCheck(request.getParameter("questionId"));
		
		// View 설정
		model.addAttribute("result", textAnswerList);
		model.addAttribute("link", strLink);
		
		//페이징 정보
		model.addAttribute("rowCnt", survey.getRowCnt());	//페이지 목록수
		model.addAttribute("totalCnt", outMaxRow);	//전체 카운트
		
		survey.setJsp("site/surveyMgr/textAnswerListPopup");
		survey.setViewTitle("주관식 답안 목록");
		return new ModelAndView("ips.layoutPopup", "obj", survey);
	}
	
	
	/*****************************************************
	 * excelDown 통계 엑셀 다운 
	 * @param survey
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *****************************************************/	
	@RequestMapping(value="/excelDown")
	public void excelDown(@ModelAttribute Survey survey, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		survey.setInParam(request);
		
		// 설문조사정보 상세 조회
		Survey objRtn = (Survey)surveyMgrService.getObject(survey);
		Survey rtnSurvey = (Survey)objRtn.getOutCursor();
		
		// 문항 목록
		List <?> questionList = surveyMgrService.getQuestionList(survey);
		List <HashMap<?,?>> qList = (List<HashMap<?,?>>) questionList;
		
		// 엑셀용 통계 목록
		List <?> exceliList = surveyMgrService.getSurveyStatExcelList(survey);
		List <HashMap<?,?>> eList = (List<HashMap<?,?>>) exceliList;
		
		//실행결과 로기 생성
		this.resultLog(survey);
		
		// 엑셀 파일명 설정
		String f_name = "";
		try {
			f_name = URLEncoder.encode("설문조사통계_" + rtnSurvey.getKName(), "UTF-8");
			f_name = f_name.replaceAll("\\+", " "); 
		} catch (UnsupportedEncodingException e2) {
			logger.info("오류발생");
		}
	
		// 엑셀 기본설정
		response.setHeader("Content-Type", "application/vnd.ms-excel;charset=UTF-8");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename="+f_name+".xls");	//엑셀작성될 화일명지정
		response.setHeader("Content-Description", "JSP Generated Data");  							//요거 중요함..
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		HSSFCellStyle headerCenter = wb.createCellStyle();
		headerCenter.setBorderRight(HSSFCellStyle.BORDER_THIN);              //테두리 설정   
		headerCenter.setBorderLeft(HSSFCellStyle.BORDER_THIN);   
		headerCenter.setBorderTop(HSSFCellStyle.BORDER_THIN);   
		headerCenter.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		headerCenter.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);     //색 설정
		headerCenter.setFillPattern(headerCenter.SOLID_FOREGROUND);
		headerCenter.setAlignment(CellStyle.ALIGN_CENTER);
		headerCenter.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		
		HSSFCellStyle headerLeft = wb.createCellStyle();
		headerLeft.setBorderRight(HSSFCellStyle.BORDER_THIN);   
		headerLeft.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		headerLeft.setBorderTop(HSSFCellStyle.BORDER_THIN);
		headerLeft.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		headerLeft.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
		headerLeft.setFillPattern(headerLeft.SOLID_FOREGROUND);
		headerLeft.setAlignment(CellStyle.ALIGN_LEFT);
		headerLeft.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		
		HSSFCellStyle contentCenter = wb.createCellStyle();
		contentCenter.setBorderRight(HSSFCellStyle.BORDER_THIN);   
		contentCenter.setBorderLeft(HSSFCellStyle.BORDER_THIN);   
		contentCenter.setBorderTop(HSSFCellStyle.BORDER_THIN);   
		contentCenter.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		contentCenter.setAlignment(CellStyle.ALIGN_CENTER);
		contentCenter.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		
		HSSFCellStyle contentLeft = wb.createCellStyle();
		contentLeft.setBorderRight(HSSFCellStyle.BORDER_THIN);   
		contentLeft.setBorderLeft(HSSFCellStyle.BORDER_THIN);   
		contentLeft.setBorderTop(HSSFCellStyle.BORDER_THIN);   
		contentLeft.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		contentLeft.setAlignment(CellStyle.ALIGN_LEFT);
		contentLeft.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		
		Row row;
		Cell cell;
		Sheet sheet;
		sheet = wb.createSheet("설문조사통계");
		BufferedOutputStream fileOut = null;
		
		try {
			
			fileOut = new BufferedOutputStream(response.getOutputStream());
			
			// 헤더 생성
			row = sheet.createRow(0);
			cell = row.createCell(0);
			cell.setCellValue("설문명");
			cell.setCellStyle(headerCenter);
			cell = row.createCell(1);
			cell.setCellValue(rtnSurvey.getKName());
			cell.setCellStyle(contentLeft);
			
			// 병합할 헤더 셀 스타일 적용 위해
			int cellSize = 2 + questionList.size();
			for (int i = 2; i < cellSize; i++) {
				cell = row.createCell(i);
				cell.setCellStyle(contentLeft);
			}
			
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, qList.size()+1)); //CellRangeAddress(int firstRow, int lastRow, int firstCol, int lastCol)
			
			row = sheet.createRow(1);
			cell = row.createCell(0);
			cell.setCellValue("설문기간");
			cell.setCellStyle(headerCenter);
			cell = row.createCell(1);
			cell.setCellValue(rtnSurvey.getSurveyStartTime() + " ~ " + rtnSurvey.getSurveyEndTime());
			cell.setCellStyle(contentLeft);
			
			for (int i = 2; i < cellSize; i++) {
				cell = row.createCell(i);
				cell.setCellStyle(contentLeft);
			}
			
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, qList.size()+1)); //CellRangeAddress(int firstRow, int lastRow, int firstCol, int lastCol)
			
			row = sheet.createRow(2);
			cell = row.createCell(0);
			cell.setCellValue("참여자");
			cell.setCellStyle(headerCenter);
			
			cell = row.createCell(1);
			cell.setCellValue("완료일자");
			cell.setCellStyle(headerCenter);
			
			// 셀 너비 설정
			sheet.setColumnWidth(0, 4000);
			sheet.setColumnWidth(1, 4000);
			
			// 문항명 헤더 생성
			int cellIndex = 2;
			for (int i = 0; i < qList.size(); i++) {
				cell = row.createCell(cellIndex);
				cell.setCellValue(qList.get(i).get("KNAME").toString());
				cell.setCellStyle(headerLeft);
				
				// 셀 너비 설정
				sheet.setColumnWidth(cellIndex, qList.get(i).get("KNAME").toString().length() * 600);
				
				cellIndex++;
			}
			
			int rowIndex = 3;
			for (int i = 0; i < eList.size(); i++) {
				
				row = sheet.createRow(rowIndex++);
				
				cell = row.createCell(0);
				cell.setCellValue(eList.get(i).get("USERNAME").toString());
				cell.setCellStyle(contentLeft);
				
				cell = row.createCell(1); 
				cell.setCellValue(eList.get(i).get("INSTIME").toString().substring(0, 16));
				cell.setCellStyle(contentLeft);
				
				// 답안 입력
				for (int j = 0; j < qList.size(); j++) {
					
					cell = row.createCell(j+2); 
					cell.setCellValue(eList.get(i+j).get("ANSWER").toString());
					cell.setCellStyle(contentLeft);
					
				}
				
				i = i + (qList.size()-1);
			}
			
			wb.write(fileOut);
			 
		}catch (Exception e){
			try {
				throw e;
			} catch (Exception e1) {
				logger.info("오류발생");
			}
		}finally{
			if(fileOut != null){
				try {
					fileOut.close();
				} catch (IOException e) {
					logger.info("오류발생");
				}
			}
		}
		
	}
	
}
