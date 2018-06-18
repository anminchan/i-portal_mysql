package kr.plani.ccis.ips.controller.stat;

import java.net.URLEncoder;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.ExcelDownload;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.stat.Stat;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.stat.ChangLogMgrService;

/*****************************************************************
* 사이트접속통계를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2014. 11. 13. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2014. 11. 13.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/changLogMgr")
public class ChangLogMgrController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ChangLogMgrController.class);
	
	 /** 사이트관리 서비스   */
	@Resource
	private ChangLogMgrService changLogMgrService;
	
	 /** 공통기능 서비스   */
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 사이트 목록 조회
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Stat stat, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		stat.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, stat);
				
		
		
				
		if(!StringUtil.isNotBlank(stat.getSiteId())) stat.setSiteId(getSiteId());
		
		if(!StringUtil.isNotBlank(stat.getSchStartDate()) && !StringUtil.isNotBlank(stat.getSchEndDate())){
			Calendar cal = new GregorianCalendar();
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			
			String sDay = formatter.format(new java.util.Date()); //현재날짜
			 
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date d = df.parse(sDay, new ParsePosition(0));
					 
			cal.setTime(d);
			cal.add(Calendar.DATE, -7);
					
			String beforeMonth = df.format(cal.getTime());
				
			stat.setInSchStartDate(beforeMonth.replaceAll("-", ""));
			stat.setInSchEndDate(sDay.replaceAll("-", ""));
					
			stat.setSchStartDate(beforeMonth);
			stat.setSchEndDate(sDay);
			
			model.addAttribute("first", "first");
		}else{
			String splitData[] = null;
			String result = "";
			
			splitData = stat.getSchStartDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
			}
			//검색 시작일
			stat.setInSchStartDate(result);
						
			splitData = null; 
			result = "";
			splitData = stat.getSchEndDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
			}
			//검색 종료일
			stat.setInSchEndDate(result);
			
			// 사이트 조회
			Stat objRtn = (Stat)changLogMgrService.getObjectList(stat);
							
			//실행결과 로기 생성
			this.resultLog(stat);
							
			//페이징 정보
			model.addAttribute("rowCnt", stat.getRowCnt());			//페이지 목록수
			model.addAttribute("totalCnt", objRtn.getOutMaxRow());	//전체 카운트
							
			// View 설정
			model.addAttribute("result", objRtn.getOutCursor());
		}
				
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(stat.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(stat.getSiteId()) +
				  "&schType=" + StringUtil.nullCheck(stat.getSchType()) +
				  "&schText=" + StringUtil.nullCheck(stat.getSchText()) +
				  "&schStartDate=" + StringUtil.nullCheck(stat.getSchStartDate()) +
				  "&schEndDate=" + StringUtil.nullCheck(stat.getSchEndDate());
		
		model.addAttribute("link", strLink);
		
		stat.setJsp("stat/changLogMgr/list");
		return new ModelAndView("ips.layout", "obj", stat);
	}
	
	@RequestMapping(value="/form")
	public ModelAndView form(@ModelAttribute Stat stat, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		stat.setInParam(request);
				
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, stat);
		
		model.addAttribute("dmlTime", request.getParameter("dmlTime")); //조회일시
		model.addAttribute("dmlUserName", request.getParameter("dmlUserName")); //조회자
		model.addAttribute("siteName", request.getParameter("siteName")); //조회자
		model.addAttribute("namePath", request.getParameter("namePath")); //메뉴
		model.addAttribute("dmlTypeName", request.getParameter("dmlTypeName")); //조회대상자
		model.addAttribute("dmlIp", request.getParameter("dmlIp")); //접속IP
		model.addAttribute("beforeData", request.getParameter("beforeData")); //조회내용
		model.addAttribute("afterData", request.getParameter("afterData")); //조회내용
				
		//실행결과 로기 생성
		this.resultLog(stat);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(stat.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(stat.getPageNum()) +
				  "&siteId=" + StringUtil.nullCheck(stat.getSiteId()) +
				  "&schType=" + StringUtil.nullCheck(stat.getSchType()) +
				  "&schText=" + StringUtil.nullCheck(stat.getSchText()) +
				  "&schStartDate=" + StringUtil.nullCheck(stat.getSchStartDate()) +
				  "&schEndDate=" + StringUtil.nullCheck(stat.getSchEndDate());
	
		model.addAttribute("link", strLink);					
		
		stat.setJsp("stat/changLogMgr/form");
		return new ModelAndView("ips.layout", "obj", stat);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute Stat stat, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		stat.setInParam(request);		

		String splitData[] = null;
		String result = "";
		
		splitData = stat.getSchStartDate().split("-");
		for(int i=0; i<splitData.length; i++){
			result = result + splitData[i];
		}
		//검색 시작일
		stat.setInSchStartDate(result);
		
		splitData = null; 
		result = "";
		splitData = stat.getSchEndDate().split("-");
		for(int i=0; i<splitData.length; i++){
			result = result + splitData[i];
		}
		//검색 종료일
		stat.setInSchEndDate(result);
		
		// 삭제
		Stat objRtn = (Stat)changLogMgrService.deleteObject(stat);
		
		//실행결과 로기 생성
		this.resultLog(stat);
				
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(stat.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(stat.getPageNum()) +
				  "&siteId=" + StringUtil.nullCheck(stat.getSiteId()) +
				  "&schType=" + StringUtil.nullCheck(stat.getSchType()) +
				  "&schText=" + URLEncoder.encode(StringUtil.nullCheck(stat.getSchText()), "UTF-8") +
				  "&schStartDate=" + StringUtil.nullCheck(stat.getSchStartDate()) +
				  "&schEndDate=" + StringUtil.nullCheck(stat.getSchEndDate());
	
		model.addAttribute("link", strLink);					
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/changLogMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/ExcelDown")
	public void excelDown(@ModelAttribute Stat stat, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		//기본 Parameter 설정
		stat.setInParam(request);	
				
		// 기본 셋팅
		stat.setRowCnt(100000);
		stat.setExcelDownYn("Y");
				
		String splitData[] = null;
		String result = "";
		Calendar cal = new GregorianCalendar();
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
				
		if(!StringUtil.isNotBlank(stat.getSiteId())) stat.setSiteId(getSiteId());
		
		if(!StringUtil.isNotBlank(stat.getSchStartDate()) && !StringUtil.isNotBlank(stat.getSchEndDate())){
			String sDay = formatter.format(new java.util.Date()); //현재날짜
			 
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date d = df.parse(sDay, new ParsePosition(0));
					 
			cal.setTime(d);
			cal.add(Calendar.DATE, -7);
					
			String beforeMonth = df.format(cal.getTime());
				
			stat.setInSchStartDate(beforeMonth.replaceAll("-", ""));
			stat.setInSchEndDate(sDay.replaceAll("-", ""));
					
			stat.setSchStartDate(beforeMonth);
			stat.setSchEndDate(sDay);
		}else{
			splitData = stat.getSchStartDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
		}
		//검색 시작일
		stat.setInSchStartDate(result);
					
		splitData = null; 
		result = "";
		splitData = stat.getSchEndDate().split("-");
		for(int i=0; i<splitData.length; i++){
			result = result + splitData[i];
		}
		//검색 종료일
		stat.setInSchEndDate(result);
		}
		
		// Parameter 설정
		stat.setInParam(request);
				
		// 사이트 조회
		Stat objRtn = (Stat)changLogMgrService.getObjectList(stat);
						
		//실행결과 로기 생성
		this.resultLog(stat);
		
		List list = (List) objRtn.getOutCursor();
		
		String[] headerName = {"처리일시", "처리자", "사이트", "메뉴", "기능", "접속IP", "기존데이터", "수정데이터"};
		String[] columnName = {"DMLTIME", "DMLUSERNAME", "SITENAME", "MENUNAME", "DMLTYPENAME", "DMLIP", "BEFOREDATA", "AFTERDATA"};
		String sheetName = "변경현황정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
}
