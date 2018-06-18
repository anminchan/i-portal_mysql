package kr.plani.ccis.mps.controller;

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
import org.springframework.web.servlet.ModelAndView;

import kr.plani.ccis.base.domain.SiteSet;
import kr.plani.ccis.base.service.BaseService;
import kr.plani.ccis.ips.domain.DefaultDomain;
import kr.plani.ccis.ips.domain.site.Banner;
import kr.plani.ccis.ips.domain.site.Doodles;
import kr.plani.ccis.ips.domain.site.FamilySite;
import kr.plani.ccis.ips.domain.site.PopupWindow;
import kr.plani.ccis.ips.domain.site.PopupZone;
import kr.plani.ccis.ips.domain.site.Title;
import kr.plani.ccis.ips.domain.site.VisualZone;

/*****************************************************************
* 대표홈페이지를 보여주는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 
* @since  2015. 11. 04. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2015. 11. 04.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mps")
public class MainMpsController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(MainMpsController.class);
	
	@Resource
	private BaseService baseService;
		
	/*****************************************
	 * main 대표홈페이지 메인
	 * @param defaultDomain
	 * @param request
	 * @param model
	 * @return
	 ******************************************/
	@RequestMapping()
	public ModelAndView main(@ModelAttribute DefaultDomain defaultDomain, HttpServletRequest request,  Model model) throws Exception{
		defaultDomain.setInParam(request);
		
		// 사이트아이디를 가져오는 로직
		defaultDomain.setMySiteKey("mps");
		HashMap siteInfo = (HashMap)baseService.selectSiteKeyInfo(defaultDomain);
		
		defaultDomain.setSiteId(siteInfo.get("SITEID").toString());
		defaultDomain.setMySiteId(defaultDomain.getSiteId().toUpperCase());

		SiteSet siteSet = new SiteSet();
		siteSet.mainGubun = "main";
		this.setCommon(baseService, request, model, defaultDomain, siteSet);
		
		// 게시글조회 Start
		Title title = new Title();
		title.setRowCnt(3);
		title.setMenuId("MENU00301");
		List<?> boardList = baseService.getBoardList(title); // 게시판조회
				
		// PopupZoneList조회 Start
		PopupZone popupZone = new PopupZone();
		popupZone.setSiteId(defaultDomain.getSiteId());
		List<?> popupZoneRtn = baseService.listPopupZone(popupZone);
		// PopupZoneList조회 End
		
		// PopupWindowList 조회 Start
		PopupWindow popupWindow = new PopupWindow();
		popupWindow.setSiteId(defaultDomain.getSiteId());
		List<?> popupWindowRtn = baseService.listPopupWindow(popupWindow);
		// PopupWindowList 조회 End

		// VisualZoneList조회 Start
		VisualZone visualZone = new VisualZone();
		visualZone.setSiteId(defaultDomain.getSiteId());
		List<?> visualZoneRtn =  baseService.listVisualZone(visualZone);
		// VisualZoneList조회 End
		
		// BannerList조회 Start
		Banner banner = new Banner();
		banner.setSiteId(defaultDomain.getSiteId());
		List<?> bannerRtn = baseService.listBanner(banner);
		// BannerList조회 End
						
		// Family Site조회 Start
		FamilySite familySite = new FamilySite();
		familySite.setSiteId(defaultDomain.getSiteId());
		List<?> familySiteRtn = baseService.listFamilySite(familySite);
		// Family Site조회 End	
		
		// 두들 조회 Start
		Doodles doodles = new Doodles();
		doodles.setSiteId(defaultDomain.getSiteId());
		List<?> doodlesListRtn = baseService.listDoodles(doodles);
		// 두들 조회 End		

		
		
		
		model.addAttribute("rtnBoardList" , boardList); // 공지사항
		model.addAttribute("rtnBannerList" , bannerRtn); // Banner
		model.addAttribute("rtnFamilySiteList" , familySiteRtn); //FamilySite
		model.addAttribute("rtnPopupZoneList" , popupZoneRtn); // PopupZone
		model.addAttribute("rtnPopupWindowList", popupWindowRtn); //popup window
		model.addAttribute("rtnVisualZoneList" , visualZoneRtn); // VisualZone
		model.addAttribute("rtnDoodlesList" , doodlesListRtn); // 두들
		
		defaultDomain.setJsp("main");
		
		return new ModelAndView("mps.layout", "obj", defaultDomain);
	}

}
