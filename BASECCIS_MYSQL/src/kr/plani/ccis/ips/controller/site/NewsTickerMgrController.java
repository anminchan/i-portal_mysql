package kr.plani.ccis.ips.controller.site;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.NewsTicker;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.NewsTickerMgrService;


@Controller
@RequestMapping(value="/mgr/newsTickerMgr")
public class NewsTickerMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(NewsTickerMgrController.class);
	 /** 뉴스티커관리 서비스   */
	@Resource
	private NewsTickerMgrService newsTickerMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 뉴스티커 목록 조회
	* @param newsTicker
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute NewsTicker newsTicker, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		newsTicker.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, newsTicker);

		// 검색 parameter 세팅
		newsTicker.setSiteId(request.getParameter("schSiteId"));
		newsTicker.setKName(request.getParameter("schKName"));
		
		// 목록 조회
		List<?> list = newsTickerMgrService.getObjectList(newsTicker);
		
		// View 설정
		model.addAttribute("result", list);

		//페이징 정보
		model.addAttribute("rowCnt", newsTicker.getRowCnt()); //페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT")))); //전체 카운트

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(newsTicker.getMenuId()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
		
		model.addAttribute("link", strLink);
		
		newsTicker.setJsp("site/newsTickerMgr/list");
		return new ModelAndView("ips.layout", "obj", newsTicker);
	}

	/*****************************************************************
	* Form 뉴스티커 추가/수정 폼
	* @param newsTicker
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute NewsTicker newsTicker, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		newsTicker.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, newsTicker);
				
		Object rtnObject = null;
		
		// 사이트 상세 조회
		rtnObject = newsTickerMgrService.getObject(newsTicker); // 본문내용
			
		// View 설정
		model.addAttribute("result", rtnObject);

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(newsTicker.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(newsTicker.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + StringUtil.nullCheck(request.getParameter("schKName"));
				
		model.addAttribute("link", strLink);
		
		newsTicker.setJsp("site/newsTickerMgr/form");
		return new ModelAndView("ips.layout", "obj", newsTicker);
	}
	
	/*****************************************************************
	 * insert 뉴스티커 추가/수정
	 * @param newsTicker
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute NewsTicker newsTicker, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		newsTicker.setInParam(request);
		
		// 저장
		if(newsTicker.getNewsTickerId() > 0){	
			newsTickerMgrService.updateObject(newsTicker);
			newsTicker.setOutNotice(messageSource.getMessage("success.update.msg", null, LocaleContextHolder.getLocale())); // 메세지설정
		}else{
			newsTickerMgrService.insertObject(newsTicker);
			newsTicker.setOutNotice(messageSource.getMessage("success.insert.msg", null, LocaleContextHolder.getLocale())); // 메세지설정
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, newsTicker);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(newsTicker.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(newsTicker.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/newsTickerMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	/*****************************************************************
	 * delete 뉴스티커 삭제(데이터삭제)
	 * @param newsTicker
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/delete")
	public ModelAndView delete(@ModelAttribute NewsTicker newsTicker, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		newsTicker.setInParam(request);		

		// 삭제
		newsTickerMgrService.deleteObject(newsTicker);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(newsTicker.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(newsTicker.getPageNum()) +
				  "&schSiteId=" + StringUtil.nullCheck(request.getParameter("schSiteId")) +
				  "&schKName=" + URLEncoder.encode(StringUtil.nullCheck(request.getParameter("schKName")), "UTF-8");
		
		model.addAttribute("link", strLink);
		
		newsTicker.setOutNotice(messageSource.getMessage("success.delete.msg", null, LocaleContextHolder.getLocale())); // 메세지설정
		this.setMessage(request, newsTicker);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/newsTickerMgr?"+strLink));
		return new ModelAndView(rv);
	}
}
