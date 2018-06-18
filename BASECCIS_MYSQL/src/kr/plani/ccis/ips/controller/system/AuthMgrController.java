package kr.plani.ccis.ips.controller.system;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.system.Auth;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.system.AuthMgrService;

/*****************************************************************
* 사용자 계정을 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2017. 05. 20. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2017. 05. 20.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/authMgr")
public class AuthMgrController extends BaseController {

	 /** 사이트관리 서비스   */
	@Resource
	private AuthMgrService authMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 사이트 목록 조회
	* @param auth
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(method=RequestMethod.GET)
	public ModelAndView list(@ModelAttribute Auth auth, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		auth.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, auth);

		if((auth.getSiteId() != null && !auth.getSiteId().equals("")) && (auth.getGroupid() != null && !auth.getGroupid().equals(""))){
			//파라미터 설정
			auth.setInGroupID(auth.getGroupid());
		
			// 조회
			List<?> list = (List<?>)authMgrService.getObjectList(auth);
		
			//view 설정
			model.addAttribute("result", list);
			//페이징 정보
			//model.addAttribute("rowCnt", auth.getRowCnt());			//페이지 목록수
			//model.addAttribute("totalCnt", list.size() <= 0 ? 0 : Integer.parseInt(String.valueOf(((Map)list.get(0)).get("TOTAL_CNT"))));	//전체 카운트
		}

		model.addAttribute("siteId", auth.getSiteId());
		model.addAttribute("groupid", auth.getGroupid());

		//링크 설정
		String strLink = null;
		strLink = "&menuId=" + StringUtil.nullCheck(auth.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(auth.getSiteId()) +
				  "&groupid=" + StringUtil.nullCheck(auth.getGroupid());
		
		model.addAttribute("link", strLink);
				
		auth.setJsp("system/authMgr/list");
		return new ModelAndView("ips.layout", "obj", auth);
	}
	
	/*****************************************************************
	 * insert 권한 추가/수정/삭제
	 * @param auth
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public ModelAndView insert(@ModelAttribute Auth auth, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		auth.setInParam(request);		
		auth.setInWorkName("그룹권한관리");
		
		// 저장
		Auth objRtn = (Auth)authMgrService.insertObject(auth);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);		
		
		//실행결과 메세지처리
		this.setMessage(request, objRtn); 
		
		String strLink = "";
		
		strLink = "menuId=" + StringUtil.nullCheck(request.getParameter("menuId")) + 
				  "&siteId=" + StringUtil.nullCheck(auth.getSiteId()) +
				  "&groupid=" + StringUtil.nullCheck(request.getParameter("groupid"));
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/authMgr?"+strLink));
		return new ModelAndView(rv);
	}
		
}
