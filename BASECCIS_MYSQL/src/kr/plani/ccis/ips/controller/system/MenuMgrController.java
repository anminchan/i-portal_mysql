package kr.plani.ccis.ips.controller.system;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import kr.plani.ccis.ips.domain.system.Menu;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.system.MenuMgrService;

/*****************************************************************
* 메뉴관리를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2016. 05. 01. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2016. 5. 01.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/menuMgr")
public class MenuMgrController extends BaseController {

	 /** 메뉴관리 서비스   */
	@Resource
	private MenuMgrService menuMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 메뉴 목록 조회
	* @param site
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute Menu menu, HttpServletRequest request, Model model) throws Exception {
		
		// Parameter 설정
		menu.setInParam(request);
		
		menu.setSiteId(request.getParameter("siteId")); // 요청 Parameter

		// 기본 셋팅
		this.setCommon(commonService, request, model, menu);

		if(!StringUtil.isNotBlank(menu.getSiteId())) menu.setSiteId(getSiteId());
		
		// 메뉴 조회
		//Menu objRtn = (Menu)menuMgrService.getObjectList(menu);
		List<?> list = (List<?>) menuMgrService.getObjectList(menu);
		
		//실행결과 로기 생성
		this.resultLog(menu);
		
		// View 설정
		model.addAttribute("result", list);
		model.addAttribute("resultSite", commonService.getSiteName(menu));
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(menu.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("action", request.getParameter("action"));
		
		if(StringUtil.isNotBlank(menu.getMenuId())){			
			model.addAttribute("pMenuId", menu.getParamMenuId());
			model.addAttribute("pSiteId", menu.getSiteId());
		}
		
		menu.setJsp("system/menuMgr/form");
		return new ModelAndView("ips.layout", "obj", menu);
	}
	
	/*****************************************************************
	* Form 메뉴 추가/수정 폼
	* @param menu
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public @ResponseBody Object formMenuJson(@ModelAttribute Menu menu, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		menu.setInParam(request);
		
		// view 기본값 셋팅
		//this.setCommon(commonService, request, model, menu);

		Menu rtnMenu = new Menu();
		
		//menuId가 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(menu.getParamMenuId())){
			menu.setMenuId(menu.getParamMenuId());

			// 메뉴 상세 조회
			rtnMenu = (Menu)menuMgrService.getObject(menu);
			
			if(rtnMenu.getMenuId() == null){
				rtnMenu = null;
			}else{
				
				// 실행결과 로기 생성
				this.resultLog(menu);

				// 변경전 데이타 저장(inBeforeData)	
				rtnMenu.setInBeforeData(rtnMenu.makeDataString());
			}
		}
		return rtnMenu;
	}
	
	/*****************************************************************
	 * insert 메뉴 추가/수정/삭제
	 * @param menu
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act",method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute Menu menu, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		menu.setInParam(request);
		
		menu.setInWorkName("메뉴관리");
		if(StringUtil.isNotBlank(menu.getParamMenuId())){
			menu.setInCondition("수정");
		}else{
			menu.setInCondition("입력");
		}

		menu.setInCLOBData1(menu.getKDesc());
		
		// 변경후 데이타 저장(inAfterData)
		menu.setInAfterData(menu.makeDataString());
		
		//InDMLData ::  MenuID|SiteID|KName|Depth|Sort|HigherID|ImagePath|ImageFile|ProgramURL|ChargeUserID|TabYN|UserGradeYN|MenuType|State|newMenuYN...
		//menu.setInDMLData(menu.makeDMLDataString());
		
		// 저장
		Menu objRtn = (Menu)menuMgrService.insertObject(menu);
		
		// 등록 후 새로 생성된 메뉴 아이디 파라메타
		//if(menu.getInCondition().equals("입력")) menu.setParamMenuId(menu.getMenuId());
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//changLog
		menu.setDmlType(menu.getInCondition().equals("입력") ? "I" : menu.getInCondition().equals("수정") ? "U" : "D");
		menu.setDmlNotice("정상적으로 ("+menu.getInWorkName()+")"+menu.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(menu);
		
		if(!StringUtil.isNotBlank(menu.getParamMenuId())) menu.setParamMenuId(menu.getMenuId());

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(menu.getMenuId()) +
				  "&paramMenuId=" + StringUtil.nullCheck(menu.getParamMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(menu.getSiteId()) +
				  "&action=" + StringUtil.nullCheck("act");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/menuMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
	@RequestMapping(value="/actDel")
	public ModelAndView delete(@ModelAttribute Menu menu, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		menu.setInParam(request);
		menu.setInWorkName("메뉴관리");
		menu.setInCondition("삭제");

		// 변경후 데이타 저장(inAfterData)
		menu.setInAfterData(menu.makeDataString());
		
		//menu.setInDMLData(menu.makeDMLDataString());
		
		// 저장
		Menu objRtn = (Menu)menuMgrService.insertObject(menu);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);

		//실행결과 메세지처리 시
		this.setMessage(request, objRtn);
		
		//changLog
		menu.setDmlType("D");
		menu.setDmlNotice("정상적으로 ("+menu.getInWorkName()+")"+menu.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(menu);

		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(menu.getMenuId()) +
				  "&paramMenuId=" + StringUtil.nullCheck(menu.getParamMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(menu.getSiteId()) +
				  "&action=" + StringUtil.nullCheck("del");
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/menuMgr?"+strLink));
		return new ModelAndView(rv);
	}

}
