package kr.plani.ccis.ips.controller.system;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import kr.plani.ccis.common.util.StringUtil;
import kr.plani.ccis.ips.controller.BaseController;
import kr.plani.ccis.ips.domain.system.Code;
import kr.plani.ccis.ips.service.common.CommonService;
import kr.plani.ccis.ips.service.system.CodeMgrService;

/*****************************************************************
* 코드를 처리하는 비즈니스 구현 클래스
* <p><b>NOTE:</b> Exception 종류를 BizException, RuntimeException 에서만 동작한다.
* fail.common.msg 메시지 키가 Message Resource 에 정의되어 있어야 한다.
* @author 플랜아이 mcahn
* @since  2014. 8. 20. 
* @version 1.0
* <pre>
* 수정내용 : 
*  수정일				수정자         	수정내용
* ------------------------------------------------------
* 2014. 8. 20.		mcahn		최초 생성
* </pre>
*******************************************************************/

@Controller
@RequestMapping(value="/mgr/codeMgr")
public class CodeMgrController extends BaseController {

	 /** 코드관리 서비스   */
	@Resource
	private CodeMgrService codeMgrService;
	
	@Resource
	private CommonService commonService;
	
	/*****************************************************************
	* list 코드 트리리스트 조회
	* @param auth
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping()
	public ModelAndView list(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {
		
		//파라미터 설정
		code.setInParam(request);
		
		//기본셋팅
		this.setCommon(commonService, request, model, code);
		
		if(!StringUtil.isNotBlank(code.getSiteId())) code.setSiteId(getSiteId());
		
		if((code.getSiteId() != null && !code.getSiteId().equals(""))){
			//분야 조회
			List<?> objRtn = (List<?>)codeMgrService.getObjectList(code);
			
			//실행결과 로그 생성
			this.resultLog(code);
			
			//view 설정
			model.addAttribute("siteId", code.getSiteId());
			model.addAttribute("result", objRtn);
			model.addAttribute("resultSite", commonService.getSiteName(code));
		}
		
		// 링크 설정
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(code.getMenuId());
		
		model.addAttribute("link", strLink);
		model.addAttribute("action", request.getParameter("action"));
		
		if(StringUtil.isNotBlank(code.getSiteId())){			
			model.addAttribute("rSiteId", code.getSiteId());
			model.addAttribute("rCode", code.getCode());
			model.addAttribute("rHigherCode", code.getHigherCode());
		}
		
		code.setJsp("system/codeMgr/form");
		return new ModelAndView("ips.layout", "obj", code);
	}

	/*****************************************************************
	* Form 코드 상세조회 폼
	* @param code
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/form")
	public @ResponseBody Object formCodeJson(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		code.setInParam(request);
		
		// view 기본값 셋팅
		//this.setCommon(commonService, request, model, code);

		Code rtnCode = new Code();

		//code값이 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(code.getParamCode())){
			code.setCode(code.getParamCode());
			code.setHigherCode(code.getParamHigherCode());

			// 코드 상세 조회
			rtnCode = (Code)codeMgrService.getObject(code);
			
			//실행결과 로그 생성
			this.resultLog(code);
			
			// 변경전 데이타 저장(inBeforeData)	
			rtnCode.setInBeforeData(rtnCode.makeDataString());
		}
		return rtnCode;
	}
	
	/*****************************************************************
	 * insert 코드 추가/수정/삭제
	 * @param auth
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *******************************************************************/
	@RequestMapping(value="/act")
	public ModelAndView insert(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		code.setInParam(request);
		
		String act = "del";
		
		if(!code.getState().equals("F")) act = "act";

		code.setInWorkName("코드관리");
		
		if(StringUtil.isNotBlank(code.getCode())){
			code.setInCondition("입력");
		}else{
			code.setInCondition("수정");
			code.setCode(code.getParamCode());
		}

		// 변경후 데이타 저장(inAfterData)
		code.setInAfterData(code.makeDataString());
		
		//InDMLData ::  Code|HigherCode|KName|Depth|Sort|State
		//code.setInDMLData(code.makeDMLDataString());

		// 저장
		Code objRtn = (Code)codeMgrService.insertObject(code);
		
		//changLog
		code.setDmlType(code.getInCondition().equals("입력") ? "I" : code.getInCondition().equals("수정") ? "U" : "D");
		code.setDmlNotice("정상적으로 ("+code.getInWorkName()+")"+code.getInCondition()+"에 성공하였습니다.");
		commonService.insertChangeLog(code);
		
		//실행결과 로그 생성
		this.resultLog(code);		
		
		//실행결과 메세지처리
		this.setMessage(request, objRtn); 
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(code.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(code.getSiteId()) +
				  "&code=" + StringUtil.nullCheck(code.getParamCode()) +
				  "&higherCode=" + StringUtil.nullCheck(code.getParamHigherCode()) +
				  "&action=" + StringUtil.nullCheck(act);
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/codeMgr?"+strLink));
		return new ModelAndView(rv);
		
	}
	
	/*****************************************************************
	* Form 코드 중복체트용
	* @param code
	* @param request
	* @param model
	* @return
	* @throws Exception
	*******************************************************************/
	@RequestMapping(value="/check")
	public @ResponseBody Integer formCheckCode(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {
		
		// 페키지 호출 기본 Parameter 설정
		code.setInParam(request);

		int rowCnt = 0;

		//code값이 넘어 오지 않을경우 신규 입력
		if(StringUtil.isNotBlank(code.getParamCode())){
			
			code.setCode(code.getParamCode());
			code.setHigherCode(code.getParamHigherCode());

			// 코드 상세 조회
			rowCnt = (int) codeMgrService.getCheckCode(code);


			//실행결과 로그 생성
			this.resultLog(code);
		}
		return rowCnt;
	}
	
	@RequestMapping(value="/codesortlist")
	public @ResponseBody List<?> listCodeSortPopup(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		//파라미터 설정
		code.setInParam(request);

		List<?> rtnList = null;
		
		// 회원구분 파라메타 세팅
		code.setInCode(request.getParameter("code"));
		code.setSiteId(request.getParameter("siteId")); 
		
		//분야 조회
		rtnList = (List<?>)codeMgrService.getComboList(code);
		
		return rtnList;		
	}
	
	@RequestMapping(value="/sortChg")
	public ModelAndView sortChg(@ModelAttribute Code code, HttpServletRequest request, Model model) throws Exception {

		//기본 Parameter 설정
		code.setInParam(request);		
		code.setInWorkName("코드관리");
		
		// 저장
		Code objRtn = (Code)codeMgrService.updateObject(code);
		
		//실행결과 로기 생성
		this.resultLog(objRtn);		
		//실행결과 메세지처리
		this.setMessage(request, objRtn); 
		
		String strLink = "";
		strLink = "&menuId=" + StringUtil.nullCheck(code.getMenuId()) +
				  "&siteId=" + StringUtil.nullCheck(code.getSiteId()) +
				  "&code=" + StringUtil.nullCheck(code.getParamSortCode()) +
				  "&higherCode=" + StringUtil.nullCheck(code.getParamSortHigherCode()) +
				  "&action=" + StringUtil.nullCheck("act");
		
		model.addAttribute("link", strLink);
		
		// View 설정
		RedirectView rv = new RedirectView(request.getContextPath().concat("/mgr/codeMgr?"+strLink));
		return new ModelAndView(rv);
	}
	
}
