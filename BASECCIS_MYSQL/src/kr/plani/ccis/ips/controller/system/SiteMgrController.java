package kr.plani.ccis.ips.controller.system;

import java.net.URLEncoder;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.ExcelDownload;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.system.Site;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.system.SiteMgrService;

/*****************************************************************
* 사용자 계정을 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2017. 05. 01. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 01.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/siteMgr")
public class SiteMgrController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SiteMgrController.class);
	
	 /** 사이트관리 서비스   */
	@Resource
	private SiteMgrService siteMgrService;
	
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
	public ModelAndView list(@ModelAttribute Site site, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		site.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, site);
		
		// 사이트 조회
		//Site objRtn = (Site)siteMgrService.getObjectList(site);
		List<?> list = (List<?>) siteMgrService.getObjectList(site);

		//실행결과 로기 생성
		this.resultLog(site);
		
		// View 설정
		model.addAttribute("result", list);
		
		//페이징 정보
		model.addAttribute("rowCnt", site.getRowCnt());			//페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT"))));	//전체 카운트
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(site.getMenuId()) +
				  "&schType=" + StringUtil.nullCheck(site.getSchType()) +
				  "&schText=" + StringUtil.nullCheck(site.getSchText());
		
		model.addAttribute("link", strLink);
		
		site.setJsp("system/siteMgr/list");
		return new ModelAndView("ips.layout", "obj", site);
	}
	
	/*****************************************************************
	* Form 사이트 추가/수정 폼
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public ModelAndView form(@ModelAttribute Site site, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		site.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, site);
		
		Site rtnSite = new Site();
		
		//siteId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(site.getParamSiteId())){
		
			// 사이트 상세 조회
			rtnSite = (Site)siteMgrService.getObject(site);
			//rtnSite = (Site)objRtn.getOutCursor();
			
			//실행결과 로기 생성
			this.resultLog(site);
			
			// 변경전 데이타 저장(inBeforeData)	
			rtnSite.setInBeforeData(rtnSite.makeDataString());
		}

		// View 설정
		model.addAttribute("rtnSite", rtnSite );					
		
		site.setJsp("system/siteMgr/form");
		return new ModelAndView("ips.layout", "obj", site);
	}
	
	/*****************************************************************
	 * insert 사이트 추가/수정/삭제
	 * @param site
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute Site site, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		site.setInParam(request);		

		site.setInWorkName("사이트관리");
		if(StringUtil.isNotBlank(site.getParamSiteId())){
			site.setInCondition("수정");
		}else{
			site.setInCondition("입력");
		}
		
		// 변경후 데이타 저장(inAfterData)
		site.setInAfterData(site.makeDataString());
		
		//InDMLData ::  SiteID|KName|KDesc|URL|IP|SourcePath|SiteType|SiteLanguage|SiteKey|State
		//site.setInDMLData(site.makeDMLDataString());

		// 저장
		Site objRtn = (Site)siteMgrService.insertObject(site);
		
		// 신규 사이트 생성 시 기본 폴더 자동생성
		/*if(objRtn.getOutResult().equals("SUCCESS")){
	        //파일 객체 생성
	        mkdirsAdd("WebContent\\resources\\css\\"+site.getSiteKey());
	        mkdirsAdd("WebContent\\resources\\images\\"+site.getSiteKey());
	        mkdirsAdd("WebContent\\WEB-INF\\jsp\\"+site.getSiteKey());
	        //사용자서비스단
	        mkdirsAdd("src\\kr\\plani\\ccis\\"+site.getSiteKey());
	        mkdirsAdd("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\controller");
	        mkdirsAdd("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\domain");
	        mkdirsAdd("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\mapper");
	        mkdirsAdd("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\service");
	        mkdirsAdd("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\sqlmap");
	        //관리자서비스단
	        mkdirsAdd("src\\kr\\plani\\ccis\\ips\\controller\\"+site.getSiteKey());
	        mkdirsAdd("src\\kr\\plani\\ccis\\ips\\mapper\\"+site.getSiteKey());
	        mkdirsAdd("src\\kr\\plani\\ccis\\ips\\service\\"+site.getSiteKey());
	        mkdirsAdd("src\\kr\\plani\\ccis\\ips\\domain\\"+site.getSiteKey());
	        
	        generateSource("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\controller", site.getSiteKey(), "Main§§SITEKEY§§Controller", "java"); //Main컨트롤생성
	        generateSource("src\\kr\\plani\\ccis\\"+site.getSiteKey()+"\\controller", site.getSiteKey(), "BaseController", "java"); //Base컨트롤생성
	        generateSource("WebContent\\WEB-INF\\jsp\\"+site.getSiteKey(), site.getSiteKey(), "main", "jsp"); //main.jsp생성
		}*/
		
		//실행결과 로기 생성
		this.resultLog(objRtn);
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn); 
		
		//changLog
		site.setDmlType(site.getInCondition().equals("입력") ? "I" : site.getInCondition().equals("수정") ? "U" : "D");
		site.setDmlNotice("정상적으로 ("+site.getInWorkName()+")"+site.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(site);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(site.getMenuId()) +
				  "&schType=" + StringUtil.nullCheck(site.getSchType()) +
				  "&schText=" + StringUtil.nullCheck(URLEncoder.encode(site.getSchText(), "UTF-8"));
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/siteMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 사이트 삭제(상태값 변경)
	 * @param site
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(@ModelAttribute Site site, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		site.setInParam(request);		

		site.setInWorkName("사이트관리");
		site.setInCondition("삭제");

		//InDMLData ::  SiteID|KName|KDesc|URL|IP|SourcePath|SiteType|SiteLanguage|SiteKey|State
		site.setInDMLData(site.makeDMLDataString());

		// 저장
		Site objRtn = (Site)siteMgrService.deleteObject(site);
		
		//실행결과 로기 생성
		this.resultLog(site);
		
		//실행결과 메세지처리 시
		this.setMessage(request, site); 
		
		//changLog
		site.setDmlType("D");
		site.setDmlNotice("정상적으로 ("+site.getInWorkName()+")"+site.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(site);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(site.getMenuId()) +
				  "&schType=" + StringUtil.nullCheck(site.getSchType()) +
				  "&schText=" + StringUtil.nullCheck(URLEncoder.encode(site.getSchText(),"UTF-8"));
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/siteMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/ExcelDown")
	public void excelDown(@ModelAttribute Site site, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		// Parameter 설정
		site.setInParam(request);
		
		site.setRowCnt(1000);
		site.setExcelDownYn("Y");
		
		//실행결과 로기 생성
		this.resultLog(site);
		
		// 사이트 조회
		List list = (List) siteMgrService.getObjectList(site);

		String[] headerName = {"사이트ID", "사이트명", "사이트 URL", "사이트IP", "사이트설명", "사이트구분"};
		String[] columnName = {"SITEID", "KNAME", "URL", "IP", "KDESC", "SITEKEY"};
		String sheetName = "사이트정보";
		
		ExcelDownload.excelDownload(response, list, headerName, columnName, sheetName);
	}
	
}
