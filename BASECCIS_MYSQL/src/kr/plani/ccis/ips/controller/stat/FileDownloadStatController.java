package kr.plani.ccis.ips.controller.stat;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.springframework.web.servlet.ModelAndView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.stat.FileDownloadStat;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.stat.FileDownloadStatService;

@Controller
@RequestMapping("/mgr/fileDownloadStat")
public class FileDownloadStatController extends BaseController {	
	private static final Logger logger = LoggerFactory.getLogger(FileDownloadStatController.class);
	
	 /** 첨부파일 다운로드현황 서비스 */
	@Resource
	private FileDownloadStatService fileDownloadStatService;
		
	 /** 공통기능 서비스   */
	@Resource
	CommonService commonService;

	/*****************************************************************
	* list 첨부파일 다운로드현황 조회
	* @param fileDownloadStat
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView list(@ModelAttribute FileDownloadStat fileDownloadStat, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		fileDownloadStat.setInParam(request);

		// 기본 셋팅
		this.setCommon(commonService, request, model, fileDownloadStat);
		
		if(!StringUtil.isNotBlank(fileDownloadStat.getStatGubun())) fileDownloadStat.setStatGubun("BOARD");
		
		if(!StringUtil.isNotBlank(fileDownloadStat.getSchStartDate()) && !StringUtil.isNotBlank(fileDownloadStat.getSchEndDate())){
			Calendar cal = new GregorianCalendar();
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
			
			String sDay = formatter.format(new java.util.Date()); //현재날짜
			 
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date d = df.parse(sDay, new ParsePosition(0));
			 
			cal.setTime(d);
			cal.add(Calendar.MONTH, -1);
			
			String beforeMonth = df.format(cal.getTime());
			
			fileDownloadStat.setInSchStartDate(beforeMonth.replaceAll("-", ""));
			fileDownloadStat.setInSchEndDate(sDay.replaceAll("-", ""));
			
			fileDownloadStat.setSchStartDate(beforeMonth);
			fileDownloadStat.setSchEndDate(sDay);
			
			model.addAttribute("first", "first");
		}else{
			String splitData[] = null;
			String result = "";
			
			splitData = fileDownloadStat.getSchStartDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
			}
			//검색 시작일
			fileDownloadStat.setInSchStartDate(result);
			
			splitData = null; 
			result = "";
			splitData = fileDownloadStat.getSchEndDate().split("-");
			for(int i=0; i<splitData.length; i++){
				result = result + splitData[i];
			}
			//검색 종료일
			fileDownloadStat.setInSchEndDate(result);
			
			// 콘텐츠이용현황조회
			List <?> fileDownloadStatList = (List<?>) fileDownloadStatService.getObjectList(fileDownloadStat); 
			
			//실행결과 로기 생성
			this.resultLog(fileDownloadStat);
					
			// View 설정
			model.addAttribute("result", fileDownloadStatList);
		}

		model.addAttribute("statGubun", fileDownloadStat.getStatGubun());
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(fileDownloadStat.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(fileDownloadStat.getSiteId()) +
				  "&statGubun=" + StringUtil.nullCheck(fileDownloadStat.getStatGubun()) +
				  "&schStartDate=" + StringUtil.nullCheck(fileDownloadStat.getSchStartDate()) +
				  "&schEndDate=" + StringUtil.nullCheck(fileDownloadStat.getSchEndDate());
		
		model.addAttribute("link", strLink);
		
		fileDownloadStat.setJsp("stat/fileDownloadStat/list");
		return new ModelAndView("ips.layout", "obj", fileDownloadStat);
	}
}
