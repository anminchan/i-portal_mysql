package kr.plani.ccis.ips.controller.site;

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
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.Trans;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentMgrService;
import kr.plani.ccis.ips.service.site.ContentTransMgrService;


@Controller
@RequestMapping(value="/mgr/contentTransMgr")
public class ContentTransMgrController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(ContentTransMgrController.class);
	
	 /** 공통기능 서비스   */
	@Resource
	private CommonService commonService;

	 /** 공통기능 서비스   */
	@Resource
	private BaseService baseService;
	
	/** 콘텐츠관리 서비스   */
	@Resource
	private ContentMgrService contentMgrService;
	
	@Resource
	private ContentTransMgrService contentTransMgrService;
	
	@RequestMapping()
	public ModelAndView list(@ModelAttribute ContentSet contentSet, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		contentSet.setInParam(request);
		contentSet.setSiteId(request.getParameter("siteId"));
		contentSet.setParamMenuId(contentSet.getMenuId());
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, contentSet);

		if(!StringUtil.isNotBlank(contentSet.getSiteId())) contentSet.setSiteId(getSiteId());
		
		// 전체 콘텐츠설정 조회
		//ContentSet objRtn = (ContentSet)contentMgrService.getContentSetList(contentSet);
		
		// View 설정
		model.addAttribute("result", contentMgrService.getContentSetList(contentSet));
		model.addAttribute("resultSite", commonService.getSiteName(contentSet));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(contentSet.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", contentSet.getParamMenuId());
		model.addAttribute("pSiteId", contentSet.getSiteId());
		
		contentSet.setJsp("site/contentTransMgr/form");
		return new ModelAndView("ips.layout", "obj", contentSet);
	}
	
	@RequestMapping(value="/transForm")
	public ModelAndView transForm(@ModelAttribute Trans trans, @ModelAttribute Content content, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		trans.setInParam(request);
		
		// 기본 셋팅
		//this.setCommon(commonService, request, model, trans);
		
		// 전체 콘텐츠설정 조회
		List<?> listTransMenu = contentTransMgrService.selectTransMenu(trans);
		
		// 전체 콘텐츠설정 조회
		List<?> listTransTargetMenu = contentTransMgrService.selectTransTargetMenu(trans);
		
		// View 설정
		model.addAttribute("resultTransMenu", listTransMenu);
		model.addAttribute("resultTransTargetMenu", listTransTargetMenu);
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(trans.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", trans.getParamMenuId());
		model.addAttribute("pSiteId", trans.getSiteId());
		
		trans.setJsp("site/contentTransMgr/transForm");
		return new ModelAndView("ips.content.layout", "obj", trans);
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/selectMenuPopup")
    public ModelAndView selectMenuPopup(@ModelAttribute Content content, @ModelAttribute Trans trans, HttpServletRequest request, Model model) throws Exception {
		
		// 파라메타 세팅
		content.setSiteId(request.getParameter("siteId"));

		if(!StringUtil.isNotBlank(content.getSiteId())) content.setSiteId(getSiteId());
		
		// 콘텐츠설정 조회
		List<?> objRtn = (List<?>) contentMgrService.getObjectList(content);
		
		//실행결과 로기 생성
		this.resultLog(content);
		
		List<?> list = null;
		
		if(request.getParameter("tableHtml") == null || request.getParameter("tableHtml").equals("")){
			if(trans.getTransGubun().equals("trans")){
				list = contentTransMgrService.selectTransTargetMenu(trans);
			}else{
				list = contentTransMgrService.selectTransMenu(trans);
			}
		}
		// 전체 콘텐츠설정 조회
		
		// View 설정
		model.addAttribute("resultTransMenu", list);
		model.addAttribute("tableHtml", request.getParameter("tableHtml"));
		model.addAttribute("outResult", request.getParameter("outResult"));
		
		// View 설정
		model.addAttribute("result", objRtn);
		model.addAttribute("resultSite", commonService.getSiteName(trans));
		model.addAttribute("TransGubun", trans.getTransGubun());
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(trans.getMenuId()) +
				"&transMenuId=" + StringUtil.nullCheck(trans.getTransMenuId()) +
				"&boardKind=" + StringUtil.nullCheck(content.getBoardKind()) +
				"&transTargetMenuId=" + StringUtil.nullCheck(trans.getTransTargetMenuId()) +
				"&transGubun=" + StringUtil.nullCheck(trans.getTransGubun());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", content.getParamMenuId());
		model.addAttribute("pSiteId", content.getSiteId());

		content.setJsp("site/contentTransMgr/selectMenuListPop");
		content.setViewTitle("선택하기");
		return new ModelAndView("ips.layoutPopup", "obj", content);
 
    }
	
	@RequestMapping(value="/act")
	public ModelAndView act(@ModelAttribute Trans trans, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		trans.setInParam(request);
		
		// 전체 콘텐츠설정 조회
		contentTransMgrService.actTransMenu(trans);
		
		if(trans.getTransGubun().equals("trans")){
			trans.setTransTargetMenuId(trans.getTransMenuId());
		}else{
			trans.setTransMenuId(trans.getTransTargetMenuId());
		}
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(trans.getMenuId()) +
				"&transMenuId=" + StringUtil.nullCheck(trans.getTransMenuId()) +
				"&transTargetMenuId=" + StringUtil.nullCheck(trans.getTransTargetMenuId()) +
				"&transGubun=" + StringUtil.nullCheck(trans.getTransGubun()) +
				"&boardKind=" + StringUtil.nullCheck(request.getParameter("boardKind")) +
				"&outResult=SUCCESS";
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", trans.getParamMenuId());
		model.addAttribute("pSiteId", trans.getSiteId());
		
		trans.setOutNotice("저장되었습니다.");
		this.setMessage(request, trans);
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		rv.setUrl(request.getContextPath().concat("/mgr/contentTransMgr/selectMenuPopup?").concat(strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/delete")
	public ModelAndView delete(@ModelAttribute Trans trans, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		trans.setInParam(request);
		
		// 전체 콘텐츠설정 조회
		contentTransMgrService.deleteTransMenu(trans);
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(trans.getMenuId()) +
				"&transMenuId=" + StringUtil.nullCheck(trans.getTransMenuId()) +
				"&transTargetMenuId=" + StringUtil.nullCheck(trans.getTransTargetMenuId()) +
				"&trans=" + StringUtil.nullCheck(trans.getTransGubun());
		
		model.addAttribute("link", strLink);
		model.addAttribute("pMenuId", trans.getParamMenuId());
		model.addAttribute("pSiteId", trans.getSiteId());
		
		trans.setOutNotice("삭제되었습니다.");
		this.setMessage(request, trans);
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		rv.setUrl(request.getContextPath().concat("/mgr/contentTransMgr/transForm?").concat(strLink));
		return new ModelAndView(rv);
	}
}
