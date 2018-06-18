package kr.plani.ccis.ips.controller.site;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.controller.system.SiteMgrController;
import kr.plani.ccis.ips.domain.site.Content;
import kr.plani.ccis.ips.domain.site.ContentSet;
import kr.plani.ccis.ips.domain.site.GuestInfo;
import kr.plani.ccis.ips.domain.site.Link;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.site.ContentAppMgrService;
import kr.plani.ccis.ips.service.site.ContentMgrService;

@Controller
@RequestMapping(value="/mgr/contentAppMgr")
public class ContentAppMgrController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(SiteMgrController.class);

	/** 콘텐츠관리 서비스   */
	@Resource
	private ContentMgrService contentMgrService;
	
	@Resource
	private ContentAppMgrService contentAppMgrService;
	
	@Resource
	private CommonService commonService;
	
	/** 공통기능 서비스   */
	@Resource
	private BaseService baseService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Title title,  HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		title.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, title);
		
		// 자유게시판 조회
		List<?> boardList = contentAppMgrService.getAppBoardList(title);
		int boardListCnt = contentAppMgrService.getAppBoardListCnt(title);
		
		//페이징 정보
		model.addAttribute("result", boardList);
		model.addAttribute("totalCnt", boardListCnt);	//전체 카운트

		//링크 정보
		String strLink = "";
		
		strLink = "&menuId=" + title.getMenuId();
		
		model.addAttribute("link", strLink);
		
		title.setJsp("site/contentAppMgr/list");
		return new ModelAndView("ips.layout", "obj", title);
	}
	
	@RequestMapping(value="/view")
	public ModelAndView viewBoard(@ModelAttribute ContentSet contentSet, @ModelAttribute Link link, HttpServletRequest request, Model model) throws Exception {
		// Parameter 설정
		contentSet.setInParam(request);
		link.setInParam(request);
		
		// 기본 셋팅
		this.setCommon(commonService, request, model, link);
		
		// 콘텐츠설정 조회
		contentSet.setMenuId(link.getParamMenuId());
		/*ContentSet objRtn = (ContentSet)contentMgrService.getContentSet(contentSet);
		ContentSet setItem = (ContentSet)objRtn.getOutCursor();*/
		model.addAttribute("rtnSetting", contentMgrService.getContentSet(contentSet));

		// 승인대기콘텐츠 상세조회
		/*Link rtnAppBoard = (Link)contentAppMgrService.getObject(link);*/
		model.addAttribute("rtnContent", contentAppMgrService.getObject(link));
		model.addAttribute("rtnFileList", contentAppMgrService.getObjectFiles(link));
		
		/*HashMap hm = (HashMap) rtnAppBoard.getOutCursor();
		
		Title title = new Title();
		title.setMenuId(link.getMenuId());
		title.setInParam(request);*/
		
		String viewJsp = "site/contentAppMgr/view";
		
		//링크 정보
		String strLink = "";
		
		strLink = "pageNum=" + StringUtil.paramUnscript(link.getPageNum()+"") +
				"&rowCnt=" + StringUtil.paramUnscript(link.getRowCnt()+"") +
				"&menuId=" + StringUtil.paramUnscript(link.getMenuId()) + 
				"&schType="+StringUtil.paramUnscript(link.getSchType()+"") + 
				"&schText="+StringUtil.paramUnscript(StringUtil.nullCheck(link.getSchText()));

		model.addAttribute("link", strLink);

		link.setJsp(viewJsp);
		return new ModelAndView("ips.layout", "obj", link);

	}
	
	@RequestMapping(value="/act", method=RequestMethod.POST)
	public ModelAndView actAppBoard(@ModelAttribute Content content, @ModelAttribute GuestInfo guestInfo, HttpServletRequest request, Model model) throws Exception{
		
		//기본 Parameter 설정
		content.setInParam(request);		

		content.setInWorkName("승인콘텐츠게시판관리");
		content.setInCondition("수정");

		//다중 수정을위한 처리
		String[] arrLinkId = null;
		arrLinkId = request.getParameterValues("linkId");

		// After data 변수
		String contentData = null;
		
		// DML data 변수
		String contentDml = null;
		
		Content objRtn = new Content();
		if(arrLinkId.length <= 1){			
			//parameter 설정
			content.setLinkId(arrLinkId[0].split("§§")[0]);
			content.setParamMenuId(arrLinkId[0].split("§§")[1]);
			
			contentData = content.makeAppDataString();
			contentDml = content.makeAppDMLDataString();
			
			content.setInAfterData(contentData);
			content.setInDMLData(contentDml);
			objRtn = (Content) contentAppMgrService.updateObject(content);			
		} else {
			for(int i=0; i<arrLinkId.length; i++){
				//parameter 설정
				content.setLinkId(arrLinkId[i].split("§§")[0]);
				content.setParamMenuId(arrLinkId[i].split("§§")[1]);
				
				//parameter 설정
				contentData = content.makeAppDataString();
				contentDml = content.makeAppDMLDataString();
				
				content.setInAfterData(contentData);
				content.setInDMLData(contentDml);
				objRtn = (Content) contentAppMgrService.updateObject(content);	
			}
		}
		
		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
				
		//링크 정보		
		String strLink = request.getParameter("link");
			
		model.addAttribute("link", strLink);
		
		RedirectView rv = new RedirectView();
		rv.setExposeModelAttributes(true);
		
		//처리결과에 따라 이동 화면 변경
		rv.setUrl(request.getContextPath().concat("/mgr/contentAppMgr?").concat(strLink));
		
		return new ModelAndView(rv);
	}
	
}
