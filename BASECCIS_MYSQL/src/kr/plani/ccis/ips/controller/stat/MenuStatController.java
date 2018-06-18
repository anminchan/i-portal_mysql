package kr.plani.ccis.ips.controller.stat;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.stat.Stat;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.stat.MenuStatService;

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
@RequestMapping(value="/mgr/menuStat")
public class MenuStatController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(MenuStatController.class);
	
	 /** 사이트관리 서비스   */
	@Resource
	private MenuStatService menuStatService;
	
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
		
		if(!StringUtil.isNotBlank(stat.getStatisSchGubun())) stat.setStatisSchGubun("MENU");
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
			Stat objRtn = (Stat)menuStatService.getObjectList(stat);
			
			//실행결과 로기 생성
			this.resultLog(stat);
			
			// View 설정
			model.addAttribute("resultMenu", objRtn.getOutCursor3());
		}
		
		// 탭 구분
		model.addAttribute("statisSchGubun", stat.getStatisSchGubun());
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(stat.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(stat.getSiteId()) +
				  "&schStartDate=" + StringUtil.nullCheck(stat.getSchStartDate()) +
				  "&schEndDate=" + StringUtil.nullCheck(stat.getSchEndDate());
		
		model.addAttribute("link", strLink);
		
		stat.setJsp("stat/menuStat/list");
		return new ModelAndView("ips.layout", "obj", stat);
	}
	
}
