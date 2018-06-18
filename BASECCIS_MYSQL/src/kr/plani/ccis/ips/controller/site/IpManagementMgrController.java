package kr.plani.ccis.ips.controller.site;

import java.util.List;
import java.util.Map;

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

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.IpManagement;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.IpManagementMgrService;

@Controller
@RequestMapping(value="/mgr/ipManagementMgr")
public class IpManagementMgrController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(IpManagementMgrController.class);

	@Resource
	private IpManagementMgrService ipManagementMgrService;
	
	@Resource
	private CommonService commonService;
	
	
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute IpManagement ipManagement, HttpServletRequest request, Model model) throws Exception {

		// Parameter 설정
		ipManagement.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, ipManagement);
		
		List<?> list = ipManagementMgrService.selectIpManagementList(ipManagement);
		
		//실행결과 로기 생성
		this.resultLog(ipManagement);
		
		// View 설정
		model.addAttribute("result", list);
				
		//페이징 정보
		model.addAttribute("rowCnt", ipManagement.getRowCnt());	//페이지 목록수
		model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT"))));	//전체 카운트

		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(ipManagement.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(ipManagement.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(ipManagement.getRowCnt());
		
		model.addAttribute("link", strLink);
		
		ipManagement.setJsp("site/ipManagementMgr/list");
		return new ModelAndView("ips.layout", "obj", ipManagement);
	}

	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute IpManagement ipManagement, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		ipManagement.setInParam(request);
		
		// view 기본값 셋팅
		this.setCommon(commonService, request, model, ipManagement);
			
		List<?> list = null;
			
		if(ipManagement.getSeq() != 0){
			
			list = ipManagementMgrService.selectIpManagementView(ipManagement);
			
			//실행결과 로기 생성
			this.resultLog(ipManagement);
		}
		
		// 탭 구분
		model.addAttribute("cate", request.getParameter("cate"));

		// View 설정
		model.addAttribute("result", list);
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(ipManagement.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(ipManagement.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(ipManagement.getRowCnt());
				
		model.addAttribute("link", strLink);
		
		ipManagement.setJsp("site/ipManagementMgr/form");
		return new ModelAndView("ips.layout", "obj", ipManagement);
	}
	
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute IpManagement ipManagement, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		ipManagement.setInParam(request);
		
		ipManagementMgrService.insertIpManagement(ipManagement);
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(ipManagement.getMenuId()) +
				  "&pageNum=" + StringUtil.nullCheck(ipManagement.getPageNum()) +
				  "&rowCnt=" + StringUtil.nullCheck(ipManagement.getRowCnt());
				
		model.addAttribute("link", strLink);

		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/ipManagementMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
}
